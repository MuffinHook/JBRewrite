local module_2 = {}
local TradeReducerUtils_upvr = require(game:GetService("ReplicatedStorage").Trade.TradeReducerUtils)
function module_2.setItemsOwned(arg1, arg2) -- Line 5
    local var7
    if arg2.itemsOwned == nil then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "missing itemsOwned")
    local module = {}
    var7 = {}
    for i = 1, #arg2.itemsOwned do
        local any_buildItemProps_result1 = TradeReducerUtils_upvr.buildItemProps(arg2.itemsOwned[i])
        if any_buildItemProps_result1 then
            any_buildItemProps_result1.timeSortMetric = -i
            any_buildItemProps_result1.primaryIndex = i
            local var10 = (var7[any_buildItemProps_result1.getInstCompare] or 0) + 1
            var7[any_buildItemProps_result1.getInstCompare] = var10
            any_buildItemProps_result1.number = var10
            table.insert(module, any_buildItemProps_result1)
        end
    end
    for i_2 = 1, #module do
        local var11 = module[i_2]
        if var7[var11.getInstCompare] <= 1 then
            var11.number = nil
        end
    end
    return module
end
return module_2