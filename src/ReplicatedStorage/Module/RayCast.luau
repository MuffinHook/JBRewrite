local RayConstructor = Ray.new
local FindPartOnRay = workspace.FindPartOnRay
local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local function RayIgnoreNonCollideSpecial(rayOrigin, rayDirection, remainingDistance, returnOnFirst, ignoreList, returnSurface, filterFunction)
	if returnSurface then
		assert(not filterFunction)
	end
	local ignoreTable = if ignoreList then if type(ignoreList) == "table" then table.clone(ignoreList) else { ignoreList } else {}
	local iterationCount, lastHitPosition, surface, normal, shouldUseIgnoreList, hitPart = 0, rayOrigin, -rayDirection, nil, true, nil
	while remainingDistance > 0.01 do
		if iterationCount >= 5 then
			return nil, lastHitPosition, surface, normal
		end
		local currentRay = RayConstructor(rayOrigin, rayDirection * remainingDistance)
		if shouldUseIgnoreList then
			local hitPartIgnore, hitPositionIgnore, surfaceIgnore, normalIgnore = FindPartOnRayWithIgnoreList(workspace, currentRay, ignoreTable, false, not returnSurface)
			lastHitPosition = hitPositionIgnore
			hitPart = hitPartIgnore
			surface = surfaceIgnore
			normal = normalIgnore
		else
			local hitPartDirect, hitPositionDirect, surfaceDirect, normalDirect = FindPartOnRay(workspace, currentRay, ignoreTable, false, not returnSurface)
			lastHitPosition = hitPositionDirect
			hitPart = hitPartDirect
			surface = surfaceDirect
			normal = normalDirect
		end
		local distanceTraveled = (rayOrigin - lastHitPosition).Magnitude
		if hitPart then
			if returnSurface or not filterFunction and hitPart.CanCollide or filterFunction and filterFunction(hitPart) then
				return hitPart, lastHitPosition, surface, normal
			end
			table.insert(ignoreTable, hitPart)
		else
			remainingDistance, rayOrigin = remainingDistance - distanceTraveled, lastHitPosition
		end
		iterationCount = iterationCount + 1
	end
	return hitPart, lastHitPosition, surface, normal
end
local function RayIgnoreNonCollideWithIgnoreList(rayOrigin, rayDirection, remainingDistance, ignoreList, returnSurface, filterFunction)
	return RayIgnoreNonCollideSpecial(rayOrigin, rayDirection, remainingDistance, true, ignoreList, returnSurface, filterFunction)
end
return {
	RayIgnoreNonCollide = function(rayOrigin, rayDirection, remainingDistance, ignoreList, returnSurface, filterFunction)
		return RayIgnoreNonCollideSpecial(rayOrigin, rayDirection, remainingDistance, false, ignoreList, returnSurface, filterFunction)
	end,
	RayIgnoreNonCollideWithIgnoreList = RayIgnoreNonCollideWithIgnoreList
}
