local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local GarageTranslationUtils = require(ReplicatedStorage.Garage.GarageTranslationUtils)
local Rodux = require(ReplicatedStorage.Rodux)
local VehicleConf = require(ReplicatedStorage.Game.Garage.VehicleConf)
return Rodux.createReducer({}, {
	setLocalVehiclePacket = function(p1, p2) --[[ Name: setLocalVehiclePacket | Line: 9 | Upvalues: VehicleConf (copy), TableUtils (copy), GarageTranslationUtils (copy) ]]
		assert(p2.packet ~= nil, "missing Packet")
		return TableUtils.map(VehicleConf.GetCategoriesByModel(p2.packet), function(p1) --[[ Line: 12 | Upvalues: GarageTranslationUtils (ref) ]]
			return {
				name = p1,
				title = GarageTranslationUtils.getCategoryTitle(p1)
			}
		end)
	end
})