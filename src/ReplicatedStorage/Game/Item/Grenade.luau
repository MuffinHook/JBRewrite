-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Module.R15IKv2)
local Joint = require(ReplicatedStorage.Std.Joint)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local Gun = require(script.Parent.Gun)
local function RandomVector()
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local function CalculateProjectileVelocity(p1, p2, p3)
	local v1 = p2 - p1
	local v2 = (v1.x * v1.x + v1.z * v1.z) ^ 0.5
	local Gravity = workspace.Gravity
	local v3 = p3 * p3 * p3 * p3 - Gravity * (Gravity * v2 * v2 + 2 * v1.Y * p3 * p3)
	local v4
	if v3 >= 0 then
		local v5 = v3 ^ 0.5
		v4 = math.min(math.atan((p3 * p3 + v5) / (Gravity * v2)), (math.atan((p3 * p3 - v5) / (Gravity * v2))))
	else
		v4 = 0.7853981633974483
	end
	return Vector3.new(p3 * v1.x / v2 * math.cos(v4), p3 * math.sin(v4), p3 * v1.z / v2 * math.cos(v4)), v2 / (p3 * math.cos(v4))
end
local t = {
	__ClassName = "Grenade"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	v1.ShootProxy = 1
	return v1
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
	local v4 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Explosion:Clone()
	v4.Parent = Part
	v4:Emit(4)
	local v5 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
	v5.Parent = Part
	v5:Emit(50)
	local v6 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Smoke:Clone()
	v6.Parent = Part
	v6:Emit(3)
	local v7 = ReplicatedStorage.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
	v7.Enabled = true
	v7.Parent = Part
	delay(5 - v7.Lifetime.Max, function()
		v7.Enabled = false
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
	local v1 = assert(ReplicatedStorage.Resource.ItemSystem.Models.Grenade, ("Item model for %s does not exist."):format("Grenade")):Clone()
	v1.Model.Handle:Destroy()
	Joint.Weld(v1.Model.Base, v1.Skeleton.BoundingBox)
	v1.Model.Base.Anchored = false
	v1.Skeleton.BoundingBox.Anchored = false
	v1.Parent = workspace.Items
	v1.PrimaryPart = v1.Skeleton.BoundingBox
	local PrimaryPart = v1.PrimaryPart
	PrimaryPart.Velocity = CalculateProjectileVelocity(p1.Model.Skeleton.BoundingBox.Position, p2, 100)
	v1:SetPrimaryPartCFrame(CFrame.new(Vector3.new(), PrimaryPart.Velocity) + p1.Model.Skeleton.BoundingBox.Position)
	PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.9, 0.5, 20, 1)
	delay(0, function()
		PrimaryPart.CanCollide = true
	end)
	delay(p3, function()
		GrenadeExplode(p1, v1)
		v1.Model.Base.CanCollide = true
		local v12 = math.random() * 2 - 1
		local v2 = math.random() * 2 - 1
		v1.Model.Base.Velocity = Vector3.new(v12, v2, math.random() * 2 - 1).Unit * 50
	end)
	delay(p3 + 2, function()
		v1:Destroy()
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
	local v1 = p1.ShootProxy + 1
	p1.ShootProxy = v1
	p1.SpringItemOffset:SetTarget(p1.Config.Motion.Raise.Springs.ItemOffset)
	p1.SpringItemRotation:SetTarget(p1.Config.Motion.Raise.Springs.ItemRotation)
	p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Raise.Springs.NeckRotation)
	local v2 = p1.Model.Model.Handle:Clone()
	v2:ClearAllChildren()
	v2.CanCollide = true
	v2.Anchored = false
	v2.Parent = workspace
	local v3 = math.random() * 2 - 1
	local v4 = math.random() * 2 - 1
	v2.Velocity = Vector3.new(v3, v4, math.random() * 2 - 1).Unit * 50
	delay(5, function()
		v2:Destroy()
	end)
	p1.Model.Model.Handle.Transparency = 1
	delay(p1.Config.FuseTime, function()
		if not p1.Destroyed then
			if p1.ShootProxy ~= v1 then
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
	local v1 = p1.Config.FuseTime - (tick() - p1.GrenadeHeldAt)
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
	p1:GrenadeThrow(p1.MousePosition, v1)
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
