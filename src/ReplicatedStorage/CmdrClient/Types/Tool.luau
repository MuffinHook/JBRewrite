local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util)
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = Util_upvr.MakeFuzzyFinder(require(ReplicatedStorage.Std.TableUtils).map(ReplicatedStorage.Resource.ItemSystem.Models:GetChildren(), function(arg1) -- Line 5
    return arg1.Name
end))
function tbl_upvr.Transform(arg1) -- Line 11
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 15
    local var6
    if 0 >= #arg1 then
        var6 = false
    else
        var6 = true
    end
    return var6, "No valid vehicle makes with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 19
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 23
    return arg1[1]
end
return function(arg1) -- Line 28
    arg1:RegisterType("tool", tbl_upvr)
    arg1:RegisterType("tools", Util_upvr.MakeListableType(tbl_upvr))
end