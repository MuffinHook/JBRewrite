local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Init = function() --[[ Name: Init | Line: 9 | Upvalues: ReplicatedStorage (copy), RunService (copy) ]]
		local BoatScenery = ReplicatedStorage.Resource.BoatScenery
		BoatScenery.Parent = workspace
		local t = {}
		for i, v in ipairs(BoatScenery:GetChildren()) do
			local v1 = nil
			if v.Name:find("Ship") then
				v1 = -20
			elseif v.Name:find("Sailboat") then
				v1 = 45 + math.random() * 20
			end
			assert(v1)
			table.insert(t, {
				Part = v,
				Speed = v1,
				Angle = math.random() * math.pi * 2 * 0.1,
				Radius = 6489.6 + (math.random() * 2 - 1) * 50
			})
		end
		RunService.Heartbeat:Connect(function(p1) --[[ Line: 30 | Upvalues: t (copy) ]]
			for i, v in ipairs(t) do
				v.Angle = v.Angle + v.Speed * p1 / v.Radius
				local v2 = CFrame.Angles(0, v.Angle, 0) * CFrame.new(v.Radius, 0, 0) + Vector3.new(169, 0, -1550)
				v.Part.CFrame = v2 + Vector3.new(0, v.Part.Size.Y * 0.5, 0)
			end
		end)
	end
}