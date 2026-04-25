-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local function GetInstance(paintConfig)
	local localVehicleModel = VehicleUtils.GetLocalVehicleModel()
	assert(localVehicleModel)
	local vehicleClone = localVehicleModel:Clone()
	VehicleUtils.CleanVehicleModel(vehicleClone)
	vehicleClone.PrimaryPart = vehicleClone.BoundingBox
	vehicleClone:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
	local SpoilerPart = vehicleClone:FindFirstChild("SpoilerPart")
	if SpoilerPart then
		SpoilerPart.Color = Paint.GetColor(paintConfig.Name)
	end
	return vehicleClone
end
local function Update(part, config)
	local timeValue = os.clock() / 2
	part.CFrame = CFrame.Angles(0, math.cos(timeValue % 6.283185307179586) * 0.1, 0) * CFrame.Angles(math.sin(timeValue) * 0.1 - 0.1, 0, 0) * CFrame.new(0, 0, config.PrimaryPart.Size.Magnitude * 0.7)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}
