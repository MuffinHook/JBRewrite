-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:59
-- Luau version 6, Types version 3
-- Time taken: 0.003573 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local var2_upvw = 0
local function _() -- Line 11, Named "GetUID"
    --[[ Upvalues[1]:
        [1]: var2_upvw (read and write)
    ]]
    var2_upvw += 1
    return var2_upvw
end
local module_upvr = {
    ListShields = {};
}
local Region_upvr = require(ReplicatedStorage.Std.Region)
local RegionUtils_upvr = require(ReplicatedStorage.Std.Region.RegionUtils)
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local ForcefieldConsts_upvr = require(ReplicatedStorage.Forcefield.ForcefieldConsts)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.init() -- Line 19
    --[[ Upvalues[6]:
        [1]: module_upvr (readonly)
        [2]: Region_upvr (readonly)
        [3]: RegionUtils_upvr (readonly)
        [4]: Binder_upvr (readonly)
        [5]: ForcefieldConsts_upvr (readonly)
        [6]: Maid_upvr (readonly)
    ]]
    module_upvr.disallowedRegion = Region_upvr.new(RegionUtils_upvr.NilCondition)
    Binder_upvr.new(ForcefieldConsts_upvr.FORCEFIELD_DISALLOWED_PART_TAG, function(arg1) -- Line 21
        --[[ Upvalues[3]:
            [1]: Maid_upvr (copied, readonly)
            [2]: RegionUtils_upvr (copied, readonly)
            [3]: module_upvr (copied, readonly)
        ]]
        local any_new_result1 = Maid_upvr.new()
        any_new_result1:GiveTask(module_upvr.disallowedRegion:AddPrism(RegionUtils_upvr.getPrism(arg1.CFrame, Vector3.new(arg1.Size.X, 10000, arg1.Size.Z))))
        return any_new_result1
    end):Start()
    return true
end
function module_upvr.add(arg1, arg2, arg3) -- Line 32
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    if module_upvr.disallowedRegion:CastPoint(arg1) then
        return nil
    end
    local module = {}
    module.Position = arg1
    module.Radius = arg2
    module.Id = arg3
    table.insert(module_upvr.ListShields, module)
    return arg3, module
end
function module_upvr.removeById(arg1) -- Line 40
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local ListShields = module_upvr.ListShields
    for i = #ListShields, 1, -1 do
        if ListShields[i].Id == arg1 then
            table.remove(ListShields, i)
            return true
        end
    end
    return false
end
function module_upvr.getIsPositionAllowed(arg1) -- Line 50
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return not module_upvr.disallowedRegion:CastPoint(arg1)
end
return module_upvr