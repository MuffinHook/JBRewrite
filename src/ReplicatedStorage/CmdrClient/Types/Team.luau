local Util_upvr = require(script.Parent.Parent.Shared.Util)
local tbl_upvr_2 = {}
local Teams_upvr = game:GetService("Teams")
function tbl_upvr_2.Transform(arg1) -- Line 5
    return Util_upvr.MakeFuzzyFinder(Teams_upvr:GetTeams())(arg1)
end
function tbl_upvr_2.Validate(arg1) -- Line 11
    local var4
    if 0 >= #arg1 then
        var4 = false
    else
        var4 = true
    end
    return var4, "No team with that name could be found."
end
function tbl_upvr_2.Autocomplete(arg1) -- Line 15
    return Util_upvr.GetNames(arg1)
end
local function Parse(arg1) -- Line 19
    return arg1[1]
end
tbl_upvr_2.Parse = Parse
local tbl_upvr_3 = {
    Listable = true;
    Transform = tbl_upvr_2.Transform;
    Validate = tbl_upvr_2.Validate;
    Autocomplete = tbl_upvr_2.Autocomplete;
}
local function Parse(arg1) -- Line 30
    return arg1[1]:GetPlayers()
end
tbl_upvr_3.Parse = Parse
local tbl_upvr = {
    Transform = tbl_upvr_2.Transform;
    Validate = tbl_upvr_2.Validate;
    Autocomplete = tbl_upvr_2.Autocomplete;
    Parse = function(arg1) -- Line 40, Named "Parse"
        return arg1[1].TeamColor
    end;
}
return function(arg1) -- Line 45
    arg1:RegisterType("team", tbl_upvr_2)
    arg1:RegisterType("teams", Util_upvr.MakeListableType(tbl_upvr_2))
    arg1:RegisterType("teamPlayers", tbl_upvr_3)
    arg1:RegisterType("teamColor", tbl_upvr)
    arg1:RegisterType("teamColors", Util_upvr.MakeListableType(tbl_upvr))
end