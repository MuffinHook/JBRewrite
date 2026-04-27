local function CubicBezierCurve(t, point1, point2, point3, point4)
	local oneMinusT = 1 - t
	return oneMinusT * oneMinusT * oneMinusT * point1 + 3 * oneMinusT * oneMinusT * t * point2 + 3 * oneMinusT * t * t * point3 + t * t * t * point4
end
local function DCubicBezierCurve(t, point1, point2, point3, point4)
	local oneMinusT = 1 - t
	return 3 * oneMinusT * oneMinusT * (point2 - point1) + 6 * oneMinusT * t * (point3 - point2) + 3 * t * t * (point4 - point3)
end
local function ApproximateVectorCubicBezierCurveLength(iterations, point1, point2, point3, point4)
	local sum = 0
	for i = 1, iterations do
		local t = (i - 1) / iterations
		local oneMinusT = 1 - t
		sum = sum + (3 * oneMinusT * oneMinusT * (point2 - point1) + 6 * oneMinusT * t * (point3 - point2) + 3 * t * t * (point4 - point3)).Magnitude / iterations
	end
	return sum
end
local BezierPath = {}
BezierPath.__index = BezierPath
function BezierPath.new()
	local self = setmetatable({}, BezierPath)
	self.Points = nil
	self.NumPoints = nil
	self.LastIndex = nil
	self.OffsetStart = 0
	self.OffsetEnd = 0
	self.progress = 0
	self.lengthCache = {}
	return self
end
function BezierPath.SetNodeOffset(self, startOffset, endOffset)
	assert(startOffset)
	assert(endOffset)
	self.OffsetStart = startOffset
	self.OffsetEnd = endOffset
end
function BezierPath.SetPoints(self, points)
	self.Points = points
	self.NumPoints = #points
	self:_recomputeLengthCache()
end
function BezierPath._recomputeLengthCache(self)
	for i = 1, self.NumPoints do
		local currentPoint = self:GetPoint(i)
		local nextPoint = self:GetPoint(i + 1)
		local magnitude = (nextPoint - currentPoint).Magnitude
		local controlPoint1 = currentPoint + (nextPoint - self:GetPoint(i - 1)).Unit * magnitude / 3
		self.lengthCache[i] = ApproximateVectorCubicBezierCurveLength(10000, currentPoint, controlPoint1, nextPoint - (self:GetPoint(i + 2) - currentPoint).Unit * magnitude / 3, nextPoint)
	end
end
function BezierPath.GetPoint(self, index)
	return self.Points[(index - 1) % self.NumPoints + 1]
end
function BezierPath.ApproximateLength(self, precision)
	local sum = 0
	for i = self.OffsetStart + 1, self.NumPoints - self.OffsetEnd do
		local currentPoint = self:GetPoint(i)
		local nextPoint = self:GetPoint(i + 1)
		local magnitude = (nextPoint - currentPoint).Magnitude
		sum = sum + ApproximateVectorCubicBezierCurveLength(precision, currentPoint, currentPoint + (nextPoint - self:GetPoint(i - 1)).Unit * magnitude / 3, nextPoint - (self:GetPoint(i + 2) - currentPoint).Unit * magnitude / 3, nextPoint)
	end
	return sum
end
function BezierPath.Step(self, distance)
	local currentProgress = self.progress
	local interpolatedPosition = currentProgress * (self.NumPoints - self.OffsetStart - self.OffsetEnd) + self.OffsetStart
	local fractionalPart = interpolatedPosition % 1
	local segmentIndex = math.floor(interpolatedPosition) + 1
	local p0, c0, c1, p1
	if self.LastIndex == segmentIndex then
		p0 = self._p0
		c0 = self._c0
		c1 = self._c1
		p1 = self._p1
	else
		local currentPoint = self:GetPoint(segmentIndex)
		local nextPoint = self:GetPoint(segmentIndex + 1)
		local magnitude = (nextPoint - currentPoint).Magnitude
		c0 = currentPoint + (nextPoint - self:GetPoint(segmentIndex - 1)).Unit * magnitude / 3
		c1 = nextPoint - (self:GetPoint(segmentIndex + 2) - currentPoint).Unit * magnitude / 3
		self._p0 = currentPoint
		self._c0 = c0
		self._c1 = c1
		self._p1 = nextPoint
		p0 = currentPoint
		p1 = nextPoint
	end
	self.LastIndex = segmentIndex
	local oneMinusFrac = 1 - fractionalPart
	local tangent = 3 * oneMinusFrac * oneMinusFrac * (c0 - p0) + 6 * oneMinusFrac * fractionalPart * (c1 - c0) + 3 * fractionalPart * fractionalPart * (p1 - c1)
	local tangentMagnitude = tangent.Magnitude
	local oneMinusFracCube = 1 - fractionalPart
	if tangentMagnitude > 0 then
		self.progress = currentProgress + distance / tangentMagnitude / (self.NumPoints - self.OffsetStart - self.OffsetEnd)
	end
	return oneMinusFracCube * oneMinusFracCube * oneMinusFracCube * p0 + 3 * oneMinusFracCube * oneMinusFracCube * fractionalPart * c0 + 3 * oneMinusFracCube * fractionalPart * fractionalPart * c1 + fractionalPart * fractionalPart * fractionalPart * p1, tangent
end
function BezierPath.GetWorldPositionAt(self, distance)
	local segmentIndex = 1 + self.OffsetStart
	while true do
		local p0, p1
		local currentPoint = self:GetPoint(segmentIndex)
		local nextPoint = self:GetPoint(segmentIndex + 1)
		local magnitude = (nextPoint - currentPoint).Magnitude
		local controlPoint1 = currentPoint + (nextPoint - self:GetPoint(segmentIndex - 1)).Unit * magnitude / 3
		local controlPoint2 = nextPoint - (self:GetPoint(segmentIndex + 2) - currentPoint).Unit * magnitude / 3
		local segmentLength = self.lengthCache[(segmentIndex - 1) % self.NumPoints + 1]
		if segmentLength then
			p0 = currentPoint
			p1 = nextPoint
		else
			segmentLength, p0, p1 = ApproximateVectorCubicBezierCurveLength(10000, currentPoint, controlPoint1, controlPoint2, nextPoint), currentPoint, nextPoint
		end
		if distance < segmentLength then
			local t = distance / segmentLength
			local oneMinusT = 1 - t
			local oneMinusT2 = 1 - t
			return oneMinusT * oneMinusT * oneMinusT * p0 + 3 * oneMinusT * oneMinusT * t * controlPoint1 + 3 * oneMinusT * t * t * controlPoint2 + t * t * t * p1, 3 * oneMinusT2 * oneMinusT2 * (controlPoint1 - p0) + 6 * oneMinusT2 * t * (controlPoint2 - controlPoint1) + 3 * t * t * (p1 - controlPoint2)
		end
		segmentIndex = segmentIndex + 1
		distance = distance - segmentLength
	end
end
function BezierPath.Reset(self)
	self.progress = 0
	self._p0 = nil
	self._c0 = nil
	self._c1 = nil
	self._p1 = nil
	self.LastIndex = nil
end
return BezierPath
