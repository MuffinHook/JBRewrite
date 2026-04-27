local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local homeStore = require(ReplicatedStorage.Home.homeStore)
return {
	isVehicleOwned = function(vehicleId)
		if type(vehicleId) == "string" then
			local garageOwned = store:getState().garageOwned
			if garageOwned and garageOwned.Vehicles then
				return garageOwned.Vehicles[vehicleId] == true
			else
				return false
			end
		else
			return false
		end
	end,
	isVehicleCustomizationOwned = function(vehicleId, customizationId)
		if type(vehicleId) == "string" and type(customizationId) == "string" then
			local garageOwned = store:getState().garageOwned
			if garageOwned then
				local vehicleCustomizations = garageOwned[vehicleId]
				if vehicleCustomizations then
					return vehicleCustomizations[customizationId] == true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end,
	isHomeItemOwned = function(itemId)
		if type(itemId) == "string" then
			local homeState = homeStore:getState()
			if homeState and homeState.inventory then
				local HomeItem = homeState.inventory.HomeItem
				if HomeItem then
					return (HomeItem[itemId] or 0) > 0
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
}
