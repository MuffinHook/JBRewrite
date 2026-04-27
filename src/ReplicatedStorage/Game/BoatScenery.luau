local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Init = function()
		local BoatScenery = ReplicatedStorage.Resource.BoatScenery
		BoatScenery.Parent = workspace
		local boatEntries = {}
		for i, boatModel in ipairs(BoatScenery:GetChildren()) do
			local speed = nil
			if boatModel.Name:find("Ship") then
				speed = -20
			elseif boatModel.Name:find("Sailboat") then
				speed = 45 + math.random() * 20
			end
			assert(speed)
			table.insert(boatEntries, {
				Part = boatModel,
				Speed = speed,
				Angle = math.random() * math.pi * 2 * 0.1,
				Radius = 6489.6 + (math.random() * 2 - 1) * 50
			})
		end
		RunService.Heartbeat:Connect(function(deltaTime)
			for i, boatData in ipairs(boatEntries) do
				boatData.Angle = boatData.Angle + boatData.Speed * deltaTime / boatData.Radius
				local cframe = CFrame.Angles(0, boatData.Angle, 0) * CFrame.new(boatData.Radius, 0, 0) + Vector3.new(169, 0, -1550)
				boatData.Part.CFrame = cframe + Vector3.new(0, boatData.Part.Size.Y * 0.5, 0)
			end
		end)
	end
}
