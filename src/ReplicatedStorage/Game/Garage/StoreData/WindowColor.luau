local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local WindowColor = require(ReplicatedStorage.Game.Garage.Customize.WindowColor)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local function GetInstance(colorConfig)
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local defaultModel = getDefaultVehicleModel(vehiclePacket.Make, vehiclePacket.Type)
	local customizeData = {
		Model = defaultModel,
		Make = vehiclePacket.Make,
		Type = vehiclePacket.Type
	}
	if colorConfig.None then
		WindowColor(nil, customizeData)
	else
		WindowColor(colorConfig, customizeData)
	end
	return defaultModel
end
local function Update(instance, targetModel)
	local animationTime = os.clock() / 2
	instance.CFrame = CFrame.Angles(0, 2.356194490192345 + math.cos(animationTime % math.tau) * 0.1, 0) * CFrame.Angles(math.sin(animationTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, targetModel.BoundingBox.Size.Magnitude * 0.6)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}
