-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Init = function()
		local BoatScenery = ReplicatedStorage.Resource.BoatScenery
		BoatScenery.Parent = workspace
		local t = {}
		for i, v in ipairs(BoatScenery:GetChildren()) do
			local speed = nil
			if v.Name:find("Ship") then
				speed = -20
			elseif v.Name:find("Sailboat") then
				speed = 45 + math.random() * 20
			end
			assert(speed)
			table.insert(t, {
				Part = v,
				Speed = speed,
				Angle = math.random() * math.pi * 2 * 0.1,
				Radius = 6489.6 + (math.random() * 2 - 1) * 50
			})
		end
		RunService.Heartbeat:Connect(function(deltaTime)
			for i, v in ipairs(t) do
				v.Angle = v.Angle + v.Speed * deltaTime / v.Radius
				local cframe = CFrame.Angles(0, v.Angle, 0) * CFrame.new(v.Radius, 0, 0) + Vector3.new(169, 0, -1550)
				v.Part.CFrame = cframe + Vector3.new(0, v.Part.Size.Y * 0.5, 0)
			end
		end)
	end
}
