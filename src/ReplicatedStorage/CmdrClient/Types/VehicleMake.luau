local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local vehicleMakeFuzzyFinder = Util.MakeFuzzyFinder((TableUtils.map(VehicleData, function(vehicleEntry)
	return vehicleEntry.Make
end)))
local vehicleMakeType = {
	Transform = function(input)
		return vehicleMakeFuzzyFinder(input)
	end,
	Validate = function(result)
		return #result > 0, "No valid vehicle makes with that name could be found."
	end,
	Autocomplete = function(matches)
		return matches
	end,
	Parse = function(matches)
		return matches[1]
	end
}
return function(registry)
	registry:RegisterType("vehicleMake", vehicleMakeType)
	registry:RegisterType("vehicleMakes", Util.MakeListableType(vehicleMakeType))
end
