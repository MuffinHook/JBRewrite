-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:35
-- Luau version 6, Types version 3
-- Time taken: 0.002373 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local tbl_upvr = {
    explosion_large_02 = 2205008239;
}
local RocketLauncherConsts_upvr = require(script.Parent.RocketLauncherConsts)
function module.getMissileItemPoolObj(arg1) -- Line 8
    --[[ Upvalues[1]:
        [1]: RocketLauncherConsts_upvr (readonly)
    ]]
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
    --[[ Upvalues[3]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: Audio_upvr (readonly)
        [3]: tbl_upvr (readonly)
    ]]
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
        --[[ Upvalues[1]:
            [1]: clone_upvr (readonly)
        ]]
        clone_upvr.Enabled = false
    end)
    game.Debris:AddItem(Part, 10)
    Audio_upvr.ObjectLocal(Part, tbl_upvr.explosion_large_02, {
        Volume = 1;
    }).EmitterSize = 20
end
return module