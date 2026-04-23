local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local t = {}
return function(p1, p2) --[[ Line: 7 | Upvalues: PaintUtils (copy), t (copy), Paint (copy) ]]
	local Model = p2.Model
	local list = {}
	for i, v in ipairs(Model:GetDescendants()) do
		if v.Name == "SecondInterior" then
			table.insert(list, v)
		end
	end
	local Make = p2.Make
	if Make == "Chiron" or (Make == "Wedge" or (Make == "Maverick" or (Make == "Venom" or Make == "Cobra"))) then
		table.insert(list, Model.Model:FindFirstChild("SteeringWheel"))
	elseif Make == "Sloop" then
		table.insert(list, Model.Visual.Flag)
	end
	for i, v in ipairs(list) do
		local v1 = PaintUtils.GetDefaultVehiclePart(v)
		if v1 then
			t.DefaultMaterial = v1.Material
			t.DefaultReflectance = v1.Reflectance
		else
			t.DefaultMaterial = Enum.Material.SmoothPlastic
			t.DefaultReflectance = 0
		end
		if p1 then
			Paint.Part(v, p1.Name, t)
		end
	end
end