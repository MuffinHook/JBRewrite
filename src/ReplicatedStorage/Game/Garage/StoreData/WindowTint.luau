local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local WindowTint = require(script.Parent.Parent.Customize.WindowTint)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
return {
	Items = {
		{
			Name = "80",
			Price = 3000,
			Value = 0.8
		},
		{
			Name = "60",
			Price = 3000,
			Value = 0.6
		},
		{
			Name = "40",
			Price = 3000,
			Value = 0.4
		},
		{
			Name = "20",
			Price = 3000,
			Value = 0.2
		}
	},
	GetInstance = function(tintValue)
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
		local vehicleModel = getDefaultVehicleModel(vehiclePacket.Make, vehiclePacket.Type)
		WindowTint(tintValue, {
			Model = vehicleModel,
			Make = vehiclePacket.Make,
			Type = vehiclePacket.Type
		})
		return vehicleModel
	end,
	Update = function(displayPart, boundingBoxReference)
		local animationTime = os.clock() / 2
		displayPart.CFrame = CFrame.Angles(0, 2.356194490192345 + math.cos(animationTime % 6.283185307179586) * 0.1, 0) * CFrame.Angles(math.sin(animationTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, boundingBoxReference.BoundingBox.Size.Magnitude * 0.6)
	end
}
