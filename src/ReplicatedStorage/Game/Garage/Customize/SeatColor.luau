local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
return function(p1, p2) --[[ Line: 5 | Upvalues: PaintUtils (copy), Paint (copy) ]]
	local Model = p2.Model
	local Make = p2.Make
	if p1 then
		local t = {}
		table.insert(t, Model.Model:FindFirstChild("Seats"))
		if Make == "Carbonara" then
			table.insert(t, Model.Model.SteeringWheel)
		end
		for v1, v2 in t do
			local v3 = PaintUtils.GetDefaultVehiclePart(v2)
			local t2 = {}
			if v3 then
				t2.DefaultReflectance = v3.Reflectance
				t2.DefaultMaterial = v3.Material
			else
				t2.DefaultReflectance = 0.1
				t2.DefaultMaterial = Enum.Material.Plastic
			end
			Paint.Part(v2, p1.Name, t2)
		end
	end
end