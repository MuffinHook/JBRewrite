-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
return function(p1, p2)
	local Model = p2.Model
	local Make = p2.Make
	if p1 then
		local seats = {}
		table.insert(seats, Model.Model:FindFirstChild("Seats"))
		if Make == "Carbonara" then
			table.insert(seats, Model.Model.SteeringWheel)
		end
		for index, seatPart in seats do
			local defaultPart = PaintUtils.GetDefaultVehiclePart(seatPart)
			local paintConfig = {}
			if defaultPart then
				paintConfig.DefaultReflectance = defaultPart.Reflectance
				paintConfig.DefaultMaterial = defaultPart.Material
			else
				paintConfig.DefaultReflectance = 0.1
				paintConfig.DefaultMaterial = Enum.Material.Plastic
			end
			Paint.Part(seatPart, p1.Name, paintConfig)
		end
	end
end
