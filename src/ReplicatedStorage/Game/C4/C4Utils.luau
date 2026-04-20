local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local C4Consts_upvr = require(script.Parent.C4Consts)
function module.getDamageRatio(arg1, arg2, arg3) -- Line 6
    if not arg3 then
    end
    return 1 - math.clamp((arg2 - arg1).Magnitude / C4Consts_upvr.BLAST_RADIUS, 0, 1)
end
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function module.explosionVisual(arg1) -- Line 14
    local Part = Instance.new("Part")
    Part.Size = Vector3.new(0.10000, 0.10000, 0.10000)
    Part.CanCollide = false
    Part.Anchored = true
    Part.Transparency = 1
    Part.Position = arg1
    Part.Parent = workspace
    game:GetService("Debris"):AddItem(Part, 5)
    local clone_upvr_3 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Explosion:Clone()
    clone_upvr_3.Parent = Part
    task.delay(0.03333333333333333, function() -- Line 31
        clone_upvr_3:Emit(4)
    end)
    local clone_upvr_2 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Debris:Clone()
    clone_upvr_2.Parent = Part
    task.delay(0.03333333333333333, function() -- Line 37
        clone_upvr_2:Emit(50)
    end)
    local clone_upvr = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Smoke:Clone()
    clone_upvr.Parent = Part
    task.delay(0.03333333333333333, function() -- Line 43
        clone_upvr:Emit(3)
    end)
    local clone_upvr_4 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
    clone_upvr_4.Enabled = true
    clone_upvr_4.Parent = Part
    task.delay(5 - clone_upvr_4.Lifetime.Max, function() -- Line 51
        clone_upvr_4.Enabled = false
    end)
    Audio_upvr.ObjectLocal(Part, 2205008239, {
        Volume = 1;
    }).EmitterSize = 20
end
return module