local module = {
	_parent = nil
}
function module.setParent(parent)
	module._parent = parent
end
function module.point(position, size, part)
	local part = size or Instance.new("Part")
	assert(part)
	part.Anchored = true
	part.CanTouch = false
	part.CanQuery = false
	part.CanCollide = false
	part.Size = Vector3.new(1, 1, 1) * (size or 0.5) * 2
	part.Shape = Enum.PartType.Ball
	part.CFrame = CFrame.new(position)
	part.Parent = module._parent
	return part
end
function module.line(startPosition, endPosition, part)
	local part = part or Instance.new("Part")
	assert(part)
	local Magnitude = (endPosition - startPosition).Magnitude
	part.Color = Color3.new(255/255, 0/255, 0/255)
	part.Anchored = true
	part.CanTouch = false
	part.CanQuery = false
	part.CanCollide = false
	part.Size = Vector3.new(0.1, 0.1, Magnitude)
	part.CFrame = CFrame.new(startPosition, endPosition) * CFrame.new(0, 0, -Magnitude * 0.5)
	part.Parent = module._parent
	return part
end
return module
