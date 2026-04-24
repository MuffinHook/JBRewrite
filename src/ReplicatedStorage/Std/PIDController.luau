-- Reviewed by Claude
-- variables reassigned
local t = {}
t.__index = t
function t.new(p1, p2, p3, p4)
	local v1 = p1 or 0
	local v3 = setmetatable({}, t)
	v3.target = v1
	v3.kP = p2 or 1
	v3.kI = p3 or 0
	v3.kD = p4 or 0
	v3._lastErr = v1 * 0
	v3._integralErr = v1 * 0
	return v3
end
function t.Update(p1, p2, p3)
	local v1 = p1.target - p2
	p1._integralErr = p1._integralErr + v1 * p3
	local v2 = (v1 - p1._lastErr) / p3
	p1._lastErr = v1
	return p1.kP * v1 + p1.kI * p1._integralErr + p1.kD * v2
end
function t.SetTarget(p1, p2)
	p1.target = p2
end
function t.Reset(p1)
	p1._lastErr = p1._lastErr * 0
	p1._integralErr = p1._integralErr * 0
end
return t
