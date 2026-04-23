local t = {
	clamp01 = function(p1, p2, p3) --[[ Name: clamp01 | Line: 3 ]]
		return math.clamp(p1, 0, 1), math.clamp(p2, 0, 1), math.clamp(p3, 0, 1)
	end
}
function t.saturateBy(p1, p2) --[[ Line: 6 | Upvalues: t (copy) ]]
	local v1, v2, v3 = p1:ToHSV()
	local v4, v5, v6 = t.clamp01(v1, v2 * (1 + p2), v3)
	return Color3.fromHSV(v4, v5, v6)
end
function t.saturateTo(p1, p2) --[[ Line: 12 | Upvalues: t (copy) ]]
	local v1, _, v2 = p1:ToHSV()
	local v3, v4, v5 = t.clamp01(v1, p2, v2)
	return Color3.fromHSV(v3, v4, v5)
end
function t.brightenBy(p1, p2) --[[ Line: 17 | Upvalues: t (copy) ]]
	local v1, v2, v3 = p1:ToHSV()
	local v4, v5, v6 = t.clamp01(v1, v2, v3 * (1 + p2))
	return Color3.fromHSV(v4, v5, v6)
end
function t.brightenTo(p1, p2) --[[ Line: 23 | Upvalues: t (copy) ]]
	local v1, v2, _ = p1:ToHSV()
	local v3, v4, v5 = t.clamp01(v1, v2, p2)
	return Color3.fromHSV(v3, v4, v5)
end
function t.hueBy(p1, p2) --[[ Line: 28 | Upvalues: t (copy) ]]
	local v1, v2, v3 = p1:ToHSV()
	local v4, v5, v6 = t.clamp01((v1 + p2) % 1, v2, v3)
	return Color3.fromHSV(v4, v5, v6)
end
function t.hueTo(p1, p2) --[[ Line: 34 | Upvalues: t (copy) ]]
	local _, v1, v2 = p1:ToHSV()
	local v3, v4, v5 = t.clamp01(p2, v1, v2)
	return Color3.fromHSV(v3, v4, v5)
end
function t.adjustBy(p1, p2, p3, p4) --[[ Line: 39 | Upvalues: t (copy) ]]
	local v1, v2, v3 = p1:ToHSV()
	local v4, v5, v6 = t.clamp01((v1 + p2) % 1, v2 * (1 + p3), v3 * (1 + p4))
	return Color3.fromHSV(v4, v5, v6)
end
return t