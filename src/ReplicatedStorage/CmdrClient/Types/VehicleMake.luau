local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util)
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = Util_upvr.MakeFuzzyFinder(require(ReplicatedStorage.Std.TableUtils).map(require(ReplicatedStorage.Game.Garage.VehicleData), function(arg1) -- Line 6
    return arg1.Make
end))
function tbl_upvr.Transform(arg1) -- Line 12
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 16
    local var6
    if 0 >= #arg1 then
        var6 = false
    else
        var6 = true
    end
    return var6, "No valid vehicle makes with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 20
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 24
    return arg1[1]
end
return function(arg1) -- Line 29
    arg1:RegisterType("vehicleMake", tbl_upvr)
    arg1:RegisterType("vehicleMakes", Util_upvr.MakeListableType(tbl_upvr))
end