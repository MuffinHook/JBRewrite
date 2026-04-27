local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TurretConsts = require(script.Parent.TurretConsts)
local TurretUtils = require(script.Parent.TurretUtils)
local RocketWorld = require(ReplicatedStorage.Game.RocketWorld)
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local Audio = require(ReplicatedStorage.Std.Audio)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Signal = require(ReplicatedStorage.Std.Signal)
local function ShortAngleDist(angle1, angle2)
	local normalizedAngleDelta = (angle2 - angle1) % 6.283185307179586
	return 2 * normalizedAngleDelta % 6.283185307179586 - normalizedAngleDelta
end
local soundAssets = {
	weapon_cannon_shot_04 = 2205008075
}
local TurretClass = {}
TurretClass.__index = TurretClass
function TurretClass.new(turretModel)
	assert(turretModel)
	local turret = {}
	setmetatable(turret, TurretClass)
	turret.Maid = Maid.new()
	turret.RocketWorld = RocketWorld.new()
	local function AddSmoke(smokeOrigin, smokeParent)
		ReplicatedStorage.Resource.Robbery.CargoShip.RocketSmoke:Clone().Parent = smokeParent
	end
	turret.RocketWorld.AddSmoke = AddSmoke
	turret.Maid:GiveTask(turret.RocketWorld)
	turret.Model = turretModel
	turret:SetupJoints()
	turret.LastUpdate = os.clock()
	turret.LastShoot = os.clock()
	turret.LastHit = os.clock()
	turret.onLocalPlayerHit = Signal.new()
	turret.Target = Vector3.new()
	turret.MaxDHorizontalAngle = 1.2566370614359172
	turret.HorizontalAngle = 1.5707963267948966
	turret.TargetHorizontalAngle = 0
	turret.SpringHorizontalAngle = Spring.new(turret.HorizontalAngle, 0, 0.7, 15)
	turret.MaxDVerticalAngle = 1.2566370614359172
	turret.VerticalAngle = 0
	turret.TargetVerticalAngle = 0
	turret.SpringVerticalAngle = Spring.new(turret.VerticalAngle, 0, 0.7, 15)
	turret.SpringShoot = Spring.new(0, 0, 0.6, 10)
	return turret
end
function TurretClass.SetupJoints(self)
	self.MotorBase = self.Model.Base.Root:WaitForChild("MotorBase", 5)
	assert(self.MotorBase)
	self.MotorBaseC0 = self.MotorBase.C0
	self.MotorArm = self.Model.Arm.Root:WaitForChild("MotorArm", 5)
	assert(self.MotorArm)
	self.MotorBarrel = self.Model.Arm.Barrel:WaitForChild("MotorBarrel", 5)
	assert(self.MotorBarrel)
end
function TurretClass.PointAt(self, targetPosition)
	self.Target = targetPosition
	if targetPosition then
		self.TargetHorizontalAngle = TurretUtils.computeHorizontalAngle(self.Model, self.MotorBase, targetPosition)
		self.TargetVerticalAngle = TurretUtils.computeVerticalAngle(self.Model, self.MotorArm, targetPosition)
	else
		self.TargetHorizontalAngle = 1.5707963267948966
		self.TargetVerticalAngle = 0
	end
end
function TurretClass.Update(self)
	local currentTime = os.clock()
	local deltaTime = currentTime - self.LastUpdate
	self.LastUpdate = currentTime
	local horizontalAngleDelta = (self.TargetHorizontalAngle - self.HorizontalAngle) % 6.283185307179586
	self.HorizontalAngle = self.HorizontalAngle + math.clamp(2 * horizontalAngleDelta % 6.283185307179586 - horizontalAngleDelta, -self.MaxDHorizontalAngle * deltaTime, self.MaxDHorizontalAngle * deltaTime)
	local springHorizontalAngle = self.SpringHorizontalAngle:SetTarget(self.HorizontalAngle)
	self.VerticalAngle = math.clamp(self.VerticalAngle + math.clamp(self.TargetVerticalAngle - self.VerticalAngle, -self.MaxDVerticalAngle * deltaTime, self.MaxDVerticalAngle * deltaTime), -0.9424777960769379, 1.5707963267948966)
	TurretUtils.updateModel(self.MotorBase, self.MotorArm, springHorizontalAngle, (self.SpringVerticalAngle:SetTarget(self.VerticalAngle)))
	local barrelRecoilOffset = self.SpringShoot:Update()
	self.MotorBarrel.C1 = self.MotorBarrel.C0:Inverse() * CFrame.new(0, 0, barrelRecoilOffset) * self.MotorBarrel.C0
	if self.Target and 1 / self:GetShootHz() < currentTime - self.LastShoot then
		self.LastShoot = currentTime
		if self.Model:GetAttribute(TurretConsts.USE_LASER_ATTR_NAME) == true then
			self:ShootLaser()
			return
		end
		self:ShootRocket()
	end
end
function TurretClass.GetShootHz(self)
	return self.Model:GetAttribute(TurretConsts.SHOOT_HZ_ATTR_NAME) or 0.6666666666666666
end
function TurretClass.ShootRocket(self)
	self.SpringShoot:Accelerate(100)
	self.SpringVerticalAngle:Accelerate(1)
	self.SpringHorizontalAngle:Accelerate(-1)
	local Tip = self.Model.Arm.Tip
	Audio.ObjectLocal(Tip, soundAssets.weapon_cannon_shot_04, {
		Volume = 1
	})
	self.RocketWorld:Launch(Tip.Position, Tip.CFrame.LookVector, 400)
end
function TurretClass.ShootLaser(self)
	self.SpringShoot:Accelerate(50)
	self.SpringVerticalAngle:Accelerate(1)
	self.SpringHorizontalAngle:Accelerate(-1)
	local laserMaid = Maid.new()
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Transparency = 0
	Part.Color = Color3.fromRGB(181, 113, 102)
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	local TopSurfaceSmooth = Enum.SurfaceType.Smooth
	local BottomSurfaceSmooth = Enum.SurfaceType.Smooth
	Part.TopSurface = TopSurfaceSmooth
	Part.BottomSurface = BottomSurfaceSmooth
	laserMaid:GiveTask(Part)
	self.Maid.laserMaid = laserMaid
	local laserDuration = 1 / self:GetShootHz() * 0.5
	local Tip = self.Model.Arm.Tip
	local Vehicles = workspace:FindFirstChild("Vehicles")
	local function updateLaserToTarget(targetPos)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { self.Model, Vehicles }
		raycastParams.IgnoreWater = true
		local direction = targetPos - Tip.Position
		local hitResult = Raycast.collidable(Tip.Position, direction.Unit, direction.Magnitude, raycastParams, function(hitPart)
			if hitPart:GetAttribute("InvisibleToBullets") == true then
				return false
			else
				return hitPart.CanCollide and true or false
			end
		end)
		if hitResult then
			direction = hitResult.Position - Tip.Position
		end
		local laserLength = direction.Magnitude
		Part.Size = Vector3.new(0.5, 0.5, laserLength)
		local rotationTime = os.clock()
		Part.CFrame = CFrame.new(Vector3.new(0, 0, 0), direction.Unit) * CFrame.new(0, 0, -laserLength / 2) * CFrame.Angles(0, 0, rotationTime * 20 % 6.283185307179586) + Tip.Position
		if self.shoot1Sound then
			self.shoot1Sound:Play()
		else
			self.shoot1Sound = Audio.ObjectLocal(Tip, 11793588989, {
				Volume = 0.6,
				RollOffMaxDistance = 1280
			})
			self.Maid:GiveTask(function()
				self.shoot1Sound:Destroy()
				self.shoot1Sound = nil
			end)
		end
		if self.laserLoop then
			self.laserLoop:Play()
		else
			self.laserLoop = Audio.ObjectLocal(Tip, 11793547887, {
				Looped = true,
				Volume = 0.5,
				RollOffMaxDistance = 1280
			})
			self.Maid:GiveTask(function()
				self.laserLoop:Destroy()
				self.laserLoop = nil
			end)
		end
		task.delay(laserDuration, function()
			self.laserLoop:Stop()
		end)
		local playerRootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		if playerRootPart then
			local _, distanceToLine = GeomUtils.closestPointOnLine(self.Model.Arm.Tip.Position, direction, playerRootPart.Position)
			if distanceToLine < 8 and os.clock() - self.LastHit >= 1 / self:GetShootHz() then
				self.LastHit = os.clock()
				self.onLocalPlayerHit:Fire(Players.LocalPlayer)
			end
		end
	end
	updateLaserToTarget(Tip.Position + Vector3.new(0.01, 0.01, 0.01))
	Part.Parent = workspace
	local laserStartTime = os.clock()
	laserMaid:GiveTask(RunService.Heartbeat:Connect(function()
		if self.Target then
			local elapsedTime = os.clock() - laserStartTime
			if laserDuration <= elapsedTime then
				elapsedTime = laserDuration
			end
			updateLaserToTarget(Tip.Position:Lerp(self.Target, (math.clamp(elapsedTime / laserDuration * 5, 0, 1))))
			if elapsedTime == laserDuration then
				self.Maid.laserMaid = nil
			end
		else
			self.Maid.laserMaid = nil
		end
	end))
end
function TurretClass.Destroy(self)
	self.Maid:Destroy()
	self.Maid = nil
end
return TurretClass
