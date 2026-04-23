-- Reviewed by Claude
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
	GetInstance = function(p1)
		local v1 = VehicleUtils.GetLocalVehiclePacketForCustomize()
		local v2 = getDefaultVehicleModel(v1.Make, v1.Type)
		WindowTint(p1, {
			Model = v2,
			Make = v1.Make,
			Type = v1.Type
		})
		return v2
	end,
	Update = function(p1, p2)
		local v1 = os.clock() / 2
		p1.CFrame = CFrame.Angles(0, 2.356194490192345 + math.cos(v1 % 6.283185307179586) * 0.1, 0) * CFrame.Angles(math.sin(v1) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, p2.BoundingBox.Size.Magnitude * 0.6)
	end
}