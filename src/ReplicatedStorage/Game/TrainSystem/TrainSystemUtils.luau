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
	local forwardSum = currentSegment.Length - fromDistance
	local forwardSegmentId = fromSegmentId
	for i = 1, 3 do
		local forwardNextSegments = train.SegmentsNext[forwardSegmentId]
		if not forwardNextSegments then
			return false
		end
		forwardSegmentId = forwardNextSegments[currentSegment.BranchIndex]
		currentSegment = train.SegmentsById[forwardSegmentId]
		if forwardSegmentId == toSegmentId then
			return forwardSum + toDistance
		end
		forwardSum = forwardSum + currentSegment.Length
	end
	local targetSegment = train.SegmentsById[toSegmentId]
	local backwardSum = targetSegment.Length - toDistance
	local backwardSegmentId = toSegmentId
	for j = 1, 3 do
		local backwardNextSegments = train.SegmentsNext[backwardSegmentId]
		if not backwardNextSegments then
			break
		end
		backwardSegmentId = backwardNextSegments[targetSegment.BranchIndex]
		targetSegment = train.SegmentsById[backwardSegmentId]
		if backwardSegmentId == fromSegmentId then
			return -backwardSum - fromDistance
		end
		backwardSum = backwardSum + targetSegment.Length
	end
	return false
end
return {
	CalculateSegment = CalculateSegment,
	CalculatePosition = function(train, offset)
		local currentSegment, offsetRemainder = CalculateSegment(train, offset)
		if currentSegment then
			local segmentCFrame = currentSegment.CF
			return segmentCFrame * Vector3.new(0, 0, currentSegment.Length * 0.5 - offsetRemainder), segmentCFrame - segmentCFrame.p
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
