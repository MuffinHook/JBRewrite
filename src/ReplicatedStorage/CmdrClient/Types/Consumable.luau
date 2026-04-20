local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {}
for i, _ in require(ReplicatedStorage.Consumables.ConsumablesData), nil do
    table.insert(tbl, i)
end
local tbl_2_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(tbl)
function tbl_2_upvr.Transform(arg1) -- Line 12
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_2_upvr.Validate(arg1) -- Line 16
    local var9
    if 0 >= #arg1 then
        var9 = false
    else
        var9 = true
    end
    return var9, "No valid consumable with that name could be found."
end
function tbl_2_upvr.Autocomplete(arg1) -- Line 20
    return arg1
end
function tbl_2_upvr.Parse(arg1) -- Line 24
    return arg1[1]
end
return function(arg1) -- Line 29
    arg1:RegisterType("consumable", tbl_2_upvr)
end