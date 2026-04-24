-- Reviewed by Claude
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
local t = {
	ContinuousSpring1 = function(target, position, velocity, stiffness, damping, deltaTime)
		return position + velocity * deltaTime * stiffness, velocity + (target - position - velocity) * deltaTime * damping
	end
}
t.ContinuousSpring3 = t.ContinuousSpring1
function t.ContinuousSpring3F(targetX, targetY, targetZ, posX, posY, posZ, velX, velY, velZ, stiffness, damping, deltaTime)
	return posX + velX * deltaTime * stiffness, posY + velY * deltaTime * stiffness, posZ + velZ * deltaTime * stiffness, velX + (targetX - posX - velX) * deltaTime * damping, velY + (targetY - posY - velY) * deltaTime * damping, velZ + (targetZ - posZ - velZ) * deltaTime * damping
end
function t.MakeSpring(target, stiffness, damping)
	local initialVelocity = if typeof(target) == "Vector3" then Vector3.new(0, 0, 0) else 0
	return {
		t = target,
		p = target or initialVelocity,
		v = initialVelocity,
		s = stiffness or 10,
		d = damping or 0.5,
		t0 = 0
	}
end
function t.Spring(spring, currentTime)
	local currentClock = tick()
	local target = spring.t
	local position = spring.p
	local velocity = spring.v
	local stiffness = spring.s
	local damping = spring.d
	local elapsedTime = currentClock - spring.t0
	if stiffness == 0 then
		return position, velocity
	end
	if damping < 1 then
		local dampingFactor = (1 - damping * damping) ^ 0.5
		local positionDelta = position - target
		local intermediateValue = (damping * positionDelta + velocity / stiffness) / dampingFactor
		local exponentialDecay = 2.718281828459045 ^ (-damping * stiffness * elapsedTime)
		local cosComponent = cos(dampingFactor * stiffness * elapsedTime)
		local sinComponent = sin(dampingFactor * stiffness * elapsedTime)
		return target + (positionDelta * cosComponent + intermediateValue * sinComponent) * exponentialDecay, ((positionDelta * damping - damping * intermediateValue - velocity) * cosComponent + (positionDelta * dampingFactor + intermediateValue * damping) * sinComponent) * -exponentialDecay
	end
	if not (damping > 1) then
		local positionDelta = position - target
		local intermediateValue = positionDelta + velocity / stiffness
		local exponentialDecay = 2.718281828459045 ^ (-stiffness * elapsedTime)
		return target + (positionDelta + intermediateValue * stiffness * elapsedTime) * exponentialDecay, stiffness * (intermediateValue - positionDelta - intermediateValue * stiffness * elapsedTime) * exponentialDecay
	end
	assert(false, "not implemented")
end
function t.SpringSetTarget(spring, targetValue)
	local currentClock = tick()
	local newPosition, newVelocity = t.Spring(spring, currentClock)
	spring.p = newPosition
	spring.v = newVelocity
	spring.t0 = currentClock
	spring.t = targetValue
end
function t.SpringAccelerate(spring, acceleration)
	local currentClock = tick()
	local newPosition, newVelocity = t.Spring(spring, currentClock)
	spring.p = newPosition
	spring.v = newVelocity + acceleration
	spring.t0 = currentClock
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
t.MakeWorldSpring = MakeWorldSpring
t.WorldSpringUpdate = WorldSpringUpdate
t.WorldSpringSetTarget = WorldSpringSetTarget
function t.CrossMagSq(vec1, vec2)
	local dotProduct = Dot(vec1, vec2)
	return Dot(vec1, vec1) * Dot(vec2, vec2) - dotProduct * dotProduct
end
function t.CrossMagSqF(x1, y1, z1, x2, y2, z2)
	local dotProduct = x1 * x2 + y1 * y2 + z1 * z2
	return (x1 * x1 + y1 * y1 + z1 * z1) * (x2 * x2 + y2 * y2 + z2 * z2) - dotProduct * dotProduct
end
function t.CFrameFromAxisAngle(axisAngle)
	local magnitude = Dot(axisAngle, axisAngle) ^ 0.5
	if magnitude > 1e-6 then
		local sinHalfMag = sin(magnitude * 0.5) / magnitude
		return createCFrame(0, 0, 0, sinHalfMag * axisAngle.x, sinHalfMag * axisAngle.y, sinHalfMag * axisAngle.z, (cos(magnitude * 0.5)))
	else
		return identityCFrame
	end
end
function t.CFrameFromAxisAngleF(axisX, axisY, axisZ)
	local magnitude = (axisX * axisX + axisY * axisY + axisZ * axisZ) ^ 0.5
	if magnitude > 1e-6 then
		local sinHalfMag = sin(magnitude * 0.5) / magnitude
		return createCFrame(0, 0, 0, sinHalfMag * axisX, sinHalfMag * axisY, sinHalfMag * axisZ, (cos(magnitude * 0.5)))
	else
		return identityCFrame
	end
end
function t.CFrameToAxisAngleF(m00, m01, m02, m10, m11, m12, m20, m21, m22)
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
function t.CFrameToAxisAngle(cframe)
	local _, _2, _3, m00, m10, m20, m01, m11, m21, m02, m12, m22 = components(cframe)
	return createVector3(t.CFrameToAxisAngleF(m00, m10, m20, m01, m11, m21, m02, m12, m22))
end
function t.UnitVectorToAnglesYXF(x, y, z)
	return asin(y), atan2(-x, -z)
end
function t.UnitVectorToAnglesYX(vector)
	return t.UnitVectorToAnglesYXF(vector.x, vector.y, vector.z)
end
function t.VectorToAnglesYXF(x, y, z)
	return asin(y / (x * x + y * y + z * z) ^ 0.5), atan2(-x, -z)
end
function t.VectorToAnglesYX(vector)
	return t.VectorToAnglesYXF(vector.x, vector.y, vector.z)
end
function t.VectorFromAnglesYX(yaw, pitch)
	local cosPitch = cos(yaw)
	return createVector3(-cosPitch * sin(pitch), sin(yaw), -cosPitch * cos(pitch))
end
function t.Quaternion(vec1, vec2)
	local dotProduct = Dot(vec1, vec2)
	local crossProduct = Cross(vec1, vec2)
	local normalizationFactor = (2 * (1 + dotProduct)) ^ 0.5
	return createCFrame(0, 0, 0, crossProduct.x / normalizationFactor, crossProduct.y / normalizationFactor, crossProduct.z / normalizationFactor, (1 + dotProduct) / normalizationFactor)
end
function t.QuaternionF(x1, y1, z1, x2, y2, z2)
	local dotProductPlus1 = 1 + x1 * x2 + y1 * y2 + z1 * z2
	local normalizationFactor = (2 * dotProductPlus1) ^ 0.5
	return createCFrame(0, 0, 0, (y1 * z2 - z1 * y2) / normalizationFactor, (z1 * x2 - x1 * z2) / normalizationFactor, (x1 * y2 - y1 * x2) / normalizationFactor, dotProductPlus1 / normalizationFactor)
end
function t.AxisAngleInterpolate(startCFrame, endCFrame, alpha)
	local _, _2, _3, m00, m10, m20, m01, m11, m21, m02, m12, m22 = components(inverse(startCFrame) * endCFrame)
	local traceDiv2 = (m00 + m11 + m22 - 1) * 0.5
	return startCFrame * fromAxisAngle(createVector3(m12 - m21, m02 - m20, m10 - m01), acos(if traceDiv2 > 1 then 1 elseif traceDiv2 < -1 then -1 else traceDiv2) * alpha) + (endCFrame.p - startCFrame.p) * alpha
end
function t.IsPointInPolygonXZ(point, polygonPoints)
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
function t.IsPointInRectangleYZ(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.y >= 0 and (localPoint.y < dimensions.y and localPoint.z >= 0) then localPoint.z < dimensions.z else false
end
function t.IsPointInRectangleXY(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.x >= 0 and (localPoint.x < dimensions.x and localPoint.y >= 0) then localPoint.y < dimensions.y else false
end
function t.IsPointInRectangleXZ(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.x >= 0 and (localPoint.x < dimensions.x and localPoint.z >= 0) then localPoint.z < dimensions.z else false
end
function t.IsPointInPrism(point, cframeRef, dimensions)
	local localPoint = cframeRef:pointToObjectSpace(point) + dimensions * 0.5
	return if localPoint.x >= 0 and (localPoint.x < dimensions.x and (localPoint.y >= 0 and (localPoint.y < dimensions.y and localPoint.z >= 0))) then localPoint.z < dimensions.z else false
end
function t.IsPointInFixedCone(p1, p2, p3, p4)
	local delta = p4 - p1.p
	return if -p3 <= delta.z then acos((Dot(p1.lookVector, delta.unit))) <= p2 else false
end
function t.DoesFixedConeIntersectSphere(p1, p2, p3, p4, p5, p6)
	local delta = p5 - p1
	if p3 <= p2:Dot(delta) then
		return false
	else
		local v2 = delta:Dot(p2)
		local var3 = v2 * tan(p4)
		return ((delta:Dot(delta) - v2 * v2) ^ 0.5 - var3) * cos(p4) <= p6
	end
end
function t.TopPoint(p1, p2)
	return p1 * delta(0, p2.y * 0.5, 0)
end
function t.BottomPoint(p1, p2)
	return t.TopPoint(p1, -p2)
end
function t.Normal(p1)
	return p1.upVector
end
function t.IntersectRayPlane(p1, p2, p3, p4)
	local delta = Dot(p4, p2)
	if not (abs(delta) < 1e-6) then
		local v2 = Dot(p4, p3 - p1) / delta
		if not (v2 < 0) then
			return p1 + p2 * v2
		end
	end
end
function t.IntersectRectanglesByCornersF(p1, p2, p3, p4, p5, p6, p7, p8)
	return not if p7 <= p1 or (p3 <= p5 or p8 <= p2) then true else p4 <= p6
end
function t.IntersectRectanglesF(p1, p2, p3, p4, p5, p6, p7, p8)
	local delta = 0.5 * p5
	local v2 = 0.5 * p6
	local var3 = 0.5 * p7
	local var4 = 0.5 * p8
	return t.IntersectRectanglesByCornersF(p1 - delta, p2 - v2, p1 + delta, p2 + v2, p3 - var3, p4 - var4, p3 + var3, p4 + var4)
end
function t.IntersectRectanglesXZ(p1, p2, p3, p4)
	return t.IntersectRectanglesF(p1.x, p1.z, p2.x, p2.z, p3.x, p3.z, p4.x, p4.z)
end
function t.Round(p1, p2)
	return floor(p1 / p2 + 0.5) * p2
end
function t.RoundVec(p1, p2)
	return delta(floor(p1.x / p2 + 0.5) * p2, floor(p1.y / p2 + 0.5) * p2, floor(p1.z / p2 + 0.5) * p2)
end
t.Clamp = math.clamp
function t.AABBXZF(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
	local delta = 0.5 * p10
	local v2 = 0.5 * p12
	local var3 = -p1 * delta - p3 * v2
	local var4 = -p7 * delta - p9 * v2
	local var5 = -p1 * delta + p3 * v2
	local var6 = -p7 * delta + p9 * v2
	local v7
	if var5 < var3 then
		var3, v7 = var5, var3
	else
		v7 = if var3 <= var5 then var5 else var3
	end
	local v8
	if var6 < var4 then
		var4, v8 = var6, var4
	else
		v8 = if var4 <= var6 then var6 else var4
	end
	local var9 = p1 * delta - p3 * v2
	local var10 = p7 * delta - p9 * v2
	if var9 < var3 then
		var3 = var9
	elseif v7 <= var9 then
		v7 = var9
	end
	if var10 < var4 then
		var4 = var10
	elseif v8 <= var10 then
		v8 = var10
	end
	local var11 = p1 * delta + p3 * v2
	local var12 = p7 * delta + p9 * v2
	if var11 < var3 then
		var3 = var11
	elseif v7 <= var11 then
		v7 = var11
	end
	if var12 < var4 then
		var4 = var12
	elseif v8 <= var12 then
		v8 = var12
	end
	return v7 - var3, v8 - var4
end
function t.AABBXZ(p1, p2)
	local _, _2, _3, delta, v2, var3, var4, var5, var6, v7, v8, var9 = components(p1)
	return t.AABBXZF(delta, v2, var3, var4, var5, var6, v7, v8, var9, p2.x, p2.y, p2.z)
end
function t.IsPrismVisibleD(p1, p2, p3)
	local lookVector = p2.lookVector
	local x = p2.x
	local y = p2.y
	local z = p2.z
	local x_2 = lookVector.x
	local y_2 = lookVector.y
	local z_2 = lookVector.z
	local delta, v2, var3, var4, var5, var6, v7, v8, var9, var10, var11, var12 = components(p3.CFrame)
	local var13 = p3.Size * 0.5
	local x_3 = var13.x
	local y_3 = var13.y
	local z_3 = var13.z
	local var14 = x_3 * var4
	local var15 = y_3 * var5
	local var16 = z_3 * var6
	local var17 = x_3 * v7
	local var18 = y_3 * v8
	local var19 = z_3 * var9
	local var20 = x_3 * var10
	local var21 = y_3 * var11
	local var22 = z_3 * var12
	local var23 = delta + var14 + var15 + var16
	local var24 = v2 + var17 + var18 + var19
	local var25 = var3 + var20 + var21 + var22
	local var26 = delta - var14 - var15 - var16
	local var27 = v2 - var17 - var18 - var19
	local var28 = var3 - var20 - var21 - var22
	local var29 = var23 - x
	local var30 = var24 - y
	local var31 = var25 - z
	local var32 = (var29 * var29 + var30 * var30 + var31 * var31) ^ (-0.5)
	if acos(x_2 * (var29 * var32) + y_2 * (var30 * var32) + z_2 * (var31 * var32)) < p1 then
		return true
	else
		local var33 = var26 - x
		local var34 = var27 - y
		local var35 = var28 - z
		local var36 = (var33 * var33 + var34 * var34 + var35 * var35) ^ (-0.5)
		if acos(x_2 * (var33 * var36) + y_2 * (var34 * var36) + z_2 * (var35 * var36)) < p1 then
			return true
		else
			local var37 = var26 - x
			local var38 = var24 - y
			local var39 = var25 - z
			local var40 = (var37 * var37 + var38 * var38 + var39 * var39) ^ (-0.5)
			if acos(x_2 * (var37 * var40) + y_2 * (var38 * var40) + z_2 * (var39 * var40)) < p1 then
				return true
			else
				local var41 = var23 - x
				local var42 = var27 - y
				local var43 = var28 - z
				local var44 = (var41 * var41 + var42 * var42 + var43 * var43) ^ (-0.5)
				return acos(x_2 * (var41 * var44) + y_2 * (var42 * var44) + z_2 * (var43 * var44)) < p1
			end
		end
	end
end
function t.IsPrismVisible(p1, p2, p3, p4)
	local var12 = 0.5 * p4
	local x = var12.x
	local y = var12.y
	local z = var12.z
	local _, v2 = p1(p2, p3 * delta(x, y, z))
	if v2 then
		return true
	end
	local _2, var3 = p1(p2, p3 * delta(-x, -y, -z))
	if var3 then
		return true
	end
	local _3, var4 = p1(p2, p3 * delta(x, y, -z))
	if var4 then
		return true
	end
	local _4, var5 = p1(p2, p3 * delta(-x, y, z))
	if var5 then
		return true
	end
	local _5, var6 = p1(p2, p3 * delta(-x, y, -z))
	if var6 then
		return true
	end
	local _6, v7 = p1(p2, p3 * delta(x, -y, z))
	if v7 then
		return true
	end
	local _7, v8 = p1(p2, p3 * delta(x, -y, -z))
	if v8 then
		return true
	end
	local _8, var9 = p1(p2, p3 * delta(-x, -y, z))
	if var9 then
		return true
	end
end
function t.IsPrismApproxVisible(p1, p2, p3, p4)
	local var12 = 0.5 * p4 * 2
	local x = var12.x
	local y = var12.y
	local z = var12.z
	local _, v2 = p1(p2, p3 * delta(x, y, z))
	if v2 then
		return true
	else
		local _2, var3 = p1(p2, p3 * delta(-x, -y, -z))
		return var3 and true or false
	end
end
local function IntersectRaySphereF(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11)
	local delta = p8 - p1
	local v2 = p9 - p2
	local var3 = p10 - p3
	local var4 = delta * p4 + v2 * p5 + var3 * p6
	if var4 < 0 then
		return false
	else
		local var5 = delta * delta + v2 * v2 + var3 * var3 - var4 * var4
		local var6 = p11 * p11
		if var6 < var5 then
			return false
		else
			return not (p7 < var4 - (var6 - var5) ^ 0.5)
		end
	end
end
local function IntersectRaySphere(p1, p2, p3, p4, p5)
	local delta = p4.x - p1.x
	local v2 = p4.y - p1.y
	local var3 = p4.z - p1.z
	local var4 = delta * p2.x + v2 * p2.y + var3 * p2.z
	if var4 < 0 then
		return false
	else
		local var5 = delta * delta + v2 * v2 + var3 * var3 - var4 * var4
		local var6 = p5 * p5
		if var6 < var5 then
			return false
		else
			return not (p3 < var4 - (var6 - var5) ^ 0.5)
		end
	end
end
t.IntersectRaySphereF = IntersectRaySphereF
t.IntersectRaySphere = IntersectRaySphere
function t.GUID()
	return ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(p1)
		return ("%x"):format(p1 == "x" and random(0, 15) or random(8, 11))
	end)
end
function t.ShortGUID()
	return ("xxx-yx"):gsub("[xy]", function(p1)
		return ("%x"):format(p1 == "x" and random(0, 15) or random(8, 11))
	end)
end
t.Base85UUID = String.base85UUID
function t.Uniform2D(p1)
	local var12 = random()
	local v2 = random()
	local var3
	if v2 < var12 then
		v2, var3 = var12, v2
	else
		var3 = var12
	end
	return delta(v2 * p1 * cos(6.283185307179586 * var3 / v2), v2 * p1 * sin(6.283185307179586 * var3 / v2), 0)
end
local var5 = Random.new()
function t.WeightedRandom(p1)
	for i = 1, 10 do
		var5:NextNumber()
	end
	local sum = 0
	for j = 1, #p1 do
		sum = sum + p1[j]
	end
	local sum_2 = var5:NextNumber() * sum
	for k = 1, #p1 do
		if sum_2 < p1[k] then
			return k
		end
		sum_2 = sum_2 - p1[k]
	end
	return false
end
function t.LookAt(p1, p2, p3)
	local unit = (p2 - p3).unit
	local unit_2 = Cross(p1, unit).unit
	local delta = Cross(unit, unit_2)
	return v2(p2.X, p2.Y, p2.Z, unit_2.x, delta.x, unit.x, unit_2.y, delta.y, unit.y, unit_2.z, delta.z, unit.z)
end
function t.BinaryFind(p1, p2, p3)
	local delta = 1
	local v2 = #p1
	local var3 = p3 or "Sort"
	while delta <= v2 do
		local var4 = floor((delta + v2) * 0.5)
		local var5 = p1[var4][var3]
		if var5 < p2 then
			delta = var4 + 1
		else
			if not (p2 < var5) then
				return var4
			end
			v2 = var4 - 1
		end
	end
	return delta
end
function t.Shuffle(p1)
	for i = #p1, 2, -1 do
		local delta = math.random(i)
		local var3 = p1[i]
		p1[i] = p1[delta]
		p1[delta] = var3
	end
end
function t.IsNaN(p1)
	return p1 ~= p1
end
function t.IsNaNv3(p1)
	return if p1.x == p1.x and p1.y == p1.y then p1.z ~= p1.z else true
end
function t.IsNaNcf(p1)
	local lookVector = p1.lookVector
	local delta = if lookVector.x == lookVector.x and lookVector.y == lookVector.y then lookVector.z ~= lookVector.z else true
	if not delta then
		local rightVector = p1.rightVector
		delta = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
		if not delta then
			local upVector = p1.upVector
			delta = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
		end
	end
	return delta
end
function t.Clampv3(p1, p2, p3)
	return delta(math.clamp(p1.x, p2, p3), math.clamp(p1.y, p2, p3), (math.clamp(p1.z, p2, p3)))
end
local function comma(p1)
	local delta, v2, var3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return delta .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. var3
end
local function FormatMoney(p1)
	local var3, var4, var5 = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
	return ("%s$%s"):format(if p1 >= 0 then "" else "-", var3 .. var4:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. var5)
end
t.comma = comma
t.FormatMoney = FormatMoney
function t.stohms(p1)
	local delta = math.floor(p1 / 3600)
	local v2 = p1 - delta * 3600
	local var3 = math.floor(v2 / 60)
	return delta, var3, v2 - var3 * 60
end
function t.Now(p1)
	return os.time() + ((p1 or -8) + 1) * 60 * 60
end
function t.NextMidnight(p1)
	return math.ceil(t.Now(p1) / 86400) * 86400
end
function t.TimeUntilMidnight(p1)
	local delta = t.Now(p1)
	return t.NextMidnight(p1) - delta
end
local max = math.max
local function TimeAccumDiff(p1, p2)
	return max(0, p1 - (p2 and os.time() or tick()))
end
local function TimeAccumAdd(p1, p2, p3)
	local delta = p3 and os.time() or tick()
	return delta + TimeAccumDiff(p1) + p2
end
t.TimeAccumDiff = TimeAccumDiff
t.TimeAccumAdd = TimeAccumAdd
local function Ease_inOutQuad(p1, p2, p3, p4)
	local delta = p1 / p4 * 2
	if delta < 1 then
		return p3 * 0.5 * delta * delta + p2
	else
		return -p3 * 0.5 * ((delta - 1) * (delta - 3) - 1) + p2
	end
end
t.TweenType = {
	Linear = 1,
	InOutQuad = 2
}
function t.MakeTween()
	return {
		i = 0,
		t0 = 0,
		t1 = 1,
		s = 1,
		v = 0,
		Type = t.TweenType.Linear,
		Finished = nil
	}
end
function t.UpdateTween(p1, p2)
	p1.i = p1.i + p2 * p1.s
	if p1.Type == t.TweenType.Linear then
		p1.v = p1.t0 * (1 - p1.i) + p1.t1 * p1.i
	elseif p1.Type == t.TweenType.InOutQuad then
		local t0 = p1.t0
		local delta = p1.t1 - p1.t0
		local v2 = p1.i / 1 * 2
		p1.v = if v2 < 1 then delta * 0.5 * v2 * v2 + t0 else -delta * 0.5 * ((v2 - 1) * (v2 - 3) - 1) + t0
	end
	if p1.i >= 1 and p1.Finished then
		p1.Finished(p1)
	end
end
function t.TweenFunSwap(p1)
	local t1 = p1.t1
	p1.t1 = p1.t0
	p1.t0 = t1
	p1.i = p1.i - 1
end
return t
