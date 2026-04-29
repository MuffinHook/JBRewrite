local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local RocketLauncherConsts = require(script.Parent.RocketLauncherConsts)
local tbl = {}
local explosionAssets = {
	explosion_large_02 = 2205008239
}
function tbl.getMissileItemPoolObj(parentInstance)
	assert(typeof(parentInstance) == "Instance")
	return parentInstance:FindFirstChild(RocketLauncherConsts.MISSILE_OBJ_POOL_NAME)
end
function tbl.explodeAt(explosionPosition)
	assert(explosionPosition)
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(0.1, 0.1, 0.1)
	Part.CanCollide = false
	Part.Anchored = true
	Part.Transparency = 1
	Part.Position = explosionPosition
	Part.Parent = workspace
	local explosionEmitter = ReplicatedStorage.Resource.ItemSystem.Projectiles.Explosion:Clone()
	explosionEmitter.Parent = Part
	explosionEmitter:Emit(4)
	local debrisEmitter = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
	debrisEmitter.Parent = Part
	debrisEmitter:Emit(50)
	local smokeEmitter = ReplicatedStorage.Resource.ItemSystem.Projectiles.Smoke:Clone()
	smokeEmitter.Parent = Part
	smokeEmitter:Emit(3)
	local landingSmokeEmitter = ReplicatedStorage.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
	landingSmokeEmitter.Enabled = true
	landingSmokeEmitter.Parent = Part
	task.delay(10 - landingSmokeEmitter.Lifetime.Max, function()
 landingSmokeEmitter.Enabled = false
	end)
	game.Debris:AddItem(Part, 10)
	Audio.ObjectLocal(Part, explosionAssets.explosion_large_02, {
 Volume = 1
	}).EmitterSize = 20
end
return tbl
