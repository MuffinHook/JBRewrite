return {
	computeRail = function(currentRail, nextRail)
		local visitedRails = {
			[currentRail] = true,
			[nextRail] = true
		}
		local list = { currentRail, nextRail }
		while true do
			local isFrontMatch, nextVector
			local frontVector = nextRail:FindFirstChild("_front").Value
			local backVector = nextRail:FindFirstChild("_back").Value
			isFrontMatch = currentRail == frontVector
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
			nextRail, currentRail = nextVector, nextRail
		end
	end,
	calculateSegment = function(railConfig, progressDistance)
		local remainingDistance = progressDistance % railConfig.totalLength
		for i = 1, #railConfig.listSegment do
			local segmentOffset = remainingDistance - railConfig.lengthCache[i]
			if segmentOffset < 0 then
				return i, remainingDistance
			end
			remainingDistance = segmentOffset
		end
	end,
	calculatePosition = function(railConfig, segmentIndex, distanceOffset)
		local segment = railConfig.listSegment[segmentIndex]
		return segment.Position + railConfig.directionCache[segmentIndex] * (-segment.Size.Z * 0.5 + distanceOffset)
	end
}
