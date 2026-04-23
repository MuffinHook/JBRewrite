-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local t = {}
return function(p1, p2)
	local Model = p2.Model
	local list = {}
	if p2.Make == "Sloop" then
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
		local v1 = PaintUtils.GetDefaultVehiclePart(v)
		t.DefaultMaterial = v1.Material
		t.DefaultReflectance = v1.Reflectance
		if p1 then
			Paint.Part(v, p1.Name, t)
		else
			v.Color = v1.Color
			v.Material = v1.Material
			v.Reflectance = v1.Reflectance
		end
	end
end