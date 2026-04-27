return {
	DrawPoint = function(position, radius)
		local radius = radius or 0.5
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
		Part.CFrame = CFrame.new(position)
		Part.Parent = workspace
		return Part
	end,
	DrawLine = function(startPosition, endPosition)
		local Magnitude = (endPosition - startPosition).Magnitude
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.Size = Vector3.new(1, 1, Magnitude)
		Part.CFrame = CFrame.new(startPosition, endPosition) * CFrame.new(0, 0, -Magnitude * 0.5)
		Part.Parent = workspace
		return Part
	end
}
