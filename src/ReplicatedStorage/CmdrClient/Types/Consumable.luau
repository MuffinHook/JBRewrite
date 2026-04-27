local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local consumableList = {}
for name, _ in require(ReplicatedStorage.Consumables.ConsumablesData) do
	table.insert(consumableList, name)
end
local fuzzyFinder = Util.MakeFuzzyFinder(consumableList)
local consumableTypeConfig = {
	Transform = function(consumableName)
		return fuzzyFinder(consumableName)
	end,
	Validate = function(consumableName)
		return #consumableName > 0, "No valid consumable with that name could be found."
	end,
	Autocomplete = function(consumableName)
		return consumableName
	end,
	Parse = function(consumableName)
		return consumableName[1]
	end
}
return function(consumableName)
	consumableName:RegisterType("consumable", consumableTypeConfig)
end
