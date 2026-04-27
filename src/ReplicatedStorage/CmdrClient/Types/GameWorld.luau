local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local worldsList = {}
for placeId, worldName in RunConsts.PLACE_ID_TO_WORLD_MAP do
	if table.find(worldsList, worldName) == nil then
		table.insert(worldsList, worldName)
	end
end
local worldFuzzyFinder = Util.MakeFuzzyFinder(worldsList)
local worldTypedef = {
	Transform = function(input)
		return worldFuzzyFinder(input)
	end,
	Validate = function(input)
		return #input > 0, "No valid world with that name could be found."
	end,
	Autocomplete = function(input)
		return input
	end,
	Parse = function(input)
		return input[1]
	end
}
return function(input)
	input:RegisterType("world", worldTypedef)
end
