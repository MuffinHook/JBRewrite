function cubicBezier(p1, p2, p3, p4, p5) --[[ Line: 1 ]]
	return (1 - p1) ^ 3 * p2 + 3 * (1 - p1) ^ 2 * p1 * p3 + 3 * (1 - p1) * p1 ^ 2 * p4 + p1 ^ 3 * p5
end
function cubicBezierDerivative(p1, p2, p3, p4, p5) --[[ Line: 5 ]]
	return 3 * (1 - p1) ^ 2 * (p3 - p2) + 6 * p1 * (1 - p1) * (p4 - p3) + 3 * p1 ^ 2 * (p5 - p4)
end
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 12 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	v2.keyframes = p1 and { unpack(p1) } or {}
	return v2
end
function t.UpdateKeyframes(p1, p2) --[[ Line: 19 ]]
	table.clear(p1.keyframes)
	table.move(p2, 1, #p2, 1, p1.keyframes)
end
function t.CalculateSegmentAt(p1, p2) --[[ Line: 24 ]]
	local v1 = p2 * (#p1.keyframes - 1)
	local v2 = math.floor(v1) + 1
	local v3 = v1 % 1
	if v2 < 1 then
		v3 = 0
		v2 = 1
	elseif #p1.keyframes <= v2 then
		v2 = #p1.keyframes - 1
		v3 = 1
	end
	return v3, p1.keyframes[v2], p1.keyframes[v2 + 1]
end
function t.CalculateSpeedAt(p1, p2) --[[ Line: 41 ]]
	local v1, v2, v3 = p1:CalculateSegmentAt(p2)
	local pos = v2.pos
	local v4 = v2.pos + v2.right
	local v5 = v3.pos + v3.left
	local pos_2 = v3.pos
	local v6 = pos - v4
	local v7 = pos_2 - v5
	local v8 = pos_2.X - pos.X
	local v9 = math.abs(v6.X)
	local v10 = math.abs(v7.X)
	if v8 < v9 then
		v4 = pos - v8 / v9 * v6
	end
	if v8 < v10 then
		v5 = pos_2 - v8 / v10 * v7
	end
	local v11 = cubicBezierDerivative(v1, pos, v4, v5, pos_2)
	return v11.Y / math.sqrt(v11.X ^ 2 + v11.Y ^ 2)
end
function t.CalculatePositionAt(p1, p2) --[[ Line: 74 ]]
	local v1, v2, v3 = p1:CalculateSegmentAt(p2)
	local pos = v2.pos
	local v4 = v2.pos + v2.right
	local v5 = v3.pos + v3.left
	local pos_2 = v3.pos
	local v6 = pos - v4
	local v7 = pos_2 - v5
	local v8 = pos_2.X - pos.X
	local v9 = math.abs(v6.X)
	local v10 = math.abs(v7.X)
	if v8 < v9 then
		v4 = pos - v8 / v9 * v6
	end
	if v8 < v10 then
		v5 = pos_2 - v8 / v10 * v7
	end
	return cubicBezier(v1, pos, v4, v5, pos_2)
end
function t.CalculateValueAt(p1, p2) --[[ Line: 106 ]]
	local v1 = 0
	local v2 = 1
	while v1 + 0.00001 < v2 do
		local v3 = (v1 + v2) / 2
		if p2 < p1:CalculatePositionAt(v3).X then
			v2 = v3
		else
			v1 = v3
		end
	end
	local v4 = (v1 + v2) / 2
	return p1:CalculatePositionAt(v4).Y, v4
end
return t