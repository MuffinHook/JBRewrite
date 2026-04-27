local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local SecondTexture = require(ReplicatedStorage.Game.Garage.Customize.SecondTexture)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local Texture = require(script.Parent.Texture)
local function GetInstance(textureObject)
	local localVehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local defaultVehicleModel = getDefaultVehicleModel(localVehiclePacket.Make, localVehiclePacket.Type)
	local vehicleConfig = {
		Model = defaultVehicleModel,
		Make = localVehiclePacket.Make,
		Type = localVehiclePacket.Type
	}
	if textureObject.None then
		SecondTexture(nil, vehicleConfig)
	else
		SecondTexture(textureObject, vehicleConfig)
	end
	return defaultVehicleModel
end
local textureModule = table.clone(Texture)
textureModule.GetInstance = GetInstance
return textureModule
