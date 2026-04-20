local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util)
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = Util_upvr.MakeFuzzyFinder(require(ReplicatedStorage.Robbery.RobberyConsts).LIST_ROBBERY)
function tbl_upvr.Transform(arg1) -- Line 11
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 15
    local var5
    if 0 >= #arg1 then
        var5 = false
    else
        var5 = true
    end
    return var5, "No valid robbery with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 19
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 23
    return arg1[1]
end
return function(arg1) -- Line 28
    arg1:RegisterType("robbery", tbl_upvr)
    arg1:RegisterType("robberies", Util_upvr.MakeListableType(tbl_upvr))
end