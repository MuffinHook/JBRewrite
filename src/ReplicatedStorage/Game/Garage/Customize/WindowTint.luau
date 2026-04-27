local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local function setTransparency(part, transparency)
	if transparency == nil then
		transparency = PaintUtils.GetDefaultVehiclePart(part).Transparency
	end
	part.Transparency = transparency
end
return function(config, vehicle)
	local Model = vehicle.Model
	local transparencyValue = config and config.Value
	if Model:FindFirstChild("Model") then
		for i, descendant in ipairs(Model:GetDescendants()) do
			local windowTransparency
			if descendant.Name == "Windows" then
				windowTransparency = if transparencyValue == nil then PaintUtils.GetDefaultVehiclePart(descendant).Transparency else transparencyValue
				descendant.Transparency = windowTransparency
			end
		end
		local Preset = Model:FindFirstChild("Preset")
		if Preset then
			local DoorLeft = Preset:FindFirstChild("DoorLeft")
			if DoorLeft then
				local Window = DoorLeft:FindFirstChild("Window")
				if Window then
					Window.Transparency = if transparencyValue == nil then PaintUtils.GetDefaultVehiclePart(Window).Transparency else transparencyValue
				end
			end
			local DoorRight = Preset:FindFirstChild("DoorRight")
			if DoorRight then
				local Window = DoorRight:FindFirstChild("Window")
				if Window then
					Window.Transparency = if transparencyValue == nil then PaintUtils.GetDefaultVehiclePart(Window).Transparency else transparencyValue
				end
			end
		end
	end
end
