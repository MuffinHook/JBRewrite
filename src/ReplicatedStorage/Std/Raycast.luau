-- Reviewed by Claude
return {
	collidable = function(p1, p2, p3, p4, p5)
		assert(p1, "missing position")
		assert(p2.Magnitude - 1 <= 0.001, "direction is not unit length")
		assert(p3 > 0, "length is not non zero")
		if not p4 then
			p4 = RaycastParams.new()
		end
		if not p4 then
			return
		end
		local FilterDescendantsInstances = p4.FilterDescendantsInstances
		local count = 0
		local v4 = nil
		while p3 >= 0.001 and count <= 10 do
			local v5 = workspace:Raycast(p1, p2 * p3, p4)
			if not v5 or p5 and p5(v5.Instance) then
				v4 = v5
				break
			end
			v4 = v5
			if not p5 and v5.Instance.CanCollide then
				break
			end
			table.insert(FilterDescendantsInstances, v5.Instance)
			p4.FilterDescendantsInstances = FilterDescendantsInstances
			count = count + 1
		end
		return v4
	end
}
