-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:13
-- Luau version 6, Types version 3
-- Time taken: 0.003135 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NPCUtils_upvr = require(ReplicatedStorage.NPC.NPCUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local setupAnimations_upvr = require(ReplicatedStorage.NPC.setupAnimations)
local NPCShared_upvr = require(ReplicatedStorage.NPC.NPCShared)
function module_upvr.new(arg1, arg2) -- Line 12
    --[[ Upvalues[4]:
        [1]: module_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: setupAnimations_upvr (readonly)
        [4]: NPCShared_upvr (readonly)
    ]]
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2.maid = Maid_upvr.new()
    module_upvr_2._maid = module_upvr_2.maid
    module_upvr_2.obj = arg1
    module_upvr_2.manifest = arg2
    module_upvr_2.humanoid = arg2.humanoid
    module_upvr_2._humanoid = module_upvr_2.humanoid
    module_upvr_2.maid:GiveTask(task.delay(0.5, function() -- Line 28
        --[[ Upvalues[3]:
            [1]: module_upvr_2 (readonly)
            [2]: setupAnimations_upvr (copied, readonly)
            [3]: arg1 (readonly)
        ]]
        module_upvr_2.maid:GiveTask(setupAnimations_upvr(arg1))
    end))
    NPCShared_upvr.setup(module_upvr_2)
    return module_upvr_2
end
local Players_upvr = game:GetService("Players")
function module_upvr.IsLocallyOwned(arg1) -- Line 35
    --[[ Upvalues[2]:
        [1]: NPCUtils_upvr (readonly)
        [2]: Players_upvr (readonly)
    ]]
    local var10
    if NPCUtils_upvr.getNetworkOwner(arg1.obj) ~= Players_upvr.LocalPlayer then
        var10 = false
    else
        var10 = true
    end
    return var10
end
function module_upvr.GetTargetType(arg1) -- Line 38
    --[[ Upvalues[1]:
        [1]: NPCUtils_upvr (readonly)
    ]]
    return NPCUtils_upvr.getTargetType(arg1.obj)
end
function module_upvr.SetTargetType(arg1, arg2) -- Line 41
    --[[ Upvalues[1]:
        [1]: NPCUtils_upvr (readonly)
    ]]
    NPCUtils_upvr.setTargetType(arg1.obj, arg2)
end
function module_upvr.GetTarget(arg1) -- Line 44
    --[[ Upvalues[1]:
        [1]: NPCUtils_upvr (readonly)
    ]]
    return NPCUtils_upvr.getTarget(arg1.obj)
end
function module_upvr.SetLookAt(arg1, arg2, arg3) -- Line 48
    --[[ Upvalues[1]:
        [1]: NPCUtils_upvr (readonly)
    ]]
    NPCUtils_upvr.setLookAt(arg1.obj, arg2, arg3)
end
function module_upvr.Destroy(arg1) -- Line 51
    arg1.maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr