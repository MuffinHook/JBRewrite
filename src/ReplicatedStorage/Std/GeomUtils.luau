-- Reviewed by Claude
-- variables reassigned
local t = {
	doesLineIntersectLine = function(p1, p2, p3, p4, p5, p6, p7, p8)
		if p1 == p3 and p2 == p4 or p5 == p7 and p6 == p8 then
			return false
		else
			local v1 = (p8 - p6) * (p3 - p1) - (p7 - p5) * (p4 - p2)
			if v1 == 0 then
				return false
			else
				local v2 = ((p7 - p5) * (p2 - p6) - (p8 - p6) * (p1 - p5)) / v1
				local v3 = ((p3 - p1) * (p2 - p6) - (p4 - p2) * (p1 - p5)) / v1
				return not (v2 < 0 or (v2 > 1 or (v3 < 0 or v3 > 1)))
			end
		end
	end,
	fasterComputeAABB = function(p1)
		local abs = math.abs
		local v1 = (-1 / 0)
		local v2 = (-1 / 0)
		local v3 = (1 / 0)
		local v4 = (1 / 0)
		local v5 = (1 / 0)
		local v6 = (-1 / 0)
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("BasePart") then
				local Size = v.Size
				local X = Size.X
				local Y = Size.Y
				local Z = Size.Z
				local v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 = v.CFrame:GetComponents()
				local v20 = 0.5 * (abs(v11) * X + abs(v12) * Y + abs(v13) * Z)
				local v21 = 0.5 * (abs(v14) * X + abs(v15) * Y + abs(v16) * Z)
				local v22 = 0.5 * (abs(v17) * X + abs(v18) * Y + abs(v19) * Z)
				if v8 - v20 < v3 then
					v3 = v8 - v20
				end
				if v9 - v21 < v4 then
					v4 = v9 - v21
				end
				if v10 - v22 < v5 then
					v5 = v10 - v22
				end
				if v6 < v8 + v20 then
					v6 = v8 + v20
				end
				if v1 < v9 + v21 then
					v1 = v9 + v21
				end
				if v2 < v10 + v22 then
					v2 = v10 + v22
				end
			end
		end
		return Vector3.new(v3, v4, v5), Vector3.new(v6, v1, v2)
	end
}
function t.fasterComputeAABBPart(p1)
	return t.fasterComputeAABBCFSize(p1.CFrame, p1.Size)
end
function t.fasterComputeAABBCFSize(p1, p2)
	local abs = math.abs
	local v1 = (1 / 0)
	local v2 = (1 / 0)
	local v3 = (1 / 0)
	local v4 = (-1 / 0)
	local v5 = (-1 / 0)
	local v6 = (-1 / 0)
	local X = p2.X
	local Y = p2.Y
	local Z = p2.Z
	local v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 = p1:GetComponents()
	local v19 = (abs(v10) * X + abs(v11) * Y + abs(v12) * Z) * 0.5
	local v20 = (abs(v13) * X + abs(v14) * Y + abs(v15) * Z) * 0.5
	local v21 = (abs(v16) * X + abs(v17) * Y + abs(v18) * Z) * 0.5
	if v7 - v19 < v1 then
		v1 = v7 - v19
	end
	if v8 - v20 < v2 then
		v2 = v8 - v20
	end
	if v9 - v21 < v3 then
		v3 = v9 - v21
	end
	if v4 < v7 + v19 then
		v4 = v7 + v19
	end
	if v5 < v8 + v20 then
		v5 = v8 + v20
	end
	if v6 < v9 + v21 then
		v6 = v9 + v21
	end
	return Vector3.new(v1, v2, v3), Vector3.new(v4, v5, v6)
end
function t.calcRayIntersectSphere(p1, p2, p3, p4)
	local Unit = (p2 - p1).Unit
	local v1 = p3 - p1
	local v2 = v1:Dot(Unit)
	if v2 < 0 then
		return nil, nil
	else
		local v4 = math.sqrt(v1:Dot(v1) - v2 ^ 2)
		if v4 < 0 then
			return nil, nil
		else
			local v5 = math.sqrt(p4 ^ 2 - v4 ^ 2)
			local v6 = v2 - v5
			local v7 = v2 + v5
			local Magnitude = (p2 - p1).Magnitude
			if v7 <= Magnitude then
				return p1 + Unit * v6, p1 + Unit * v7
			elseif v6 <= Magnitude then
				return p1 + Unit * v6, nil
			else
				return nil, nil
			end
		end
	end
end
function t.intersectRayPlane(p1, p2, p3, p4)
	local v1 = p4:Dot(p2)
	if not (math.abs(v1) < 1e-6) then
		local v2 = p4:Dot(p3 - p1) / v1
		if not (v2 < 0) then
			return p1 + p2 * v2
		end
	end
end
function t.isPointInCylinder(p1, p2, p3, p4, p5)
	local Unit = p3.Unit
	local v1 = p1 - p2
	local v2 = v1:Dot(Unit)
	if v2 < 0 or p4 < v2 then
		return false
	else
		return not (p5 < (v1 - Unit * v2).Magnitude)
	end
end
function t.randomPointInCircle()
	local v2 = math.sqrt((math.random()))
	local v3 = math.random() * 2 * math.pi
	return Vector2.new(v2 * math.cos(v3), v2 * math.sin(v3))
end
function t.randomPointOnCircle()
	local v1 = math.random() * 2 * math.pi
	return Vector2.new(math.cos(v1), (math.sin(v1)))
end
function t.randomPointInRing(p1)
	local v2 = math.sqrt(math.random() * (1 - p1 ^ 2) + p1 ^ 2)
	local v3 = math.random() * 2 * math.pi
	return Vector2.new(v2 * math.cos(v3), v2 * math.sin(v3))
end
function t.randomPointOnSphere()
	local v1 = math.random() * math.pi * 2
	local v2 = math.random() * 2 - 1
	local v3 = math.sqrt(1 - v2 ^ 2) * math.cos(v1)
	return Vector3.new(v3, math.sqrt(1 - v2 ^ 2) * math.sin(v1), v2)
end
function t.randomPointInSphere()
	local v1 = math.random() * 2 * math.pi
	local v3 = math.acos(2 * math.random() - 1)
	local v4 = math.random() ^ 0.3333333333333333
	local v5 = math.sin(v1)
	local v6 = math.cos(v1)
	local v7 = math.sin(v3)
	return Vector3.new(v4 * v7 * v6, v4 * v7 * v5, v4 * math.cos(v3))
end
function t.shortAngleDist(p1, p2)
	local v1 = math.sign(p2 - p1)
	local v2 = v1 * (math.abs(p2 - p1) % 6.283185307179586)
	return v1 * (math.abs(v2) * 2 % 6.283185307179586) - v2
end
function t.waveTriangle(p1, p2, p3)
	local v1 = p2 or 1
	assert(v1)
	local v2 = p3 or 1
	assert(v2)
	return 4 * v1 / v2 * math.abs(p1 % v2 - v2 / 2) - v1
end
function t.closestPointInPart(p1, p2)
	local v1 = p1.CFrame
	local v2 = v1:PointToObjectSpace(p2)
	local v3 = p1.Size.X * 0.5
	local v4 = p1.Size.Y * 0.5
	local v5 = p1.Size.Z * 0.5
	return v1 * Vector3.new(math.clamp(v2.X, -v3, v3), math.clamp(v2.Y, -v4, v4), (math.clamp(v2.Z, -v5, v5)))
end
function t.closestPointOnPart(p1, p2)
	return p1:GetClosestPointOnSurface(p2)
end
function t.closestPointOnLine(p1, p2, p3)
	local Unit = p2.Unit
	local v2 = p1 + Unit * math.clamp(Unit:Dot(p3 - p1), 0, p2.Magnitude)
	return v2, (p3 - v2).Magnitude
end
function t.getSunflowerSeedArrangementGenerator(p1, p2, p3)
	local v2 = math.floor(p2 * math.sqrt(p1) + 0.5)
	local v3 = 0
	return function()
		if v3 < p1 then
			v3 = v3 + 1
			local v1 = p3
			if v3 <= p1 - v2 then
				v1 = p3 * math.sqrt((1 - v3 * 2) / (v2 - p1 * 2 + 1))
			end
			return Vector3.new(math.cos(2.399963229728653 * v3), 0, (math.sin(2.399963229728653 * v3))) * v1, v1
		else
			return nil, nil
		end
	end
end
function t.getTrajectoryInterceptTime(p1, p2, p3, p4, p5)
	local X = p3.X
	local Y = p3.Y
	local Z = p3.Z
	local X_2 = p5.X
	local Y_2 = p5.Y
	local Z_2 = p5.Z
	local X_3 = p1.X
	local Y_3 = p1.Y
	local Z_3 = p1.Z
	local v1 = p2 * p2 - (X_2 * X_2 + Y_2 * Y_2 + Z_2 * Z_2) * p4 * p4
	local v2 = math.sqrt(p4 * 4 * p4 * (X_2 * (X_3 - X) + Y_2 * (Y_3 - Y) + Z_2 * (Z_3 - Z)) ^ 2 - ((X_2 * X_2 + Y_2 * Y_2 + Z_2 * Z_2) * p4 * p4 - p2 * p2) * 4 * ((X_3 - X) ^ 2 + (Y_3 - Y) ^ 2 + (Z_3 - Z) ^ 2)) * 0.5
	local v3 = X_2 * X * p4 + Y_2 * Y * p4 + Z_2 * Z * p4 - X_2 * X_3 * p4 - Y_2 * Y_3 * p4 - Z_2 * Z_3 * p4
	local v4 = (v3 + v2) / v1
	local v5 = (v3 - v2) / v1
	if v4 ~= v4 or v4 <= 0 then
		v4 = nil
	end
	if v5 ~= v5 or v5 <= 0 then
		v5 = nil
	end
	if v4 and v5 then
		return math.min(v4, v5)
	else
		return v4 or v5
	end
end
function t.offsetLookAtTarget(p1, p2, p3, p4, p5, p6)
	if p6 == 0 then
		return 0, 0
	else
		local v1 = p4 * p4 + p6 * p6
		local v2 = p6 < 0 and math.atan(p4 / p6) or math.pi - math.atan(-p4 / p6)
		local v4 = v2 + (p1 * p1 < v1 and math.asin(p1 / v1 ^ 0.5) or math.asin(v1 ^ 0.5 / p1))
		local v5 = p6 * math.cos(v4) + p4 * math.sin(v4)
		local v6 = p5 * p5 + v5 * v5
		local v7 = v5 < 0 and math.atan(-p5 / v5) or math.atan(p5 / v5)
		return v4, v7 - (p2 * p2 < v6 and math.asin(p2 / v6 ^ 0.5) or math.asin(v6 ^ 0.5 / p2))
	end
end
function t.generate2DPointClockwiseComparisonFunction(p1)
	local v1 = p1 or Vector2.zero
	assert(typeof(v1) == "Vector2", "optionalCenter must be a Vector2")
	return function(p1, p2)
		local v12 = p1 - v1
		local v2 = p2 - v1
		if v12.X >= 0 and v2.X < 0 then
			return true
		elseif v12.X < 0 and v2.X >= 0 then
			return false
		else
			if math.abs(v12.X) <= 0.001 and math.abs(v2.X) <= 0.001 then
				if v12.Y >= 0 or v2.Y >= 0 then
					return p1.Y > p2.Y
				else
					return p2.Y > p1.Y
				end
			else
				local v3, v4
				v3 = v12:Cross(v2)
				if v3 < 0 then
					return true
				elseif v3 > 0 then
					return false
				else
					v4 = v12.Magnitude > v2.Magnitude
					return v4
				end
			end
		end
	end
end
function t.yieldNPointsOnSphere(p1)
	local v1 = 2 / p1
	local v2 = 1
	return function()
		v2 = v2 + 1
		if v2 <= p1 then
			local v12 = v2 * v1 - 1 + v1 / 2
			if v12 > 1 then
				v12 = 1
			end
			local v22 = math.sqrt(1 - v12 * v12)
			local v3 = v2 % p1 * 2.399963229728653
			return math.cos(v3) * v22, v12, math.sin(v3) * v22, v2
		end
	end
end
function t.catmullRomSplinePoint(p1, p2, p3, p4, p5)
	local v1 = p5 * p5
	local v2 = v1 * p5
	local v3 = (-v2 + v1 * 2 - p5) * 0.5
	local v4 = (v2 * 3 - v1 * 5 + 2) * 0.5
	local v5 = (v2 * -3 + v1 * 4 + p5) * 0.5
	local v6 = (v2 - v1) * 0.5
	return Vector3.new(v3 * p1.X + v4 * p2.X + v5 * p3.X + v6 * p4.X, v3 * p1.Y + v4 * p2.Y + v5 * p3.Y + v6 * p4.Y, v3 * p1.Z + v4 * p2.Z + v5 * p3.Z + v6 * p4.Z)
end
function t.getNCatmullRomSplinePoints(p1, p2, p3, p4, p5)
	local v1 = p5 or 100
	assert(v1)
	local t2 = {}
	for i = 1, v1 do
		table.insert(t2, (t.catmullRomSplinePoint(p1, p2, p3, p4, (i - 1) / (v1 - 1))))
	end
	return t2
end
function t.yieldNCatmullRomSplinePoints(p1, p2, p3, p4, p5)
	local v1 = p5 or 100
	assert(v1)
	local v3 = 1
	return function()
		if v3 <= v1 then
			local v2 = t.catmullRomSplinePoint(p1, p2, p3, p4, (v3 - 1) / (v1 - 1))
			v3 = v3 + 1
			return v2, v3
		end
	end
end
function t.stepAlongPath(p1, p2, p3, p4)
	while p4 > 0 do
		local v2 = p2 + 1 <= #p1 and p2 + 1 or 1
		local Magnitude = (p1[p2]:Lerp(p1[(p2 + 1 - 1) % #p1 + 1], p3) - p1[v2]).Magnitude
		if p4 < Magnitude then
			p4 = 0
			p3 = p3 + p4 / Magnitude * (1 - p3)
		else
			p4, p2, p3 = p4 - Magnitude, v2, 0
		end
	end
	return p2, p3
end
function t.getDepthForWidth(p1, p2, p3)
	local ViewportSize = p3.ViewportSize
	return 0.5 * ViewportSize.X * p1 / (p2 * (ViewportSize.X / ViewportSize.Y * math.tan(math.rad(p3.FieldOfView) / 2)))
end
function t.transformRange(p1, p2, p3, p4, p5)
	return p4 + (p1 - p2) * (p5 - p4) / (p3 - p2)
end
return t
