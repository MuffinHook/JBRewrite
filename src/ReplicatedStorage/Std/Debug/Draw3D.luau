local t = {
	_parent = nil
}
function t.setParent(p1) --[[ Line: 6 | Upvalues: t (copy) ]]
	t._parent = p1
end
function t.point(p1, p2, p3) --[[ Line: 9 | Upvalues: t (copy) ]]
	local v2 = p3 or Instance.new("Part")
	assert(v2)
	v2.Anchored = true
	v2.CanTouch = false
	v2.CanQuery = false
	v2.CanCollide = false
	v2.Size = Vector3.new(1, 1, 1) * (p2 or 0.5) * 2
	v2.Shape = Enum.PartType.Ball
	v2.CFrame = CFrame.new(p1)
	v2.Parent = t._parent
	return v2
end
function t.line(p1, p2, p3) --[[ Line: 27 | Upvalues: t (copy) ]]
	local v1 = p3 or Instance.new("Part")
	assert(v1)
	local Magnitude = (p2 - p1).Magnitude
	v1.Color = Color3.new(255/255, 0/255, 0/255)
	v1.Anchored = true
	v1.CanTouch = false
	v1.CanQuery = false
	v1.CanCollide = false
	v1.Size = Vector3.new(0.1, 0.1, Magnitude)
	v1.CFrame = CFrame.new(p1, p2) * CFrame.new(0, 0, -Magnitude * 0.5)
	v1.Parent = t._parent
	return v1
end
return t