local Teams = game:GetService("Teams")
local Util = require(script.Parent.Parent.Shared.Util)
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 5 | Upvalues: Util (copy), Teams (copy) ]]
		return Util.MakeFuzzyFinder(Teams:GetTeams())(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 11 ]]
		return #p1 > 0, "No team with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 15 | Upvalues: Util (copy) ]]
		return Util.GetNames(p1)
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 19 ]]
		return p1[1]
	end
}
local t2 = {
	Listable = true,
	Transform = t.Transform,
	Validate = t.Validate,
	Autocomplete = t.Autocomplete,
	Parse = function(p1) --[[ Name: Parse | Line: 30 ]]
		return p1[1]:GetPlayers()
	end
}
local t3 = {
	Transform = t.Transform,
	Validate = t.Validate,
	Autocomplete = t.Autocomplete,
	Parse = function(p1) --[[ Name: Parse | Line: 40 ]]
		return p1[1].TeamColor
	end
}
return function(p1) --[[ Line: 45 | Upvalues: t (copy), Util (copy), t2 (copy), t3 (copy) ]]
	p1:RegisterType("team", t)
	p1:RegisterType("teams", Util.MakeListableType(t))
	p1:RegisterType("teamPlayers", t2)
	p1:RegisterType("teamColor", t3)
	p1:RegisterType("teamColors", Util.MakeListableType(t3))
end