local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local function getPaintConfig(p1) --[[ Line: 5 | Upvalues: PaintUtils (copy) ]]
	local v1 = PaintUtils.GetDefaultVehiclePart(p1)
	return {
		DefaultReflectance = v1.Reflectance,
		DefaultMaterial = v1.Material
	}
end
return function(p1, p2) --[[ Line: 13 | Upvalues: PaintUtils (copy), Paint (copy) ]]
	local Model = p2.Model
	local Type = p2.Type
	local Make = p2.Make
	if p1 then
		local v1 = p1.Name
		local list = {}
		for i, v in ipairs(Model:GetDescendants()) do
			if v.Name == "Windows" then
				table.insert(list, v)
			end
		end
		for i, v in ipairs(list) do
			local v2 = PaintUtils.GetDefaultVehiclePart(v)
			local t = {
				DefaultReflectance = v2.Reflectance,
				DefaultMaterial = v2.Material
			}
			if Make == "Concept" then
				t.OverrideMaterial = Enum.Material.ForceField
			end
			Paint.Part(v, v1, t)
			if Make == "Heli" or (Make == "BlackHawk" or Make == "LittleBird") then
				local Color = v.Color
				v.Color = Color3.new(math.clamp(Color.r * 1.4, 0, 1), math.clamp(Color.g * 1.4, 0, 1), (math.clamp(Color.b * 1.4, 0, 1)))
			end
		end
		local Preset = Model:FindFirstChild("Preset")
		if Preset then
			local DoorLeft = Preset:FindFirstChild("DoorLeft")
			if DoorLeft then
				local Window = DoorLeft:FindFirstChild("Window")
				if Window then
					local v9 = PaintUtils.GetDefaultVehiclePart(Window)
					Paint.Part(Window, v1, {
						DefaultReflectance = v9.Reflectance,
						DefaultMaterial = v9.Material
					})
				end
			end
			local DoorRight = Preset:FindFirstChild("DoorRight")
			if DoorRight then
				local Window = DoorRight:FindFirstChild("Window")
				if Window then
					local v10 = PaintUtils.GetDefaultVehiclePart(Window)
					Paint.Part(Window, v1, {
						DefaultReflectance = v10.Reflectance,
						DefaultMaterial = v10.Material
					})
				end
			end
		end
	end
end