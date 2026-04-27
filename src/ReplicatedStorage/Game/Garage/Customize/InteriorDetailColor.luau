local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local defaultProperties = {}
return function(paintColor, vehicleData)
	local Model = vehicleData.Model
	local list = {}
	for i, instance in ipairs(Model:GetDescendants()) do
		if instance.Name == "SecondInterior" then
			table.insert(list, instance)
		end
	end
	local Make = vehicleData.Make
	if Make == "Chiron" or (Make == "Wedge" or (Make == "Maverick" or (Make == "Venom" or Make == "Cobra"))) then
		table.insert(list, Model.Model:FindFirstChild("SteeringWheel"))
	elseif Make == "Sloop" then
		table.insert(list, Model.Visual.Flag)
	end
	for i, part in ipairs(list) do
		local defaultPart = PaintUtils.GetDefaultVehiclePart(part)
		if defaultPart then
			defaultProperties.DefaultMaterial = defaultPart.Material
			defaultProperties.DefaultReflectance = defaultPart.Reflectance
		else
			defaultProperties.DefaultMaterial = Enum.Material.SmoothPlastic
			defaultProperties.DefaultReflectance = 0
		end
		if paintColor then
			Paint.Part(part, paintColor.Name, defaultProperties)
		end
	end
end
