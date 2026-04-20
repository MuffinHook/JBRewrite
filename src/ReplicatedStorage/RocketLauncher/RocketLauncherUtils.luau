local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local tbl_upvr = {
    explosion_large_02 = 2205008239;
}
local RocketLauncherConsts_upvr = require(script.Parent.RocketLauncherConsts)
function module.getMissileItemPoolObj(arg1) -- Line 8
    local var5
    if typeof(arg1) ~= "Instance" then
        var5 = false
    else
        var5 = true
    end
    assert(var5)
    return arg1:FindFirstChild(RocketLauncherConsts_upvr.MISSILE_OBJ_POOL_NAME)
end
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function module.explodeAt(arg1) -- Line 12
    assert(arg1)
    local Part = Instance.new("Part")
    Part.Size = Vector3.new(0.10000, 0.10000, 0.10000)
    Part.CanCollide = false
    Part.Anchored = true
    Part.Transparency = 1
    Part.Position = arg1
    Part.Parent = workspace
    local clone = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Explosion:Clone()
    clone.Parent = Part
    clone:Emit(4)
    local clone_3 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Debris:Clone()
    clone_3.Parent = Part
    clone_3:Emit(50)
    local clone_2 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Smoke:Clone()
    clone_2.Parent = Part
    clone_2:Emit(3)
    local clone_upvr = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
    clone_upvr.Enabled = true
    clone_upvr.Parent = Part
    delay(10 - clone_upvr.Lifetime.Max, function() -- Line 39
        clone_upvr.Enabled = false
    end)
    game.Debris:AddItem(Part, 10)
    Audio_upvr.ObjectLocal(Part, tbl_upvr.explosion_large_02, {
        Volume = 1;
    }).EmitterSize = 20
end
return module