local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local GarageTranslationUtils = require(ReplicatedStorage.Garage.GarageTranslationUtils)
local Rodux = require(ReplicatedStorage.Rodux)
local VehicleConf = require(ReplicatedStorage.Game.Garage.VehicleConf)
return Rodux.createReducer({}, {
	setLocalVehiclePacket = function(state, action)
		assert(action.packet ~= nil, "missing Packet")
		return TableUtils.map(VehicleConf.GetCategoriesByModel(action.packet), function(categoryId)
			return {
				name = categoryId,
				title = GarageTranslationUtils.getCategoryTitle(categoryId)
			}
		end)
	end
})
