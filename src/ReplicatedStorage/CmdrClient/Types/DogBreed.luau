local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(require(ReplicatedStorage.Game.Dog.DogConsts).LIST_BREED)
function tbl_upvr.Transform(arg1) -- Line 10
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 14
    local var4
    if 0 >= #arg1 then
        var4 = false
    else
        var4 = true
    end
    return var4, "No valid breeds with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 18
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 22
    return arg1[1]
end
return function(arg1) -- Line 27
    arg1:RegisterType("dogbreed", tbl_upvr)
end