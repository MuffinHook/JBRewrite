-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local function GetLight(item)
	local Step = item:FindFirstChild("Step")
	if Step then
		return Step:FindFirstChild("Glow")
	else
		return nil
	end
end
return function(item, config)
	local Model = config.Model
	local Type = config.Type
	local Make = config.Make
	local Step = Model:FindFirstChild("Step")
	local glowLight = if Step then Step:FindFirstChild("Glow") else nil
	if glowLight then
		if item then
			glowLight.Color = Paint.GetColor(item.Name)
			glowLight.Enabled = true
		else
			glowLight.Enabled = false
		end
	elseif item and (Type == "Heli" and (Make == "Bionic" and Model:FindFirstChild("Model"))) then
		local color = Paint.GetColor(item.Name)
		Model.Model.Vents.Color = color
		Model.Model.Vents.Glow.Color = color
		for index, beam in Model.Model.Body:GetChildren() do
			if beam:IsA("Beam") and beam.Name == "Bend" then
				beam.Color = ColorSequence.new(color)
			end
		end
	end
end
