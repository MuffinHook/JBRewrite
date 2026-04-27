local t = {}
local exp = math.exp
local cos = math.cos
local sin = math.sin
local function SpringUpdate(springConfig)
	local elapsed = tick() - springConfig.lastUpdateTime
	local Freq = springConfig.Freq
	local Damp = springConfig.Damp
	local velocity = springConfig.velocity
	local Target = springConfig.Target
	local displacement = springConfig.position - Target
	if Damp > 1 then
		local decayBase = -Freq * Damp
		local oscillationFreq = Freq * (Damp * Damp - 1) ^ 0.5
		local root1 = decayBase - oscillationFreq
		local root2 = decayBase + oscillationFreq
		local expRoot1 = exp(root1 * elapsed)
		local expRoot2 = exp(root2 * elapsed)
		local c1 = (velocity - displacement * root2) / (-2 * oscillationFreq)
		local c2 = displacement - c1
		return Target + c1 * expRoot1 + c2 * expRoot2, c1 * root1 * expRoot1 + c2 * root2 * expRoot2
	elseif Damp == 1 then
		local expDecay = exp(-Freq * elapsed)
		local coeff = velocity + Freq * displacement
		local solution = (coeff * elapsed + displacement) * expDecay
		return Target + solution, coeff * expDecay - solution * Freq
	else
		local decayRate = Freq * Damp
		local oscillationRate = Freq * (1 - Damp * Damp) ^ 0.5
		local expDecay = exp(-decayRate * elapsed)
		local cosOscillation = cos(oscillationRate * elapsed)
		local sinOscillation = sin(oscillationRate * elapsed)
		local phaseOffset = (velocity + decayRate * displacement) / oscillationRate
		return Target + expDecay * (displacement * cosOscillation + phaseOffset * sinOscillation), -expDecay * ((displacement * decayRate - phaseOffset * oscillationRate) * cosOscillation + (displacement * oscillationRate + phaseOffset * decayRate) * sinOscillation)
	end
end
local function SpringSetTarget(springConfig, newTarget)
	local newPosition, newVelocity = SpringUpdate(springConfig)
	springConfig.position = newPosition
	springConfig.velocity = newVelocity
	springConfig.Target = newTarget
	springConfig.lastUpdateTime = tick()
	return newPosition, newVelocity
end
local function SpringAccelerate(springConfig, acceleration)
	local newPosition, newVelocity = SpringUpdate(springConfig)
	springConfig.lastUpdateTime = tick()
	springConfig.position = newPosition
	springConfig.velocity = newVelocity + acceleration
end
function t.MakeSpring()
	return {
		position = nil,
		velocity = nil,
		Target = nil,
		Damp = nil,
		Freq = nil,
		lastUpdateTime = tick(),
		Update = SpringUpdate,
		SetTarget = SpringSetTarget,
		Accelerate = SpringAccelerate
	}
end
t.SpringUpdate = SpringUpdate
local cframeConstructor = CFrame.new
local identityCFrame = cframeConstructor()
local cosineAngle = math.cos
local sineAngle = math.sin
local pointToObjectSpace = identityCFrame.pointToObjectSpace
local function FromAxisAngle(axisAngleVec)
	local x = axisAngleVec.x
	local y = axisAngleVec.y
	local z = axisAngleVec.z
	local magnitude = (x * x + y * y + z * z) ^ 0.5
	if magnitude > 0.00001 then
		local sinHalf = sineAngle(magnitude * 0.5) / magnitude
		return cframeConstructor(0, 0, 0, sinHalf * x, sinHalf * y, sinHalf * z, (cosineAngle(magnitude * 0.5)))
	else
		return identityCFrame
	end
end
local function SolveIK(upperLength, lowerLength, basePosition, targetPosition, twistAngle)
	local relativeTarget = pointToObjectSpace(basePosition, targetPosition)
	local x = relativeTarget.x
	local y = relativeTarget.y
	local z = relativeTarget.z
	local distance = (x * x + y * y + z * z) ^ 0.5
	local normalX = x / distance
	local normalY = y / distance
	local normalZ = z / distance
	local reachLimit = upperLength + lowerLength < distance and upperLength + lowerLength or distance
	local cosElbow = (lowerLength * lowerLength - upperLength * upperLength - reachLimit * reachLimit) / (2 * upperLength * reachLimit)
	local sinElbow = (1 - cosElbow * cosElbow) ^ 0.5
	local denominator = (2 * (1 + sinElbow * normalY + cosElbow * normalZ)) ^ 0.5
	local qx = denominator * 0.5
	local qy = (sinElbow * normalZ - cosElbow * normalY) / denominator
	local qz = cosElbow * normalX / denominator
	local qw = -sinElbow * normalX / denominator
	if twistAngle then
		local cosHalf = cosineAngle(twistAngle / 2)
		local sinHalf = sineAngle(twistAngle / 2)
		qy = cosHalf * qy + sinHalf * (normalX * qx - normalZ * qz + normalY * qw)
		qw = cosHalf * qw + sinHalf * (normalZ * qx - normalY * qy + normalX * qz)
		qz = cosHalf * qz + sinHalf * (normalY * qx + normalZ * qy - normalX * qw)
		qx = cosHalf * qx - sinHalf * (normalX * qy + normalY * qz + normalZ * qw)
	end
	local halfAngleCos = (reachLimit * cosElbow + upperLength) / (reachLimit * reachLimit + 2 * reachLimit * cosElbow * upperLength + upperLength * upperLength) ^ 0.5
	local halfAngleSinMinus = ((1 - halfAngleCos) * 0.5) ^ 0.5
	local halfAngleSinPlus = ((1 + halfAngleCos) * 0.5) ^ 0.5
	return basePosition * cframeConstructor(-upperLength * 2 * (qy * qw + qz * qx), upperLength * 2 * (qy * qx - qz * qw), upperLength * (2 * (qy * qy + qz * qz) - 1), halfAngleSinMinus * qy + halfAngleSinPlus * qx, halfAngleSinMinus * qz + halfAngleSinPlus * qw, halfAngleSinMinus * qw - halfAngleSinPlus * qz, halfAngleSinMinus * qx - halfAngleSinPlus * qy), basePosition * cframeConstructor(0, 0, 0, qy, qz, qw, qx)
end
t.FromAxisAngle = FromAxisAngle
t.SolveIK = SolveIK
local Dot = Vector3.new().Dot
local min = math.min
local max = math.max
local components = CFrame.new().components
local abs = math.abs
local function SingleAABBRaw(cframe, size, rightAxis, upAxis, forwardAxis)
	local axisRightX, axisUpX, axisForwardX
	if rightAxis then
		axisRightX = rightAxis.x
		axisUpX = rightAxis.y
		axisForwardX = rightAxis.z
	else
		axisRightX = 1
		axisUpX = 0
		axisForwardX = 0
	end
	local axisRightY, axisUpY, axisForwardY
	if upAxis then
		axisRightY = upAxis.x
		axisUpY = upAxis.y
		axisForwardY = upAxis.z
	else
		axisUpY = 1
		axisForwardY = 0
		axisRightY = 0
	end
	local axisRightZ, axisUpZ, axisForwardZ
	if forwardAxis then
		axisRightZ = forwardAxis.x
		axisUpZ = forwardAxis.y
		axisForwardZ = forwardAxis.z
	else
		axisRightZ = 0
		axisUpZ = 0
		axisForwardZ = 1
	end
	local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = components(cframe)
	local halfExtentX = 0.5 * size.x
	local halfExtentY = 0.5 * size.y
	local halfExtentZ = 0.5 * size.z
	local corner000X = x - r00 * halfExtentX - r01 * halfExtentY - r02 * halfExtentZ
	local corner000Y = y - r10 * halfExtentX - r11 * halfExtentY - r12 * halfExtentZ
	local corner000Z = z - r20 * halfExtentX - r21 * halfExtentY - r22 * halfExtentZ
	local corner001X = x - r00 * halfExtentX - r01 * halfExtentY + r02 * halfExtentZ
	local corner001Y = y - r10 * halfExtentX - r11 * halfExtentY + r12 * halfExtentZ
	local corner001Z = z - r20 * halfExtentX - r21 * halfExtentY + r22 * halfExtentZ
	local corner010X = x - r00 * halfExtentX + r01 * halfExtentY - r02 * halfExtentZ
	local corner010Y = y - r10 * halfExtentX + r11 * halfExtentY - r12 * halfExtentZ
	local corner010Z = z - r20 * halfExtentX + r21 * halfExtentY - r22 * halfExtentZ
	local corner011X = x - r00 * halfExtentX + r01 * halfExtentY + r02 * halfExtentZ
	local corner011Y = y - r10 * halfExtentX + r11 * halfExtentY + r12 * halfExtentZ
	local corner011Z = z - r20 * halfExtentX + r21 * halfExtentY + r22 * halfExtentZ
	local corner100X = x + r00 * halfExtentX - r01 * halfExtentY - r02 * halfExtentZ
	local corner100Y = y + r10 * halfExtentX - r11 * halfExtentY - r12 * halfExtentZ
	local corner100Z = z + r20 * halfExtentX - r21 * halfExtentY - r22 * halfExtentZ
	local corner101X = x + r00 * halfExtentX - r01 * halfExtentY + r02 * halfExtentZ
	local corner101Y = y + r10 * halfExtentX - r11 * halfExtentY + r12 * halfExtentZ
	local corner101Z = z + r20 * halfExtentX - r21 * halfExtentY + r22 * halfExtentZ
	local corner110X = x + r00 * halfExtentX + r01 * halfExtentY - r02 * halfExtentZ
	local corner110Y = y + r10 * halfExtentX + r11 * halfExtentY - r12 * halfExtentZ
	local corner110Z = z + r20 * halfExtentX + r21 * halfExtentY - r22 * halfExtentZ
	local corner111X = x + r00 * halfExtentX + r01 * halfExtentY + r02 * halfExtentZ
	local corner111Y = y + r10 * halfExtentX + r11 * halfExtentY + r12 * halfExtentZ
	local corner111Z = z + r20 * halfExtentX + r21 * halfExtentY + r22 * halfExtentZ
	local proj000Right = axisRightX * corner000X + axisUpX * corner000Y + axisForwardX * corner000Z
	local proj001Right = axisRightX * corner001X + axisUpX * corner001Y + axisForwardX * corner001Z
	local proj010Right = axisRightX * corner010X + axisUpX * corner010Y + axisForwardX * corner010Z
	local proj011Right = axisRightX * corner011X + axisUpX * corner011Y + axisForwardX * corner011Z
	local proj100Right = axisRightX * corner100X + axisUpX * corner100Y + axisForwardX * corner100Z
	local proj101Right = axisRightX * corner101X + axisUpX * corner101Y + axisForwardX * corner101Z
	local proj110Right = axisRightX * corner110X + axisUpX * corner110Y + axisForwardX * corner110Z
	local proj111Right = axisRightX * corner111X + axisUpX * corner111Y + axisForwardX * corner111Z
	local proj000Up = axisRightY * corner000X + axisUpY * corner000Y + axisForwardY * corner000Z
	local proj001Up = axisRightY * corner001X + axisUpY * corner001Y + axisForwardY * corner001Z
	local proj010Up = axisRightY * corner010X + axisUpY * corner010Y + axisForwardY * corner010Z
	local proj011Up = axisRightY * corner011X + axisUpY * corner011Y + axisForwardY * corner011Z
	local proj100Up = axisRightY * corner100X + axisUpY * corner100Y + axisForwardY * corner100Z
	local proj101Up = axisRightY * corner101X + axisUpY * corner101Y + axisForwardY * corner101Z
	local proj110Up = axisRightY * corner110X + axisUpY * corner110Y + axisForwardY * corner110Z
	local proj111Up = axisRightY * corner111X + axisUpY * corner111Y + axisForwardY * corner111Z
	local proj000Forward = axisRightZ * corner000X + axisUpZ * corner000Y + axisForwardZ * corner000Z
	local proj001Forward = axisRightZ * corner001X + axisUpZ * corner001Y + axisForwardZ * corner001Z
	local proj010Forward = axisRightZ * corner010X + axisUpZ * corner010Y + axisForwardZ * corner010Z
	local proj011Forward = axisRightZ * corner011X + axisUpZ * corner011Y + axisForwardZ * corner011Z
	local proj100Forward = axisRightZ * corner100X + axisUpZ * corner100Y + axisForwardZ * corner100Z
	local proj101Forward = axisRightZ * corner101X + axisUpZ * corner101Y + axisForwardZ * corner101Z
	local proj110Forward = axisRightZ * corner110X + axisUpZ * corner110Y + axisForwardZ * corner110Z
	local proj111Forward = axisRightZ * corner111X + axisUpZ * corner111Y + axisForwardZ * corner111Z
	return min(proj000Right, proj001Right, proj010Right, proj011Right, proj100Right, proj101Right, proj110Right, proj111Right), max(proj000Right, proj001Right, proj010Right, proj011Right, proj100Right, proj101Right, proj110Right, proj111Right), min(proj000Up, proj001Up, proj010Up, proj011Up, proj100Up, proj101Up, proj110Up, proj111Up), max(proj000Up, proj001Up, proj010Up, proj011Up, proj100Up, proj101Up, proj110Up, proj111Up), min(proj000Forward, proj001Forward, proj010Forward, proj011Forward, proj100Forward, proj101Forward, proj110Forward, proj111Forward), max(proj000Forward, proj001Forward, proj010Forward, proj011Forward, proj100Forward, proj101Forward, proj110Forward, proj111Forward)
end
local function SingleAABB(cframe, size)
	local minRight, maxRight, minUp, maxUp, minForward, maxForward = SingleAABBRaw(cframe, size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
	return CFrame.new(0.5 * (minRight + maxRight), 0.5 * (minUp + maxUp), 0.5 * (minForward + maxForward), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(maxRight - minRight, maxUp - minUp, maxForward - minForward)
end
local function MultiAABBRaw(parts, rightAxis, upAxis, forwardAxis)
	local minRight = nil
	local maxRight = nil
	local minUp = nil
	local maxUp = nil
	local minForward = nil
	local maxForward = nil
	for partIdx, part in next, parts do
		local partMinRight, partMaxRight, partMinUp, partMaxUp, partMinForward, partMaxForward = SingleAABBRaw(part.CFrame, part.Size, rightAxis, upAxis, forwardAxis)
		if not minForward or partMinRight < minForward then
			minForward = partMinRight
		end
		if not maxForward or maxForward < partMaxRight then
			maxForward = partMaxRight
		end
		if not minRight or partMinUp < minRight then
			minRight = partMinUp
		end
		if not maxRight or maxRight < partMaxUp then
			maxRight = partMaxUp
		end
		if not minUp or partMinForward < minUp then
			minUp = partMinForward
		end
		if not maxUp or maxUp < partMaxForward then
			maxUp = partMaxForward
		end
	end
	return minForward, maxForward, minRight, maxRight, minUp, maxUp
end
local function MultiAABB(parts)
	local minRight, maxRight, minUp, maxUp, minForward, maxForward = MultiAABBRaw(parts, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
	return CFrame.new(0.5 * (minRight + maxRight), 0.5 * (minUp + maxUp), 0.5 * (minForward + maxForward), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(maxRight - minRight, maxUp - minUp, maxForward - minForward)
end
local function IntersectAABB(minX1, maxX1, minY1, maxY1, minZ1, maxZ1, minX2, maxX2, minY2, maxY2, minZ2, maxZ2)
	return if minX1 <= maxX2 and (minX2 <= maxX1 and (minY1 <= maxY2 and (minY2 <= maxY1 and minZ1 <= maxZ2))) then minZ2 <= maxZ1 else false
end
local function IntersectPrism(cframe1, size1, cframe2, size2)
	local minRight1, maxRight1, minUp1, maxUp1, minForward1, maxForward1 = SingleAABBRaw(cframe1, size1)
	local minRight2, maxRight2, minUp2, maxUp2, minForward2, maxForward2 = SingleAABBRaw(cframe2, size2)
	return if minRight1 <= maxRight2 and (minRight2 <= maxRight1 and (minUp1 <= maxUp2 and (minUp2 <= maxUp1 and minForward1 <= maxForward2))) then minForward2 <= maxForward1 else false
end
local function IntersectMultiPrism(parts)
	for i = 1, #parts do
		local part1 = parts[i]
		local minRight1, maxRight1, minUp1, maxUp1, minForward1, maxForward1 = SingleAABBRaw(part1.CFrame, part1.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
		for j = i + 1, #parts do
			local intersects
			local part2 = parts[j]
			local minRight2, maxRight2, minUp2, maxUp2, minForward2, maxForward2 = SingleAABBRaw(part2.CFrame, part2.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
			intersects = if maxRight1 <= minRight2 and (minRight2 <= minRight1 and (minUp1 <= maxUp2 and (minUp2 <= maxUp1 and minForward1 <= maxForward2))) then minForward2 <= maxForward1 else false
			if intersects then
				return true
			end
		end
	end
	return false
end
local function IntersectRectangleRaw(minX1, maxX1, minY1, maxY1, minX2, maxX2, minY2, maxY2)
	return if minX1 <= maxX2 and (minX2 <= maxX1 and minY1 <= maxY2) then minY2 <= maxY1 else false
end
local function ContainRectangleRaw(minX1, maxX1, minY1, maxY1, minX2, maxX2, minY2, maxY2)
	return if minX2 <= minX1 and (maxX1 <= maxX2 and minY2 <= minY1) then maxY1 <= maxY2 else false
end
local function IsPointInRectangleRaw(px, py, minX, maxX, minY, maxY)
	return if minX <= px and (px <= maxX and minY <= py) then py <= maxY else false
end
local function IntersectRayPlane(rayOrigin, rayDirection, planePoint, planeNormal)
	local denom = Dot(rayDirection, planeNormal)
	if abs(denom) <= 1e-6 then
		return false
	else
		local numerator = Dot(planePoint - rayOrigin, planeNormal)
		if numerator > 0 then
			return false
		else
			return true, rayOrigin + rayDirection * (numerator / denom)
		end
	end
end
local function IntersectSegSeg(seg1Start, seg1StartY, seg2Start, seg2StartY, seg1End, seg1EndY, seg2End, seg2EndY)
	local crossProduct = (seg2EndY - seg1EndY) * (seg2Start - seg1Start) - (seg2End - seg1End) * (seg1StartY - seg1EndY)
	local numeratorS = (seg2End - seg1End) * (seg1StartY - seg1EndY) - (seg2EndY - seg1EndY) * (seg1Start - seg1End)
	local numeratorT = (seg2Start - seg1Start) * (seg1StartY - seg1EndY) - (seg1StartY - seg2StartY) * (seg1Start - seg1End)
	if abs(numeratorS) < 0.001 and (abs(numeratorT) < 0.001 and abs(crossProduct) < 0.001) then
		return true
	elseif abs(crossProduct) < 0.001 then
		return false
	else
		local s = numeratorS / crossProduct
		local tParam = numeratorT / crossProduct
		return not (s <= 0 or (s > 1 or (tParam <= 0 or tParam > 1)))
	end
end
t.SingleAABB = SingleAABB
t.SingleAABBRaw = SingleAABBRaw
t.MultiAABB = MultiAABB
t.MultiAABBRaw = MultiAABBRaw
t.IntersectAABB = IntersectAABB
t.IntersectPrism = IntersectPrism
t.IntersectMultiPrism = IntersectMultiPrism
t.IntersectRectangleRaw = IntersectRectangleRaw
t.ContainRectangleRaw = ContainRectangleRaw
t.IsPointInRectangleRaw = IsPointInRectangleRaw
t.IntersectRayPlane = IntersectRayPlane
local cosineAngleOffset = math.cos
local tan = math.tan
function t.DoesFixedConeIntersectSphere(coneOrigin, coneDirection, coneAngleLimit, coneHalfAngle, sphereCenter, sphereRadius)
	local rayToSphere = sphereCenter - coneOrigin
	if coneAngleLimit <= coneDirection:Dot(rayToSphere) then
		return false
	else
		local projLength = rayToSphere:Dot(coneDirection)
		local perpDistance = projLength * tan(coneHalfAngle)
		return ((rayToSphere:Dot(rayToSphere) - projLength * projLength) ^ 0.5 - perpDistance) * cosineAngleOffset(coneHalfAngle) <= sphereRadius
	end
end
local asin = math.asin
local atan = math.atan
local cosineAngleLookAt = math.cos
local sineAngleLookAt = math.sin
function t.OffsetLookAtTarget(horizAngle, vertAngle, camHeight, targetX, targetY, targetZ)
	if targetX == 0 or (targetY == 0 or targetZ == 0) then
		return 0, 0
	else
		local horizontalDist = targetX * targetX + targetZ * targetZ
		local azimuthAngle = targetZ < 0 and atan(targetX / targetZ) or math.pi - atan(-targetX / targetZ)
		local elevationAngle = azimuthAngle + (horizAngle * horizAngle < horizontalDist and asin(horizAngle / horizontalDist ^ 0.5) or asin(horizontalDist ^ 0.5 / horizAngle))
		local newVertPos = targetZ * cosineAngleLookAt(elevationAngle) + targetX * sineAngleLookAt(elevationAngle)
		local totalHeight = targetY * targetY + newVertPos * newVertPos
		local pitchAngle = newVertPos < 0 and atan(-targetY / newVertPos) or atan(targetY / newVertPos)
		return elevationAngle, pitchAngle - (vertAngle * vertAngle < totalHeight and asin(vertAngle / totalHeight ^ 0.5) or asin(totalHeight ^ 0.5 / vertAngle))
	end
end
local function TraceBounceRay(rayOrigin, rayDirection, rayDistance, ignoreList)
	local bounceCount = 0
	while true do
		bounceCount = bounceCount + 1
		local hitPart, hitPosition, surfaceNormal = workspace:FindPartOnRayWithIgnoreList(Ray.new(rayOrigin, rayDirection * rayDistance), ignoreList)
		local travelDistance = (hitPosition - rayOrigin).Magnitude
		rayDistance = rayDistance - travelDistance
		if hitPart and hitPart.CanCollide then
			rayDirection = rayDirection - 2 * rayDirection:Dot(surfaceNormal) * surfaceNormal
		end
		if rayDistance <= 0 or (travelDistance < 0.001 or bounceCount > 10) then
			return hitPosition, rayDirection
		end
		rayOrigin = hitPosition
	end
end
function t.SinkRay(rayOrigin, rayDirection, rayDistance, ignoreList)
	local bounceCount = 0
	while true do
		bounceCount = bounceCount + 1
		local hitPart, hitPosition, _ = workspace:FindPartOnRayWithIgnoreList(Ray.new(rayOrigin, rayDirection * rayDistance), ignoreList)
		local travelDistance = (hitPosition - rayOrigin).Magnitude
		rayDistance = rayDistance - travelDistance
		if hitPart then
			if hitPart.CanCollide then
				return hitPosition, rayDirection, hitPart
			end
			table.insert(ignoreList, hitPart)
		end
		if rayDistance <= 0 or (travelDistance < 0.001 or bounceCount > 10) then
			return hitPosition, rayDirection
		end
		rayOrigin = hitPosition
	end
end
t.TraceBounceRay = TraceBounceRay
return t
