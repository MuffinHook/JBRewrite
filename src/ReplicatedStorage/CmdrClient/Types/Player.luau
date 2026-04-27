local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local playerType = {
	Transform = function(players)
		return Util.MakeFuzzyFinder(Players:GetPlayers())(players)
	end,
	Validate = function(players)
		return #players > 0, "No player with that name could be found."
	end,
	Autocomplete = function(players)
		return Util.GetNames(players)
	end,
	Parse = function(players)
		return players[1]
	end,
	Default = function(player)
		return player.Name
	end,
	ArgumentOperatorAliases = {
		me = ".",
		all = "*",
		others = "**",
		random = "?"
	}
}
return function(cmdr)
	cmdr:RegisterType("player", playerType)
	cmdr:RegisterType("players", Util.MakeListableType(playerType, {
		Prefixes = "% teamPlayers"
	}))
end
