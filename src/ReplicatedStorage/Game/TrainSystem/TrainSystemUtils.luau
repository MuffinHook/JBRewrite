-- Reviewed by Claude
local function CalculateSegment(p1, p2)
	local v1 = p1.SegmentsById[p1.SegmentId]
	if not (p2 < v1.Length) then
		repeat
			local v2
			p2 = p2 - v1.Length
			v1 = p1.SegmentsById[v2[v1.BranchIndex]]
			if not (v1.Length <= p2) then
				break
			end
			v2 = p1.SegmentsNext[v1.Id]
		until not v2
	end
	return v1, p2
end
local function CalculateDistanceAhead(p1, p2, p3, p4, p5)
	if p2 == p4 then
		return p5 - p3
	end
	local v1 = p1.SegmentsById[p2]
	local sum = v1.Length - p3
	local v2 = p2
	for i = 1, 3 do
		local v3 = p1.SegmentsNext[v2]
		if not v3 then
			return false
		end
		v2 = v3[v1.BranchIndex]
		v1 = p1.SegmentsById[v2]
		if v2 == p4 then
			return sum + p5
		end
		sum = sum + v1.Length
	end
	local v4 = p1.SegmentsById[p4]
	local sum_2 = v4.Length - p5
	local v5 = p4
	for j = 1, 3 do
		local v6 = p1.SegmentsNext[v5]
		if not v6 then
			break
		end
		v5 = v6[v4.BranchIndex]
		v4 = p1.SegmentsById[v5]
		if v5 == p2 then
			return -sum_2 - p3
		end
		sum_2 = sum_2 + v4.Length
	end
	return false
end
return {
	CalculateSegment = CalculateSegment,
	CalculatePosition = function(p1, p2)
		local v1, v2 = CalculateSegment(p1, p2)
		if v1 then
			local CF = v1.CF
			return CF * Vector3.new(0, 0, v1.Length * 0.5 - v2), CF - CF.p
		else
			return false
		end
	end,
	CalculateDistanceAhead = CalculateDistanceAhead,
	MoveTrain = function(p1, p2)
		local v1, v2 = CalculateSegment(p1, p1.Offset + p2 * p1.Speed)
		p1.SegmentId = v1.Id
		p1.Offset = v2
	end
}
