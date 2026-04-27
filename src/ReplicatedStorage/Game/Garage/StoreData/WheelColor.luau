local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local WheelColor = require(ReplicatedStorage.Game.Garage.Customize.WheelColor)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local function GetInstance(wheelInstance)
	local localVehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local defaultVehicleModel = getDefaultVehicleModel(localVehiclePacket.Make, localVehiclePacket.Type)
	WheelColor(wheelInstance, {
		Model = defaultVehicleModel,
		Make = localVehiclePacket.Make,
		Type = localVehiclePacket.Type
	})
	return defaultVehicleModel
end
local function Update(wheelInstance, wheelConfig)
	local elapsedTime = os.clock() / 2
	wheelInstance.CFrame = CFrame.Angles(0, elapsedTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(elapsedTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, wheelConfig.BoundingBox.Size.Magnitude * 0.7)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}
