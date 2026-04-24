-- Reviewed by Claude
return {
	DrawPoint = function(p1, p2)
		local v1 = p2 or 0.5
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.Size = Vector3.new(v1 * 2, v1 * 2, v1 * 2)
		Part.CFrame = CFrame.new(p1)
		Part.Parent = workspace
		return Part
	end,
	DrawLine = function(p1, p2)
		local Magnitude = (p2 - p1).Magnitude
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.Size = Vector3.new(1, 1, Magnitude)
		Part.CFrame = CFrame.new(p1, p2) * CFrame.new(0, 0, -Magnitude * 0.5)
		Part.Parent = workspace
		return Part
	end
}
