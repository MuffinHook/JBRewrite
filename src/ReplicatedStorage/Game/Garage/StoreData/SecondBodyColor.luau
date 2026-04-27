local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local SecondBodyColor = require(ReplicatedStorage.Game.Garage.Customize.SecondBodyColor)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local function GetInstance(colorConfig)
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local vehicleModel = getDefaultVehicleModel(vehiclePacket.Make, vehiclePacket.Type)
	local modelContext = {
		Model = vehicleModel,
		Make = vehiclePacket.Make,
		Type = vehiclePacket.Type
	}
	if colorConfig.None then
		SecondBodyColor(nil, modelContext)
	else
		SecondBodyColor(colorConfig, modelContext)
	end
	return vehicleModel
end
local function Update(modelPart, partConfig)
	local elapsedTime = os.clock() / 2
	modelPart.CFrame = CFrame.Angles(0, elapsedTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(elapsedTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, partConfig.BoundingBox.Size.Magnitude * 0.6)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}
