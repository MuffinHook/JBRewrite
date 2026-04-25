-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameLocations = require(ReplicatedStorage.App.GameLocations)
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local gameLocationsList = {}
for location in GameLocations do
	table.insert(gameLocationsList, location)
end
local fuzzyFinder = Util.MakeFuzzyFinder(gameLocationsList)
local typeDefinition = {
	Transform = function(input)
		return fuzzyFinder(input)
	end,
	Validate = function(input)
		return #input > 0, "No valid robbery with that name could be found."
	end,
	Autocomplete = function(input)
		return input
	end,
	Parse = function(input)
		return input[1]
	end
}
return function(cmdr)
	cmdr:RegisterType("gameLocation", typeDefinition)
end
