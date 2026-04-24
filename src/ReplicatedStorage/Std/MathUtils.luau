-- Reviewed by Claude
-- variables reassigned
local t = {
	regulaFalsiWithEndpoints = function(p1, p2, p3, p4, p5)
		local v1 = p4 or 1e-15
		local v3 = nil
		local v4 = 0
		local v5 = p1(p2)
		local v6 = p1(p3)
		if v5 == 0 then
			return p2
		end
		if v6 == 0 then
			return p3
		end
		if p1(p2) * p1(p3) > 0 then
			error("Initial guesses have the same sign, invalid a and b")
		end
		for i = 1, p5 or 1000 do
			v3 = (v5 * p3 - v6 * p2) / (v5 - v6)
			if math.abs(p3 - p2) < v1 * math.abs(p3 + p2) then
				break
			end
			local v7 = p1(v3)
			if v7 * v6 > 0 then
				if v4 == -1 then
					v5 = v5 / 2
				end
				v4 = -1
				p3 = v3
				v6 = v7
			else
				if not (v5 * v7 > 0) then
					break
				end
				if v4 == 1 then
					v6 = v6 / 2
				end
				v4 = 1
				v5 = v7
				p2 = v3
			end
		end
		return v3
	end
}
function t.regulaFalsi(p1, p2, p3)
	local v1 = 0
	local v2 = 1
	for i = 1, 20 do
		if p1(v1) * p1(v2) <= 0 then
			break
		end
		if v1 == 0 then
			v1 = -1
		else
			v1 = v1 * 2
			v2 = v2 * 2
		end
	end
	if p1(v1) * p1(v2) > 0 then
		error("Could not find valid endpoints with opposite signs")
	end
	return t.regulaFalsiWithEndpoints(p1, v1, v2, p2, p3)
end
return t
