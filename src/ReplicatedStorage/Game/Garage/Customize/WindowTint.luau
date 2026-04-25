-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local function setTransparency(p1, p2)
	if p2 == nil then
		p2 = PaintUtils.GetDefaultVehiclePart(p1).Transparency
	end
	p1.Transparency = p2
end
return function(p1, p2)
	local Model = p2.Model
	local transparencyValue = p1 and p1.Value
	if Model:FindFirstChild("Model") then
		for i, v in ipairs(Model:GetDescendants()) do
			local windowTransparency
			if v.Name == "Windows" then
				windowTransparency = if transparencyValue == nil then PaintUtils.GetDefaultVehiclePart(v).Transparency else transparencyValue
				v.Transparency = windowTransparency
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
