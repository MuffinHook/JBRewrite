local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BulletEmitter = require(ReplicatedStorage.Game.ItemSystem.BulletEmitter)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Spring = require(ReplicatedStorage.Std.Spring)
local Signal = require(ReplicatedStorage.Std.Signal)
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local RunService = game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local function randomVector()
	local randomX = math.random() * 2 - 1
	local randomY = math.random() * 2 - 1
	return Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit
end
local audioEventIds = {
	bullet_impact_bass = 2837091387,
	reload = 6602025903,
	shoot = 6602025330,
	detected = 6602024939,
	motor = 6602024532
}
local MilitaryTurretConsts = require(script.Parent.MilitaryTurretConsts)
local MilitaryTurretUtils = require(script.Parent.MilitaryTurretUtils)
local MilitaryTurret = {}
MilitaryTurret.__index = MilitaryTurret
function MilitaryTurret.new(turretModel)
	RxInstanceUtils.yieldForProperty(turretModel, "PrimaryPart")
	local self = {}
	setmetatable(self, MilitaryTurret)
	self._maid = Maid.new()
	self.onBulletHit = Signal.new()
	local ignoreList = { turretModel.Parent, workspace.Vehicles }
	self._lastPitch = 0
	self._lastYaw = 0
	self._pitchSpring = Spring.new(self._lastPitch, 0, 0.6, 15)
	self._yawSpring = Spring.new(self._lastYaw, 0, 0.6, 15)
	self._kickSpring = Spring.new(0, 0, 0.7, 70)
	local bulletEmitter = BulletEmitter.new(true)
	bulletEmitter.IgnoreList = assert(ignoreList)
	bulletEmitter.LifeSpan = 1
	bulletEmitter.IgnoreLocalPlayer = false
	bulletEmitter.GravityVector = Vector3.new(0, -2, 0)
	self._maid:GiveTask(bulletEmitter.OnLocalHitPlayer:Connect(function(bulletPart)
		if Players:GetPlayerFromCharacter(bulletPart.Parent) == LocalPlayer then
			self.onBulletHit:Fire(MilitaryTurretConsts.TURRET_DAMAGE)
		end
		Audio.ObjectLocal(bulletPart.RootPart, audioEventIds.bullet_impact_bass, {
			Volume = 1
		})
	end))
	self._maid:GiveTask(bulletEmitter)
	self._bulletEmitter = bulletEmitter
	self._lastDt = os.clock()
	self._maxDYaw = 12.566370614359172
	self._turretMotorSound = Audio.ObjectLocal(turretModel.PrimaryPart, audioEventIds.motor, {
		Looped = true,
		DoNotPlay = true,
		Volume = 0.3,
		RollOffMaxDistance = 256
	})
	self._clipSize = MilitaryTurretConsts.MAG_SIZE
	self._lastFire = os.clock()
	self._lastPointAt = nil
	self._lastDetectedBeep = os.clock()
	self._maid:GiveTask(RunService.Heartbeat:Connect(function()
		self:_update(turretModel)
	end))
	local MotorArm = turretModel:FindFirstChild("MotorArm")
	local MotorBase = turretModel:FindFirstChild("MotorBase")
	if MotorArm == nil then
		RxInstanceUtils.yieldForProperty(turretModel.Top, "PrimaryPart")
		RxInstanceUtils.yieldForProperty(turretModel.Post, "PrimaryPart")
		Joint.WeldAllTo(turretModel.Top, turretModel.Top.PrimaryPart)
		Joint.WeldAllTo(turretModel.Post, turretModel.Post.PrimaryPart)
		local topWeld = Joint.CustomWeld(turretModel.Top.PrimaryPart, turretModel.PivotTop, turretModel.Top.PrimaryPart.CFrame:ToObjectSpace(turretModel.PivotTop.CFrame), CFrame.new())
		topWeld.Parent = turretModel
		local bottomWeld = Joint.CustomWeld(turretModel.Post.PrimaryPart, turretModel.PivotBottom, turretModel.Post.PrimaryPart.CFrame:ToObjectSpace(turretModel.PivotBottom.CFrame), CFrame.new())
		bottomWeld.Parent = turretModel
		MotorArm = topWeld
		MotorBase = bottomWeld
	end
	self._motorArm = MotorArm
	self._motorBase = MotorBase
	return self
end
function MilitaryTurret._update(self, turretModel)
	local currentTime = os.clock()
	local playerRoot = PlayerUtils.getRootPart(LocalPlayer)
	if playerRoot then
		self._bulletEmitter:Update()
		if not ((playerRoot.Position - turretModel.PrimaryPart.Position).Magnitude > 450) then
			local targetPlayer = MilitaryTurretUtils.getNearestNonPolice(turretModel.PrimaryPart.Position, 400)
			local targetCharacter, targetPosition
			if targetPlayer then
				local targetRoot = PlayerUtils.getRootPart(targetPlayer)
				targetCharacter = targetRoot.Parent
				targetPosition = targetRoot.Position
			else
				targetPosition = nil
				targetCharacter = nil
			end
			if targetPosition then
				local Position = turretModel.Top.Tip.Position
				local directionToTarget = targetPosition - Position
				local rayHitPart, rayHitPosition = RayCast.RayIgnoreNonCollideWithIgnoreList(Position, directionToTarget.Unit, directionToTarget.Magnitude, assert(self._bulletEmitter.IgnoreList))
				if rayHitPart and ((rayHitPosition - targetPosition).Magnitude > 1 and not (targetCharacter and rayHitPart:IsDescendantOf(targetCharacter))) then
					targetPosition = nil
				end
			end
			if targetPosition then
				if not self._lastPointAt then
					if not self._turretMotorSound.IsPlaying then
						self._turretMotorSound:Play()
					end
					if currentTime - self._lastDetectedBeep > 2 then
						self._lastDetectedBeep = currentTime
						Audio.ObjectLocal(turretModel.PrimaryPart, audioEventIds.detected, {
							Volume = 1,
							RollOffMaxDistance = 512
						})
						self._lastFire = currentTime + 0.5
					end
				end
				self:_updateRotation(turretModel, targetPosition)
				if currentTime - self._lastFire > MilitaryTurretConsts.FIRE_RATE then
					self._lastFire = currentTime
					if self._clipSize > 0 then
						self._clipSize = self._clipSize - 1
						self:_fire(turretModel)
					else
						self._lastFire = currentTime + MilitaryTurretConsts.RELOAD_TIME
						self._clipSize = MilitaryTurretConsts.MAG_SIZE
						Audio.ObjectLocal(turretModel.PrimaryPart, audioEventIds.reload, {
							Volume = 1,
							RollOffMaxDistance = 512
						})
					end
				end
			end
			if not targetPosition and (self._lastPointAt and self._turretMotorSound.IsPlaying) then
				self._turretMotorSound:Stop()
			end
			self._lastPointAt = targetPosition
		end
	end
end
function MilitaryTurret._updateRotation(self, turretModel, targetPosition)
	local currentTime = os.clock()
	local deltaTime = currentTime - self._lastDt
	self._lastDt = currentTime
	local kickOffset = self._kickSpring:Update()
	local baseRelativeTarget = turretModel.PivotBottom.CFrame:PointToObjectSpace(targetPosition)
	local yawAngle = math.atan2(-baseRelativeTarget.x, -baseRelativeTarget.z)
	local armRelativeTarget = (turretModel.PivotTop.CFrame * CFrame.Angles(0, yawAngle, 0)):PointToObjectSpace(targetPosition)
	local horizontalDistance = math.sqrt(armRelativeTarget.y * armRelativeTarget.y + armRelativeTarget.z * armRelativeTarget.z)
	self._lastPitch = math.atan2(armRelativeTarget.y, -armRelativeTarget.z) + math.asin(-0.56 / horizontalDistance)
	self._lastYaw = self._lastYaw + math.clamp(MilitaryTurretUtils.shortAngleDist(self._lastYaw, yawAngle), -self._maxDYaw * deltaTime, self._maxDYaw * deltaTime)
	local pitchTarget = self._pitchSpring:SetTarget(self._lastPitch)
	local yawTarget = self._yawSpring:SetTarget(self._lastYaw)
	self._motorBase.C1 = CFrame.Angles(0, yawTarget, 0)
	self._motorArm.C1 = CFrame.Angles(0, yawTarget, 0) * CFrame.Angles(pitchTarget, 0, 0) * CFrame.new(0, 0, kickOffset)
end
function MilitaryTurret._fire(self, turretModel)
	local firePoint = turretModel.Top.Tip.CFrame
	self._bulletEmitter:Emit(firePoint.p, firePoint.LookVector + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.008, 400)
	self._kickSpring:Accelerate(40)
	Audio.ObjectLocal(turretModel.Top.Tip, audioEventIds.shoot, {
		Volume = 0.5
	})
end
function MilitaryTurret.Destroy(self)
	local maidInstance = self._maid
	self._maid = nil
	maidInstance:Destroy()
end
return MilitaryTurret
