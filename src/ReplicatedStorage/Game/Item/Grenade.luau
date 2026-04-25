-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Module.R15IKv2)
local Joint = require(ReplicatedStorage.Std.Joint)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local Gun = require(script.Parent.Gun)
local function RandomVector()
	local dirX = math.random() * 2 - 1
	local dirY = math.random() * 2 - 1
	return Vector3.new(dirX, dirY, math.random() * 2 - 1).Unit
end
local function CalculateProjectileVelocity(p1, p2, p3)
	local displacement = p2 - p1
	local horizontalDist = (displacement.x * displacement.x + displacement.z * displacement.z) ^ 0.5
	local Gravity = workspace.Gravity
	local discriminant = p3 * p3 * p3 * p3 - Gravity * (Gravity * horizontalDist * horizontalDist + 2 * displacement.Y * p3 * p3)
	local launchAngle
	if discriminant >= 0 then
		local sqrtDisc = discriminant ^ 0.5
		launchAngle = math.min(math.atan((p3 * p3 + sqrtDisc) / (Gravity * horizontalDist)), (math.atan((p3 * p3 - sqrtDisc) / (Gravity * horizontalDist))))
	else
		launchAngle = 0.7853981633974483
	end
	return Vector3.new(p3 * displacement.x / horizontalDist * math.cos(launchAngle), p3 * math.sin(launchAngle), p3 * displacement.z / horizontalDist * math.cos(launchAngle)), horizontalDist / (p3 * math.cos(launchAngle))
end
local t = {
	__ClassName = "Grenade"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local instance = Gun.new(p1, p2, p3)
	setmetatable(instance, t)
	instance:Setup(p3)
	instance.ShootProxy = 1
	return instance
end
function t.SetupArmWelds(p1)  end
function t.UpdateArmIK(p1)
	local IK = p1.IK
	IK.RightArm = p1.Model.Model.Base.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
end
function t.SetupTip(p1)
	p1.TipOffset = Vector3.new()
end
local function GrenadeExplode(p1, p2)
	local Position = p2.Skeleton.BoundingBox.Position
	if p1.BulletEmitter.Bullets then
		for i = 1, 30 do
			local Unit = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
			p1.BulletEmitter:Emit(Position, Unit, 400)
		end
	end
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(0.1, 0.1, 0.1)
	Part.CanCollide = false
	Part.Anchored = true
	Part.Transparency = 1
	Part.Position = Position
	Part.Parent = workspace
	local explosionEffect = ReplicatedStorage.Resource.ItemSystem.Projectiles.Explosion:Clone()
	explosionEffect.Parent = Part
	explosionEffect:Emit(4)
	local debrisEffect = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
	debrisEffect.Parent = Part
	debrisEffect:Emit(50)
	local smokeEffect = ReplicatedStorage.Resource.ItemSystem.Projectiles.Smoke:Clone()
	smokeEffect.Parent = Part
	smokeEffect:Emit(3)
	local landingSmokeEffect = ReplicatedStorage.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
	landingSmokeEffect.Enabled = true
	landingSmokeEffect.Parent = Part
	delay(5 - landingSmokeEffect.Lifetime.Max, function()
		landingSmokeEffect.Enabled = false
	end)
	game.Debris:AddItem(Part, 5)
	Audio.ObjectLocal(Part, p1.Config.Sound.explosion_large_02, {
		Volume = 1
	}).EmitterSize = 20
	if p1.Local then
		p1.inventoryItemValue:FindFirstChild(GunSystemConsts.DAMAGE_REMOTE_NAME):FireServer(Position)
	end
end
function t.GrenadeThrow(p1, p2, p3)
	local grenadeModel = assert(ReplicatedStorage.Resource.ItemSystem.Models.Grenade, ("Item model for %s does not exist."):format("Grenade")):Clone()
	grenadeModel.Model.Handle:Destroy()
	Joint.Weld(grenadeModel.Model.Base, grenadeModel.Skeleton.BoundingBox)
	grenadeModel.Model.Base.Anchored = false
	grenadeModel.Skeleton.BoundingBox.Anchored = false
	grenadeModel.Parent = workspace.Items
	grenadeModel.PrimaryPart = grenadeModel.Skeleton.BoundingBox
	local PrimaryPart = grenadeModel.PrimaryPart
	PrimaryPart.Velocity = CalculateProjectileVelocity(p1.Model.Skeleton.BoundingBox.Position, p2, 100)
	grenadeModel:SetPrimaryPartCFrame(CFrame.new(Vector3.new(), PrimaryPart.Velocity) + p1.Model.Skeleton.BoundingBox.Position)
	PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.9, 0.5, 20, 1)
	delay(0, function()
		PrimaryPart.CanCollide = true
	end)
	delay(p3, function()
		GrenadeExplode(p1, grenadeModel)
		grenadeModel.Model.Base.CanCollide = true
		local randomX = math.random() * 2 - 1
		local randomY = math.random() * 2 - 1
		grenadeModel.Model.Base.Velocity = Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit * 50
	end)
	delay(p3 + 2, function()
		grenadeModel:Destroy()
	end)
	if p1.Local then
		p1.inventoryItemValue:FindFirstChild(GunSystemConsts.SHOOT_REMOTE_NAME):FireServer()
	end
end
function t.BulletEmitterOnLocalHitPlayer(p1)  end
function t.ShootBegin(p1, p2)
	if not p1:ShootCheckConditions() then
		return false
	end
	p1:DecrementAmmo()
	p1:SetNextShotPossible()
	p1.GrenadeHeldAt = tick()
	local proxyIncrement = p1.ShootProxy + 1
	p1.ShootProxy = proxyIncrement
	p1.SpringItemOffset:SetTarget(p1.Config.Motion.Raise.Springs.ItemOffset)
	p1.SpringItemRotation:SetTarget(p1.Config.Motion.Raise.Springs.ItemRotation)
	p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Raise.Springs.NeckRotation)
	local detachedHandle = p1.Model.Model.Handle:Clone()
	detachedHandle:ClearAllChildren()
	detachedHandle.CanCollide = true
	detachedHandle.Anchored = false
	detachedHandle.Parent = workspace
	local dropX = math.random() * 2 - 1
	local dropY = math.random() * 2 - 1
	detachedHandle.Velocity = Vector3.new(dropX, dropY, math.random() * 2 - 1).Unit * 50
	delay(5, function()
		detachedHandle:Destroy()
	end)
	p1.Model.Model.Handle.Transparency = 1
	delay(p1.Config.FuseTime, function()
		if not p1.Destroyed then
			if p1.ShootProxy ~= proxyIncrement then
				return false
			end
			p1:ShootEnd(p2)
		end
	end)
	if p1.Local then
		p1:BroadcastInputBegan(p2)
	end
end
function t.ShootEnd(p1, p2)
	if not p1.GrenadeHeldAt then
		return false
	end
	local remainingFuse = p1.Config.FuseTime - (tick() - p1.GrenadeHeldAt)
	p1.GrenadeHeldAt = nil
	p1.SpringItemOffset:SetTarget(p1.Config.Motion.Launch.Springs.ItemOffset)
	p1.SpringItemRotation:SetTarget(p1.Config.Motion.Launch.Springs.ItemRotation)
	p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Launch.Springs.NeckRotation)
	delay(0.2, function()
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
		p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
	end)
	local Model = p1.Model
	Model.Model.Base.Transparency = 1
	Model.Model.Handle.Transparency = 1
	delay(p1.Config.ReloadTime, function()
		if p1.Destroyed then
			return false
		end
		Model.Model.Base.Transparency = 0
		Model.Model.Handle.Transparency = 0
	end)
	p1:GrenadeThrow(p1.MousePosition, remainingFuse)
	if p1.Local then
		p1:BroadcastInputEnded(p2)
	end
end
function t.ShootOther(p1)  end
function t.ShootSound(p1, p2)
	if p2 then
		Audio.ObjectLocal(p1.Model.Skeleton.BoundingBox, p1.Config.Sound.gun_pistol_dry_fire_01, {
			Volume = 0.6,
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	end
end
t.ApplySkin = false
t.ScopeBegin = false
t.ScopeEnd = false
t.Reload = false
return t
