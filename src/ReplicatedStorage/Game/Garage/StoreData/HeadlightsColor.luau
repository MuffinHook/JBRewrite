local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local function GetInstance(colorItem)
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local defaultModel = getDefaultVehicleModel(vehiclePacket.Make, vehiclePacket.Type)
	local Headlights = defaultModel.Model.Headlights
	Headlights.Transparency = 0
	Headlights.Color = Paint.GetColor(colorItem.Name)
	return defaultModel
end
local function Update(headlightPart, boundingBoxReference)
	local normalizedTime = os.clock() / 2
	headlightPart.CFrame = CFrame.Angles(0, math.pi + math.cos(normalizedTime % 6.283185307179586) * 0.1, 0) * CFrame.Angles(math.sin(normalizedTime) * 0.1 - 0.05, 0, 0) * CFrame.new(0, 0, boundingBoxReference.BoundingBox.Size.Magnitude * 0.7)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}
