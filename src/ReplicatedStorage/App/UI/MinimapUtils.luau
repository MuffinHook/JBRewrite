local t = {
	computeOffsetXY = function(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ Name: computeOffsetXY | Line: 3 ]]
		if not p2 then
			p2 = Vector2.new(512, 512)
		end
		local v2 = p9 * p2.Y / p7
		local v3 = p2.X * v2
		local v4 = p2.Y * v2
		local v7 = p7 * v2 - v3 - (1 - v2) * p2.X
		local v8 = p8 * v2 - v4 - (1 - v2) * p2.Y
		local v9 = p7 * v2 * (0.5 + (p1.X - p5) / p3) - v3 * 0.5 - 0.5 * (1 - v2) * p2.X
		local v10 = p8 * v2 * (0.5 + (p1.Z - p6) / p4) - v4 * 0.5 - 0.5 * (1 - v2) * p2.Y
		if v7 < v9 then
			v9 = v7
		end
		if v9 < 0 then
			v9 = 0
		end
		if v8 < v10 then
			v10 = v8
		end
		if v10 < 0 then
			v10 = 0
		end
		return v9 < 0 or (v10 < 0 or v7 < v9) or v8 < v10, v9, v10, v2
	end
}
function t.computeWorldXY(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) --[[ Line: 56 | Upvalues: t (copy) ]]
	local _, v1, v2, v3 = t.computeOffsetXY(p3, p4, p5, p6, p7, p8, p9, p10, p11)
	return ((p1 + v1) / p9 / v3 - 0.5) * p5 + p7, ((p2 + v2) / p10 / v3 - 0.5) * p6 + p8
end
function t.worldToScale(p1, p2, p3, p4, p5, p6) --[[ Line: 84 ]]
	return UDim2.fromScale(0.5 + (p1 - p3) / p5, 0.5 + (p2 - p4) / p6)
end
function t.relativeWorldToScale(p1, p2, p3, p4) --[[ Line: 87 ]]
	return UDim2.fromScale(p1 / p3, p2 / p4)
end
return t