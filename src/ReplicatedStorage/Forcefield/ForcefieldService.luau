local ReplicatedStorage = game:GetService("ReplicatedStorage")
local var2_upvw = 0
local function _() -- Line 11, Named "GetUID"
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
    module_upvr.disallowedRegion = Region_upvr.new(RegionUtils_upvr.NilCondition)
    Binder_upvr.new(ForcefieldConsts_upvr.FORCEFIELD_DISALLOWED_PART_TAG, function(arg1) -- Line 21
        local any_new_result1 = Maid_upvr.new()
        any_new_result1:GiveTask(module_upvr.disallowedRegion:AddPrism(RegionUtils_upvr.getPrism(arg1.CFrame, Vector3.new(arg1.Size.X, 10000, arg1.Size.Z))))
        return any_new_result1
    end):Start()
    return true
end
function module_upvr.add(arg1, arg2, arg3) -- Line 32
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
    return not module_upvr.disallowedRegion:CastPoint(arg1)
end
return module_upvr