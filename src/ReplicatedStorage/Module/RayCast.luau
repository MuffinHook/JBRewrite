-- Reviewed by Claude
local obj = Ray.new
local FindPartOnRay = workspace.FindPartOnRay
local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local function RayIgnoreNonCollideSpecial(p1, p2, p3, p4, p5, p6, p7, p8)
	if p6 then
		assert(not p8)
	end
	local table12 = if p5 then if type(p5) == "table" then table.clone(p5) else { p5 } else {}
	local count, v3, v4, v5, v6, v7 = 0, p1, -p2, nil, true, nil
	while p3 > 0.01 do
		if count >= 5 then
			return nil, v3, v4, v5
		end
		local var8 = obj(p1, p2 * p3)
		if v6 then
			local v9, v10, v11, v122 = FindPartOnRayWithIgnoreList(workspace, var8, table12, false, not p7)
			v3 = v10
			v7 = v9
			v4 = v11
			v5 = v122
		else
			local v13, v14, v15, v16 = FindPartOnRay(workspace, var8, table12, false, not p7)
			v3 = v14
			v7 = v13
			v4 = v15
			v5 = v16
		end
		local Magnitude = (p1 - v3).Magnitude
		if v7 then
			if p6 or not p8 and v7.CanCollide or p8 and p8(v7) then
				return v7, v3, v4, v5
			end
			table.insert(table12, v7)
		else
			p3, p1 = p3 - Magnitude, v3
		end
		count = count + 1
	end
	return v7, v3, v4, v5
end
local function RayIgnoreNonCollideWithIgnoreList(p1, p2, p3, p4, p5, p6, p7)
	return RayIgnoreNonCollideSpecial(p1, p2, p3, true, p4, p5, p6, p7)
end
return {
	RayIgnoreNonCollide = function(p1, p2, p3, p4, p5, p6, p7)
		return RayIgnoreNonCollideSpecial(p1, p2, p3, false, p4, p5, p6, p7)
	end,
	RayIgnoreNonCollideWithIgnoreList = RayIgnoreNonCollideWithIgnoreList
}
