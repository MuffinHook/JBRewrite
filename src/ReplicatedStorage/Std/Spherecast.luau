-- Reviewed by Claude
-- variables reassigned
return {
	collidable = function(p1, p2, p3, p4, p5, p6)
		assert(p1, "missing position")
		assert(p3.Magnitude - 1 <= 0.001, "direction is not unit length")
		assert(p4 > 0, "length is not non zero")
		assert(p2 > 0, "radius is not non zero")
		if not p5 then
			p5 = RaycastParams.new()
		end
		if not p5 then
			return
		end
		local FilterDescendantsInstances = p5.FilterDescendantsInstances
		local count = 0
		local v5 = nil
		while p4 >= 0.001 and count <= 10 do
			local v6 = workspace:Spherecast(p1, p2, p3 * p4, p5)
			if not v6 or p6 and p6(v6.Instance) then
				v5 = v6
				break
			end
			v5 = v6
			if not p6 and v6.Instance.CanCollide then
				break
			end
			table.insert(FilterDescendantsInstances, v6.Instance)
			p5.FilterDescendantsInstances = FilterDescendantsInstances
			count = count + 1
		end
		return v5
	end
}
