local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local paintConfig = {}
return function(paint, vehicle)
	local Model = vehicle.Model
	local list = {}
	if vehicle.Make == "Sloop" then
		table.insert(list, Model.Visual.SailFront)
		table.insert(list, Model.Physics.SailBack.Sail)
	else
		for i, descendant in ipairs(Model:GetDescendants()) do
			if descendant.Name == "Interior" then
				table.insert(list, descendant)
			end
		end
	end
	for i, interiorPart in ipairs(list) do
		local defaultPart = PaintUtils.GetDefaultVehiclePart(interiorPart)
		paintConfig.DefaultMaterial = defaultPart.Material
		paintConfig.DefaultReflectance = defaultPart.Reflectance
		if paint then
			Paint.Part(interiorPart, paint.Name, paintConfig)
		else
			interiorPart.Color = defaultPart.Color
			interiorPart.Material = defaultPart.Material
			interiorPart.Reflectance = defaultPart.Reflectance
		end
	end
end
