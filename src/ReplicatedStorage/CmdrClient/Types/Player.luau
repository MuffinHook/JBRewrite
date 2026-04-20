local Util_upvr = require(script.Parent.Parent.Shared.Util)
local tbl_upvr = {}
local Players_upvr = game:GetService("Players")
function tbl_upvr.Transform(arg1) -- Line 5
    return Util_upvr.MakeFuzzyFinder(Players_upvr:GetPlayers())(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 11
    local var4
    if 0 >= #arg1 then
        var4 = false
    else
        var4 = true
    end
    return var4, "No player with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 15
    return Util_upvr.GetNames(arg1)
end
function tbl_upvr.Parse(arg1) -- Line 19
    return arg1[1]
end
function tbl_upvr.Default(arg1) -- Line 23
    return arg1.Name
end
tbl_upvr.ArgumentOperatorAliases = {
    me = '.';
    all = '*';
    others = "**";
    random = '?';
}
return function(arg1) -- Line 35
    arg1:RegisterType("player", tbl_upvr)
    arg1:RegisterType("players", Util_upvr.MakeListableType(tbl_upvr, {
        Prefixes = "% teamPlayers";
    }))
end