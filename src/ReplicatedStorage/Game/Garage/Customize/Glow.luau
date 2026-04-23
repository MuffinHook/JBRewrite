local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local function GetLight(p1) --[[ Line: 4 ]]
	local Step = p1:FindFirstChild("Step")
	if Step then
		return Step:FindFirstChild("Glow")
	else
		return nil
	end
end
return function(p1, p2) --[[ Line: 11 | Upvalues: Paint (copy) ]]
	local Model = p2.Model
	local Type = p2.Type
	local Make = p2.Make
	local Step = Model:FindFirstChild("Step")
	local v1 = if Step then Step:FindFirstChild("Glow") else nil
	if v1 then
		if p1 then
			v1.Color = Paint.GetColor(p1.Name)
			v1.Enabled = true
		else
			v1.Enabled = false
		end
	elseif p1 and (Type == "Heli" and (Make == "Bionic" and Model:FindFirstChild("Model"))) then
		local v2 = Paint.GetColor(p1.Name)
		Model.Model.Vents.Color = v2
		Model.Model.Vents.Glow.Color = v2
		for v3, v4 in Model.Model.Body:GetChildren() do
			if v4:IsA("Beam") and v4.Name == "Bend" then
				v4.Color = ColorSequence.new(v2)
			end
		end
	end
end