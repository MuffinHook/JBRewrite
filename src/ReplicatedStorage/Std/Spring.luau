-- Reviewed by Claude
-- variables reassigned
local exp = math.exp
local cos = math.cos
local sin = math.sin
local t = {}
t.__index = t
function t.new(p1, p2, p3, p4)
	assert(p1)
	assert(p2)
	assert(p3)
	assert(p4)
	local v2 = setmetatable({}, t)
	v2.p = p1
	v2.v = p2
	v2.Target = v2.p
	v2.Freq = p4
	v2.Damp = p3
	v2.t = tick()
	return v2
end
function t.Update(p1)
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
function t.SetTarget(p1, p2)
	local v1, v2 = p1:Update()
	p1.p = v1
	p1.v = v2
	p1.Target = p2
	p1.t = tick()
	return v1, v2
end
function t.Accelerate(p1, p2)
	local v1, v2 = p1:Update()
	p1.t = tick()
	p1.p = v1
	p1.v = v2 + p2
end
function t.ForceTarget(p1, p2)
	p1.p = p2
	p1.v = p2 * 0
	p1.Target = p1.p
	p1.t = tick()
end
function t.SetConsts(p1, p2, p3)
	local v1, v2 = p1:Update()
	p1.p = v1
	p1.v = v2
	p1.Damp = p2
	p1.Freq = p3
	p1.t = tick()
	return v1, v2
end
return t
