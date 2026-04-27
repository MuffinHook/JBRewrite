local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local LIST_ROBBERY = require(ReplicatedStorage.Robbery.RobberyConsts).LIST_ROBBERY
local fuzzyFinder = Util.MakeFuzzyFinder(LIST_ROBBERY)
local robberyType = {
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
return function(registry)
	registry:RegisterType("robbery", robberyType)
	registry:RegisterType("robberies", Util.MakeListableType(robberyType))
end
