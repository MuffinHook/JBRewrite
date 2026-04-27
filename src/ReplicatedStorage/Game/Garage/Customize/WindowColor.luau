local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local function getPaintConfig(paintColorName)
	local colorName = PaintUtils.GetDefaultVehiclePart(paintColorName)
	return {
		DefaultReflectance = colorName.Reflectance,
		DefaultMaterial = colorName.Material
	}
end
return function(paintColorName, modelInfo)
	local Model = modelInfo.Model
	local Type = modelInfo.Type
	local Make = modelInfo.Make
	if paintColorName then
		local colorName = paintColorName.Name
		local list = {}
		for i, window in ipairs(Model:GetDescendants()) do
			if window.Name == "Windows" then
				table.insert(list, window)
			end
		end
		for i, window in ipairs(list) do
			local defaultPart = PaintUtils.GetDefaultVehiclePart(window)
			local paintConfig = {
				DefaultReflectance = defaultPart.Reflectance,
				DefaultMaterial = defaultPart.Material
			}
			if Make == "Concept" then
				paintConfig.OverrideMaterial = Enum.Material.ForceField
			end
			Paint.Part(window, colorName, paintConfig)
			if Make == "Heli" or (Make == "BlackHawk" or Make == "LittleBird") then
				local Color = window.Color
				window.Color = Color3.new(math.clamp(Color.r * 1.4, 0, 1), math.clamp(Color.g * 1.4, 0, 1), (math.clamp(Color.b * 1.4, 0, 1)))
			end
		end
		local Preset = Model:FindFirstChild("Preset")
		if Preset then
			local DoorLeft = Preset:FindFirstChild("DoorLeft")
			if DoorLeft then
				local Window = DoorLeft:FindFirstChild("Window")
				if Window then
					local defaultWindowPart = PaintUtils.GetDefaultVehiclePart(Window)
					Paint.Part(Window, colorName, {
						DefaultReflectance = defaultWindowPart.Reflectance,
						DefaultMaterial = defaultWindowPart.Material
					})
				end
			end
			local DoorRight = Preset:FindFirstChild("DoorRight")
			if DoorRight then
				local Window = DoorRight:FindFirstChild("Window")
				if Window then
					local defaultDoorWindowPart = PaintUtils.GetDefaultVehiclePart(Window)
					Paint.Part(Window, colorName, {
						DefaultReflectance = defaultDoorWindowPart.Reflectance,
						DefaultMaterial = defaultDoorWindowPart.Material
					})
				end
			end
		end
	end
end
