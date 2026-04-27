local Teams = game:GetService("Teams")
local Util = require(script.Parent.Parent.Shared.Util)
local teamType = {
	Transform = function(input)
		return Util.MakeFuzzyFinder(Teams:GetTeams())(input)
	end,
	Validate = function(input)
		return #input > 0, "No team with that name could be found."
	end,
	Autocomplete = function(input)
		return Util.GetNames(input)
	end,
	Parse = function(input)
		return input[1]
	end
}
local teamPlayersType = {
	Listable = true,
	Transform = teamType.Transform,
	Validate = teamType.Validate,
	Autocomplete = teamType.Autocomplete,
	Parse = function(input)
		return input[1]:GetPlayers()
	end
}
local teamColorType = {
	Transform = teamType.Transform,
	Validate = teamType.Validate,
	Autocomplete = teamType.Autocomplete,
	Parse = function(input)
		return input[1].TeamColor
	end
}
return function(registry)
	registry:RegisterType("team", teamType)
	registry:RegisterType("teams", Util.MakeListableType(teamType))
	registry:RegisterType("teamPlayers", teamPlayersType)
	registry:RegisterType("teamColor", teamColorType)
	registry:RegisterType("teamColors", Util.MakeListableType(teamColorType))
end
