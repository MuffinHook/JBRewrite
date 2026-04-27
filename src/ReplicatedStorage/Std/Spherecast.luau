return {
	collidable = function(position, radius, direction, length, raycastParams, filterCallback)
		assert(position, "missing position")
		assert(direction.Magnitude - 1 <= 0.001, "direction is not unit length")
		assert(length > 0, "length is not non zero")
		assert(radius > 0, "radius is not non zero")
		if not raycastParams then
			raycastParams = RaycastParams.new()
		end
		if not raycastParams then
			return
		end
		local FilterDescendantsInstances = raycastParams.FilterDescendantsInstances
		local count = 0
		local lastHit = nil
		while length >= 0.001 and count <= 10 do
			local hitResult = workspace:Spherecast(position, radius, direction * length, raycastParams)
			if not hitResult or filterCallback and filterCallback(hitResult.Instance) then
				lastHit = hitResult
				break
			end
			lastHit = hitResult
			if not filterCallback and hitResult.Instance.CanCollide then
				break
			end
			table.insert(FilterDescendantsInstances, hitResult.Instance)
			raycastParams.FilterDescendantsInstances = FilterDescendantsInstances
			count = count + 1
		end
		return lastHit
	end
}
