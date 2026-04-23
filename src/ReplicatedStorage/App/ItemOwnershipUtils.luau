-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local homeStore = require(ReplicatedStorage.Home.homeStore)
return {
	isVehicleOwned = function(p1)
		if type(p1) == "string" then
			local garageOwned = store:getState().garageOwned
			if garageOwned and garageOwned.Vehicles then
				return garageOwned.Vehicles[p1] == true
			else
				return false
			end
		else
			return false
		end
	end,
	isVehicleCustomizationOwned = function(p1, p2)
		if type(p1) == "string" and type(p2) == "string" then
			local garageOwned = store:getState().garageOwned
			if garageOwned then
				local v1 = garageOwned[p1]
				if v1 then
					return v1[p2] == true
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
	isHomeItemOwned = function(p1)
		if type(p1) == "string" then
			local v1 = homeStore:getState()
			if v1 and v1.inventory then
				local HomeItem = v1.inventory.HomeItem
				if HomeItem then
					return (HomeItem[p1] or 0) > 0
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