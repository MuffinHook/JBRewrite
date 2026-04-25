-- Reviewed by Claude
-- variables reassigned
local function CalculateSegment(train, offset)
	local currentSegment = train.SegmentsById[train.SegmentId]
	if not (offset < currentSegment.Length) then
		repeat
			local nextSegments
			offset = offset - currentSegment.Length
			currentSegment = train.SegmentsById[nextSegments[currentSegment.BranchIndex]]
			if not (currentSegment.Length <= offset) then
				break
			end
			nextSegments = train.SegmentsNext[currentSegment.Id]
		until not nextSegments
	end
	return currentSegment, offset
end
local function CalculateDistanceAhead(train, fromSegmentId, fromDistance, toSegmentId, toDistance)
	if fromSegmentId == toSegmentId then
		return toDistance - fromDistance
	end
	local currentSegment = train.SegmentsById[fromSegmentId]
	local sum = currentSegment.Length - fromDistance
	local segmentId = fromSegmentId
	for i = 1, 3 do
		local nextSegments = train.SegmentsNext[segmentId]
		if not nextSegments then
			return false
		end
		segmentId = nextSegments[currentSegment.BranchIndex]
		currentSegment = train.SegmentsById[segmentId]
		if segmentId == toSegmentId then
			return sum + toDistance
		end
		sum = sum + currentSegment.Length
	end
	local targetSegment = train.SegmentsById[toSegmentId]
	local sum_2 = targetSegment.Length - toDistance
	local segmentId_2 = toSegmentId
	for j = 1, 3 do
		local nextSegments_2 = train.SegmentsNext[segmentId_2]
		if not nextSegments_2 then
			break
		end
		segmentId_2 = nextSegments_2[targetSegment.BranchIndex]
		targetSegment = train.SegmentsById[segmentId_2]
		if segmentId_2 == fromSegmentId then
			return -sum_2 - fromDistance
		end
		sum_2 = sum_2 + targetSegment.Length
	end
	return false
end
return {
	CalculateSegment = CalculateSegment,
	CalculatePosition = function(train, offset)
		local currentSegment, offsetRemainder = CalculateSegment(train, offset)
		if currentSegment then
			local CF = currentSegment.CF
			return CF * Vector3.new(0, 0, currentSegment.Length * 0.5 - offsetRemainder), CF - CF.p
		else
			return false
		end
	end,
	CalculateDistanceAhead = CalculateDistanceAhead,
	MoveTrain = function(train, deltaOffset)
		local currentSegment, offsetRemainder = CalculateSegment(train, train.Offset + deltaOffset * train.Speed)
		train.SegmentId = currentSegment.Id
		train.Offset = offsetRemainder
	end
}
