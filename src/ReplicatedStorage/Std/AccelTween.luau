-- Reviewed by Claude
-- variables reassigned
local moduleTable = {}
function t.new(p1)
	return setmetatable({
		_accel = p1 or 1,
		_t0 = 0,
		_y0 = 0,
		_a0 = 0,
		_t1 = 0,
		_y1 = 0,
		_a1 = 0
	}, t)
end
function t.__index(p1, p2)
	if t[p2] then
		return t[p2]
	end
	if p2 == "p" then
		local v1, _ = p1:_getstate(os.clock())
		return v1
	end
	if p2 == "v" then
		local _, v2 = p1:_getstate(os.clock())
		return v2
	end
	if p2 == "a" then
		return p1._accel
	end
	if p2 == "t" then
		return p1._y1
	end
	if p2 == "rtime" then
		local v3 = os.clock()
		return v3 < p1._t1 and p1._t1 - v3 or 0
	end
	error(("Bad index %q"):format((tostring(p2))))
end
function t.__newindex(p1, p2, p3)
	if p2 == "p" then
		p1:_setstate(p3, nil, nil, nil)
	elseif p2 == "v" then
		p1:_setstate(nil, p3, nil, nil)
	elseif p2 == "a" then
		p1:_setstate(nil, nil, p3, nil)
	elseif p2 == "t" then
		p1:_setstate(nil, nil, nil, p3)
	elseif p2 == "pt" then
		p1:_setstate(p3, 0, nil, p3)
	else
		error(("Bad index %q"):format((tostring(p2))))
	end
end
function t._getstate(p1, p2)
	if p2 < (p1._t0 + p1._t1) / 2 then
		local v1 = p2 - p1._t0
		return p1._y0 + v1 * v1 / 2 * p1._a0, v1 * p1._a0
	elseif p2 < p1._t1 then
		local v2 = p2 - p1._t1
		return p1._y1 + v2 * v2 / 2 * p1._a1, v2 * p1._a1
	else
		return p1._y1, 0
	end
end
function t._setstate(p1, p2, p3, p4, p5)
	local v1 = os.clock()
	local v2, v3 = p1:_getstate(v1)
	local v4 = p2 or v2
	local v5 = p3 or v3
	p1._accel = p4 or p1._accel
	local v7 = p5 or p1._y1
	if p1._accel * p1._accel < 1e-8 then
		p1._t0 = 0
		p1._y0 = v4
		p1._a0 = 0
		p1._t1 = (1 / 0)
		p1._y1 = v7
		p1._a1 = 0
	else
		local v8 = v7 < v4
		local v9 = v5 < 0
		local v11 = v4 + v5 * v5 / (2 * p1._accel) < v7
		if v8 and (v9 and v4 - v5 * v5 / (2 * p1._accel) < v7) then
			p1._a0 = p1._accel
			p1._t1 = v1 + ((2 * v5 * v5 + 4 * p1._accel * (v7 - v4)) ^ 0.5 - v5) / p1._accel
		elseif v8 or not v9 and (v9 or not v11) then
			p1._a0 = -p1._accel
			p1._t1 = v1 + ((2 * v5 * v5 - 4 * p1._accel * (v7 - v4)) ^ 0.5 + v5) / p1._accel
		else
			p1._a0 = p1._accel
			p1._t1 = v1 + ((2 * v5 * v5 + 4 * p1._accel * (v7 - v4)) ^ 0.5 - v5) / p1._accel
		end
		p1._t0 = v1 - v5 / p1._a0
		p1._y0 = v4 - v5 * v5 / (2 * p1._a0)
		p1._y1 = v7
		p1._a1 = -p1._a0
	end
end
return t
