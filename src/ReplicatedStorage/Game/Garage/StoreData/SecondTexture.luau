-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local SecondTexture = require(ReplicatedStorage.Game.Garage.Customize.SecondTexture)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local Texture = require(script.Parent.Texture)
local function GetInstance(p1)
	local v1 = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local v2 = getDefaultVehicleModel(v1.Make, v1.Type)
	local t = {
		Model = v2,
		Make = v1.Make,
		Type = v1.Type
	}
	if p1.None then
		SecondTexture(nil, t)
	else
		SecondTexture(p1, t)
	end
	return v2
end
local v1 = table.clone(Texture)
v1.GetInstance = GetInstance
return v1