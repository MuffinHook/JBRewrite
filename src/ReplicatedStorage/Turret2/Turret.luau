-- Reviewed by Claude
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
local function ShortAngleDist(p1, p2)
	local instance = (p2 - p1) % 6.283185307179586
	return 2 * instance % 6.283185307179586 - instance
end
local t = {
	weapon_cannon_shot_04 = 2205008075
}
local t2 = {}
t2.__index = t2
function t2.new(p1)
	assert(p1)
	local t = {}
	setmetatable(t, t2)
	t.Maid = Maid.new()
	t.RocketWorld = RocketWorld.new()
	local function AddSmoke(p1, p2)
		ReplicatedStorage.Resource.Robbery.CargoShip.RocketSmoke:Clone().Parent = p2
	end
	t.RocketWorld.AddSmoke = AddSmoke
	t.Maid:GiveTask(t.RocketWorld)
	t.Model = p1
	t:SetupJoints()
	t.LastUpdate = os.clock()
	t.LastShoot = os.clock()
	t.LastHit = os.clock()
	t.onLocalPlayerHit = Signal.new()
	t.Target = Vector3.new()
	t.MaxDHorizontalAngle = 1.2566370614359172
	t.HorizontalAngle = 1.5707963267948966
	t.TargetHorizontalAngle = 0
	t.SpringHorizontalAngle = Spring.new(t.HorizontalAngle, 0, 0.7, 15)
	t.MaxDVerticalAngle = 1.2566370614359172
	t.VerticalAngle = 0
	t.TargetVerticalAngle = 0
	t.SpringVerticalAngle = Spring.new(t.VerticalAngle, 0, 0.7, 15)
	t.SpringShoot = Spring.new(0, 0, 0.6, 10)
	return t
end
function t2.SetupJoints(p1)
	p1.MotorBase = p1.Model.Base.Root:WaitForChild("MotorBase", 5)
	assert(p1.MotorBase)
	p1.MotorBaseC0 = p1.MotorBase.C0
	p1.MotorArm = p1.Model.Arm.Root:WaitForChild("MotorArm", 5)
	assert(p1.MotorArm)
	p1.MotorBarrel = p1.Model.Arm.Barrel:WaitForChild("MotorBarrel", 5)
	assert(p1.MotorBarrel)
end
function t2.PointAt(p1, p2)
	p1.Target = p2
	if p2 then
		p1.TargetHorizontalAngle = TurretUtils.computeHorizontalAngle(p1.Model, p1.MotorBase, p2)
		p1.TargetVerticalAngle = TurretUtils.computeVerticalAngle(p1.Model, p1.MotorArm, p2)
	else
		p1.TargetHorizontalAngle = 1.5707963267948966
		p1.TargetVerticalAngle = 0
	end
end
function t2.Update(p1)
	local instance = os.clock()
	local v2 = instance - p1.LastUpdate
	p1.LastUpdate = instance
	local var3 = (p1.TargetHorizontalAngle - p1.HorizontalAngle) % 6.283185307179586
	p1.HorizontalAngle = p1.HorizontalAngle + math.clamp(2 * var3 % 6.283185307179586 - var3, -p1.MaxDHorizontalAngle * v2, p1.MaxDHorizontalAngle * v2)
	local var6 = p1.SpringHorizontalAngle:SetTarget(p1.HorizontalAngle)
	p1.VerticalAngle = math.clamp(p1.VerticalAngle + math.clamp(p1.TargetVerticalAngle - p1.VerticalAngle, -p1.MaxDVerticalAngle * v2, p1.MaxDVerticalAngle * v2), -0.9424777960769379, 1.5707963267948966)
	TurretUtils.updateModel(p1.MotorBase, p1.MotorArm, var6, (p1.SpringVerticalAngle:SetTarget(p1.VerticalAngle)))
	local var12 = p1.SpringShoot:Update()
	p1.MotorBarrel.C1 = p1.MotorBarrel.C0:Inverse() * CFrame.new(0, 0, var12) * p1.MotorBarrel.C0
	if p1.Target and 1 / p1:GetShootHz() < instance - p1.LastShoot then
		p1.LastShoot = instance
		if p1.Model:GetAttribute(TurretConsts.USE_LASER_ATTR_NAME) == true then
			p1:ShootLaser()
			return
		end
		p1:ShootRocket()
	end
end
function t2.GetShootHz(p1)
	return p1.Model:GetAttribute(TurretConsts.SHOOT_HZ_ATTR_NAME) or 0.6666666666666666
end
function t2.ShootRocket(p1)
	p1.SpringShoot:Accelerate(100)
	p1.SpringVerticalAngle:Accelerate(1)
	p1.SpringHorizontalAngle:Accelerate(-1)
	local Tip = p1.Model.Arm.Tip
	Audio.ObjectLocal(Tip, t.weapon_cannon_shot_04, {
		Volume = 1
	})
	p1.RocketWorld:Launch(Tip.Position, Tip.CFrame.LookVector, 400)
end
function t2.ShootLaser(p1)
	p1.SpringShoot:Accelerate(50)
	p1.SpringVerticalAngle:Accelerate(1)
	p1.SpringHorizontalAngle:Accelerate(-1)
	local instance = Maid.new()
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Transparency = 0
	Part.Color = Color3.fromRGB(181, 113, 102)
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	local Smooth = Enum.SurfaceType.Smooth
	local Smooth_2 = Enum.SurfaceType.Smooth
	Part.TopSurface = Smooth
	Part.BottomSurface = Smooth_2
	instance:GiveTask(Part)
	p1.Maid.laserMaid = instance
	local v2 = 1 / p1:GetShootHz() * 0.5
	local Tip = p1.Model.Arm.Tip
	local Vehicles = workspace:FindFirstChild("Vehicles")
	local function updateLaserToTarget(p12)
		local instance = RaycastParams.new()
		instance.FilterType = Enum.RaycastFilterType.Exclude
		instance.FilterDescendantsInstances = { p1.Model, Vehicles }
		instance.IgnoreWater = true
		local var22 = p12 - Tip.Position
		local var3 = Raycast.collidable(Tip.Position, var22.Unit, var22.Magnitude, instance, function(p1)
			if p1:GetAttribute("InvisibleToBullets") == true then
				return false
			else
				return p1.CanCollide and true or false
			end
		end)
		if var3 then
			var22 = var3.Position - Tip.Position
		end
		local Magnitude = var22.Magnitude
		Part.Size = Vector3.new(0.5, 0.5, Magnitude)
		local var4 = os.clock()
		Part.CFrame = CFrame.new(Vector3.new(0, 0, 0), var22.Unit) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles(0, 0, var4 * 20 % 6.283185307179586) + Tip.Position
		if p1.shoot1Sound then
			p1.shoot1Sound:Play()
		else
			p1.shoot1Sound = Audio.ObjectLocal(Tip, 11793588989, {
				Volume = 0.6,
				RollOffMaxDistance = 1280
			})
			p1.Maid:GiveTask(function()
				p1.shoot1Sound:Destroy()
				p1.shoot1Sound = nil
			end)
		end
		if p1.laserLoop then
			p1.laserLoop:Play()
		else
			p1.laserLoop = Audio.ObjectLocal(Tip, 11793547887, {
				Looped = true,
				Volume = 0.5,
				RollOffMaxDistance = 1280
			})
			p1.Maid:GiveTask(function()
				p1.laserLoop:Destroy()
				p1.laserLoop = nil
			end)
		end
		task.delay(v2, function()
			p1.laserLoop:Stop()
		end)
		local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		if localPlayer then
			local _, var6 = GeomUtils.closestPointOnLine(p1.Model.Arm.Tip.Position, var22, localPlayer.Position)
			if var6 < 8 and os.clock() - p1.LastHit >= 1 / p1:GetShootHz() then
				p1.LastHit = os.clock()
				p1.onLocalPlayerHit:Fire(Players.LocalPlayer)
			end
		end
	end
	updateLaserToTarget(Tip.Position + Vector3.new(0.01, 0.01, 0.01))
	Part.Parent = workspace
	local var3 = os.clock()
	instance:GiveTask(RunService.Heartbeat:Connect(function()
		if p1.Target then
			local instance = os.clock() - var3
			if v2 <= instance then
				instance = v2
			end
			updateLaserToTarget(Tip.Position:Lerp(p1.Target, (math.clamp(instance / v2 * 5, 0, 1))))
			if instance == v2 then
				p1.Maid.laserMaid = nil
			end
		else
			p1.Maid.laserMaid = nil
		end
	end))
end
function t2.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t2
