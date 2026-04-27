local TweenService = game:GetService("TweenService")
local function warnf(formatString, ...)
	warn(string.format(formatString, ...))
end
local curveData = script.Curve:FindFirstChild("CurveData") and require(script.Curve.CurveData)
local catmullRomSpline = script:FindFirstChild("CatmullRomSpline") and require(script.CatmullRomSpline)
local GraphBezier = require(script.GraphBezier)
local mathf = script:FindFirstChild("Mathf") and require(script.Mathf)
local upVectorData = script.Curve:FindFirstChild("UpVectorData") and require(script.Curve.UpVectorData)
local transformFunction = script.Curve:FindFirstChild("TransformFunction") and require(script.Curve.TransformFunction)
local animationCurve
if curveData.AnimationKeyframes then
	local keyframeTable = {}
	keyframeTable[1] = unpack(curveData.AnimationKeyframes)
	table.sort(keyframeTable, function(keyframeA, keyframeB)
		return keyframeA.pos.X < keyframeB.pos.X
	end)
	if #keyframeTable == 0 or keyframeTable[1].pos.X > 0 then
		table.insert(keyframeTable, 1, {
			pos = Vector2.new(0, 0),
			left = Vector2.new(-0.1, 0),
			right = Vector2.new(0.1, 0)
		})
	end
	if #keyframeTable == 1 or keyframeTable[#keyframeTable].pos.X < 1 then
		table.insert(keyframeTable, {
			pos = Vector2.new(1, 1),
			left = Vector2.new(-0.1, 0),
			right = Vector2.new(0.1, 0)
		})
	end
	animationCurve = GraphBezier.new(keyframeTable)
else
	animationCurve = nil
end
local transformationData = {}
local pathAnimationModule = {}
local NumPoints = curveData.Attributes.NumPoints
function pathAnimationModule.GetCurveValueAt(self, progressValue)
	return mathf.Lerp(self:_getAttribute("GraphMinSpeed") or 0, self:_getAttribute("GraphMaxSpeed") or 1, (math.clamp(self:_getCurveValueAt(progressValue), 0, 1)))
end
function pathAnimationModule.GetProgress(self, lengthValue, offsetValue, deltaTimeValue)
	local positionOffset, directionVector, upVectorResult = self:_getProgress(lengthValue, offsetValue)
	local DeltaTime = self.DeltaTime
	if not DeltaTime then
		DeltaTime = deltaTimeValue or 1 / 60
	end
	return self:_getTransformed(positionOffset, directionVector, upVectorResult, transformationData, DeltaTime)
end
function pathAnimationModule.GetProgressRaw(self, lengthValue, offsetValue, deltaTimeValue)
	local positionOffset, directionVector, upVectorResult = self:_getProgress(lengthValue, offsetValue)
	local DeltaTime = self.DeltaTime
	if not DeltaTime then
		DeltaTime = deltaTimeValue or 1 / 60
	end
	return self:_getTransformedRaw(positionOffset, directionVector, upVectorResult, transformationData, DeltaTime)
end
function pathAnimationModule.CreateTween(self, tweenInfo, curveValue, onProgressCallback)
	local numberValue = Instance.new("NumberValue")
	local createdTween = TweenService:Create(numberValue, tweenInfo, {
		Value = 1
	})
	createdTween:GetPropertyChangedSignal("PlaybackState"):connect(function()
		if createdTween.PlaybackState == Enum.PlaybackState.Playing then
			self.LastTick = os.clock()
		end
	end)
	numberValue:GetPropertyChangedSignal("Value"):connect(function()
		local currentTime = os.clock()
		self.DeltaTime = currentTime - self.LastTick
		self.LastTick = currentTime
		onProgressCallback(self:GetProgress(numberValue.Value, curveValue))
	end)
	return createdTween
end
function pathAnimationModule.Generate(self)
	local ControlPoints = curveData.ControlPoints
	local generatedSpline
	if curveData.Attributes.PathClosed == true then
		local closedPathPoints = {}
		for i = 1, #ControlPoints do
			table.insert(closedPathPoints, ControlPoints[i])
		end
		table.insert(closedPathPoints, ControlPoints[1])
		table.insert(closedPathPoints, ControlPoints[2])
		table.insert(closedPathPoints, ControlPoints[3])
		generatedSpline = catmullRomSpline.new(closedPathPoints, curveData.Attributes.Tension)
	else
		generatedSpline = catmullRomSpline.new(ControlPoints, curveData.Attributes.Tension)
	end
	generatedSpline.LengthIterations = curveData.Attributes.LengthIterations or 2000
	generatedSpline:UpdateLength()
	self.Spline = generatedSpline
	self:_generatePointData()
end
function pathAnimationModule._getAttribute(self, attributeName)
	return curveData.Attributes[attributeName]
end
function pathAnimationModule._getCurveValueAt(self, progressValue)
	if animationCurve then
		return animationCurve:CalculateValueAt(progressValue)
	end
end
function pathAnimationModule._getProgress(self, lengthValue, offsetValue)
	local isPathClosed = self:_getAttribute("PathClosed")
	local splinePosition = self.Spline:CalculatePositionRelativeToLength(lengthValue)
	local splineDerivative = self.Spline:CalculateDerivativeRelativeToLength(lengthValue)
	local upVector = self:_getUpVector(lengthValue, splinePosition, splineDerivative)
	if upVectorData then
		upVector = self:_twistUpvector(upVector, isPathClosed, lengthValue, splineDerivative, upVectorData)
	end
	return splinePosition + upVector * (offsetValue or 0), splineDerivative, upVector
end
function pathAnimationModule._getUpVector(self, lengthValue, splinePosition, splineDerivative)
	if self.PointData then
		local pointDataEntry = self.PointData.points[math.floor(lengthValue * NumPoints)]
		if pointDataEntry then
			return CFrame.lookAt(splinePosition, splinePosition + splineDerivative, pointDataEntry.upVector).UpVector
		else
			return Vector3.new(0, 1, 0)
		end
	else
		return Vector3.new(0, 1, 0)
	end
end
function pathAnimationModule._getTwistAt(self, isLooped, progressValue, twistData)
	local firstTwistEntry = nil
	local lowerTwistDegrees = nil
	local upperTwistDegrees = nil
	local upperTwistTValue = nil
	local matchingTwistEntry = nil
	local lowerTValue = nil
	for k, v in pairs(twistData.data) do
		local degrees = v.degrees
		local tValue = v.tValue
		if degrees ~= 0.00001 then
			firstTwistEntry = firstTwistEntry or v
			if not upperTwistDegrees then
				if tValue <= progressValue then
					lowerTValue = tValue
					lowerTwistDegrees = degrees
				else
					upperTwistDegrees = degrees
					upperTwistTValue = tValue
				end
				if lowerTwistDegrees and upperTwistDegrees then
					matchingTwistEntry = v
					break
				end
			end
			matchingTwistEntry = v
		end
	end
	if isLooped or (not lowerTwistDegrees or upperTwistDegrees) then
		if isLooped and (upperTwistDegrees and not lowerTwistDegrees) then
			lowerTwistDegrees = matchingTwistEntry.degrees + (self.PointData.LoopAngleDiff or 0)
			lowerTValue = matchingTwistEntry.tValue - 1
		elseif isLooped and (lowerTwistDegrees and not upperTwistDegrees) then
			upperTwistDegrees = firstTwistEntry.degrees - (self.PointData.LoopAngleDiff or 0)
			upperTwistTValue = firstTwistEntry.tValue + 1
		end
		if lowerTwistDegrees and upperTwistDegrees then
			return mathf.Lerp(lowerTwistDegrees, lowerTwistDegrees + (upperTwistDegrees - lowerTwistDegrees + 180) % 360 - 180, mathf.PercentBetween(progressValue, lowerTValue, upperTwistTValue))
		else
			return 0
		end
	else
		return lowerTwistDegrees
	end
end
function pathAnimationModule._twistUpvector(self, baseUpVector, isPathClosed, lengthValue, splineDerivative, upVectorDataParam)
	if self.PointData then
		local twistAngle = self:_getTwistAt(isPathClosed, lengthValue, upVectorDataParam)
		if twistAngle == 0 then
			return baseUpVector
		else
			return CFrame.fromAxisAngle(splineDerivative, (math.rad(twistAngle))) * baseUpVector
		end
	end
end
function pathAnimationModule._getTransformed(self, ...)
	local argumentTable = { ... }
	local position, direction, upVector, _
	if transformFunction then
		local success, transformResult = pcall(function()
			return transformFunction(unpack(argumentTable))
		end)
		if success then
			return transformResult
		else
			position, direction, upVector, _ = ...
			return CFrame.lookAt(position, position + direction, upVector)
		end
	else
		position, direction, upVector, _ = ...
		return CFrame.lookAt(position, position + direction, upVector)
	end
end
function pathAnimationModule._getTransformedRaw(self, ...)
	local argumentTable = { ... }
	local position, direction, upVector, _
	if transformFunction then
		local success, transformResult = pcall(function()
			return transformFunction(unpack(argumentTable))
		end)
		if success then
			return transformResult
		else
			position, direction, upVector, _ = ...
			return position, direction, upVector
		end
	else
		position, direction, upVector, _ = ...
		return position, direction, upVector
	end
end
function pathAnimationModule._generatePointData(self)
	local baseUpVector = Vector3.new(0, 1, 0)
	local pointDataStructure = {
		points = {}
	}
	for i = 1, NumPoints do
		local normalizedProgress = i / NumPoints
		local pointPosition = self.Spline:CalculatePositionRelativeToLength(normalizedProgress)
		local pointDerivative = self.Spline:CalculateDerivativeRelativeToLength(normalizedProgress)
		local calculatedUpVector = CFrame.lookAt(pointPosition, pointPosition + pointDerivative, baseUpVector).UpVector
		pointDataStructure.points[i] = {
			upVector = baseUpVector,
			pos = pointPosition,
			dir = pointDerivative,
			t = normalizedProgress
		}
		baseUpVector = calculatedUpVector
	end
	local loopAngleDifference = math.acos(baseUpVector.Y) / math.pi * 180
	pointDataStructure.LoopAngleDiff = loopAngleDifference * if baseUpVector:Dot(pointDataStructure.points[#pointDataStructure.points].dir:Cross(Vector3.new(0, 1, 0))) < 0 then -1 else 1
	self.PointData = pointDataStructure
end
return pathAnimationModule
