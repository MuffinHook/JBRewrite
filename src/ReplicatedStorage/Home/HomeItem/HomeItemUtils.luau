local t = {}
local function isPointInPrism(p1, p2, p3) --[[ Line: 3 ]]
	local v1 = p2:pointToObjectSpace(p1) + p3 * 0.5
	return if v1.x >= 0 and (v1.x <= p3.x and (v1.y >= 0 and (v1.y <= p3.y and v1.z >= 0))) then v1.z <= p3.z else false
end
function t.isWithinBounds(p1, p2, p3) --[[ Line: 9 ]]
	local Size = p1.Size
	for i = -4, 4 do
		for j = -4, 4 do
			local v1 = p2 * (Vector3.new(i / 4, -1, j / 4) * Size * 0.5)
			local v2 = false
			for i2, v in ipairs(p3) do
				local v3
				local v4, v5 = v:GetPlacementPrism()
				local v6 = v5 * 1.001
				local v7 = v4:pointToObjectSpace(v1) + v6 * 0.5
				v3 = if v7.x >= 0 and (v7.x <= v6.x and (v7.y >= 0 and (v7.y <= v6.y and v7.z >= 0))) then v7.z <= v6.z else false
				if v3 then
					v2 = true
					break
				end
			end
			if not v2 then
				return false
			end
		end
	end
	return true
end
return t