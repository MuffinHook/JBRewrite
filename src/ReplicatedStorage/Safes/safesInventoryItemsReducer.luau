local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local SAFE_DATA_upvr = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
function module.setSafesInventoryItems(arg1, arg2) -- Line 8
    local var8
    if arg2.itemsOwned == nil then
        var8 = false
    else
        var8 = true
    end
    assert(var8, "missing itemsOwned")
    local module_2 = {}
    var8 = arg2.itemsOwned
    for i, v in var8 do
        assert(v.Id, "missing Id")
        local TypeEnum = v.TypeEnum
        local var11 = SAFE_DATA_upvr[TypeEnum]
        local var12
        if var11 == nil then
            var12 = false
        else
            var12 = true
        end
        assert(var12, "missing safeTierData")
        var12 = module_2
        table.insert(var12, {
            name = string.format(("%s_%s"), TypeEnum, i);
            typeEnum = TypeEnum;
            imageId = var11.ImageId;
            itemOwnedId = v.Id;
        })
    end
    return module_2
end
return require(ReplicatedStorage.Rodux).createReducer({}, module)
