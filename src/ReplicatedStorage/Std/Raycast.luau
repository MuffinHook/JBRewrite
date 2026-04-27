return {
	collidable = function(rayOrigin, rayDirection, maxDistance, raycastParams, shouldFilterFunction)
		assert(rayOrigin, "missing position")
		assert(rayDirection.Magnitude - 1 <= 0.001, "direction is not unit length")
		assert(maxDistance > 0, "length is not non zero")
		if not raycastParams then
			raycastParams = RaycastParams.new()
		end
		if not raycastParams then
			return
		end
		local FilterDescendantsInstances = raycastParams.FilterDescendantsInstances
		local count = 0
		local lastHitResult = nil
		while maxDistance >= 0.001 and count <= 10 do
			local hitResult = workspace:Raycast(rayOrigin, rayDirection * maxDistance, raycastParams)
			if not hitResult or shouldFilterFunction and shouldFilterFunction(hitResult.Instance) then
				lastHitResult = hitResult
				break
			end
			lastHitResult = hitResult
			if not shouldFilterFunction and hitResult.Instance.CanCollide then
				break
			end
			table.insert(FilterDescendantsInstances, hitResult.Instance)
			raycastParams.FilterDescendantsInstances = FilterDescendantsInstances
			count = count + 1
		end
		return lastHitResult
	end
}
