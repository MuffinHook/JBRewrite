-- Reviewed by Claude
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
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local t = {
	bullet_impact_bass = 2837091387,
	reload = 6602025903,
	shoot = 6602025330,
	detected = 6602024939,
	motor = 6602024532
}
local MilitaryTurretConsts = require(script.Parent.MilitaryTurretConsts)
local MilitaryTurretUtils = require(script.Parent.MilitaryTurretUtils)
local t2 = {}
t2.__index = t2
function t2.new(p1)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	local t3 = {}
	setmetatable(t3, t2)
	t3._maid = Maid.new()
	t3.onBulletHit = Signal.new()
	local t4 = { p1.Parent, workspace.Vehicles }
	t3._lastPitch = 0
	t3._lastYaw = 0
	t3._pitchSpring = Spring.new(t3._lastPitch, 0, 0.6, 15)
	t3._yawSpring = Spring.new(t3._lastYaw, 0, 0.6, 15)
	t3._kickSpring = Spring.new(0, 0, 0.7, 70)
	local v2 = BulletEmitter.new(true)
	v2.IgnoreList = assert(t4)
	v2.LifeSpan = 1
	v2.IgnoreLocalPlayer = false
	v2.GravityVector = Vector3.new(0, -2, 0)
	t3._maid:GiveTask(v2.OnLocalHitPlayer:Connect(function(p1)
		if Players:GetPlayerFromCharacter(p1.Parent) == LocalPlayer then
			t3.onBulletHit:Fire(MilitaryTurretConsts.TURRET_DAMAGE)
		end
		Audio.ObjectLocal(p1.RootPart, t.bullet_impact_bass, {
			Volume = 1
		})
	end))
	t3._maid:GiveTask(v2)
	t3._bulletEmitter = v2
	t3._lastDt = os.clock()
	t3._maxDYaw = 12.566370614359172
	t3._turretMotorSound = Audio.ObjectLocal(p1.PrimaryPart, t.motor, {
		Looped = true,
		DoNotPlay = true,
		Volume = 0.3,
		RollOffMaxDistance = 256
	})
	t3._clipSize = MilitaryTurretConsts.MAG_SIZE
	t3._lastFire = os.clock()
	t3._lastPointAt = nil
	t3._lastDetectedBeep = os.clock()
	t3._maid:GiveTask(RunService.Heartbeat:Connect(function()
		t3:_update(p1)
	end))
	local MotorArm = p1:FindFirstChild("MotorArm")
	local MotorBase = p1:FindFirstChild("MotorBase")
	if MotorArm == nil then
		RxInstanceUtils.yieldForProperty(p1.Top, "PrimaryPart")
		RxInstanceUtils.yieldForProperty(p1.Post, "PrimaryPart")
		Joint.WeldAllTo(p1.Top, p1.Top.PrimaryPart)
		Joint.WeldAllTo(p1.Post, p1.Post.PrimaryPart)
		local v3 = Joint.CustomWeld(p1.Top.PrimaryPart, p1.PivotTop, p1.Top.PrimaryPart.CFrame:ToObjectSpace(p1.PivotTop.CFrame), CFrame.new())
		v3.Parent = p1
		local v4 = Joint.CustomWeld(p1.Post.PrimaryPart, p1.PivotBottom, p1.Post.PrimaryPart.CFrame:ToObjectSpace(p1.PivotBottom.CFrame), CFrame.new())
		v4.Parent = p1
		MotorArm = v3
		MotorBase = v4
	end
	t3._motorArm = MotorArm
	t3._motorBase = MotorBase
	return t3
end
function t2._update(p1, p2)
	local v1 = os.clock()
	local v2 = PlayerUtils.getRootPart(LocalPlayer)
	if v2 then
		p1._bulletEmitter:Update()
		if not ((v2.Position - p2.PrimaryPart.Position).Magnitude > 450) then
			local v3 = MilitaryTurretUtils.getNearestNonPolice(p2.PrimaryPart.Position, 400)
			local v4, v5
			if v3 then
				local v6 = PlayerUtils.getRootPart(v3)
				v4 = v6.Parent
				v5 = v6.Position
			else
				v5 = nil
				v4 = nil
			end
			if v5 then
				local Position = p2.Top.Tip.Position
				local v7 = v5 - Position
				local v8, v9 = RayCast.RayIgnoreNonCollideWithIgnoreList(Position, v7.Unit, v7.Magnitude, assert(p1._bulletEmitter.IgnoreList))
				if v8 and ((v9 - v5).Magnitude > 1 and not (v4 and v8:IsDescendantOf(v4))) then
					v5 = nil
				end
			end
			if v5 then
				if not p1._lastPointAt then
					if not p1._turretMotorSound.IsPlaying then
						p1._turretMotorSound:Play()
					end
					if v1 - p1._lastDetectedBeep > 2 then
						p1._lastDetectedBeep = v1
						Audio.ObjectLocal(p2.PrimaryPart, t.detected, {
							Volume = 1,
							RollOffMaxDistance = 512
						})
						p1._lastFire = v1 + 0.5
					end
				end
				p1:_updateRotation(p2, v5)
				if v1 - p1._lastFire > MilitaryTurretConsts.FIRE_RATE then
					p1._lastFire = v1
					if p1._clipSize > 0 then
						p1._clipSize = p1._clipSize - 1
						p1:_fire(p2)
					else
						p1._lastFire = v1 + MilitaryTurretConsts.RELOAD_TIME
						p1._clipSize = MilitaryTurretConsts.MAG_SIZE
						Audio.ObjectLocal(p2.PrimaryPart, t.reload, {
							Volume = 1,
							RollOffMaxDistance = 512
						})
					end
				end
			end
			if not v5 and (p1._lastPointAt and p1._turretMotorSound.IsPlaying) then
				p1._turretMotorSound:Stop()
			end
			p1._lastPointAt = v5
		end
	end
end
function t2._updateRotation(p1, p2, p3)
	local v1 = os.clock()
	local v2 = v1 - p1._lastDt
	p1._lastDt = v1
	local v3 = p1._kickSpring:Update()
	local v4 = p2.PivotBottom.CFrame:PointToObjectSpace(p3)
	local v7 = math.atan2(-v4.x, -v4.z)
	local v8 = (p2.PivotTop.CFrame * CFrame.Angles(0, v7, 0)):PointToObjectSpace(p3)
	local v10 = math.sqrt(v8.y * v8.y + v8.z * v8.z)
	p1._lastPitch = math.atan2(v8.y, -v8.z) + math.asin(-0.56 / v10)
	p1._lastYaw = p1._lastYaw + math.clamp(MilitaryTurretUtils.shortAngleDist(p1._lastYaw, v7), -p1._maxDYaw * v2, p1._maxDYaw * v2)
	local v15 = p1._pitchSpring:SetTarget(p1._lastPitch)
	local v16 = p1._yawSpring:SetTarget(p1._lastYaw)
	p1._motorBase.C1 = CFrame.Angles(0, v16, 0)
	p1._motorArm.C1 = CFrame.Angles(0, v16, 0) * CFrame.Angles(v15, 0, 0) * CFrame.new(0, 0, v3)
end
function t2._fire(p1, p2)
	local v1 = p2.Top.Tip.CFrame
	p1._bulletEmitter:Emit(v1.p, v1.LookVector + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.008, 400)
	p1._kickSpring:Accelerate(40)
	Audio.ObjectLocal(p2.Top.Tip, t.shoot, {
		Volume = 0.5
	})
end
function t2.Destroy(p1)
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
end
return t2
