local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 5 | Upvalues: Util (copy), Players (copy) ]]
		return Util.MakeFuzzyFinder(Players:GetPlayers())(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 11 ]]
		return #p1 > 0, "No player with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 15 | Upvalues: Util (copy) ]]
		return Util.GetNames(p1)
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 19 ]]
		return p1[1]
	end,
	Default = function(p1) --[[ Name: Default | Line: 23 ]]
		return p1.Name
	end,
	ArgumentOperatorAliases = {
		me = ".",
		all = "*",
		others = "**",
		random = "?"
	}
}
return function(p1) --[[ Line: 35 | Upvalues: t (copy), Util (copy) ]]
	p1:RegisterType("player", t)
	p1:RegisterType("players", Util.MakeListableType(t, {
		Prefixes = "% teamPlayers"
	}))
end