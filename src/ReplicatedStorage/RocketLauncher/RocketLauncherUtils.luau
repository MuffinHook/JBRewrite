-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local RocketLauncherConsts = require(script.Parent.RocketLauncherConsts)
local tbl = {}
local t2 = {
	explosion_large_02 = 2205008239
}
function tbl.getMissileItemPoolObj(p1)
	assert(typeof(p1) == "Instance")
	return p1:FindFirstChild(RocketLauncherConsts.MISSILE_OBJ_POOL_NAME)
end
function tbl.explodeAt(p1)
	assert(p1)
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(0.1, 0.1, 0.1)
	Part.CanCollide = false
	Part.Anchored = true
	Part.Transparency = 1
	Part.Position = p1
	Part.Parent = workspace
	local v1 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Explosion:Clone()
	v1.Parent = Part
	v1:Emit(4)
	local v2 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
	v2.Parent = Part
	v2:Emit(50)
	local v3 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Smoke:Clone()
	v3.Parent = Part
	v3:Emit(3)
	local v4 = ReplicatedStorage.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
	v4.Enabled = true
	v4.Parent = Part
	delay(10 - v4.Lifetime.Max, function()
 v4.Enabled = false
	end)
	game.Debris:AddItem(Part, 10)
	Audio.ObjectLocal(Part, t2.explosion_large_02, {
 Volume = 1
	}).EmitterSize = 20
end
return tbl