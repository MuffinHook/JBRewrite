local t = {}
local exp = math.exp
local cos = math.cos
local sin = math.sin
local function SpringUpdate(p1) --[[ Line: 7 | Upvalues: exp (copy), cos (copy), sin (copy) ]]
	local v1 = tick() - p1.t
	local Freq = p1.Freq
	local Damp = p1.Damp
	local v = p1.v
	local Target = p1.Target
	local v2 = p1.p - Target
	if Damp > 1 then
		local v3 = -Freq * Damp
		local v4 = Freq * (Damp * Damp - 1) ^ 0.5
		local v5 = v3 - v4
		local v6 = v3 + v4
		local v7 = exp(v5 * v1)
		local v8 = exp(v6 * v1)
		local v9 = (v - v2 * v6) / (-2 * v4)
		local v10 = v2 - v9
		return Target + v9 * v7 + v10 * v8, v9 * v5 * v7 + v10 * v6 * v8
	elseif Damp == 1 then
		local v11 = exp(-Freq * v1)
		local v12 = v + Freq * v2
		local v13 = (v12 * v1 + v2) * v11
		return Target + v13, v12 * v11 - v13 * Freq
	else
		local v14 = Freq * Damp
		local v15 = Freq * (1 - Damp * Damp) ^ 0.5
		local v16 = exp(-v14 * v1)
		local v17 = cos(v15 * v1)
		local v18 = sin(v15 * v1)
		local v19 = (v + v14 * v2) / v15
		return Target + v16 * (v2 * v17 + v19 * v18), -v16 * ((v2 * v14 - v19 * v15) * v17 + (v2 * v15 + v19 * v14) * v18)
	end
end
local function SpringSetTarget(p1, p2) --[[ Line: 52 | Upvalues: SpringUpdate (copy) ]]
	local v1, v2 = SpringUpdate(p1)
	p1.p = v1
	p1.v = v2
	p1.Target = p2
	p1.t = tick()
	return v1, v2
end
local function SpringAccelerate(p1, p2) --[[ Line: 59 | Upvalues: SpringUpdate (copy) ]]
	local v1, v2 = SpringUpdate(p1)
	p1.t = tick()
	p1.p = v1
	p1.v = v2 + p2
end
function t.MakeSpring() --[[ Line: 70 | Upvalues: SpringUpdate (copy), SpringSetTarget (copy), SpringAccelerate (copy) ]]
	return {
		p = nil,
		v = nil,
		Target = nil,
		Damp = nil,
		Freq = nil,
		t = tick(),
		Update = SpringUpdate,
		SetTarget = SpringSetTarget,
		Accelerate = SpringAccelerate
	}
end
t.SpringUpdate = SpringUpdate
local v1 = CFrame.new
local v2 = v1()
local cos_2 = math.cos
local sin_2 = math.sin
local pointToObjectSpace = v2.pointToObjectSpace
local function FromAxisAngle(p1) --[[ Line: 92 | Upvalues: sin_2 (copy), v1 (copy), cos_2 (copy), v2 (copy) ]]
	local x = p1.x
	local y = p1.y
	local z = p1.z
	local v12 = (x * x + y * y + z * z) ^ 0.5
	if v12 > 0.00001 then
		local v22 = sin_2(v12 * 0.5) / v12
		return v1(0, 0, 0, v22 * x, v22 * y, v22 * z, (cos_2(v12 * 0.5)))
	else
		return v2
	end
end
local function SolveIK(p1, p2, p3, p4, p5) --[[ Line: 103 | Upvalues: pointToObjectSpace (copy), cos_2 (copy), sin_2 (copy), v1 (copy) ]]
	local v12 = pointToObjectSpace(p3, p4)
	local x = v12.x
	local y = v12.y
	local z = v12.z
	local v2 = (x * x + y * y + z * z) ^ 0.5
	local v3 = x / v2
	local v4 = y / v2
	local v5 = z / v2
	local v6 = p1 + p2 < v2 and p1 + p2 or v2
	local v7 = (p2 * p2 - p1 * p1 - v6 * v6) / (2 * p1 * v6)
	local v8 = (1 - v7 * v7) ^ 0.5
	local v9 = (2 * (1 + v8 * v4 + v7 * v5)) ^ 0.5
	local v10 = v9 * 0.5
	local v11 = (v8 * v5 - v7 * v4) / v9
	local v122 = v7 * v3 / v9
	local v13 = -v8 * v3 / v9
	if p5 then
		local v14 = cos_2(p5 / 2)
		local v15 = sin_2(p5 / 2)
		v11 = v14 * v11 + v15 * (v3 * v10 - v5 * v122 + v4 * v13)
		v13 = v14 * v13 + v15 * (v5 * v10 - v4 * v11 + v3 * v122)
		v122 = v14 * v122 + v15 * (v4 * v10 + v5 * v11 - v3 * v13)
		v10 = v14 * v10 - v15 * (v3 * v11 + v4 * v122 + v5 * v13)
	end
	local v16 = (v6 * v7 + p1) / (v6 * v6 + 2 * v6 * v7 * p1 + p1 * p1) ^ 0.5
	local v17 = ((1 - v16) * 0.5) ^ 0.5
	local v18 = ((1 + v16) * 0.5) ^ 0.5
	return p3 * v1(-p1 * 2 * (v11 * v13 + v122 * v10), p1 * 2 * (v11 * v10 - v122 * v13), p1 * (2 * (v11 * v11 + v122 * v122) - 1), v17 * v11 + v18 * v10, v17 * v122 + v18 * v13, v17 * v13 - v18 * v122, v17 * v10 - v18 * v11), p3 * v1(0, 0, 0, v11, v122, v13, v10)
end
t.FromAxisAngle = FromAxisAngle
t.SolveIK = SolveIK
local Dot = Vector3.new().Dot
local min = math.min
local max = math.max
local components = CFrame.new().components
local abs = math.abs
local function SingleAABBRaw(p1, p2, p3, p4, p5) --[[ Line: 167 | Upvalues: components (copy), min (copy), max (copy) ]]
	local v1, v2, v3
	if p3 then
		v1 = p3.x
		v2 = p3.y
		v3 = p3.z
	else
		v1 = 1
		v2 = 0
		v3 = 0
	end
	local v4, v5, v6
	if p4 then
		v4 = p4.x
		v5 = p4.y
		v6 = p4.z
	else
		v5 = 1
		v6 = 0
		v4 = 0
	end
	local v7, v8, v9
	if p5 then
		v7 = p5.x
		v8 = p5.y
		v9 = p5.z
	else
		v7 = 0
		v8 = 0
		v9 = 1
	end
	local v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 = components(p1)
	local v22 = 0.5 * p2.x
	local v23 = 0.5 * p2.y
	local v24 = 0.5 * p2.z
	local v25 = v10 - v13 * v22 - v14 * v23 - v15 * v24
	local v26 = v11 - v16 * v22 - v17 * v23 - v18 * v24
	local v27 = v12 - v19 * v22 - v20 * v23 - v21 * v24
	local v28 = v10 - v13 * v22 - v14 * v23 + v15 * v24
	local v29 = v11 - v16 * v22 - v17 * v23 + v18 * v24
	local v30 = v12 - v19 * v22 - v20 * v23 + v21 * v24
	local v31 = v10 - v13 * v22 + v14 * v23 - v15 * v24
	local v32 = v11 - v16 * v22 + v17 * v23 - v18 * v24
	local v33 = v12 - v19 * v22 + v20 * v23 - v21 * v24
	local v34 = v10 - v13 * v22 + v14 * v23 + v15 * v24
	local v35 = v11 - v16 * v22 + v17 * v23 + v18 * v24
	local v36 = v12 - v19 * v22 + v20 * v23 + v21 * v24
	local v37 = v10 + v13 * v22 - v14 * v23 - v15 * v24
	local v38 = v11 + v16 * v22 - v17 * v23 - v18 * v24
	local v39 = v12 + v19 * v22 - v20 * v23 - v21 * v24
	local v40 = v10 + v13 * v22 - v14 * v23 + v15 * v24
	local v41 = v11 + v16 * v22 - v17 * v23 + v18 * v24
	local v42 = v12 + v19 * v22 - v20 * v23 + v21 * v24
	local v43 = v10 + v13 * v22 + v14 * v23 - v15 * v24
	local v44 = v11 + v16 * v22 + v17 * v23 - v18 * v24
	local v45 = v12 + v19 * v22 + v20 * v23 - v21 * v24
	local v46 = v10 + v13 * v22 + v14 * v23 + v15 * v24
	local v47 = v11 + v16 * v22 + v17 * v23 + v18 * v24
	local v48 = v12 + v19 * v22 + v20 * v23 + v21 * v24
	local v49 = v1 * v25 + v2 * v26 + v3 * v27
	local v50 = v1 * v28 + v2 * v29 + v3 * v30
	local v51 = v1 * v31 + v2 * v32 + v3 * v33
	local v52 = v1 * v34 + v2 * v35 + v3 * v36
	local v53 = v1 * v37 + v2 * v38 + v3 * v39
	local v54 = v1 * v40 + v2 * v41 + v3 * v42
	local v55 = v1 * v43 + v2 * v44 + v3 * v45
	local v56 = v1 * v46 + v2 * v47 + v3 * v48
	local v57 = v4 * v25 + v5 * v26 + v6 * v27
	local v58 = v4 * v28 + v5 * v29 + v6 * v30
	local v59 = v4 * v31 + v5 * v32 + v6 * v33
	local v60 = v4 * v34 + v5 * v35 + v6 * v36
	local v61 = v4 * v37 + v5 * v38 + v6 * v39
	local v62 = v4 * v40 + v5 * v41 + v6 * v42
	local v63 = v4 * v43 + v5 * v44 + v6 * v45
	local v64 = v4 * v46 + v5 * v47 + v6 * v48
	local v65 = v7 * v25 + v8 * v26 + v9 * v27
	local v66 = v7 * v28 + v8 * v29 + v9 * v30
	local v67 = v7 * v31 + v8 * v32 + v9 * v33
	local v68 = v7 * v34 + v8 * v35 + v9 * v36
	local v69 = v7 * v37 + v8 * v38 + v9 * v39
	local v70 = v7 * v40 + v8 * v41 + v9 * v42
	local v71 = v7 * v43 + v8 * v44 + v9 * v45
	local v72 = v7 * v46 + v8 * v47 + v9 * v48
	return min(v49, v50, v51, v52, v53, v54, v55, v56), max(v49, v50, v51, v52, v53, v54, v55, v56), min(v57, v58, v59, v60, v61, v62, v63, v64), max(v57, v58, v59, v60, v61, v62, v63, v64), min(v65, v66, v67, v68, v69, v70, v71, v72), max(v65, v66, v67, v68, v69, v70, v71, v72)
end
local function SingleAABB(p1, p2) --[[ Line: 245 | Upvalues: SingleAABBRaw (copy) ]]
	local v1, v2, v3, v4, v5, v6 = SingleAABBRaw(p1, p2, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
	return CFrame.new(0.5 * (v1 + v2), 0.5 * (v3 + v4), 0.5 * (v5 + v6), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(v2 - v1, v4 - v3, v6 - v5)
end
local function MultiAABBRaw(p1, p2, p3, p4) --[[ Line: 265 | Upvalues: SingleAABBRaw (copy) ]]
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = nil
	local v6 = nil
	for v7, v8 in next, p1 do
		local v9, v10, v11, v12, v13, v14 = SingleAABBRaw(v8.CFrame, v8.Size, p2, p3, p4)
		if not v5 or v9 < v5 then
			v5 = v9
		end
		if not v6 or v6 < v10 then
			v6 = v10
		end
		if not v1 or v11 < v1 then
			v1 = v11
		end
		if not v2 or v2 < v12 then
			v2 = v12
		end
		if not v3 or v13 < v3 then
			v3 = v13
		end
		if not v4 or v4 < v14 then
			v4 = v14
		end
	end
	return v5, v6, v1, v2, v3, v4
end
local function MultiAABB(p1) --[[ Line: 291 | Upvalues: MultiAABBRaw (copy) ]]
	local v1, v2, v3, v4, v5, v6 = MultiAABBRaw(p1, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
	return CFrame.new(0.5 * (v1 + v2), 0.5 * (v3 + v4), 0.5 * (v5 + v6), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(v2 - v1, v4 - v3, v6 - v5)
end
local function IntersectAABB(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) --[[ Line: 310 ]]
	return if p1 <= p8 and (p7 <= p2 and (p3 <= p10 and (p9 <= p4 and p5 <= p12))) then p11 <= p6 else false
end
local function IntersectPrism(p1, p2, p3, p4) --[[ Line: 313 | Upvalues: SingleAABBRaw (copy) ]]
	local v1, v2, v3, v4, v5, v6 = SingleAABBRaw(p1, p2)
	local v7, v8, v9, v10, v11, v12 = SingleAABBRaw(p3, p4)
	return if v1 <= v8 and (v7 <= v2 and (v3 <= v10 and (v9 <= v4 and v5 <= v12))) then v11 <= v6 else false
end
local function IntersectMultiPrism(p1) --[[ Line: 318 | Upvalues: SingleAABBRaw (copy) ]]
	for i = 1, #p1 do
		local v1 = p1[i]
		local v2, v3, v4, v5, v6, v7 = SingleAABBRaw(v1.CFrame, v1.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
		for j = i + 1, #p1 do
			local v8
			local v9 = p1[j]
			local v10, v11, v12, v13, v14, v15 = SingleAABBRaw(v9.CFrame, v9.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
			v8 = if v2 <= v11 and (v10 <= v3 and (v4 <= v13 and (v12 <= v5 and v6 <= v15))) then v14 <= v7 else false
			if v8 then
				return true
			end
		end
	end
	return false
end
local function IntersectRectangleRaw(p1, p2, p3, p4, p5, p6, p7, p8) --[[ Line: 335 ]]
	return if p1 <= p6 and (p5 <= p2 and p3 <= p8) then p7 <= p4 else false
end
local function ContainRectangleRaw(p1, p2, p3, p4, p5, p6, p7, p8) --[[ Line: 339 ]]
	return if p5 <= p1 and (p2 <= p6 and p7 <= p3) then p4 <= p8 else false
end
local function IsPointInRectangleRaw(p1, p2, p3, p4, p5, p6) --[[ Line: 342 ]]
	return if p3 <= p1 and (p1 <= p4 and p5 <= p2) then p2 <= p6 else false
end
local function IntersectRayPlane(p1, p2, p3, p4) --[[ Line: 350 | Upvalues: Dot (copy), abs (copy) ]]
	local v1 = Dot(p2, p4)
	if abs(v1) <= 1e-6 then
		return false
	else
		local v2 = Dot(p3 - p1, p4)
		if v2 > 0 then
			return false
		else
			return true, p1 + p2 * (v2 / v1)
		end
	end
end
local function IntersectSegSeg(p1, p2, p3, p4, p5, p6, p7, p8) --[[ Line: 365 | Upvalues: abs (copy) ]]
	local v1 = (p8 - p6) * (p3 - p1) - (p7 - p5) * (p4 - p2)
	local v2 = (p7 - p5) * (p2 - p6) - (p8 - p6) * (p1 - p5)
	local v3 = (p3 - p1) * (p2 - p6) - (p4 - p2) * (p1 - p5)
	if abs(v2) < 0.001 and (abs(v3) < 0.001 and abs(v1) < 0.001) then
		return true
	elseif abs(v1) < 0.001 then
		return false
	else
		local v4 = v2 / v1
		local v5 = v3 / v1
		return not (v4 <= 0 or (v4 > 1 or (v5 <= 0 or v5 > 1)))
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
local cos_3 = math.cos
local tan = math.tan
function t.DoesFixedConeIntersectSphere(p1, p2, p3, p4, p5, p6) --[[ Line: 399 | Upvalues: tan (copy), cos_3 (copy) ]]
	local v1 = p5 - p1
	if p3 <= p2:Dot(v1) then
		return false
	else
		local v2 = v1:Dot(p2)
		local v3 = v2 * tan(p4)
		return ((v1:Dot(v1) - v2 * v2) ^ 0.5 - v3) * cos_3(p4) <= p6
	end
end
local asin = math.asin
local atan = math.atan
local cos_4 = math.cos
local sin_3 = math.sin
function t.OffsetLookAtTarget(p1, p2, p3, p4, p5, p6) --[[ Line: 428 | Upvalues: atan (copy), asin (copy), cos_4 (copy), sin_3 (copy) ]]
	if p4 == 0 or (p5 == 0 or p6 == 0) then
		return 0, 0
	else
		local v1 = p4 * p4 + p6 * p6
		local v2 = p6 < 0 and atan(p4 / p6) or math.pi - atan(-p4 / p6)
		local v4 = v2 + (p1 * p1 < v1 and asin(p1 / v1 ^ 0.5) or asin(v1 ^ 0.5 / p1))
		local v5 = p6 * cos_4(v4) + p4 * sin_3(v4)
		local v6 = p5 * p5 + v5 * v5
		local v7 = v5 < 0 and atan(-p5 / v5) or atan(p5 / v5)
		return v4, v7 - (p2 * p2 < v6 and asin(p2 / v6 ^ 0.5) or asin(v6 ^ 0.5 / p2))
	end
end
local function TraceBounceRay(p1, p2, p3, p4) --[[ Line: 445 ]]
	local count = 0
	while true do
		count = count + 1
		local v2, v3, v4 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p1, p2 * p3), p4)
		local Magnitude = (v3 - p1).Magnitude
		p3 = p3 - Magnitude
		if v2 and v2.CanCollide then
			p2 = p2 - 2 * p2:Dot(v4) * v4
		end
		if p3 <= 0 or (Magnitude < 0.001 or count > 10) then
			return v3, p2
		end
		p1 = v3
	end
end
function t.SinkRay(p1, p2, p3, p4) --[[ Line: 468 ]]
	local count = 0
	while true do
		count = count + 1
		local v2, v3, _ = workspace:FindPartOnRayWithIgnoreList(Ray.new(p1, p2 * p3), p4)
		local Magnitude = (v3 - p1).Magnitude
		p3 = p3 - Magnitude
		if v2 then
			if v2.CanCollide then
				return v3, p2, v2
			end
			table.insert(p4, v2)
		end
		if p3 <= 0 or (Magnitude < 0.001 or count > 10) then
			return v3, p2
		end
		p1 = v3
	end
end
t.TraceBounceRay = TraceBounceRay
return t