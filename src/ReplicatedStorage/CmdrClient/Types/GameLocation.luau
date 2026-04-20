local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {}
for i in require(ReplicatedStorage.App.GameLocations), nil do
    table.insert(tbl, i)
end
local tbl_2_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(tbl)
function tbl_2_upvr.Transform(arg1) -- Line 16
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_2_upvr.Validate(arg1) -- Line 20
    local var7
    if 0 >= #arg1 then
        var7 = false
    else
        var7 = true
    end
    return var7, "No valid robbery with that name could be found."
end
function tbl_2_upvr.Autocomplete(arg1) -- Line 24
    return arg1
end
function tbl_2_upvr.Parse(arg1) -- Line 28
    return arg1[1]
end
return function(arg1) -- Line 33
    arg1:RegisterType("gameLocation", tbl_2_upvr)
end