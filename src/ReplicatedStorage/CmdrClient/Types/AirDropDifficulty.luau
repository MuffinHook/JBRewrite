-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local TYPE_ENUM_TO_NAME = require(ReplicatedStorage.AirDrop.AirDropConsts).TYPE_ENUM_TO_NAME
local fuzzyFinder = Util.MakeFuzzyFinder(TYPE_ENUM_TO_NAME)
local airDropDifficultyType = {
	Transform = function(input)
		return fuzzyFinder(input)
	end,
	Validate = function(input)
		return #input > 0, "No valid airDropDifficulty with that name could be found."
	end,
	Autocomplete = function(input)
		return input
	end,
	Parse = function(input)
		return input[1]
	end
}
return function(cmdr)
	cmdr:RegisterType("airDropDifficulty", airDropDifficultyType)
end
