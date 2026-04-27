local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local BodyColor = require(ReplicatedStorage.Game.Garage.Customize.BodyColor)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local function GetInstance(colorData)
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local vehicleModel = getDefaultVehicleModel(vehiclePacket.Make, vehiclePacket.Type)
	vehicleModel:FindFirstChild("Body", true).TextureID = ""
	local customizeData = {
		Model = vehicleModel,
		Make = vehiclePacket.Make,
		Type = vehiclePacket.Type
	}
	if colorData.None then
		BodyColor(nil, customizeData)
	else
		BodyColor(colorData, customizeData)
	end
	return vehicleModel
end
local function Update(model, part)
	local rotationTime = os.clock() / 2
	model.CFrame = CFrame.Angles(0, rotationTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(rotationTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, part:GetExtentsSize().Magnitude * 0.6)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}
