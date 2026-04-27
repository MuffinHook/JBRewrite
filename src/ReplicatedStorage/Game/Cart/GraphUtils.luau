local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Module.Table)
local t = {
	calculateDist = function(segments, targetTime)
		local count = 1
		local elapsedTime = 0
		local sum = 0
		while true do
			local segment = segments[count]
			local speedDifference = segment.speedStart or segment.speed
			local timeUntil = segment.timeUntil
			local timeInSegment = math.min(timeUntil, targetTime) - elapsedTime
			sum = sum + (((segment.speedEnd or segment.speed) - speedDifference) / (2 * (timeUntil - elapsedTime)) * timeInSegment * timeInSegment + speedDifference * timeInSegment)
			elapsedTime = segment.timeUntil
			count = count + 1
			if #segments < count or targetTime < elapsedTime then
				return sum
			end
		end
	end,
	calculateSpeed = function(segments, targetTime)
		local elapsedTime = 0
		for i = 1, #segments do
			local segment = segments[i]
			local timeUntil = segment.timeUntil
			local timeInSegment = math.min(timeUntil, targetTime) - elapsedTime
			if targetTime <= timeUntil then
				local initialSpeed = segment.speedStart or segment.speed
				return ((segment.speedEnd or segment.speed) - initialSpeed) / (timeUntil - elapsedTime) * timeInSegment + initialSpeed
			end
			elapsedTime = segment.timeUntil
		end
	end
}
function t.calculateTime(segments, targetDistance)
	assert(#segments > 0)
	if not (t.calculateDist(segments, segments[#segments].timeUntil) < targetDistance) then
		local lastError = 0
		local function binarySearchSegment(minTime, maxTime)
			local midpoint = (minTime + maxTime) * 0.5
			local error = t.calculateDist(segments, midpoint) - targetDistance
			if math.abs(error) < 1e-6 then
				return midpoint
			else
				if math.abs(error - lastError) < 1e-6 then
				else
					lastError = error
					if error > 0 then
						return binarySearchSegment(minTime, midpoint)
					else
						return binarySearchSegment(midpoint, maxTime)
					end
				end
			end
		end
		return binarySearchSegment(0, segments[#segments].timeUntil)
	end
end
function t.constrainLastTimeToReachTarget(segments, targetDistance)
	if #segments > 1 and targetDistance < t.calculateDist(segments, segments[#segments - 1].timeUntil) then
		return nil
	else
		local lastError = 0
		local function binarySearchSegment(minTime, maxTime)
			local midpoint = (minTime + maxTime) * 0.5
			segments[#segments].timeUntil = midpoint
			local error = t.calculateDist(segments, midpoint) - targetDistance
			if math.abs(error) < 1e-6 then
				return midpoint
			else
				if math.abs(error - lastError) < 1e-6 then
				else
					lastError = error
					if error > 0 then
						return binarySearchSegment(minTime, midpoint)
					else
						return binarySearchSegment(midpoint, maxTime)
					end
				end
			end
		end
		return binarySearchSegment(#segments > 1 and segments[#segments - 1].timeUntil or 0, 10000000000)
	end
end
function t.cap(segments)
	table.insert(segments, {
		timeUntil = 10000000000,
		speedStart = 0,
		speedEnd = 0
	})
end
return t
