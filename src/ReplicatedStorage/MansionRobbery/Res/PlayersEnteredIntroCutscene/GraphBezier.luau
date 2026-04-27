function cubicBezier(self, startPos, controlPoint1, controlPoint2, endPos)
	return (1 - self) ^ 3 * startPos + 3 * (1 - self) ^ 2 * self * controlPoint1 + 3 * (1 - self) * self ^ 2 * controlPoint2 + self ^ 3 * endPos
end
function cubicBezierDerivative(self, startPos, controlPoint1, controlPoint2, endPos)
	return 3 * (1 - self) ^ 2 * (controlPoint1 - startPos) + 6 * self * (1 - self) * (controlPoint2 - controlPoint1) + 3 * self ^ 2 * (endPos - controlPoint2)
end
local BezierCurve = {}
BezierCurve.__index = BezierCurve
function BezierCurve.new(self)
	local instance = setmetatable({}, BezierCurve)
	instance.keyframes = self and { unpack(self) } or {}
	return instance
end
function BezierCurve.UpdateKeyframes(self, keyframeList)
	table.clear(self.keyframes)
	table.move(keyframeList, 1, #keyframeList, 1, self.keyframes)
end
function BezierCurve.CalculateSegmentAt(self, progress)
	local normalizedProgress = progress * (#self.keyframes - 1)
	local segmentIndex = math.floor(normalizedProgress) + 1
	local parametricValue = normalizedProgress % 1
	if segmentIndex < 1 then
		parametricValue = 0
		segmentIndex = 1
	elseif #self.keyframes <= segmentIndex then
		segmentIndex = #self.keyframes - 1
		parametricValue = 1
	end
	return parametricValue, self.keyframes[segmentIndex], self.keyframes[segmentIndex + 1]
end
function BezierCurve.CalculateSpeedAt(self, progress)
	local parametricValue, startKeyframe, endKeyframe = self:CalculateSegmentAt(progress)
	local startPos = startKeyframe.pos
	local startControlPoint = startKeyframe.pos + startKeyframe.right
	local endControlPoint = endKeyframe.pos + endKeyframe.left
	local endPos = endKeyframe.pos
	local startVector = startPos - startControlPoint
	local endVector = endPos - endControlPoint
	local xDifference = endPos.X - startPos.X
	local startXMagnitude = math.abs(startVector.X)
	local endXMagnitude = math.abs(endVector.X)
	if xDifference < startXMagnitude then
		startControlPoint = startPos - xDifference / startXMagnitude * startVector
	end
	if xDifference < endXMagnitude then
		endControlPoint = endPos - xDifference / endXMagnitude * endVector
	end
	local tangent = cubicBezierDerivative(parametricValue, startPos, startControlPoint, endControlPoint, endPos)
	return tangent.Y / math.sqrt(tangent.X ^ 2 + tangent.Y ^ 2)
end
function BezierCurve.CalculatePositionAt(self, progress)
	local parametricValue, startKeyframe, endKeyframe = self:CalculateSegmentAt(progress)
	local startPos = startKeyframe.pos
	local startControlPoint = startKeyframe.pos + startKeyframe.right
	local endControlPoint = endKeyframe.pos + endKeyframe.left
	local endPos = endKeyframe.pos
	local startVector = startPos - startControlPoint
	local endVector = endPos - endControlPoint
	local xDifference = endPos.X - startPos.X
	local startXMagnitude = math.abs(startVector.X)
	local endXMagnitude = math.abs(endVector.X)
	if xDifference < startXMagnitude then
		startControlPoint = startPos - xDifference / startXMagnitude * startVector
	end
	if xDifference < endXMagnitude then
		endControlPoint = endPos - xDifference / endXMagnitude * endVector
	end
	return cubicBezier(parametricValue, startPos, startControlPoint, endControlPoint, endPos)
end
function BezierCurve.CalculateValueAt(self, progress)
	local lowerBound = 0
	local upperBound = 1
	while lowerBound + 0.00001 < upperBound do
		local midpoint = (lowerBound + upperBound) / 2
		if progress < self:CalculatePositionAt(midpoint).X then
			upperBound = midpoint
		else
			lowerBound = midpoint
		end
	end
	local finalProgress = (lowerBound + upperBound) / 2
	return self:CalculatePositionAt(finalProgress).Y, finalProgress
end
return BezierCurve
