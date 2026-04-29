local Mathf = {
	FrameDelta = function(deltaTime, timeScale)
		return 1 - (1 - deltaTime) ^ (timeScale * 60)
	end,
	SafeLerp = function(startValue, endValue, progress)
		if startValue == nil or progress >= 1 then
			return endValue
		elseif endValue == nil or progress <= 0 then
			return startValue
		elseif typeof(startValue) == "Color3" then
			local inverseProgress = 1 - progress
			return Color3.new((startValue.R ^ 2 * inverseProgress + endValue.R ^ 2 * progress) ^ 0.5, (startValue.G ^ 2 * inverseProgress + endValue.G ^ 2 * progress) ^ 0.5, (startValue.B ^ 2 * inverseProgress + endValue.B ^ 2 * progress) ^ 0.5)
		else
			return startValue * (1 - progress) + endValue * progress
		end
	end,
	PercentBetween = function(value, min, max)
		if max - min == 0 then
			return 1
		else
			return math.clamp((value - min) / (max - min), 0, 1)
		end
	end,
	Round = function(value, increment, roundOffset)
		return math.floor(value / increment + (roundOffset or 0.5)) * increment
	end,
	RoundNumber = function(value)
		return value >= 0 and math.floor(value + 0.5) or math.ceil(value - 0.5)
	end,
	Lerp = function(startValue, endValue, progress)
		return startValue * (1 - progress) + endValue * progress
	end,
	SmoothLerp = function(startValue, endValue, progress, smoothness)
		local easeProgress = 1 - math.pow(1 - progress, smoothness)
		if type(startValue) == "number" then
			return (1 - easeProgress) * startValue + endValue * easeProgress
		else
			return startValue:Lerp(endValue, easeProgress)
		end
	end,
	LerpTowards = function(currentValue, targetValue, step)
		if currentValue < targetValue then
			return math.clamp(currentValue + step, currentValue, targetValue)
		else
			return math.clamp(currentValue - step, targetValue, currentValue)
		end
	end,
	Wrap = function(value, min, max)
		return min + (value - min) % (max - min)
	end,
	Cubic_Interpolate = function(p0, p1, p2, p3, progression)
		local cubicCoeff = p3 - p2 - (p0 - p1)
		return cubicCoeff * progression ^ 3 + (p0 - p1 - cubicCoeff) * progression ^ 2 + (p2 - p0) * progression + p1
	end,
	SlerpVector = function(startVector, endVector, progress)
		return CFrame.new(Vector3.new(0, 0, 0), startVector):Lerp(CFrame.new(Vector3.new(0, 0, 0), endVector), progress).LookVector
	end,
	RandomizeVector = function(randomGenerator, magnitude, maxAngle)
		local orientedFrame = CFrame.new(Vector3.new(), magnitude) * CFrame.Angles(0, 0, randomGenerator:NextNumber(0, math.tau))
		local Angles = CFrame.Angles
		return (orientedFrame * Angles(math.acos((randomGenerator:NextNumber(math.cos(maxAngle), 1))), 0, 0)).LookVector * magnitude.Magnitude
	end,
	LerpColor3 = function(startColor, endColor, progress)
		local inverseProgress = 1 - progress
		return Color3.new((startColor.R ^ 2 * inverseProgress + endColor.R ^ 2 * progress) ^ 0.5, (startColor.G ^ 2 * inverseProgress + endColor.G ^ 2 * progress) ^ 0.5, (startColor.B ^ 2 * inverseProgress + endColor.B ^ 2 * progress) ^ 0.5)
	end,
	InPart = function(part, point, scale)
		local localPoint = part.CFrame:PointToObjectSpace(point)
		local scaledSize = part.Size * (scale or 1)
		if math.abs(localPoint.x) <= scaledSize.x / 2 and (math.abs(localPoint.y) <= scaledSize.y / 2 and math.abs(localPoint.z) <= scaledSize.z / 2) then
			return true
		else
			return false
		end
	end,
	IK = function(startPos, endPos, boneALength, boneBLength)
		if boneALength + boneBLength <= (startPos - endPos).magnitude then
			return CFrame.new(startPos, endPos), 0, 0
		elseif (startPos - endPos).magnitude < math.max(boneALength, boneBLength) - math.min(boneALength, boneBLength) then
			return CFrame.new(startPos, endPos), 0, math.pi
		else
			local baseCFrame = CFrame.new(startPos, endPos)
			local objectSpacePoint = baseCFrame:pointToObjectSpace(endPos)
			local jointX = (objectSpacePoint.z ^ 2 - boneBLength ^ 2 + boneALength ^ 2) / (2 * objectSpacePoint.z)
			local jointY = math.sqrt(1 - (jointX / boneALength) ^ 2) * boneALength
			local angleA = -math.asin(jointY / (jointX ^ 2 + jointY ^ 2) ^ 0.5)
			local angleB, sinComponent
			if jointX < objectSpacePoint.z then
				angleB = -math.pi + math.asin(-jointY / ((objectSpacePoint.z - jointX) ^ 2 + jointY ^ 2) ^ 0.5)
				if not angleB then
					sinComponent = -jointY / ((objectSpacePoint.z - jointX) ^ 2 + jointY ^ 2) ^ 0.5
					angleB = -math.asin(sinComponent)
				end
			else
				sinComponent = -jointY / ((objectSpacePoint.z - jointX) ^ 2 + jointY ^ 2) ^ 0.5
				angleB = -math.asin(sinComponent)
			end
			return baseCFrame, angleA, angleB - angleA
		end
	end,
	Vector3ToPixel = function(worldPosition, camera, viewport)
		local screenWidth = viewport.AbsoluteSize.X
		local screenHeight = viewport.AbsoluteSize.Y
		local cameraSpacePos = (camera.CoordinateFrame * CFrame.Angles(0, 0, -camera:GetRoll())):inverse() * worldPosition
		local focalLength = 1 / math.tan(math.rad(camera.FieldOfView) / 2)
		local pixelX = screenWidth / 2 * (1 + cameraSpacePos.x / -cameraSpacePos.z * focalLength * screenHeight / screenWidth)
		local pixelY = screenHeight / 2 * (1 + cameraSpacePos.y / -cameraSpacePos.z * focalLength)
		if cameraSpacePos.z > 0 then
			pixelX = 20000
			pixelY = 20000
		end
		return pixelX, screenHeight - pixelY - 36
	end,
	LerpAngle = function(startAngle, endAngle, progress)
		return (if startAngle - endAngle < 180 then startAngle + (endAngle - startAngle) * progress else startAngle + (360 + endAngle - startAngle) * progress - 180) % 360 - 180
	end
}
function Mathf.LerpTowardsAngle(currentAngle, targetAngle, step)
	if math.abs(targetAngle - currentAngle) > 180 then
		if targetAngle < currentAngle then
			currentAngle = currentAngle + 360
		else
			targetAngle = targetAngle + 360
		end
	end
	return Mathf.LerpTowards(currentAngle, targetAngle, step)
end
function Mathf.LerpAngle2(startAngle, endAngle, progress)
	local normalizedStart = startAngle + 180
	local normalizedEnd = endAngle + 180
	local angleDifference = math.abs(normalizedEnd - normalizedStart)
	if angleDifference > 180 then
		if normalizedStart < normalizedEnd then
			normalizedEnd = normalizedEnd - 360
		else
			normalizedStart = normalizedStart - 360
		end
	end
	return Mathf.Wrap(Mathf.Lerp(normalizedStart - 180, normalizedEnd - 180, progress), -180, 180)
end
function Mathf.AngleDistance(angleA, angleB)
	local degreesA = math.deg(angleA)
	local degreesB = math.deg(angleB)
	local angleDifference = math.abs(degreesB - degreesA)
	local resultA, resultB
	if angleDifference > 180 then
		if degreesB < degreesA then
			resultA = degreesA
			resultB = degreesB + 360
		else
			resultA = degreesA + 360
			resultB = degreesB
		end
	else
		resultA = degreesA
		resultB = degreesB
	end
	return math.rad(resultA - resultB)
end
function Mathf.InterpolateCFrame(startFrame, endFrame, progress)
	return if progress < 0.001 and startFrame then startFrame elseif progress > 0.999 and endFrame then endFrame else startFrame:lerp(endFrame, progress)
end
return Mathf
