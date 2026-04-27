local module = {
	doesLineIntersectLine = function(line1StartX, line1StartY, line1EndX, line1EndY, line2StartX, line2StartY, line2EndX, line2EndY)
		if line1StartX == line1EndX and line1StartY == line1EndY or line2StartX == line2EndX and line2StartY == line2EndY then
			return false
		else
			local denominator = (line2EndY - line2StartY) * (line1EndX - line1StartX) - (line2EndX - line2StartX) * (line1EndY - line1StartY)
			if denominator == 0 then
				return false
			else
				local parameterT = ((line2EndX - line2StartX) * (line1StartY - line2StartY) - (line2EndY - line2StartY) * (line1StartX - line2StartX)) / denominator
				local parameterU = ((line1EndX - line1StartX) * (line1StartY - line2StartY) - (line1EndY - line1StartY) * (line1StartX - line2StartX)) / denominator
				return not (parameterT < 0 or (parameterT > 1 or (parameterU < 0 or parameterU > 1)))
			end
		end
	end,
	fasterComputeAABB = function(root)
		local abs = math.abs
		local maxY = (-1 / 0)
		local maxZ = (-1 / 0)
		local minX = (1 / 0)
		local minY = (1 / 0)
		local minZ = (1 / 0)
		local maxX = (-1 / 0)
		for k, part in pairs(root:GetDescendants()) do
			if part:IsA("BasePart") then
				local Size = part.Size
				local X = Size.X
				local Y = Size.Y
				local Z = Size.Z
				local cframeX, cframeY, cframeZ, m01, m02, m03, m10, m11, m12, m20, m21, m22 = part.CFrame:GetComponents()
				local extentX = 0.5 * (abs(m01) * X + abs(m02) * Y + abs(m03) * Z)
				local extentY = 0.5 * (abs(m10) * X + abs(m11) * Y + abs(m12) * Z)
				local extentZ = 0.5 * (abs(m20) * X + abs(m21) * Y + abs(m22) * Z)
				if cframeX - extentX < minX then
					minX = cframeX - extentX
				end
				if cframeY - extentY < minY then
					minY = cframeY - extentY
				end
				if cframeZ - extentZ < minZ then
					minZ = cframeZ - extentZ
				end
				if maxX < cframeX + extentX then
					maxX = cframeX + extentX
				end
				if maxY < cframeY + extentY then
					maxY = cframeY + extentY
				end
				if maxZ < cframeZ + extentZ then
					maxZ = cframeZ + extentZ
				end
			end
		end
		return Vector3.new(minX, minY, minZ), Vector3.new(maxX, maxY, maxZ)
	end
}
function module.fasterComputeAABBPart(part)
	return module.fasterComputeAABBCFSize(part.CFrame, part.Size)
end
function module.fasterComputeAABBCFSize(cframe, size)
	local abs = math.abs
	local minX = (1 / 0)
	local minY = (1 / 0)
	local minZ = (1 / 0)
	local maxX = (-1 / 0)
	local maxY = (-1 / 0)
	local maxZ = (-1 / 0)
	local X = size.X
	local Y = size.Y
	local Z = size.Z
	local cframeX, cframeY, cframeZ, m01, m02, m03, m10, m11, m12, m20, m21, m22 = cframe:GetComponents()
	local extentX = (abs(m01) * X + abs(m02) * Y + abs(m03) * Z) * 0.5
	local extentY = (abs(m10) * X + abs(m11) * Y + abs(m12) * Z) * 0.5
	local extentZ = (abs(m20) * X + abs(m21) * Y + abs(m22) * Z) * 0.5
	if cframeX - extentX < minX then
		minX = cframeX - extentX
	end
	if cframeY - extentY < minY then
		minY = cframeY - extentY
	end
	if cframeZ - extentZ < minZ then
		minZ = cframeZ - extentZ
	end
	if maxX < cframeX + extentX then
		maxX = cframeX + extentX
	end
	if maxY < cframeY + extentY then
		maxY = cframeY + extentY
	end
	if maxZ < cframeZ + extentZ then
		maxZ = cframeZ + extentZ
	end
	return Vector3.new(minX, minY, minZ), Vector3.new(maxX, maxY, maxZ)
end
function module.calcRayIntersectSphere(rayStart, rayEnd, sphereCenter, sphereRadius)
	local Unit = (rayEnd - rayStart).Unit
	local rayToSphere = sphereCenter - rayStart
	local projectedDistance = rayToSphere:Dot(Unit)
	if projectedDistance < 0 then
		return nil, nil
	else
		local closestDistance = math.sqrt(rayToSphere:Dot(rayToSphere) - projectedDistance ^ 2)
		if closestDistance < 0 then
			return nil, nil
		else
			local perpDistance = math.sqrt(sphereRadius ^ 2 - closestDistance ^ 2)
			local nearDistance = projectedDistance - perpDistance
			local farDistance = projectedDistance + perpDistance
			local Magnitude = (rayEnd - rayStart).Magnitude
			if farDistance <= Magnitude then
				return rayStart + Unit * nearDistance, rayStart + Unit * farDistance
			elseif nearDistance <= Magnitude then
				return rayStart + Unit * nearDistance, nil
			else
				return nil, nil
			end
		end
	end
end
function module.intersectRayPlane(rayStart, rayDirection, planePoint, planeNormal)
	local denominator = planeNormal:Dot(rayDirection)
	if not (math.abs(denominator) < 1e-6) then
		local parameter = planeNormal:Dot(planePoint - rayStart) / denominator
		if not (parameter < 0) then
			return rayStart + rayDirection * parameter
		end
	end
end
function module.isPointInCylinder(point, cylinderBase, cylinderAxis, cylinderHeight, cylinderRadius)
	local Unit = cylinderAxis.Unit
	local pointRelative = point - cylinderBase
	local heightAlongAxis = pointRelative:Dot(Unit)
	if heightAlongAxis < 0 or cylinderHeight < heightAlongAxis then
		return false
	else
		return not (cylinderRadius < (pointRelative - Unit * heightAlongAxis).Magnitude)
	end
end
function module.randomPointInCircle()
	local radius = math.sqrt((math.random()))
	local angle = math.random() * 2 * math.pi
	return Vector2.new(radius * math.cos(angle), radius * math.sin(angle))
end
function module.randomPointOnCircle()
	local angle = math.random() * 2 * math.pi
	return Vector2.new(math.cos(angle), (math.sin(angle)))
end
function module.randomPointInRing(innerRadiusRatio)
	local radius = math.sqrt(math.random() * (1 - innerRadiusRatio ^ 2) + innerRadiusRatio ^ 2)
	local angle = math.random() * 2 * math.pi
	return Vector2.new(radius * math.cos(angle), radius * math.sin(angle))
end
function module.randomPointOnSphere()
	local azimuthAngle = math.random() * math.pi * 2
	local yComponent = math.random() * 2 - 1
	local xyRadius = math.sqrt(1 - yComponent ^ 2) * math.cos(azimuthAngle)
	return Vector3.new(xyRadius, math.sqrt(1 - yComponent ^ 2) * math.sin(azimuthAngle), yComponent)
end
function module.randomPointInSphere()
	local azimuthAngle = math.random() * 2 * math.pi
	local polarAngle = math.acos(2 * math.random() - 1)
	local radialScale = math.random() ^ 1/3
	local sinAzimuth = math.sin(azimuthAngle)
	local cosAzimuth = math.cos(azimuthAngle)
	local sinPolar = math.sin(polarAngle)
	return Vector3.new(radialScale * sinPolar * cosAzimuth, radialScale * sinPolar * sinAzimuth, radialScale * math.cos(polarAngle))
end
function module.shortAngleDist(angle1, angle2)
	local direction = math.sign(angle2 - angle1)
	local normalizedDelta = direction * (math.abs(angle2 - angle1) % math.tau)
	return direction * (math.abs(normalizedDelta) * 2 % math.tau) - normalizedDelta
end
function module.waveTriangle(time, amplitude, period)
	local amp = amplitude or 1
	assert(amp)
	local dur = period or 1
	assert(dur)
	return 4 * amp / dur * math.abs(time % dur - dur / 2) - amp
end
function module.closestPointInPart(part, targetPoint)
	local partCFrame = part.CFrame
	local localPoint = partCFrame:PointToObjectSpace(targetPoint)
	local halfExtentX = part.Size.X * 0.5
	local halfExtentY = part.Size.Y * 0.5
	local halfExtentZ = part.Size.Z * 0.5
	return partCFrame * Vector3.new(math.clamp(localPoint.X, -halfExtentX, halfExtentX), math.clamp(localPoint.Y, -halfExtentY, halfExtentY), (math.clamp(localPoint.Z, -halfExtentZ, halfExtentZ)))
end
function module.closestPointOnPart(part, targetPoint)
	return part:GetClosestPointOnSurface(targetPoint)
end
function module.closestPointOnLine(lineStart, lineDirection, targetPoint)
	local Unit = lineDirection.Unit
	local closestPoint = lineStart + Unit * math.clamp(Unit:Dot(targetPoint - lineStart), 0, lineDirection.Magnitude)
	return closestPoint, (targetPoint - closestPoint).Magnitude
end
function module.getSunflowerSeedArrangementGenerator(pointCount, goldenAngleScalar, baseRadius)
	local goldenAngleFactor = math.floor(goldenAngleScalar * math.sqrt(pointCount) + 0.5)
	local currentIndex = 0
	return function()
		currentIndex = currentIndex + 1
		if currentIndex <= pointCount then
			local radiusParameter = baseRadius
			if currentIndex <= pointCount - goldenAngleFactor then
				radiusParameter = baseRadius * math.sqrt((1 - currentIndex * 2) / (goldenAngleFactor - pointCount * 2 + 1))
			end
			return Vector3.new(math.cos(2.399963229728653 * currentIndex), 0, (math.sin(2.399963229728653 * currentIndex))) * radiusParameter, radiusParameter
		else
			return nil, nil
		end
	end
end
function module.getTrajectoryInterceptTime(targetPosition, projectileSpeed, launcherPosition, launcherVelocityScale, targetVelocity)
	local X = targetPosition.X
	local Y = targetPosition.Y
	local Z = targetPosition.Z
	local X_2 = targetVelocity.X
	local Y_2 = targetVelocity.Y
	local Z_2 = targetVelocity.Z
	local X_3 = launcherPosition.X
	local Y_3 = launcherPosition.Y
	local Z_3 = launcherPosition.Z
	local quadraticA = projectileSpeed * projectileSpeed - (X_2 * X_2 + Y_2 * Y_2 + Z_2 * Z_2) * launcherVelocityScale * launcherVelocityScale
	local discriminantTerm = math.sqrt(launcherVelocityScale * 4 * launcherVelocityScale * (X_2 * (X_3 - X) + Y_2 * (Y_3 - Y) + Z_2 * (Z_3 - Z)) ^ 2 - ((X_2 * X_2 + Y_2 * Y_2 + Z_2 * Z_2) * launcherVelocityScale * launcherVelocityScale - projectileSpeed * projectileSpeed) * 4 * ((X_3 - X) ^ 2 + (Y_3 - Y) ^ 2 + (Z_3 - Z) ^ 2)) * 0.5
	local quadraticB = X_2 * X * launcherVelocityScale + Y_2 * Y * launcherVelocityScale + Z_2 * Z * launcherVelocityScale - X_2 * X_3 * launcherVelocityScale - Y_2 * Y_3 * launcherVelocityScale - Z_2 * Z_3 * launcherVelocityScale
	local timeSolution1 = (quadraticB + discriminantTerm) / quadraticA
	local timeSolution2 = (quadraticB - discriminantTerm) / quadraticA
	if timeSolution1 ~= timeSolution1 or timeSolution1 <= 0 then
		timeSolution1 = nil
	end
	if timeSolution2 ~= timeSolution2 or timeSolution2 <= 0 then
		timeSolution2 = nil
	end
	if timeSolution1 and timeSolution2 then
		return math.min(timeSolution1, timeSolution2)
	else
		return timeSolution1 or timeSolution2
	end
end
function module.offsetLookAtTarget(observerDistance, observerSize, targetOffsetX, targetOffsetY, targetSize, cameraOffsetZ)
	if cameraOffsetZ == 0 then
		return 0, 0
	else
		local radiusSquared = targetOffsetY * targetOffsetY + cameraOffsetZ * cameraOffsetZ
		local azimuthAngle = cameraOffsetZ < 0 and math.atan(targetOffsetY / cameraOffsetZ) or math.pi - math.atan(-targetOffsetY / cameraOffsetZ)
		local elevationAngle = azimuthAngle + (observerDistance * observerDistance < radiusSquared and math.asin(observerDistance / radiusSquared ^ 0.5) or math.asin(radiusSquared ^ 0.5 / observerDistance))
		local projectedRadius = cameraOffsetZ * math.cos(elevationAngle) + targetOffsetY * math.sin(elevationAngle)
		local finalRadiusSquared = targetSize * targetSize + projectedRadius * projectedRadius
		local finalAzimuthAngle = projectedRadius < 0 and math.atan(-targetSize / projectedRadius) or math.atan(targetSize / projectedRadius)
		return elevationAngle, finalAzimuthAngle - (observerSize * observerSize < finalRadiusSquared and math.asin(observerSize / finalRadiusSquared ^ 0.5) or math.asin(finalRadiusSquared ^ 0.5 / observerSize))
	end
end
function module.generate2DPointClockwiseComparisonFunction(optionalCenter)
	local center = optionalCenter or Vector2.zero
	assert(typeof(center) == "Vector2", "optionalCenter must be a Vector2")
	return function(point1, point2)
		local point1Relative = point1 - center
		local point2Relative = point2 - center
		if point1Relative.X >= 0 and point2Relative.X < 0 then
			return true
		elseif point1Relative.X < 0 and point2Relative.X >= 0 then
			return false
		else
			if math.abs(point1Relative.X) <= 0.001 and math.abs(point2Relative.X) <= 0.001 then
				if point1Relative.Y >= 0 or point2Relative.Y >= 0 then
					return point1.Y > point2.Y
				else
					return point2.Y > point1.Y
				end
			else
				local crossProduct, isLarger
				crossProduct = point1Relative:Cross(point2Relative)
				if crossProduct < 0 then
					return true
				elseif crossProduct > 0 then
					return false
				else
					isLarger = point1Relative.Magnitude > point2Relative.Magnitude
					return isLarger
				end
			end
		end
	end
end
function module.yieldNPointsOnSphere(pointCount)
	local verticalStep = 2 / pointCount
	local currentIndex = 1
	return function()
		currentIndex = currentIndex + 1
		if currentIndex <= pointCount then
			local normalizedHeight = currentIndex * verticalStep - 1 + verticalStep / 2
			if normalizedHeight > 1 then
				normalizedHeight = 1
			end
			local horizontalRadius = math.sqrt(1 - normalizedHeight * normalizedHeight)
			local azimuthAngle = currentIndex % pointCount * 2.399963229728653
			return math.cos(azimuthAngle) * horizontalRadius, normalizedHeight, math.sin(azimuthAngle) * horizontalRadius, currentIndex
		end
	end
end
function module.catmullRomSplinePoint(point0, point1, point2, point3, t)
	local tSquared = t * t
	local tCubed = tSquared * t
	local basisP0 = (-tCubed + tSquared * 2 - t) * 0.5
	local basisP1 = (tCubed * 3 - tSquared * 5 + 2) * 0.5
	local basisP2 = (tCubed * -3 + tSquared * 4 + t) * 0.5
	local basisP3 = (tCubed - tSquared) * 0.5
	return Vector3.new(basisP0 * point0.X + basisP1 * point1.X + basisP2 * point2.X + basisP3 * point3.X, basisP0 * point0.Y + basisP1 * point1.Y + basisP2 * point2.Y + basisP3 * point3.Y, basisP0 * point0.Z + basisP1 * point1.Z + basisP2 * point2.Z + basisP3 * point3.Z)
end
function module.getNCatmullRomSplinePoints(point0, point1, point2, point3, pointCount)
	local count = pointCount or 100
	assert(count)
	local splinePoints = {}
	for i = 1, count do
		table.insert(splinePoints, (module.catmullRomSplinePoint(point0, point1, point2, point3, (i - 1) / (count - 1))))
	end
	return splinePoints
end
function module.yieldNCatmullRomSplinePoints(point0, point1, point2, point3, pointCount)
	local count = pointCount or 100
	assert(count)
	local currentIndex = 1
	return function()
		if currentIndex <= count then
			local splinePoint = module.catmullRomSplinePoint(point0, point1, point2, point3, (currentIndex - 1) / (count - 1))
			currentIndex = currentIndex + 1
			return splinePoint, currentIndex
		end
	end
end
function module.stepAlongPath(pathPoints, currentWaypoint, currentT, remainingDistance)
	while remainingDistance > 0 do
		local nextWaypoint = currentWaypoint + 1 <= #pathPoints and currentWaypoint + 1 or 1
		local Magnitude = (pathPoints[currentWaypoint]:Lerp(pathPoints[(currentWaypoint + 1 - 1) % #pathPoints + 1], currentT) - pathPoints[nextWaypoint]).Magnitude
		if remainingDistance < Magnitude then
			remainingDistance = 0
			currentT = currentT + remainingDistance / Magnitude * (1 - currentT)
		else
			remainingDistance, currentWaypoint, currentT = remainingDistance - Magnitude, nextWaypoint, 0
		end
	end
	return currentWaypoint, currentT
end
function module.getDepthForWidth(width, focalLength, camera)
	local ViewportSize = camera.ViewportSize
	return 0.5 * ViewportSize.X * width / (focalLength * (ViewportSize.X / ViewportSize.Y * math.tan(math.rad(camera.FieldOfView) / 2)))
end
function module.transformRange(value, oldMinimum, oldMaximum, newMinimum, newMaximum)
	return newMinimum + (value - oldMinimum) * (newMaximum - newMinimum) / (oldMaximum - oldMinimum)
end
return module
