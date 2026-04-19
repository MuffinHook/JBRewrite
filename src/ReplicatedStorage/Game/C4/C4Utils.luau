-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:07
-- Luau version 6, Types version 3
-- Time taken: 0.002527 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local C4Consts_upvr = require(script.Parent.C4Consts)
function module.getDamageRatio(arg1, arg2, arg3) -- Line 6
    --[[ Upvalues[1]:
        [1]: C4Consts_upvr (readonly)
    ]]
    if not arg3 then
    end
    return 1 - math.clamp((arg2 - arg1).Magnitude / C4Consts_upvr.BLAST_RADIUS, 0, 1)
end
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function module.explosionVisual(arg1) -- Line 14
    --[[ Upvalues[2]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: Audio_upvr (readonly)
    ]]
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
        --[[ Upvalues[1]:
            [1]: clone_upvr_3 (readonly)
        ]]
        clone_upvr_3:Emit(4)
    end)
    local clone_upvr_2 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Debris:Clone()
    clone_upvr_2.Parent = Part
    task.delay(0.03333333333333333, function() -- Line 37
        --[[ Upvalues[1]:
            [1]: clone_upvr_2 (readonly)
        ]]
        clone_upvr_2:Emit(50)
    end)
    local clone_upvr = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Smoke:Clone()
    clone_upvr.Parent = Part
    task.delay(0.03333333333333333, function() -- Line 43
        --[[ Upvalues[1]:
            [1]: clone_upvr (readonly)
        ]]
        clone_upvr:Emit(3)
    end)
    local clone_upvr_4 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
    clone_upvr_4.Enabled = true
    clone_upvr_4.Parent = Part
    task.delay(5 - clone_upvr_4.Lifetime.Max, function() -- Line 51
        --[[ Upvalues[1]:
            [1]: clone_upvr_4 (readonly)
        ]]
        clone_upvr_4.Enabled = false
    end)
    Audio_upvr.ObjectLocal(Part, 2205008239, {
        Volume = 1;
    }).EmitterSize = 20
end
return module