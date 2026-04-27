local createVector3 = Vector3.new
local createCFrame = CFrame.new
local Angles = CFrame.Angles
local zeroVector3 = Vector3.new(0, 0, 0)
local identityCFrame = createCFrame()
local Cross = zeroVector3.Cross
local Dot = zeroVector3.Dot
local cos = math.cos
local sin = math.sin
local tan = math.tan
local acos = math.acos
local asin = math.asin
local atan2 = math.atan2
local atan = math.atan
local components = identityCFrame.components
local inverse = identityCFrame.inverse
local fromAxisAngle = CFrame.fromAxisAngle
local abs = math.abs
local floor = math.floor
local random = math.random
local pointToObjectSpace = identityCFrame.pointToObjectSpace
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local MathModule = {
	ContinuousSpring1 = function(target, position, velocity, stiffness, damping, deltaTime)
		return position + velocity * deltaTime * stiffness, velocity + (target - position - velocity) * deltaTime * damping
	end
}
MathModule.ContinuousSpring3 = MathModule.ContinuousSpring1
function MathModule.ContinuousSpring3F(targetX, targetY, targetZ, posX, posY, posZ, velX, velY, velZ, stiffness, damping, deltaTime)
	return posX + velX * deltaTime * stiffness, posY + velY * deltaTime * stiffness, posZ + velZ * deltaTime * stiffness, velX + (targetX - posX - velX) * deltaTime * damping, velY + (targetY - posY - velY) * deltaTime * damping, velZ + (targetZ - posZ - velZ) * deltaTime * damping
end
function MathModule.MakeSpring(target, stiffness, damping)
	local initialVelocity = if typeof(target) == "Vector3" then Vector3.new(0, 0, 0) else 0
	return {
		target = target,
		position = target or initialVelocity,
		velocity = initialVelocity,
		stiffness = stiffness or 10,
		damping = damping or 0.5,
		time0 = 0
	}
end
function MathModule.Spring(spring, currentTime)
	local currentClock = tick()
	local target = spring.target
	local position = spring.position
	local velocity = spring.velocity
	local stiffness = spring.stiffness
	local damping = spring.damping
	local elapsedTime = currentClock - spring.time0
	if stiffness == 0 then
		return position, velocity
	end
	if damping < 1 then
		local dampingFactor = (1 - damping * damping) ^ 0.5
		local positionDelta = position - target
		local intermediateValue = (damping * positionDelta + velocity / stiffness) / dampingFactor
		local exponentialDecay = math.exp(1) ^ (-damping * stiffness * elapsedTime)
		local cosComponent = cos(dampingFactor * stiffness * elapsedTime)
		local sinComponent = sin(dampingFactor * stiffness * elapsedTime)
		return target + (positionDelta * cosComponent + intermediateValue * sinComponent) * exponentialDecay, ((positionDelta * damping - damping * intermediateValue - velocity) * cosComponent + (positionDelta * dampingFactor + intermediateValue * damping) * sinComponent) * -exponentialDecay
	end
	if not (damping > 1) then
		local positionDelta = position - target
		local intermediateValue = positionDelta + velocity / stiffness
		local exponentialDecay = math.exp(1) ^ (-stiffness * elapsedTime)
		return target + (positionDelta + intermediateValue * stiffness * elapsedTime) * exponentialDecay, stiffness * (intermediateValue - positionDelta - intermediateValue * stiffness * elapsedTime) * exponentialDecay
	end
	assert(false, "not implemented")
end
function MathModule.SpringSetTarget(spring, targetValue)
	local currentClock = tick()
	local newPosition, newVelocity = MathModule.Spring(spring, currentClock)
	spring.position = newPosition
	spring.velocity = newVelocity
	spring.time0 = currentClock
	spring.target = targetValue
end
function MathModule.SpringAccelerate(spring, acceleration)
	local currentClock = tick()
	local newPosition, newVelocity = MathModule.Spring(spring, currentClock)
	spring.position = newPosition
	spring.velocity = newVelocity + acceleration
	spring.time0 = currentClock
end
local function MakeWorldSpring()
	return {
		Part = nil,
		Target = nil,
		k = 200,
		B = 15,
		forceVector = nil
	}
end
local function WorldSpringUpdate(spring, deltaTime)
	local Part = spring.Part
	local Target = spring.Target
	spring.forceVector = if Target then spring.k * Target - spring.B * Part.CFrame:vectorToObjectSpace(Part.Velocity) else Vector3.new(0, 0, 0)
end
local function WorldSpringSetTarget(spring, targetPosition)
	spring.Target = targetPosition - spring.Part.Position
end
MathModule.MakeWorldSpring = MakeWorldSpring
MathModule.WorldSpringUpdate = WorldSpringUpdate
MathModule.WorldSpringSetTarget = WorldSpringSetTarget
function MathModule.CrossMagSq(vec1, vec2)
	local dotProduct = Dot(vec1, vec2)
	return Dot(vec1, vec1) * Dot(vec2, vec2) - dotProduct * dotProduct
end
function MathModule.CrossMagSqF(x1, y1, z1, x2, y2, z2)
	local dotProduct = x1 * x2 + y1 * y2 + z1 * z2
	return (x1 * x1 + y1 * y1 + z1 * z1) * (x2 * x2 + y2 * y2 + z2 * z2) - dotProduct * dotProduct
end
function MathModule.CFrameFromAxisAngle(axisAngle)
	local magnitude = Dot(axisAngle, axisAngle) ^ 0.5
	if magnitude > 1e-6 then
		local sinHalfMag = sin(magnitude * 0.5) / magnitude
		return createCFrame(0, 0, 0, sinHalfMag * axisAngle.x, sinHalfMag * axisAngle.y, sinHalfMag * axisAngle.z, (cos(magnitude * 0.5)))
	else
		return identityCFrame
	end
end
function MathModule.CFrameFromAxisAngleF(axisX, axisY, axisZ)
	local magnitude = (axisX * axisX + axisY * axisY + axisZ * axisZ) ^ 0.5
	if magnitude > 1e-6 then
		local sinHalfMag = sin(magnitude * 0.5) / magnitude
		return createCFrame(0, 0, 0, sinHalfMag * axisX, sinHalfMag * axisY, sinHalfMag * axisZ, (cos(magnitude * 0.5)))
	else
		return identityCFrame
	end
end
function MathModule.CFrameToAxisAngleF(m00, m01, m02, m10, m11, m12, m20, m21, m22)
	local traceDiv2 = (m00 + m11 + m22 - 1) * 0.5
	if traceDiv2 < -0.99999 then
		local axisX = m00 + m01 + m02 + 1
		local axisY = m10 + m11 + m12 + 1
		local axisZ = m20 + m21 + m22 + 1
		local normalizationFactor = math.pi * (axisX * axisX + axisY * axisY + axisZ * axisZ) ^ (-0.5)
		return normalizationFactor * axisX, normalizationFactor * axisY, normalizationFactor * axisZ
	elseif traceDiv2 < 0.99999 then
		local crossX = m21 - m12
		local crossY = m02 - m20
		local crossZ = m10 - m01
		local angleScaleFactor = acos(traceDiv2) * (crossX * crossX + crossY * crossY + crossZ * crossZ) ^ (-0.5)
		return angleScaleFactor * crossX, angleScaleFactor * crossY, angleScaleFactor * crossZ
	else
		return 0, 0, 0
	end
end
function MathModule.CFrameToAxisAngle(cframe)
	local _, _2, _3, m00, m10, m20, m01, m11, m21, m02, m12, m22 = components(cframe)
	return createVector3(MathModule.CFrameToAxisAngleF(m00, m10, m20, m01, m11, m21, m02, m12, m22))
end
function MathModule.UnitVectorToAnglesYXF(x, y, z)
	return asin(y), atan2(-x, -z)
end
function MathModule.UnitVectorToAnglesYX(vector)
	return MathModule.UnitVectorToAnglesYXF(vector.x, vector.y, vector.z)
end
function MathModule.VectorToAnglesYXF(x, y, z)
	return asin(y / (x * x + y * y + z * z) ^ 0.5), atan2(-x, -z)
end
function MathModule.VectorToAnglesYX(vector)
	return MathModule.VectorToAnglesYXF(vector.x, vector.y, vector.z)
end
function MathModule.VectorFromAnglesYX(yaw, pitch)
	local cosPitch = cos(yaw)
	return createVector3(-cosPitch * sin(pitch), sin(yaw), -cosPitch * cos(pitch))
end
function MathModule.Quaternion(vec1, vec2)
	local dotProduct = Dot(vec1, vec2)
	local crossProduct = Cross(vec1, vec2)
	local normalizationFactor = (2 * (1 + dotProduct)) ^ 0.5
	return createCFrame(0, 0, 0, crossProduct.x / normalizationFactor, crossProduct.y / normalizationFactor, crossProduct.z / normalizationFactor, (1 + dotProduct) / normalizationFactor)
end
function MathModule.QuaternionF(x1, y1, z1, x2, y2, z2)
	local dotProductPlus1 = 1 + x1 * x2 + y1 * y2 + z1 * z2
	local normalizationFactor = (2 * dotProductPlus1) ^ 0.5
	return createCFrame(0, 0, 0, (y1 * z2 - z1 * y2) / normalizationFactor, (z1 * x2 - x1 * z2) / normalizationFactor, (x1 * y2 - y1 * x2) / normalizationFactor, dotProductPlus1 / normalizationFactor)
end
function MathModule.AxisAngleInterpolate(startCFrame, endCFrame, alpha)
	local _, _2, _3, m00, m10, m20, m01, m11, m21, m02, m12, m22 = components(inverse(startCFrame) * endCFrame)
	local traceDiv2 = (m00 + m11 + m22 - 1) * 0.5
	return startCFrame * fromAxisAngle(createVector3(m12 - m21, m02 - m20, m10 - m01), acos(if traceDiv2 > 1 then 1 elseif traceDiv2 < -1 then -1 else traceDiv2) * alpha) + (endCFrame.p - startCFrame.p) * alpha
end
function MathModule.IsPointInPolygonXZ(point, polygonPoints)
	local X = point.X
	local Z = point.Z
	local pointCount = #polygonPoints
	local index = 0
	local isInside = false
	local prevIndex = pointCount - 1
	while not (pointCount <= index) do
		local currentPoint = polygonPoints[index + 1]
		local previousPoint = polygonPoints[prevIndex + 1]
		local currentX = currentPoint.X
		local currentZ = currentPoint.Z
		local previousZ = previousPoint.Z
		local isZBetween = Z < currentZ
		local isZPrevBetween = Z < previousZ
		if isZBetween ~= isZPrevBetween and X < (previousPoint.X - currentX) * (Z - currentZ) / (previousZ - currentZ) + currentX then
			isInside = not isInside
		end
		index, prevIndex = index + 1, index
	end
	return isInside
end
function MathModule.IsPointInRectangleYZ(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.y >= 0 and (localPoint.y < dimensions.y and localPoint.z >= 0) then localPoint.z < dimensions.z else false
end
function MathModule.IsPointInRectangleXY(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.x >= 0 and (localPoint.x < dimensions.x and localPoint.y >= 0) then localPoint.y < dimensions.y else false
end
function MathModule.IsPointInRectangleXZ(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.x >= 0 and (localPoint.x < dimensions.x and localPoint.z >= 0) then localPoint.z < dimensions.z else false
end
function MathModule.IsPointInPrism(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.x >= 0 and (localPoint.x < dimensions.x and (localPoint.y >= 0 and (localPoint.y < dimensions.y and localPoint.z >= 0))) then localPoint.z < dimensions.z else false
end
function MathModule.IsPointInFixedCone(coneOrigin, coneAngle, coneLength, sphereCenter)
	local delta = sphereCenter - coneOrigin.p
	return if -coneLength <= delta.z then acos((Dot(coneOrigin.lookVector, delta.unit))) <= coneAngle else false
end
function MathModule.DoesFixedConeIntersectSphere(coneOrigin, coneDirection, coneAngle, coneLength, sphereCenter, sphereRadius)
	local delta = sphereCenter - coneOrigin
	if coneAngle <= coneDirection:Dot(delta) then
		return false
	else
		local projectionLength = delta:Dot(coneDirection)
		local radiusAtProjection = projectionLength * tan(coneLength)
		return ((delta:Dot(delta) - projectionLength * projectionLength) ^ 0.5 - radiusAtProjection) * cos(coneLength) <= sphereRadius
	end
end
function MathModule.TopPoint(cframe, offset)
	return cframe * createVector3(0, offset.y * 0.5, 0)
end
function MathModule.BottomPoint(cframe, offset)
	return MathModule.TopPoint(cframe, -offset)
end
function MathModule.Normal(cframe)
	return cframe.upVector
end
function MathModule.IntersectRayPlane(rayOrigin, rayDirection, planeOrigin, planeNormal)
	local delta = Dot(planeNormal, rayDirection)
	if not (abs(delta) < 1e-6) then
		local intersectionDistance = Dot(planeNormal, planeOrigin - rayOrigin) / delta
		if not (intersectionDistance < 0) then
			return rayOrigin + rayDirection * intersectionDistance
		end
	end
end
function MathModule.IntersectRectanglesByCornersF(rect1MinX, rect1MinY, rect1MaxX, rect1MaxY, rect2MinX, rect2MinY, rect2MaxX, rect2MaxY)
	return not if rect2MaxX <= rect1MinX or (rect1MaxX <= rect2MinX or rect2MaxY <= rect1MinY) then true else rect1MaxY <= rect2MinY
end
function MathModule.IntersectRectanglesF(rect1X, rect1Y, rect1Width, rect1Height, rect2X, rect2Y, rect2Width, rect2Height)
	local halfWidth1 = 0.5 * rect1Width
	local halfHeight1 = 0.5 * rect1Height
	local halfWidth2 = 0.5 * rect2Width
	local halfHeight2 = 0.5 * rect2Height
	return MathModule.IntersectRectanglesByCornersF(rect1X - halfWidth1, rect1Y - halfHeight1, rect1X + halfWidth1, rect1Y + halfHeight1, rect2X - halfWidth2, rect2Y - halfHeight2, rect2X + halfWidth2, rect2Y + halfHeight2)
end
function MathModule.IntersectRectanglesXZ(rect1, rect2, rect3, rect4)
	return MathModule.IntersectRectanglesF(rect1.x, rect1.z, rect2.x, rect2.z, rect3.x, rect3.z, rect4.x, rect4.z)
end
function MathModule.Round(value, roundStep)
	return floor(value / roundStep + 0.5) * roundStep
end
function MathModule.RoundVec(vector, roundStep)
	return createVector3(floor(vector.x / roundStep + 0.5) * roundStep, floor(vector.y / roundStep + 0.5) * roundStep, floor(vector.z / roundStep + 0.5) * roundStep)
end
MathModule.Clamp = math.clamp
function MathModule.AABBXZF(scaleX, rotX, scaleZ, rotZ, scaleX2, rotX2, scaleZ2, rotZ2, scale, width, height, depth)
	local halfWidth = 0.5 * width
	local halfDepth = 0.5 * depth
	local minX = -scaleX * halfWidth - scaleZ * halfDepth
	local minZ = -scaleX2 * halfWidth - scaleZ2 * halfDepth
	local maxXCandidate1 = -scaleX * halfWidth + scaleZ * halfDepth
	local maxZCandidate1 = -scaleX2 * halfWidth + scaleZ2 * halfDepth
	local maxX = if maxXCandidate1 < minX then maxXCandidate1 else if minX <= maxXCandidate1 then maxXCandidate1 else minX
	local maxZ = if maxZCandidate1 < minZ then maxZCandidate1 else if minZ <= maxZCandidate1 then maxZCandidate1 else minZ
	local cornerX2 = scaleX * halfWidth - scaleZ * halfDepth
	local cornerZ2 = scaleX2 * halfWidth - scaleZ2 * halfDepth
	if cornerX2 < minX then
		minX = cornerX2
	elseif maxX <= cornerX2 then
		maxX = cornerX2
	end
	if cornerZ2 < minZ then
		minZ = cornerZ2
	elseif maxZ <= cornerZ2 then
		maxZ = cornerZ2
	end
	local cornerX3 = scaleX * halfWidth + scaleZ * halfDepth
	local cornerZ3 = scaleX2 * halfWidth + scaleZ2 * halfDepth
	if cornerX3 < minX then
		minX = cornerX3
	elseif maxX <= cornerX3 then
		maxX = cornerX3
	end
	if cornerZ3 < minZ then
		minZ = cornerZ3
	elseif maxZ <= cornerZ3 then
		maxZ = cornerZ3
	end
	return maxX - minX, maxZ - minZ
end
function MathModule.AABBXZ(cframeMatrix, dimensions)
	local _, _2, _3, scaleX, rotX, scaleZ, rotZ, scaleX2, rotX2, scaleZ2, rotZ2, scale = components(cframeMatrix)
	return MathModule.AABBXZF(scaleX, rotX, scaleZ, rotZ, scaleX2, rotX2, scaleZ2, rotZ2, scale, dimensions.x, dimensions.y, dimensions.z)
end
function MathModule.IsPrismVisibleD(coneHalfAngle, coneOrigin, prism)
	local lookVector = coneOrigin.lookVector
	local x = coneOrigin.x
	local y = coneOrigin.y
	local z = coneOrigin.z
	local dirX = lookVector.x
	local dirY = lookVector.y
	local dirZ = lookVector.z
	local scaleX, rotX, scaleZ, rotZ, scaleX2, rotX2, scaleZ2, rotZ2, scale, posX, posY, posZ = components(prism.CFrame)
	local halfSize = prism.Size * 0.5
	local halfX = halfSize.x
	local halfY = halfSize.y
	local halfZ = halfSize.z
	local offsetX1 = halfX * rotZ
	local offsetY1 = halfY * rotX2
	local offsetZ1 = halfZ * scaleZ
	local offsetX2 = halfX * scaleX2
	local offsetY2 = halfY * rotZ2
	local offsetZ2 = halfZ * rotX
	local offsetX3 = halfX * posX
	local offsetY3 = halfY * posY
	local offsetZ3 = halfZ * posZ
	local corner1X = scaleX + offsetX1 + offsetY1 + offsetZ1
	local corner1Y = rotX + offsetX2 + offsetY2 + offsetZ2
	local corner1Z = scaleZ + offsetX3 + offsetY3 + offsetZ3
	local corner2X = scaleX - offsetX1 - offsetY1 - offsetZ1
	local corner2Y = rotX - offsetX2 - offsetY2 - offsetZ2
	local corner2Z = scaleZ - offsetX3 - offsetY3 - offsetZ3
	local deltaX1 = corner1X - x
	local deltaY1 = corner1Y - y
	local deltaZ1 = corner1Z - z
	local distInverse1 = (deltaX1 * deltaX1 + deltaY1 * deltaY1 + deltaZ1 * deltaZ1) ^ (-0.5)
	if acos(dirX * (deltaX1 * distInverse1) + dirY * (deltaY1 * distInverse1) + dirZ * (deltaZ1 * distInverse1)) < coneHalfAngle then
		return true
	else
		local deltaX2 = corner2X - x
		local deltaY2 = corner2Y - y
		local deltaZ2 = corner2Z - z
		local distInverse2 = (deltaX2 * deltaX2 + deltaY2 * deltaY2 + deltaZ2 * deltaZ2) ^ (-0.5)
		if acos(dirX * (deltaX2 * distInverse2) + dirY * (deltaY2 * distInverse2) + dirZ * (deltaZ2 * distInverse2)) < coneHalfAngle then
			return true
		else
			local deltaX3 = corner2X - x
			local deltaY3 = corner1Y - y
			local deltaZ3 = corner1Z - z
			local distInverse3 = (deltaX3 * deltaX3 + deltaY3 * deltaY3 + deltaZ3 * deltaZ3) ^ (-0.5)
			if acos(dirX * (deltaX3 * distInverse3) + dirY * (deltaY3 * distInverse3) + dirZ * (deltaZ3 * distInverse3)) < coneHalfAngle then
				return true
			else
				local deltaX4 = corner1X - x
				local deltaY4 = corner2Y - y
				local deltaZ4 = corner2Z - z
				local distInverse4 = (deltaX4 * deltaX4 + deltaY4 * deltaY4 + deltaZ4 * deltaZ4) ^ (-0.5)
				return acos(dirX * (deltaX4 * distInverse4) + dirY * (deltaY4 * distInverse4) + dirZ * (deltaZ4 * distInverse4)) < coneHalfAngle
			end
		end
	end
end
function MathModule.IsPrismVisible(testFunction, coneOrigin, cframePosition, dimensions)
	local halfDimensionX = 0.5 * dimensions.x
	local halfDimensionY = 0.5 * dimensions.y
	local halfDimensionZ = 0.5 * dimensions.z
	local _, isVisible = testFunction(coneOrigin, cframePosition * createVector3(halfDimensionX, halfDimensionY, halfDimensionZ))
	if isVisible then
		return true
	end
	local _, corner2Visible = testFunction(coneOrigin, cframePosition * createVector3(-halfDimensionX, -halfDimensionY, -halfDimensionZ))
	if corner2Visible then
		return true
	end
	local _, corner3Visible = testFunction(coneOrigin, cframePosition * createVector3(halfDimensionX, halfDimensionY, -halfDimensionZ))
	if corner3Visible then
		return true
	end
	local _, corner4Visible = testFunction(coneOrigin, cframePosition * createVector3(-halfDimensionX, halfDimensionY, halfDimensionZ))
	if corner4Visible then
		return true
	end
	local _, corner5Visible = testFunction(coneOrigin, cframePosition * createVector3(-halfDimensionX, halfDimensionY, -halfDimensionZ))
	if corner5Visible then
		return true
	end
	local _, corner6Visible = testFunction(coneOrigin, cframePosition * createVector3(halfDimensionX, -halfDimensionY, halfDimensionZ))
	if corner6Visible then
		return true
	end
	local _, corner7Visible = testFunction(coneOrigin, cframePosition * createVector3(halfDimensionX, -halfDimensionY, -halfDimensionZ))
	if corner7Visible then
		return true
	end
	local _, corner8Visible = testFunction(coneOrigin, cframePosition * createVector3(-halfDimensionX, -halfDimensionY, halfDimensionZ))
	if corner8Visible then
		return true
	end
end
function MathModule.IsPrismApproxVisible(testFunction, coneOrigin, cframePosition, dimensions)
	local halfDimensionX = 0.5 * dimensions.x * 2
	local halfDimensionY = 0.5 * dimensions.y * 2
	local halfDimensionZ = 0.5 * dimensions.z * 2
	local _, isVisible = testFunction(coneOrigin, cframePosition * createVector3(halfDimensionX, halfDimensionY, halfDimensionZ))
	if isVisible then
		return true
	else
		local _, oppositeVisible = testFunction(coneOrigin, cframePosition * createVector3(-halfDimensionX, -halfDimensionY, -halfDimensionZ))
		return oppositeVisible and true or false
	end
end
local function IntersectRaySphereF(rayOriginX, rayOriginY, rayOriginZ, rayDirX, rayDirY, rayDirZ, maxDistance, sphereX, sphereY, sphereZ, sphereRadius)
	local deltaX = sphereX - rayOriginX
	local deltaY = sphereY - rayOriginY
	local deltaZ = sphereZ - rayOriginZ
	local dotProduct = deltaX * rayDirX + deltaY * rayDirY + deltaZ * rayDirZ
	if dotProduct < 0 then
		return false
	else
		local discriminant = deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ - dotProduct * dotProduct
		local radiusSq = sphereRadius * sphereRadius
		if radiusSq < discriminant then
			return false
		else
			return not (maxDistance < dotProduct - (radiusSq - discriminant) ^ 0.5)
		end
	end
end
local function IntersectRaySphere(rayOrigin, rayDirection, maxDistance, sphereCenter, sphereRadius)
	local deltaX = sphereCenter.x - rayOrigin.x
	local deltaY = sphereCenter.y - rayOrigin.y
	local deltaZ = sphereCenter.z - rayOrigin.z
	local dotProduct = deltaX * rayDirection.x + deltaY * rayDirection.y + deltaZ * rayDirection.z
	if dotProduct < 0 then
		return false
	else
		local discriminant = deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ - dotProduct * dotProduct
		local radiusSq = sphereRadius * sphereRadius
		if radiusSq < discriminant then
			return false
		else
			return not (maxDistance < dotProduct - (radiusSq - discriminant) ^ 0.5)
		end
	end
end
MathModule.IntersectRaySphereF = IntersectRaySphereF
MathModule.IntersectRaySphere = IntersectRaySphere
function MathModule.GUID()
	return ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(hexChar)
		return ("%x"):format(hexChar == "x" and random(0, 15) or random(8, 11))
	end)
end
function MathModule.ShortGUID()
	return ("xxx-yx"):gsub("[xy]", function(hexChar)
		return ("%x"):format(hexChar == "x" and random(0, 15) or random(8, 11))
	end)
end
MathModule.Base85UUID = String.base85UUID
function MathModule.Uniform2D(radius)
	local randomRadius = random()
	local randomAngle = random()
	local swappedValue
	if randomAngle < randomRadius then
		randomAngle, swappedValue = randomRadius, randomAngle
	else
		swappedValue = randomRadius
	end
	return createVector3(randomAngle * radius * cos(math.tau * swappedValue / randomAngle), randomAngle * radius * sin(math.tau * swappedValue / randomAngle), 0)
end
local randomGenerator = Random.new()
function MathModule.WeightedRandom(weights)
	for i = 1, 10 do
		randomGenerator:NextNumber()
	end
	local sum = 0
	for j = 1, #weights do
		sum = sum + weights[j]
	end
	local randomValue = randomGenerator:NextNumber() * sum
	for k = 1, #weights do
		if randomValue < weights[k] then
			return k
		end
		randomValue = randomValue - weights[k]
	end
	return false
end
function MathModule.LookAt(upDirection, targetPosition, cameraPosition)
	local unit = (targetPosition - cameraPosition).unit
	local unit_2 = Cross(upDirection, unit).unit
	local delta = Cross(unit, unit_2)
	return createCFrame(targetPosition.X, targetPosition.Y, targetPosition.Z, unit_2.x, delta.x, unit.x, unit_2.y, delta.y, unit.y, unit_2.z, delta.z, unit.z)
end
function MathModule.BinaryFind(sortedArray, searchValue, sortKey)
	local lowIndex = 1
	local highIndex = #sortedArray
	local searchKey = sortKey or "Sort"
	while lowIndex <= highIndex do
		local midIndex = floor((lowIndex + highIndex) * 0.5)
		local midValue = sortedArray[midIndex][searchKey]
		if midValue < searchValue then
			lowIndex = midIndex + 1
		else
			if not (searchValue < midValue) then
				return midIndex
			end
			highIndex = midIndex - 1
		end
	end
	return lowIndex
end
function MathModule.Shuffle(array)
	for i = #array, 2, -1 do
		local randomIndex = math.random(i)
		local tempValue = array[i]
		array[i] = array[randomIndex]
		array[randomIndex] = tempValue
	end
end
function MathModule.IsNaN(value)
	return value ~= value
end
function MathModule.IsNaNv3(vector)
	return if vector.x == vector.x and vector.y == vector.y then vector.z ~= vector.z else true
end
function MathModule.IsNaNcf(cframe)
	local lookVector = cframe.lookVector
	local delta = if lookVector.x == lookVector.x and lookVector.y == lookVector.y then lookVector.z ~= lookVector.z else true
	if not delta then
		local rightVector = cframe.rightVector
		delta = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
		if not delta then
			local upVector = cframe.upVector
			delta = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
		end
	end
	return delta
end
function MathModule.Clampv3(vector, minValue, maxValue)
	return createVector3(math.clamp(vector.x, minValue, maxValue), math.clamp(vector.y, minValue, maxValue), (math.clamp(vector.z, minValue, maxValue)))
end
local function comma(numString)
	local integerPart, decimalDigits, suffix = string.match(numString, "^([^%d]*%d)(%d*)(.-)$")
	return integerPart .. decimalDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
end
local function FormatMoney(amount)
	local integerPart, decimalDigits, suffix = string.match(abs(amount), "^([^%d]*%d)(%d*)(.-)$")
	return ("%s$%s"):format(if amount >= 0 then "" else "-", integerPart .. decimalDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix)
end
MathModule.comma = comma
MathModule.FormatMoney = FormatMoney
function MathModule.stohms(seconds)
	local hours = math.floor(seconds / 3600)
	local remainingSeconds = seconds - hours * 3600
	local minutes = math.floor(remainingSeconds / 60)
	return hours, minutes, remainingSeconds - minutes * 60
end
function MathModule.Now(timezoneOffset)
	return os.time() + ((timezoneOffset or -8) + 1) * 60 * 60
end
function MathModule.NextMidnight(timezoneOffset)
	return math.ceil(MathModule.Now(timezoneOffset) / 86400) * 86400
end
function MathModule.TimeUntilMidnight(timezoneOffset)
	local currentTime = MathModule.Now(timezoneOffset)
	return MathModule.NextMidnight(timezoneOffset) - currentTime
end
local max = math.max
local function TimeAccumDiff(accumulatedTime, useWallTime)
	return max(0, accumulatedTime - (useWallTime and os.time() or tick()))
end
local function TimeAccumAdd(accumulatedTime, additionalTime, useWallTime)
	local currentTime = useWallTime and os.time() or tick()
	return currentTime + TimeAccumDiff(accumulatedTime) + additionalTime
end
MathModule.TimeAccumDiff = TimeAccumDiff
MathModule.TimeAccumAdd = TimeAccumAdd
local function Ease_inOutQuad(elapsed, startValue, changeValue, duration)
	local normalizedTime = elapsed / duration * 2
	if normalizedTime < 1 then
		return changeValue * 0.5 * normalizedTime * normalizedTime + startValue
	else
		return -changeValue * 0.5 * ((normalizedTime - 1) * (normalizedTime - 3) - 1) + startValue
	end
end
MathModule.TweenType = {
	Linear = 1,
	InOutQuad = 2
}
function MathModule.MakeTween()
	return {
		progress = 0,
		startValue = 0,
		endValue = 1,
		speed = 1,
		currentValue = 0,
		Type = MathModule.TweenType.Linear,
		Finished = nil
	}
end
function MathModule.UpdateTween(tween, deltaTime)
	tween.progress = tween.progress + deltaTime * tween.speed
	if tween.Type == MathModule.TweenType.Linear then
		tween.currentValue = tween.startValue * (1 - tween.progress) + tween.endValue * tween.progress
	elseif tween.Type == MathModule.TweenType.InOutQuad then
		local startValue = tween.startValue
		local changeValue = tween.endValue - tween.startValue
		local normalizedProgress = tween.progress / 1 * 2
		tween.currentValue = if normalizedProgress < 1 then changeValue * 0.5 * normalizedProgress * normalizedProgress + startValue else -changeValue * 0.5 * ((normalizedProgress - 1) * (normalizedProgress - 3) - 1) + startValue
	end
	if tween.progress >= 1 and tween.Finished then
		tween.Finished(tween)
	end
end
function MathModule.TweenFunSwap(tween)
	local endValue = tween.endValue
	tween.endValue = tween.startValue
	tween.startValue = endValue
	tween.progress = tween.progress - 1
end
return MathModule
