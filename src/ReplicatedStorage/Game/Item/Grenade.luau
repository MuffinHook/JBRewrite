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
local function CalculateProjectileVelocity(startPosition, targetPosition, projectileSpeed)
	local displacement = targetPosition - startPosition
	local horizontalDist = (displacement.x * displacement.x + displacement.z * displacement.z) ^ 0.5
	local Gravity = workspace.Gravity
	local discriminant = projectileSpeed * projectileSpeed * projectileSpeed * projectileSpeed - Gravity * (Gravity * horizontalDist * horizontalDist + 2 * displacement.Y * projectileSpeed * projectileSpeed)
	local launchAngle
	if discriminant >= 0 then
		local sqrtDisc = discriminant ^ 0.5
		launchAngle = math.min(math.atan((projectileSpeed * projectileSpeed + sqrtDisc) / (Gravity * horizontalDist)), (math.atan((projectileSpeed * projectileSpeed - sqrtDisc) / (Gravity * horizontalDist))))
	else
		launchAngle = math.pi / 4
	end
	return Vector3.new(projectileSpeed * displacement.x / horizontalDist * math.cos(launchAngle), projectileSpeed * math.sin(launchAngle), projectileSpeed * displacement.z / horizontalDist * math.cos(launchAngle)), horizontalDist / (projectileSpeed * math.cos(launchAngle))
end
local t = {
	__ClassName = "Grenade"
}
t.__index = t
setmetatable(t, Gun)
function t.new(player, config, setupConfig)
	local instance = Gun.new(player, config, setupConfig)
	setmetatable(instance, t)
	instance:Setup(setupConfig)
	instance.ShootProxy = 1
	return instance
end
function t.SetupArmWelds(grenadeInstance)  end
function t.UpdateArmIK(grenadeInstance)
	local IK = grenadeInstance.IK
	IK.RightArm = grenadeInstance.Model.Model.Base.Position
	IK.RightAngle = grenadeInstance.Config.Motion.RightElbowAngle
end
function t.SetupTip(grenadeInstance)
	grenadeInstance.TipOffset = Vector3.new()
end
local function GrenadeExplode(grenadeInstance, grenadeModel)
	local Position = grenadeModel.Skeleton.BoundingBox.Position
	if grenadeInstance.BulletEmitter.Bullets then
		for i = 1, 30 do
			local Unit = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
			grenadeInstance.BulletEmitter:Emit(Position, Unit, 400)
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
	task.delay(5 - landingSmokeEffect.Lifetime.Max, function()
		landingSmokeEffect.Enabled = false
	end)
	game.Debris:AddItem(Part, 5)
	Audio.ObjectLocal(Part, grenadeInstance.Config.Sound.explosion_large_02, {
		Volume = 1
	}).EmitterSize = 20
	if grenadeInstance.Local then
		grenadeInstance.inventoryItemValue:FindFirstChild(GunSystemConsts.DAMAGE_REMOTE_NAME):FireServer(Position)
	end
end
function t.GrenadeThrow(grenadeInstance, targetPosition, fuseTime)
	local grenadeModel = assert(ReplicatedStorage.Resource.ItemSystem.Models.Grenade, ("Item model for %s does not exist."):format("Grenade")):Clone()
	grenadeModel.Model.Handle:Destroy()
	Joint.Weld(grenadeModel.Model.Base, grenadeModel.Skeleton.BoundingBox)
	grenadeModel.Model.Base.Anchored = false
	grenadeModel.Skeleton.BoundingBox.Anchored = false
	grenadeModel.Parent = workspace.Items
	grenadeModel.PrimaryPart = grenadeModel.Skeleton.BoundingBox
	local PrimaryPart = grenadeModel.PrimaryPart
	PrimaryPart.Velocity = CalculateProjectileVelocity(grenadeInstance.Model.Skeleton.BoundingBox.Position, targetPosition, 100)
	grenadeModel:SetPrimaryPartCFrame(CFrame.new(Vector3.new(), PrimaryPart.Velocity) + grenadeInstance.Model.Skeleton.BoundingBox.Position)
	PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.9, 0.5, 20, 1)
	task.delay(0, function()
		PrimaryPart.CanCollide = true
	end)
	task.delay(fuseTime, function()
		GrenadeExplode(grenadeInstance, grenadeModel)
		grenadeModel.Model.Base.CanCollide = true
		local randomX = math.random() * 2 - 1
		local randomY = math.random() * 2 - 1
		grenadeModel.Model.Base.Velocity = Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit * 50
	end)
	task.delay(fuseTime + 2, function()
		grenadeModel:Destroy()
	end)
	if grenadeInstance.Local then
		grenadeInstance.inventoryItemValue:FindFirstChild(GunSystemConsts.SHOOT_REMOTE_NAME):FireServer()
	end
end
function t.BulletEmitterOnLocalHitPlayer(grenadeInstance)  end
function t.ShootBegin(grenadeInstance, inputDirection)
	if not grenadeInstance:ShootCheckConditions() then
		return false
	end
	grenadeInstance:DecrementAmmo()
	grenadeInstance:SetNextShotPossible()
	grenadeInstance.GrenadeHeldAt = tick()
	local proxyIncrement = grenadeInstance.ShootProxy + 1
	grenadeInstance.ShootProxy = proxyIncrement
	grenadeInstance.SpringItemOffset:SetTarget(grenadeInstance.Config.Motion.Raise.Springs.ItemOffset)
	grenadeInstance.SpringItemRotation:SetTarget(grenadeInstance.Config.Motion.Raise.Springs.ItemRotation)
	grenadeInstance.SpringNeckRotation:SetTarget(grenadeInstance.Config.Motion.Raise.Springs.NeckRotation)
	local detachedHandle = grenadeInstance.Model.Model.Handle:Clone()
	detachedHandle:ClearAllChildren()
	detachedHandle.CanCollide = true
	detachedHandle.Anchored = false
	detachedHandle.Parent = workspace
	local dropX = math.random() * 2 - 1
	local dropY = math.random() * 2 - 1
	detachedHandle.Velocity = Vector3.new(dropX, dropY, math.random() * 2 - 1).Unit * 50
	task.delay(5, function()
		detachedHandle:Destroy()
	end)
	grenadeInstance.Model.Model.Handle.Transparency = 1
	task.delay(grenadeInstance.Config.FuseTime, function()
		if not grenadeInstance.Destroyed then
			if grenadeInstance.ShootProxy ~= proxyIncrement then
				return false
			end
			grenadeInstance:ShootEnd(inputDirection)
		end
	end)
	if grenadeInstance.Local then
		grenadeInstance:BroadcastInputBegan(inputDirection)
	end
end
function t.ShootEnd(grenadeInstance, inputDirection)
	if not grenadeInstance.GrenadeHeldAt then
		return false
	end
	local remainingFuse = grenadeInstance.Config.FuseTime - (tick() - grenadeInstance.GrenadeHeldAt)
	grenadeInstance.GrenadeHeldAt = nil
	grenadeInstance.SpringItemOffset:SetTarget(grenadeInstance.Config.Motion.Launch.Springs.ItemOffset)
	grenadeInstance.SpringItemRotation:SetTarget(grenadeInstance.Config.Motion.Launch.Springs.ItemRotation)
	grenadeInstance.SpringNeckRotation:SetTarget(grenadeInstance.Config.Motion.Launch.Springs.NeckRotation)
	task.delay(0.2, function()
		grenadeInstance.SpringItemOffset:SetTarget(grenadeInstance.Config.Motion.Hip.Springs.ItemOffset)
		grenadeInstance.SpringItemRotation:SetTarget(grenadeInstance.Config.Motion.Hip.Springs.ItemRotation)
		grenadeInstance.SpringNeckRotation:SetTarget(grenadeInstance.Config.Motion.Hip.Springs.NeckRotation)
	end)
	local Model = grenadeInstance.Model
	Model.Model.Base.Transparency = 1
	Model.Model.Handle.Transparency = 1
	task.delay(grenadeInstance.Config.ReloadTime, function()
		if grenadeInstance.Destroyed then
			return false
		end
		Model.Model.Base.Transparency = 0
		Model.Model.Handle.Transparency = 0
	end)
	grenadeInstance:GrenadeThrow(grenadeInstance.MousePosition, remainingFuse)
	if grenadeInstance.Local then
		grenadeInstance:BroadcastInputEnded(inputDirection)
	end
end
function t.ShootOther(grenadeInstance)  end
function t.ShootSound(grenadeInstance, shouldPlayDryFire)
	if shouldPlayDryFire then
		Audio.ObjectLocal(grenadeInstance.Model.Skeleton.BoundingBox, grenadeInstance.Config.Sound.gun_pistol_dry_fire_01, {
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
