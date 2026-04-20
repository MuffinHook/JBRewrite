local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {}
for _, v in require(ReplicatedStorage.App.RunConsts).PLACE_ID_TO_WORLD_MAP do
    if table.find(tbl, v) == nil then
        table.insert(tbl, v)
    end
end
local tbl_2_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(tbl)
function tbl_2_upvr.Transform(arg1) -- Line 17
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_2_upvr.Validate(arg1) -- Line 21
    local var7
    if 0 >= #arg1 then
        var7 = false
    else
        var7 = true
    end
    return var7, "No valid world with that name could be found."
end
function tbl_2_upvr.Autocomplete(arg1) -- Line 25
    return arg1
end
function tbl_2_upvr.Parse(arg1) -- Line 29
    return arg1[1]
end
return function(arg1) -- Line 34
    arg1:RegisterType("world", tbl_2_upvr)
end