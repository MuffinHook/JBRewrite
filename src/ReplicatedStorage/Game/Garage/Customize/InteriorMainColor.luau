-- Reviewed by Claude
-- variables reassigned
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
		for i, v in ipairs(Model:GetDescendants()) do
			if v.Name == "Interior" then
				table.insert(list, v)
			end
		end
	end
	for i, v in ipairs(list) do
		local defaultPart = PaintUtils.GetDefaultVehiclePart(v)
		paintConfig.DefaultMaterial = defaultPart.Material
		paintConfig.DefaultReflectance = defaultPart.Reflectance
		if paint then
			Paint.Part(v, paint.Name, paintConfig)
		else
			v.Color = defaultPart.Color
			v.Material = defaultPart.Material
			v.Reflectance = defaultPart.Reflectance
		end
	end
end
