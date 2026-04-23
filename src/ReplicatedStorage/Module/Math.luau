local v1 = Vector3.new
local v2 = CFrame.new
local Angles = CFrame.Angles
local v3 = Vector3.new(0, 0, 0)
local v4 = v2()
local Cross = v3.Cross
local Dot = v3.Dot
local cos = math.cos
local sin = math.sin
local tan = math.tan
local acos = math.acos
local asin = math.asin
local atan2 = math.atan2
local atan = math.atan
local components = v4.components
local inverse = v4.inverse
local fromAxisAngle = CFrame.fromAxisAngle
local abs = math.abs
local floor = math.floor
local random = math.random
local pointToObjectSpace = v4.pointToObjectSpace
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local t = {
	ContinuousSpring1 = function(p1, p2, p3, p4, p5, p6) --[[ Name: ContinuousSpring1 | Line: 29 ]]
		return p2 + p3 * p6 * p4, p3 + (p1 - p2 - p3) * p6 * p5
	end
}
t.ContinuousSpring3 = t.ContinuousSpring1
function t.ContinuousSpring3F(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) --[[ Line: 33 ]]
	return p4 + p7 * p12 * p10, p6 + p9 * p12 * p10, p6 + p9 * p12 * p10, p7 + (p1 - p4 - p7) * p12 * p11, p8 + (p2 - p5 - p8) * p12 * p11, p9 + (p3 - p6 - p9) * p12 * p11
end
function t.MakeSpring(p1, p2, p3) --[[ Line: 45 ]]
	local v1 = if typeof(p1) == "Vector3" then Vector3.new(0, 0, 0) else 0
	return {
		t = p1,
		p = p1 or v1,
		v = v1,
		s = p2 or 10,
		d = p3 or 0.5,
		t0 = 0
	}
end
function t.Spring(p1, p2) --[[ Line: 56 | Upvalues: cos (copy), sin (copy) ]]
	local v1 = tick()
	local t = p1.t
	local p = p1.p
	local v = p1.v
	local s = p1.s
	local d = p1.d
	local v2 = v1 - p1.t0
	if s == 0 then
		return p, v
	end
	if d < 1 then
		local v3 = (1 - d * d) ^ 0.5
		local v4 = p - t
		local v5 = (d * v4 + v / s) / v3
		local v6 = 2.718281828459045 ^ (-d * s * v2)
		local v7 = cos(v3 * s * v2)
		local v8 = sin(v3 * s * v2)
		return t + (v4 * v7 + v5 * v8) * v6, ((v4 * d - d * v5 - v) * v7 + (v4 * v3 + v5 * d) * v8) * -v6
	end
	if not (d > 1) then
		local v9 = p - t
		local v10 = v9 + v / s
		local v11 = 2.718281828459045 ^ (-s * v2)
		return t + (v9 + v10 * s * v2) * v11, s * (v10 - v9 - v10 * s * v2) * v11
	end
	assert(false, "not implemented")
end
function t.SpringSetTarget(p1, p2) --[[ Line: 79 | Upvalues: t (copy) ]]
	local v1 = tick()
	local v2, v3 = t.Spring(p1, v1)
	p1.p = v2
	p1.v = v3
	p1.t0 = v1
	p1.t = p2
end
function t.SpringAccelerate(p1, p2) --[[ Line: 87 | Upvalues: t (copy) ]]
	local v1 = tick()
	local v2, v3 = t.Spring(p1, v1)
	p1.p = v2
	p1.v = v3 + p2
	p1.t0 = v1
end
local function MakeWorldSpring() --[[ Line: 95 ]]
	return {
		Part = nil,
		Target = nil,
		k = 200,
		B = 15,
		f3 = nil
	}
end
local function WorldSpringUpdate(p1, p2) --[[ Line: 104 ]]
	local Part = p1.Part
	local Target = p1.Target
	p1.f3 = if Target then p1.k * Target - p1.B * Part.CFrame:vectorToObjectSpace(Part.Velocity) else Vector3.new(0, 0, 0)
end
local function WorldSpringSetTarget(p1, p2) --[[ Line: 116 ]]
	p1.Target = p2 - p1.Part.Position
end
t.MakeWorldSpring = MakeWorldSpring
t.WorldSpringUpdate = WorldSpringUpdate
t.WorldSpringSetTarget = WorldSpringSetTarget
function t.CrossMagSq(p1, p2) --[[ Line: 130 | Upvalues: Dot (copy) ]]
	local v1 = Dot(p1, p2)
	return Dot(p1, p1) * Dot(p2, p2) - v1 * v1
end
function t.CrossMagSqF(p1, p2, p3, p4, p5, p6) --[[ Line: 134 ]]
	local v1 = p1 * p4 + p2 * p5 + p3 * p6
	return (p1 * p1 + p2 * p2 + p3 * p3) * (p4 * p4 + p5 * p5 + p6 * p6) - v1 * v1
end
function t.CFrameFromAxisAngle(p1) --[[ Line: 138 | Upvalues: Dot (copy), sin (copy), v2 (copy), cos (copy), v4 (copy) ]]
	local v1 = Dot(p1, p1) ^ 0.5
	if v1 > 1e-6 then
		local v22 = sin(v1 * 0.5) / v1
		return v2(0, 0, 0, v22 * p1.x, v22 * p1.y, v22 * p1.z, (cos(v1 * 0.5)))
	else
		return v4
	end
end
function t.CFrameFromAxisAngleF(p1, p2, p3) --[[ Line: 146 | Upvalues: sin (copy), v2 (copy), cos (copy), v4 (copy) ]]
	local v1 = (p1 * p1 + p2 * p2 + p3 * p3) ^ 0.5
	if v1 > 1e-6 then
		local v22 = sin(v1 * 0.5) / v1
		return v2(0, 0, 0, v22 * p1, v22 * p2, v22 * p3, (cos(v1 * 0.5)))
	else
		return v4
	end
end
function t.CFrameToAxisAngleF(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ Line: 154 | Upvalues: acos (copy) ]]
	local v1 = (p1 + p5 + p9 - 1) * 0.5
	if v1 < -0.99999 then
		local v2 = p1 + p2 + p3 + 1
		local v3 = p4 + p5 + p6 + 1
		local v4 = p7 + p8 + p9 + 1
		local v5 = math.pi * (v2 * v2 + v3 * v3 + v4 * v4) ^ (-0.5)
		return v5 * v2, v5 * v3, v5 * v4
	elseif v1 < 0.99999 then
		local v6 = p8 - p6
		local v7 = p3 - p7
		local v8 = p4 - p2
		local v9 = acos(v1) * (v6 * v6 + v7 * v7 + v8 * v8) ^ (-0.5)
		return v9 * v6, v9 * v7, v9 * v8
	else
		return 0, 0, 0
	end
end
function t.CFrameToAxisAngle(p1) --[[ Line: 173 | Upvalues: components (copy), t (copy), v1 (copy) ]]
	local _, _2, _3, v12, v2, v3, v4, v5, v6, v7, v8, v9 = components(p1)
	return v1(t.CFrameToAxisAngleF(v12, v2, v3, v4, v5, v6, v7, v8, v9))
end
function t.UnitVectorToAnglesYXF(p1, p2, p3) --[[ Line: 178 | Upvalues: asin (copy), atan2 (copy) ]]
	return asin(p2), atan2(-p1, -p3)
end
function t.UnitVectorToAnglesYX(p1) --[[ Line: 181 | Upvalues: t (copy) ]]
	return t.UnitVectorToAnglesYXF(p1.x, p1.y, p1.z)
end
function t.VectorToAnglesYXF(p1, p2, p3) --[[ Line: 184 | Upvalues: asin (copy), atan2 (copy) ]]
	return asin(p2 / (p1 * p1 + p2 * p2 + p3 * p3) ^ 0.5), atan2(-p1, -p3)
end
function t.VectorToAnglesYX(p1) --[[ Line: 187 | Upvalues: t (copy) ]]
	return t.VectorToAnglesYXF(p1.x, p1.y, p1.z)
end
function t.VectorFromAnglesYX(p1, p2) --[[ Line: 190 | Upvalues: cos (copy), sin (copy), v1 (copy) ]]
	local v12 = cos(p1)
	return v1(-v12 * sin(p2), sin(p1), -v12 * cos(p2))
end
function t.Quaternion(p1, p2) --[[ Line: 202 | Upvalues: Dot (copy), Cross (copy), v2 (copy) ]]
	local v1 = Dot(p1, p2)
	local v22 = Cross(p1, p2)
	local v3 = (2 * (1 + v1)) ^ 0.5
	return v2(0, 0, 0, v22.x / v3, v22.y / v3, v22.z / v3, (1 + v1) / v3)
end
function t.QuaternionF(p1, p2, p3, p4, p5, p6) --[[ Line: 208 | Upvalues: v2 (copy) ]]
	local v1 = 1 + p1 * p4 + p2 * p5 + p3 * p6
	local v22 = (2 * v1) ^ 0.5
	return v2(0, 0, 0, (p2 * p6 - p3 * p5) / v22, (p3 * p4 - p1 * p6) / v22, (p1 * p5 - p2 * p4) / v22, v1 / v22)
end
function t.AxisAngleInterpolate(p1, p2, p3) --[[ Line: 216 | Upvalues: components (copy), inverse (copy), fromAxisAngle (copy), v1 (copy), acos (copy) ]]
	local _, _2, _3, v12, v2, v3, v4, v5, v6, v7, v8, v9 = components(inverse(p1) * p2)
	local v10 = (v12 + v5 + v9 - 1) * 0.5
	return p1 * fromAxisAngle(v1(v8 - v6, v3 - v7, v4 - v2), acos(if v10 > 1 then 1 elseif v10 < -1 then -1 else v10) * p3) + (p2.p - p1.p) * p3
end
function t.IsPointInPolygonXZ(p1, p2) --[[ Line: 226 ]]
	local X = p1.X
	local Z = p1.Z
	local v1 = #p2
	local count = 0
	local v2 = false
	local v3 = v1 - 1
	while not (v1 <= count) do
		local v4, v5
		local v6 = p2[count + 1]
		local v7 = p2[v3 + 1]
		local X_2 = v6.X
		local Z_2 = v6.Z
		local Z_3 = v7.Z
		v4 = Z < Z_2
		v5 = Z < Z_3
		if v4 ~= v5 and X < (v7.X - X_2) * (Z - Z_2) / (Z_3 - Z_2) + X_2 then
			v2 = not v2
		end
		count, v3 = count + 1, count
	end
	return v2
end
function t.IsPointInRectangleYZ(p1, p2, p3) --[[ Line: 244 ]]
	local v1 = p2:pointToObjectSpace(p1) + p3 * 0.5
	return if v1.y >= 0 and (v1.y < p3.y and v1.z >= 0) then v1.z < p3.z else false
end
function t.IsPointInRectangleXY(p1, p2, p3) --[[ Line: 248 ]]
	local v1 = p2:pointToObjectSpace(p1) + p3 * 0.5
	return if v1.x >= 0 and (v1.x < p3.x and v1.y >= 0) then v1.y < p3.y else false
end
function t.IsPointInRectangleXZ(p1, p2, p3) --[[ Line: 252 ]]
	local v1 = p2:pointToObjectSpace(p1) + p3 * 0.5
	return if v1.x >= 0 and (v1.x < p3.x and v1.z >= 0) then v1.z < p3.z else false
end
function t.IsPointInPrism(p1, p2, p3) --[[ Line: 256 ]]
	local v1 = p2:pointToObjectSpace(p1) + p3 * 0.5
	return if v1.x >= 0 and (v1.x < p3.x and (v1.y >= 0 and (v1.y < p3.y and v1.z >= 0))) then v1.z < p3.z else false
end
function t.IsPointInFixedCone(p1, p2, p3, p4) --[[ Line: 260 | Upvalues: Dot (copy), acos (copy) ]]
	local v1 = p4 - p1.p
	return if -p3 <= v1.z then acos((Dot(p1.lookVector, v1.unit))) <= p2 else false
end
function t.DoesFixedConeIntersectSphere(p1, p2, p3, p4, p5, p6) --[[ Line: 265 | Upvalues: tan (copy), cos (copy) ]]
	local v1 = p5 - p1
	if p3 <= p2:Dot(v1) then
		return false
	else
		local v2 = v1:Dot(p2)
		local v3 = v2 * tan(p4)
		return ((v1:Dot(v1) - v2 * v2) ^ 0.5 - v3) * cos(p4) <= p6
	end
end
function t.TopPoint(p1, p2) --[[ Line: 286 | Upvalues: v1 (copy) ]]
	return p1 * v1(0, p2.y * 0.5, 0)
end
function t.BottomPoint(p1, p2) --[[ Line: 289 | Upvalues: t (copy) ]]
	return t.TopPoint(p1, -p2)
end
function t.Normal(p1) --[[ Line: 299 ]]
	return p1.upVector
end
function t.IntersectRayPlane(p1, p2, p3, p4) --[[ Line: 303 | Upvalues: Dot (copy), abs (copy) ]]
	local v1 = Dot(p4, p2)
	if not (abs(v1) < 1e-6) then
		local v2 = Dot(p4, p3 - p1) / v1
		if not (v2 < 0) then
			return p1 + p2 * v2
		end
	end
end
function t.IntersectRectanglesByCornersF(p1, p2, p3, p4, p5, p6, p7, p8) --[[ Line: 316 ]]
	return not if p7 <= p1 or (p3 <= p5 or p8 <= p2) then true else p4 <= p6
end
function t.IntersectRectanglesF(p1, p2, p3, p4, p5, p6, p7, p8) --[[ Line: 319 | Upvalues: t (copy) ]]
	local v1 = 0.5 * p5
	local v2 = 0.5 * p6
	local v3 = 0.5 * p7
	local v4 = 0.5 * p8
	return t.IntersectRectanglesByCornersF(p1 - v1, p2 - v2, p1 + v1, p2 + v2, p3 - v3, p4 - v4, p3 + v3, p4 + v4)
end
function t.IntersectRectanglesXZ(p1, p2, p3, p4) --[[ Line: 325 | Upvalues: t (copy) ]]
	return t.IntersectRectanglesF(p1.x, p1.z, p2.x, p2.z, p3.x, p3.z, p4.x, p4.z)
end
function t.Round(p1, p2) --[[ Line: 328 | Upvalues: floor (copy) ]]
	return floor(p1 / p2 + 0.5) * p2
end
function t.RoundVec(p1, p2) --[[ Line: 331 | Upvalues: floor (copy), v1 (copy) ]]
	return v1(floor(p1.x / p2 + 0.5) * p2, floor(p1.y / p2 + 0.5) * p2, floor(p1.z / p2 + 0.5) * p2)
end
t.Clamp = math.clamp
function t.AABBXZF(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) --[[ Line: 336 ]]
	local v1 = 0.5 * p10
	local v2 = 0.5 * p12
	local v3 = -p1 * v1 - p3 * v2
	local v4 = -p7 * v1 - p9 * v2
	local v5 = -p1 * v1 + p3 * v2
	local v6 = -p7 * v1 + p9 * v2
	local v7
	if v5 < v3 then
		v3, v7 = v5, v3
	else
		v7 = if v3 <= v5 then v5 else v3
	end
	local v8
	if v6 < v4 then
		v4, v8 = v6, v4
	else
		v8 = if v4 <= v6 then v6 else v4
	end
	local v9 = p1 * v1 - p3 * v2
	local v10 = p7 * v1 - p9 * v2
	if v9 < v3 then
		v3 = v9
	elseif v7 <= v9 then
		v7 = v9
	end
	if v10 < v4 then
		v4 = v10
	elseif v8 <= v10 then
		v8 = v10
	end
	local v11 = p1 * v1 + p3 * v2
	local v12 = p7 * v1 + p9 * v2
	if v11 < v3 then
		v3 = v11
	elseif v7 <= v11 then
		v7 = v11
	end
	if v12 < v4 then
		v4 = v12
	elseif v8 <= v12 then
		v8 = v12
	end
	return v7 - v3, v8 - v4
end
function t.AABBXZ(p1, p2) --[[ Line: 375 | Upvalues: components (copy), t (copy) ]]
	local _, _2, _3, v1, v2, v3, v4, v5, v6, v7, v8, v9 = components(p1)
	return t.AABBXZF(v1, v2, v3, v4, v5, v6, v7, v8, v9, p2.x, p2.y, p2.z)
end
function t.IsPrismVisibleD(p1, p2, p3) --[[ Line: 380 | Upvalues: components (copy), acos (copy) ]]
	local lookVector = p2.lookVector
	local x = p2.x
	local y = p2.y
	local z = p2.z
	local x_2 = lookVector.x
	local y_2 = lookVector.y
	local z_2 = lookVector.z
	local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = components(p3.CFrame)
	local v13 = p3.Size * 0.5
	local x_3 = v13.x
	local y_3 = v13.y
	local z_3 = v13.z
	local v14 = x_3 * v4
	local v15 = y_3 * v5
	local v16 = z_3 * v6
	local v17 = x_3 * v7
	local v18 = y_3 * v8
	local v19 = z_3 * v9
	local v20 = x_3 * v10
	local v21 = y_3 * v11
	local v22 = z_3 * v12
	local v23 = v1 + v14 + v15 + v16
	local v24 = v2 + v17 + v18 + v19
	local v25 = v3 + v20 + v21 + v22
	local v26 = v1 - v14 - v15 - v16
	local v27 = v2 - v17 - v18 - v19
	local v28 = v3 - v20 - v21 - v22
	local v29 = v23 - x
	local v30 = v24 - y
	local v31 = v25 - z
	local v32 = (v29 * v29 + v30 * v30 + v31 * v31) ^ (-0.5)
	if acos(x_2 * (v29 * v32) + y_2 * (v30 * v32) + z_2 * (v31 * v32)) < p1 then
		return true
	else
		local v33 = v26 - x
		local v34 = v27 - y
		local v35 = v28 - z
		local v36 = (v33 * v33 + v34 * v34 + v35 * v35) ^ (-0.5)
		if acos(x_2 * (v33 * v36) + y_2 * (v34 * v36) + z_2 * (v35 * v36)) < p1 then
			return true
		else
			local v37 = v26 - x
			local v38 = v24 - y
			local v39 = v25 - z
			local v40 = (v37 * v37 + v38 * v38 + v39 * v39) ^ (-0.5)
			if acos(x_2 * (v37 * v40) + y_2 * (v38 * v40) + z_2 * (v39 * v40)) < p1 then
				return true
			else
				local v41 = v23 - x
				local v42 = v27 - y
				local v43 = v28 - z
				local v44 = (v41 * v41 + v42 * v42 + v43 * v43) ^ (-0.5)
				return acos(x_2 * (v41 * v44) + y_2 * (v42 * v44) + z_2 * (v43 * v44)) < p1
			end
		end
	end
end
function t.IsPrismVisible(p1, p2, p3, p4) --[[ Line: 425 | Upvalues: v1 (copy) ]]
	local v12 = 0.5 * p4
	local x = v12.x
	local y = v12.y
	local z = v12.z
	local _, v2 = p1(p2, p3 * v1(x, y, z))
	if v2 then
		return true
	end
	local _2, v3 = p1(p2, p3 * v1(-x, -y, -z))
	if v3 then
		return true
	end
	local _3, v4 = p1(p2, p3 * v1(x, y, -z))
	if v4 then
		return true
	end
	local _4, v5 = p1(p2, p3 * v1(-x, y, z))
	if v5 then
		return true
	end
	local _5, v6 = p1(p2, p3 * v1(-x, y, -z))
	if v6 then
		return true
	end
	local _6, v7 = p1(p2, p3 * v1(x, -y, z))
	if v7 then
		return true
	end
	local _7, v8 = p1(p2, p3 * v1(x, -y, -z))
	if v8 then
		return true
	end
	local _8, v9 = p1(p2, p3 * v1(-x, -y, z))
	if v9 then
		return true
	end
end
function t.IsPrismApproxVisible(p1, p2, p3, p4) --[[ Line: 469 | Upvalues: v1 (copy) ]]
	local v12 = 0.5 * p4 * 2
	local x = v12.x
	local y = v12.y
	local z = v12.z
	local _, v2 = p1(p2, p3 * v1(x, y, z))
	if v2 then
		return true
	else
		local _2, v3 = p1(p2, p3 * v1(-x, -y, -z))
		return v3 and true or false
	end
end
local function IntersectRaySphereF(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) --[[ Line: 496 ]]
	local v1 = p8 - p1
	local v2 = p9 - p2
	local v3 = p10 - p3
	local v4 = v1 * p4 + v2 * p5 + v3 * p6
	if v4 < 0 then
		return false
	else
		local v5 = v1 * v1 + v2 * v2 + v3 * v3 - v4 * v4
		local v6 = p11 * p11
		if v6 < v5 then
			return false
		else
			return not (p7 < v4 - (v6 - v5) ^ 0.5)
		end
	end
end
local function IntersectRaySphere(p1, p2, p3, p4, p5) --[[ Line: 523 ]]
	local v1 = p4.x - p1.x
	local v2 = p4.y - p1.y
	local v3 = p4.z - p1.z
	local v4 = v1 * p2.x + v2 * p2.y + v3 * p2.z
	if v4 < 0 then
		return false
	else
		local v5 = v1 * v1 + v2 * v2 + v3 * v3 - v4 * v4
		local v6 = p5 * p5
		if v6 < v5 then
			return false
		else
			return not (p3 < v4 - (v6 - v5) ^ 0.5)
		end
	end
end
t.IntersectRaySphereF = IntersectRaySphereF
t.IntersectRaySphere = IntersectRaySphere
function t.GUID() --[[ Line: 541 | Upvalues: random (copy) ]]
	return ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(p1) --[[ Line: 543 | Upvalues: random (ref) ]]
		return ("%x"):format(p1 == "x" and random(0, 15) or random(8, 11))
	end)
end
function t.ShortGUID() --[[ Line: 548 | Upvalues: random (copy) ]]
	return ("xxx-yx"):gsub("[xy]", function(p1) --[[ Line: 550 | Upvalues: random (ref) ]]
		return ("%x"):format(p1 == "x" and random(0, 15) or random(8, 11))
	end)
end
t.Base85UUID = String.base85UUID
function t.Uniform2D(p1) --[[ Line: 556 | Upvalues: random (copy), cos (copy), sin (copy), v1 (copy) ]]
	local v12 = random()
	local v2 = random()
	local v3
	if v2 < v12 then
		v2, v3 = v12, v2
	else
		v3 = v12
	end
	return v1(v2 * p1 * cos(6.283185307179586 * v3 / v2), v2 * p1 * sin(6.283185307179586 * v3 / v2), 0)
end
local v5 = Random.new()
function t.WeightedRandom(p1) --[[ Line: 566 | Upvalues: v5 (copy) ]]
	for i = 1, 10 do
		v5:NextNumber()
	end
	local sum = 0
	for j = 1, #p1 do
		sum = sum + p1[j]
	end
	local sum_2 = v5:NextNumber() * sum
	for k = 1, #p1 do
		if sum_2 < p1[k] then
			return k
		end
		sum_2 = sum_2 - p1[k]
	end
	return false
end
function t.LookAt(p1, p2, p3) --[[ Line: 584 | Upvalues: Cross (copy), v2 (copy) ]]
	local unit = (p2 - p3).unit
	local unit_2 = Cross(p1, unit).unit
	local v1 = Cross(unit, unit_2)
	return v2(p2.X, p2.Y, p2.Z, unit_2.x, v1.x, unit.x, unit_2.y, v1.y, unit.y, unit_2.z, v1.z, unit.z)
end
function t.BinaryFind(p1, p2, p3) --[[ Line: 590 | Upvalues: floor (copy) ]]
	local v1 = 1
	local v2 = #p1
	local v3 = p3 or "Sort"
	while v1 <= v2 do
		local v4 = floor((v1 + v2) * 0.5)
		local v5 = p1[v4][v3]
		if v5 < p2 then
			v1 = v4 + 1
		else
			if not (p2 < v5) then
				return v4
			end
			v2 = v4 - 1
		end
	end
	return v1
end
function t.Shuffle(p1) --[[ Line: 606 ]]
	for i = #p1, 2, -1 do
		local v1 = math.random(i)
		local v3 = p1[i]
		p1[i] = p1[v1]
		p1[v1] = v3
	end
end
function t.IsNaN(p1) --[[ Line: 612 ]]
	return p1 ~= p1
end
function t.IsNaNv3(p1) --[[ Line: 615 ]]
	return if p1.x == p1.x and p1.y == p1.y then p1.z ~= p1.z else true
end
function t.IsNaNcf(p1) --[[ Line: 619 ]]
	local lookVector = p1.lookVector
	local v1 = if lookVector.x == lookVector.x and lookVector.y == lookVector.y then lookVector.z ~= lookVector.z else true
	if not v1 then
		local rightVector = p1.rightVector
		v1 = if rightVector.x == rightVector.x and rightVector.y == rightVector.y then rightVector.z ~= rightVector.z else true
		if not v1 then
			local upVector = p1.upVector
			v1 = if upVector.x == upVector.x and upVector.y == upVector.y then upVector.z ~= upVector.z else true
		end
	end
	return v1
end
function t.Clampv3(p1, p2, p3) --[[ Line: 622 | Upvalues: v1 (copy) ]]
	return v1(math.clamp(p1.x, p2, p3), math.clamp(p1.y, p2, p3), (math.clamp(p1.z, p2, p3)))
end
local function comma(p1) --[[ Line: 626 ]]
	local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
end
local function FormatMoney(p1) --[[ Line: 630 | Upvalues: abs (copy) ]]
	local v3, v4, v5 = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
	return ("%s$%s"):format(if p1 >= 0 then "" else "-", v3 .. v4:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v5)
end
t.comma = comma
t.FormatMoney = FormatMoney
function t.stohms(p1) --[[ Line: 639 ]]
	local v1 = math.floor(p1 / 3600)
	local v2 = p1 - v1 * 3600
	local v3 = math.floor(v2 / 60)
	return v1, v3, v2 - v3 * 60
end
function t.Now(p1) --[[ Line: 649 ]]
	return os.time() + ((p1 or -8) + 1) * 60 * 60
end
function t.NextMidnight(p1) --[[ Line: 657 | Upvalues: t (copy) ]]
	return math.ceil(t.Now(p1) / 86400) * 86400
end
function t.TimeUntilMidnight(p1) --[[ Line: 663 | Upvalues: t (copy) ]]
	local v1 = t.Now(p1)
	return t.NextMidnight(p1) - v1
end
local max = math.max
local function TimeAccumDiff(p1, p2) --[[ Line: 670 | Upvalues: max (copy) ]]
	return max(0, p1 - (p2 and os.time() or tick()))
end
local function TimeAccumAdd(p1, p2, p3) --[[ Line: 674 | Upvalues: TimeAccumDiff (ref) ]]
	local v1 = p3 and os.time() or tick()
	return v1 + TimeAccumDiff(p1) + p2
end
t.TimeAccumDiff = TimeAccumDiff
t.TimeAccumAdd = TimeAccumAdd
local function Ease_inOutQuad(p1, p2, p3, p4) --[[ Line: 683 ]]
	local v1 = p1 / p4 * 2
	if v1 < 1 then
		return p3 * 0.5 * v1 * v1 + p2
	else
		return -p3 * 0.5 * ((v1 - 1) * (v1 - 3) - 1) + p2
	end
end
t.TweenType = {
	Linear = 1,
	InOutQuad = 2
}
function t.MakeTween() --[[ Line: 695 | Upvalues: t (copy) ]]
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
function t.UpdateTween(p1, p2) --[[ Line: 706 | Upvalues: t (copy) ]]
	p1.i = p1.i + p2 * p1.s
	if p1.Type == t.TweenType.Linear then
		p1.v = p1.t0 * (1 - p1.i) + p1.t1 * p1.i
	elseif p1.Type == t.TweenType.InOutQuad then
		local t0 = p1.t0
		local v1 = p1.t1 - p1.t0
		local v2 = p1.i / 1 * 2
		p1.v = if v2 < 1 then v1 * 0.5 * v2 * v2 + t0 else -v1 * 0.5 * ((v2 - 1) * (v2 - 3) - 1) + t0
	end
	if p1.i >= 1 and p1.Finished then
		p1.Finished(p1)
	end
end
function t.TweenFunSwap(p1) --[[ Line: 717 ]]
	local t1 = p1.t1
	p1.t1 = p1.t0
	p1.t0 = t1
	p1.i = p1.i - 1
end
return t