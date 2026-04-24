-- Reviewed by Claude
local function CubicBezierCurve(p1, p2, p3, p4, p5)
	local v1 = 1 - p1
	return v1 * v1 * v1 * p2 + 3 * v1 * v1 * p1 * p3 + 3 * v1 * p1 * p1 * p4 + p1 * p1 * p1 * p5
end
local function DCubicBezierCurve(p1, p2, p3, p4, p5)
	local v1 = 1 - p1
	return 3 * v1 * v1 * (p3 - p2) + 6 * v1 * p1 * (p4 - p3) + 3 * p1 * p1 * (p5 - p4)
end
local function ApproximateVectorCubicBezierCurveLength(p1, p2, p3, p4, p5)
	local sum = 0
	for i = 1, p1 do
		local v1 = (i - 1) / p1
		local v2 = 1 - v1
		sum = sum + (3 * v2 * v2 * (p3 - p2) + 6 * v2 * v1 * (p4 - p3) + 3 * v1 * v1 * (p5 - p4)).Magnitude / p1
	end
	return sum
end
local t = {}
t.__index = t
function t.new()
	local v2 = setmetatable({}, t)
	v2.Points = nil
	v2.NumPoints = nil
	v2.LastIndex = nil
	v2.OffsetStart = 0
	v2.OffsetEnd = 0
	v2.t = 0
	v2.lengthCache = {}
	return v2
end
function t.SetNodeOffset(p1, p2, p3)
	assert(p2)
	assert(p3)
	p1.OffsetStart = p2
	p1.OffsetEnd = p3
end
function t.SetPoints(p1, p2)
	p1.Points = p2
	p1.NumPoints = #p2
	p1:_recomputeLengthCache()
end
function t._recomputeLengthCache(p1)
	for i = 1, p1.NumPoints do
		local v1 = p1:GetPoint(i)
		local v2 = p1:GetPoint(i + 1)
		local Magnitude = (v2 - v1).Magnitude
		local v3 = v1 + (v2 - p1:GetPoint(i - 1)).Unit * Magnitude / 3
		p1.lengthCache[i] = ApproximateVectorCubicBezierCurveLength(10000, v1, v3, v2 - (p1:GetPoint(i + 2) - v1).Unit * Magnitude / 3, v2)
	end
end
function t.GetPoint(p1, p2)
	return p1.Points[(p2 - 1) % p1.NumPoints + 1]
end
function t.ApproximateLength(p1, p2)
	local sum = 0
	for i = p1.OffsetStart + 1, p1.NumPoints - p1.OffsetEnd do
		local v1 = p1:GetPoint(i)
		local v2 = p1:GetPoint(i + 1)
		local Magnitude = (v2 - v1).Magnitude
		sum = sum + ApproximateVectorCubicBezierCurveLength(p2, v1, v1 + (v2 - p1:GetPoint(i - 1)).Unit * Magnitude / 3, v2 - (p1:GetPoint(i + 2) - v1).Unit * Magnitude / 3, v2)
	end
	return sum
end
function t.Step(p1, p2)
	local t = p1.t
	local v1 = t * (p1.NumPoints - p1.OffsetStart - p1.OffsetEnd) + p1.OffsetStart
	local v2 = v1 % 1
	local v3 = math.floor(v1) + 1
	local v4, v5, v6, v7
	if p1.LastIndex == v3 then
		v4 = p1._p0
		v5 = p1._c0
		v6 = p1._c1
		v7 = p1._p1
	else
		local v8 = p1:GetPoint(v3)
		local v9 = p1:GetPoint(v3 + 1)
		local Magnitude = (v9 - v8).Magnitude
		v5 = v8 + (v9 - p1:GetPoint(v3 - 1)).Unit * Magnitude / 3
		v6 = v9 - (p1:GetPoint(v3 + 2) - v8).Unit * Magnitude / 3
		p1._p0 = v8
		p1._c0 = v5
		p1._c1 = v6
		p1._p1 = v9
		v4 = v8
		v7 = v9
	end
	p1.LastIndex = v3
	local v10 = 1 - v2
	local v11 = 3 * v10 * v10 * (v5 - v4) + 6 * v10 * v2 * (v6 - v5) + 3 * v2 * v2 * (v7 - v6)
	local Magnitude = v11.Magnitude
	local v12 = 1 - v2
	if Magnitude > 0 then
		p1.t = t + p2 / Magnitude / (p1.NumPoints - p1.OffsetStart - p1.OffsetEnd)
	end
	return v12 * v12 * v12 * v4 + 3 * v12 * v12 * v2 * v5 + 3 * v12 * v2 * v2 * v6 + v2 * v2 * v2 * v7, v11
end
function t.GetWorldPositionAt(p1, p2)
	local count = 1 + p1.OffsetStart
	while true do
		local v1, v2
		local v3 = p1:GetPoint(count)
		local v4 = p1:GetPoint(count + 1)
		local Magnitude = (v4 - v3).Magnitude
		local v5 = v3 + (v4 - p1:GetPoint(count - 1)).Unit * Magnitude / 3
		local v6 = v4 - (p1:GetPoint(count + 2) - v3).Unit * Magnitude / 3
		local v7 = p1.lengthCache[(count - 1) % p1.NumPoints + 1]
		if v7 then
			v1 = v3
			v2 = v4
		else
			v7, v1, v2 = ApproximateVectorCubicBezierCurveLength(10000, v3, v5, v6, v4), v3, v4
		end
		if p2 < v7 then
			local v9 = p2 / v7
			local v10 = 1 - v9
			local v11 = 1 - v9
			return v10 * v10 * v10 * v1 + 3 * v10 * v10 * v9 * v5 + 3 * v10 * v9 * v9 * v6 + v9 * v9 * v9 * v2, 3 * v11 * v11 * (v5 - v1) + 6 * v11 * v9 * (v6 - v5) + 3 * v9 * v9 * (v2 - v6)
		end
		count = count + 1
		p2 = p2 - v7
	end
end
function t.Reset(p1)
	p1.t = 0
	p1._p0 = nil
	p1._c0 = nil
	p1._c1 = nil
	p1._p1 = nil
	p1.LastIndex = nil
end
return t
