-- Reviewed by Claude
return {
	computeRail = function(p1, p2)
		local t = {
			[p1] = true,
			[p2] = true
		}
		local list = { p1, p2 }
		while true do
			local v1, v2
			local v3 = p2:FindFirstChild("_front").Value
			local v4 = p2:FindFirstChild("_back").Value
			v1 = p1 == v3
			v2 = if v1 and v4 then v4 else v3
			if t[v2] then
				local sum = 0
				local t2 = {}
				for i, v in ipairs(list) do
					local Z = v.Size.Z
					table.insert(t2, Z)
					sum = sum + Z
				end
				local t3 = {}
				for i = 1, #list do
					local v5
					local v6 = list[i]
					local v7 = list[(i - 1 + 1) % #list + 1]
					local v8 = v6:FindFirstChild("_front").Value
					v5 = if v7 == v8 then v6.CFrame.LookVector elseif v7 == v6:FindFirstChild("_back").Value then -v6.CFrame.LookVector else Vector3.new(0, 1, 0)
					table.insert(t3, v5)
				end
				return {
					listSegment = list,
					lengthCache = t2,
					totalLength = sum,
					directionCache = t3
				}
			end
			t[v2] = true
			table.insert(list, v2)
			p2, p1 = v2, p2
		end
	end,
	calculateSegment = function(p1, p2)
		local v1 = p2 % p1.totalLength
		for i = 1, #p1.listSegment do
			local v2 = v1 - p1.lengthCache[i]
			if v2 < 0 then
				return i, v1
			end
			v1 = v2
		end
	end,
	calculatePosition = function(p1, p2, p3)
		local v1 = p1.listSegment[p2]
		return v1.Position + p1.directionCache[p2] * (-v1.Size.Z * 0.5 + p3)
	end
}
