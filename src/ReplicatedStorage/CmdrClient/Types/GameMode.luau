local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local fuzzyFinder = Util.MakeFuzzyFinder((require(ReplicatedStorage.GameMode.GameModeUtils).getGameModeNames()))
local gameModeType = {
	Transform = function(input)
		return fuzzyFinder(input)
	end,
	Validate = function(input)
		return #input > 0, "No valid gamemode with that name could be found."
	end,
	Autocomplete = function(input)
		return input
	end,
	Parse = function(input)
		return input[1]
	end
}
return function(registry)
	registry:RegisterType("gamemode", gameModeType)
end
