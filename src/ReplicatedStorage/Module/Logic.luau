-- Reviewed by Claude
local t = {}
local exp = math.exp
local cos = math.cos
local sin = math.sin
local function SpringUpdate(p1)
	local cframe = tick() - p1.t
	local Freq = p1.Freq
	local Damp = p1.Damp
	local v = p1.v
	local Target = p1.Target
	local v2 = p1.p - Target
	if Damp > 1 then
		local var3 = -Freq * Damp
		local var4 = Freq * (Damp * Damp - 1) ^ 0.5
		local var5 = var3 - var4
		local var6 = var3 + var4
		local var7 = exp(var5 * cframe)
		local var8 = exp(var6 * cframe)
		local var9 = (v - v2 * var6) / (-2 * var4)
		local var10 = v2 - var9
		return Target + var9 * var7 + var10 * var8, var9 * var5 * var7 + var10 * var6 * var8
	elseif Damp == 1 then
		local var11 = exp(-Freq * cframe)
		local var12 = v + Freq * v2
		local var13 = (var12 * cframe + v2) * var11
		return Target + var13, var12 * var11 - var13 * Freq
	else
		local var14 = Freq * Damp
		local var15 = Freq * (1 - Damp * Damp) ^ 0.5
		local var16 = exp(-var14 * cframe)
		local var17 = cos(var15 * cframe)
		local var18 = sin(var15 * cframe)
		local var19 = (v + var14 * v2) / var15
		return Target + var16 * (v2 * var17 + var19 * var18), -var16 * ((v2 * var14 - var19 * var15) * var17 + (v2 * var15 + var19 * var14) * var18)
	end
end
local function SpringSetTarget(p1, p2)
	local cframe, v2 = SpringUpdate(p1)
	p1.p = cframe
	p1.v = v2
	p1.Target = p2
	p1.t = tick()
	return cframe, v2
end
local function SpringAccelerate(p1, p2)
	local cframe, v2 = SpringUpdate(p1)
	p1.t = tick()
	p1.p = cframe
	p1.v = v2 + p2
end
function t.MakeSpring()
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
local cframe = CFrame.new
local v2 = cframe()
local cos_2 = math.cos
local sin_2 = math.sin
local pointToObjectSpace = v2.pointToObjectSpace
local function FromAxisAngle(p1)
	local x = p1.x
	local y = p1.y
	local z = p1.z
	local var12 = (x * x + y * y + z * z) ^ 0.5
	if var12 > 0.00001 then
		local var22 = sin_2(var12 * 0.5) / var12
		return cframe(0, 0, 0, var22 * x, var22 * y, var22 * z, (cos_2(var12 * 0.5)))
	else
		return v2
	end
end
local function SolveIK(p1, p2, p3, p4, p5)
	local var12 = pointToObjectSpace(p3, p4)
	local x = var12.x
	local y = var12.y
	local z = var12.z
	local v2 = (x * x + y * y + z * z) ^ 0.5
	local var3 = x / v2
	local var4 = y / v2
	local var5 = z / v2
	local var6 = p1 + p2 < v2 and p1 + p2 or v2
	local var7 = (p2 * p2 - p1 * p1 - var6 * var6) / (2 * p1 * var6)
	local var8 = (1 - var7 * var7) ^ 0.5
	local var9 = (2 * (1 + var8 * var4 + var7 * var5)) ^ 0.5
	local var10 = var9 * 0.5
	local var11 = (var8 * var5 - var7 * var4) / var9
	local var122 = var7 * var3 / var9
	local var13 = -var8 * var3 / var9
	if p5 then
		local var14 = cos_2(p5 / 2)
		local var15 = sin_2(p5 / 2)
		var11 = var14 * var11 + var15 * (var3 * var10 - var5 * var122 + var4 * var13)
		var13 = var14 * var13 + var15 * (var5 * var10 - var4 * var11 + var3 * var122)
		var122 = var14 * var122 + var15 * (var4 * var10 + var5 * var11 - var3 * var13)
		var10 = var14 * var10 - var15 * (var3 * var11 + var4 * var122 + var5 * var13)
	end
	local var16 = (var6 * var7 + p1) / (var6 * var6 + 2 * var6 * var7 * p1 + p1 * p1) ^ 0.5
	local var17 = ((1 - var16) * 0.5) ^ 0.5
	local var18 = ((1 + var16) * 0.5) ^ 0.5
	return p3 * cframe(-p1 * 2 * (var11 * var13 + var122 * var10), p1 * 2 * (var11 * var10 - var122 * var13), p1 * (2 * (var11 * var11 + var122 * var122) - 1), var17 * var11 + var18 * var10, var17 * var122 + var18 * var13, var17 * var13 - var18 * var122, var17 * var10 - var18 * var11), p3 * cframe(0, 0, 0, var11, var122, var13, var10)
end
t.FromAxisAngle = FromAxisAngle
t.SolveIK = SolveIK
local Dot = Vector3.new().Dot
local min = math.min
local max = math.max
local components = CFrame.new().components
local abs = math.abs
local function SingleAABBRaw(p1, p2, p3, p4, p5)
	local cframe, v2, var3
	if p3 then
		cframe = p3.x
		v2 = p3.y
		var3 = p3.z
	else
		cframe = 1
		v2 = 0
		var3 = 0
	end
	local var4, var5, var6
	if p4 then
		var4 = p4.x
		var5 = p4.y
		var6 = p4.z
	else
		var5 = 1
		var6 = 0
		var4 = 0
	end
	local var7, var8, var9
	if p5 then
		var7 = p5.x
		var8 = p5.y
		var9 = p5.z
	else
		var7 = 0
		var8 = 0
		var9 = 1
	end
	local var10, var11, var12, var13, var14, var15, var16, var17, var18, var19, v20, v21 = components(p1)
	local var22 = 0.5 * p2.x
	local var23 = 0.5 * p2.y
	local var24 = 0.5 * p2.z
	local var25 = var10 - var13 * var22 - var14 * var23 - var15 * var24
	local var26 = var11 - var16 * var22 - var17 * var23 - var18 * var24
	local var27 = var12 - var19 * var22 - v20 * var23 - v21 * var24
	local var28 = var10 - var13 * var22 - var14 * var23 + var15 * var24
	local var29 = var11 - var16 * var22 - var17 * var23 + var18 * var24
	local var30 = var12 - var19 * var22 - v20 * var23 + v21 * var24
	local var31 = var10 - var13 * var22 + var14 * var23 - var15 * var24
	local var32 = var11 - var16 * var22 + var17 * var23 - var18 * var24
	local var33 = var12 - var19 * var22 + v20 * var23 - v21 * var24
	local var34 = var10 - var13 * var22 + var14 * var23 + var15 * var24
	local var35 = var11 - var16 * var22 + var17 * var23 + var18 * var24
	local var36 = var12 - var19 * var22 + v20 * var23 + v21 * var24
	local var37 = var10 + var13 * var22 - var14 * var23 - var15 * var24
	local var38 = var11 + var16 * var22 - var17 * var23 - var18 * var24
	local var39 = var12 + var19 * var22 - v20 * var23 - v21 * var24
	local var40 = var10 + var13 * var22 - var14 * var23 + var15 * var24
	local var41 = var11 + var16 * var22 - var17 * var23 + var18 * var24
	local var42 = var12 + var19 * var22 - v20 * var23 + v21 * var24
	local var43 = var10 + var13 * var22 + var14 * var23 - var15 * var24
	local var44 = var11 + var16 * var22 + var17 * var23 - var18 * var24
	local var45 = var12 + var19 * var22 + v20 * var23 - v21 * var24
	local var46 = var10 + var13 * var22 + var14 * var23 + var15 * var24
	local var47 = var11 + var16 * var22 + var17 * var23 + var18 * var24
	local var48 = var12 + var19 * var22 + v20 * var23 + v21 * var24
	local var49 = cframe * var25 + v2 * var26 + var3 * var27
	local var50 = cframe * var28 + v2 * var29 + var3 * var30
	local var51 = cframe * var31 + v2 * var32 + var3 * var33
	local var52 = cframe * var34 + v2 * var35 + var3 * var36
	local var53 = cframe * var37 + v2 * var38 + var3 * var39
	local var54 = cframe * var40 + v2 * var41 + var3 * var42
	local var55 = cframe * var43 + v2 * var44 + var3 * var45
	local var56 = cframe * var46 + v2 * var47 + var3 * var48
	local var57 = var4 * var25 + var5 * var26 + var6 * var27
	local var58 = var4 * var28 + var5 * var29 + var6 * var30
	local var59 = var4 * var31 + var5 * var32 + var6 * var33
	local var60 = var4 * var34 + var5 * var35 + var6 * var36
	local var61 = var4 * var37 + var5 * var38 + var6 * var39
	local var62 = var4 * var40 + var5 * var41 + var6 * var42
	local var63 = var4 * var43 + var5 * var44 + var6 * var45
	local var64 = var4 * var46 + var5 * var47 + var6 * var48
	local var65 = var7 * var25 + var8 * var26 + var9 * var27
	local var66 = var7 * var28 + var8 * var29 + var9 * var30
	local var67 = var7 * var31 + var8 * var32 + var9 * var33
	local var68 = var7 * var34 + var8 * var35 + var9 * var36
	local var69 = var7 * var37 + var8 * var38 + var9 * var39
	local var70 = var7 * var40 + var8 * var41 + var9 * var42
	local var71 = var7 * var43 + var8 * var44 + var9 * var45
	local var72 = var7 * var46 + var8 * var47 + var9 * var48
	return min(var49, var50, var51, var52, var53, var54, var55, var56), max(var49, var50, var51, var52, var53, var54, var55, var56), min(var57, var58, var59, var60, var61, var62, var63, var64), max(var57, var58, var59, var60, var61, var62, var63, var64), min(var65, var66, var67, var68, var69, var70, var71, var72), max(var65, var66, var67, var68, var69, var70, var71, var72)
end
local function SingleAABB(p1, p2)
	local cframe, v2, var3, var4, var5, var6 = SingleAABBRaw(p1, p2, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
	return CFrame.new(0.5 * (cframe + v2), 0.5 * (var3 + var4), 0.5 * (var5 + var6), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(v2 - cframe, var4 - var3, var6 - var5)
end
local function MultiAABBRaw(p1, p2, p3, p4)
	local cframe = nil
	local v2 = nil
	local var3 = nil
	local var4 = nil
	local var5 = nil
	local var6 = nil
	for var7, var8 in next, p1 do
		local var9, var10, var11, var12, var13, var14 = SingleAABBRaw(var8.CFrame, var8.Size, p2, p3, p4)
		if not var5 or var9 < var5 then
			var5 = var9
		end
		if not var6 or var6 < var10 then
			var6 = var10
		end
		if not cframe or var11 < cframe then
			cframe = var11
		end
		if not v2 or v2 < var12 then
			v2 = var12
		end
		if not var3 or var13 < var3 then
			var3 = var13
		end
		if not var4 or var4 < var14 then
			var4 = var14
		end
	end
	return var5, var6, cframe, v2, var3, var4
end
local function MultiAABB(p1)
	local cframe, v2, var3, var4, var5, var6 = MultiAABBRaw(p1, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
	return CFrame.new(0.5 * (cframe + v2), 0.5 * (var3 + var4), 0.5 * (var5 + var6), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(v2 - cframe, var4 - var3, var6 - var5)
end
local function IntersectAABB(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
	return if p1 <= p8 and (p7 <= p2 and (p3 <= p10 and (p9 <= p4 and p5 <= p12))) then p11 <= p6 else false
end
local function IntersectPrism(p1, p2, p3, p4)
	local cframe, v2, var3, var4, var5, var6 = SingleAABBRaw(p1, p2)
	local var7, var8, var9, var10, var11, var12 = SingleAABBRaw(p3, p4)
	return if cframe <= var8 and (var7 <= v2 and (var3 <= var10 and (var9 <= var4 and var5 <= var12))) then var11 <= var6 else false
end
local function IntersectMultiPrism(p1)
	for i = 1, #p1 do
		local cframe = p1[i]
		local v2, var3, var4, var5, var6, var7 = SingleAABBRaw(cframe.CFrame, cframe.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
		for j = i + 1, #p1 do
			local var8
			local var9 = p1[j]
			local var10, var11, var12, var13, var14, var15 = SingleAABBRaw(var9.CFrame, var9.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
			var8 = if v2 <= var11 and (var10 <= var3 and (var4 <= var13 and (var12 <= var5 and var6 <= var15))) then var14 <= var7 else false
			if var8 then
				return true
			end
		end
	end
	return false
end
local function IntersectRectangleRaw(p1, p2, p3, p4, p5, p6, p7, p8)
	return if p1 <= p6 and (p5 <= p2 and p3 <= p8) then p7 <= p4 else false
end
local function ContainRectangleRaw(p1, p2, p3, p4, p5, p6, p7, p8)
	return if p5 <= p1 and (p2 <= p6 and p7 <= p3) then p4 <= p8 else false
end
local function IsPointInRectangleRaw(p1, p2, p3, p4, p5, p6)
	return if p3 <= p1 and (p1 <= p4 and p5 <= p2) then p2 <= p6 else false
end
local function IntersectRayPlane(p1, p2, p3, p4)
	local cframe = Dot(p2, p4)
	if abs(cframe) <= 1e-6 then
		return false
	else
		local v2 = Dot(p3 - p1, p4)
		if v2 > 0 then
			return false
		else
			return true, p1 + p2 * (v2 / cframe)
		end
	end
end
local function IntersectSegSeg(p1, p2, p3, p4, p5, p6, p7, p8)
	local cframe = (p8 - p6) * (p3 - p1) - (p7 - p5) * (p4 - p2)
	local v2 = (p7 - p5) * (p2 - p6) - (p8 - p6) * (p1 - p5)
	local var3 = (p3 - p1) * (p2 - p6) - (p4 - p2) * (p1 - p5)
	if abs(v2) < 0.001 and (abs(var3) < 0.001 and abs(cframe) < 0.001) then
		return true
	elseif abs(cframe) < 0.001 then
		return false
	else
		local var4 = v2 / cframe
		local var5 = var3 / cframe
		return not (var4 <= 0 or (var4 > 1 or (var5 <= 0 or var5 > 1)))
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
function t.DoesFixedConeIntersectSphere(p1, p2, p3, p4, p5, p6)
	local cframe = p5 - p1
	if p3 <= p2:Dot(cframe) then
		return false
	else
		local v2 = cframe:Dot(p2)
		local var3 = v2 * tan(p4)
		return ((cframe:Dot(cframe) - v2 * v2) ^ 0.5 - var3) * cos_3(p4) <= p6
	end
end
local asin = math.asin
local atan = math.atan
local cos_4 = math.cos
local sin_3 = math.sin
function t.OffsetLookAtTarget(p1, p2, p3, p4, p5, p6)
	if p4 == 0 or (p5 == 0 or p6 == 0) then
		return 0, 0
	else
		local cframe = p4 * p4 + p6 * p6
		local v2 = p6 < 0 and atan(p4 / p6) or math.pi - atan(-p4 / p6)
		local var4 = v2 + (p1 * p1 < cframe and asin(p1 / cframe ^ 0.5) or asin(cframe ^ 0.5 / p1))
		local var5 = p6 * cos_4(var4) + p4 * sin_3(var4)
		local var6 = p5 * p5 + var5 * var5
		local var7 = var5 < 0 and atan(-p5 / var5) or atan(p5 / var5)
		return var4, var7 - (p2 * p2 < var6 and asin(p2 / var6 ^ 0.5) or asin(var6 ^ 0.5 / p2))
	end
end
local function TraceBounceRay(p1, p2, p3, p4)
	local count = 0
	while true do
		count = count + 1
		local v2, var3, var4 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p1, p2 * p3), p4)
		local Magnitude = (var3 - p1).Magnitude
		p3 = p3 - Magnitude
		if v2 and v2.CanCollide then
			p2 = p2 - 2 * p2:Dot(var4) * var4
		end
		if p3 <= 0 or (Magnitude < 0.001 or count > 10) then
			return var3, p2
		end
		p1 = var3
	end
end
function t.SinkRay(p1, p2, p3, p4)
	local count = 0
	while true do
		count = count + 1
		local v2, var3, _ = workspace:FindPartOnRayWithIgnoreList(Ray.new(p1, p2 * p3), p4)
		local Magnitude = (var3 - p1).Magnitude
		p3 = p3 - Magnitude
		if v2 then
			if v2.CanCollide then
				return var3, p2, v2
			end
			table.insert(p4, v2)
		end
		if p3 <= 0 or (Magnitude < 0.001 or count > 10) then
			return var3, p2
		end
		p1 = var3
	end
end
t.TraceBounceRay = TraceBounceRay
return t
