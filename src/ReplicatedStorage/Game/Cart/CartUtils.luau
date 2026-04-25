-- Reviewed by Claude
-- variables reassigned
return {
	computeRail = function(p1, p2)
		local visitedRails = {
			[p1] = true,
			[p2] = true
		}
		local list = { p1, p2 }
		while true do
			local isFrontMatch, nextVector
			local frontVector = p2:FindFirstChild("_front").Value
			local backVector = p2:FindFirstChild("_back").Value
			isFrontMatch = p1 == frontVector
			nextVector = if isFrontMatch and backVector then backVector else frontVector
			if visitedRails[nextVector] then
				local sum = 0
				local segmentLengths = {}
				for i, v in ipairs(list) do
					local Z = v.Size.Z
					table.insert(segmentLengths, Z)
					sum = sum + Z
				end
				local directionCache = {}
				for i = 1, #list do
					local segmentDirection
					local currentSegment = list[i]
					local previousSegment = list[(i - 1 + 1) % #list + 1]
					local currentFrontVector = currentSegment:FindFirstChild("_front").Value
					segmentDirection = if previousSegment == currentFrontVector then currentSegment.CFrame.LookVector elseif previousSegment == currentSegment:FindFirstChild("_back").Value then -currentSegment.CFrame.LookVector else Vector3.new(0, 1, 0)
					table.insert(directionCache, segmentDirection)
				end
				return {
					listSegment = list,
					lengthCache = segmentLengths,
					totalLength = sum,
					directionCache = directionCache
				}
			end
			visitedRails[nextVector] = true
			table.insert(list, nextVector)
			p2, p1 = nextVector, p2
		end
	end,
	calculateSegment = function(p1, p2)
		local v1 = p2 % p1.totalLength
		for i = 1, #p1.listSegment do
			local v2 = v1 - p1.lengthCache[i]
			if v2 < 0 then
				return i, v1
			end
			v1 = v2
		end
	end,
	calculatePosition = function(p1, p2, p3)
		local v1 = p1.listSegment[p2]
		return v1.Position + p1.directionCache[p2] * (-v1.Size.Z * 0.5 + p3)
	end
}
