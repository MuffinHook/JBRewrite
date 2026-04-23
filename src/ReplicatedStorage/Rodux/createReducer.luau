return function(p1, p2) --[[ Line: 1 ]]
	return function(p12, p22) --[[ Line: 2 | Upvalues: p1 (copy), p2 (copy) ]]
		if p12 == nil then
			p12 = p1
		end
		local v1 = p2[p22.type]
		if v1 then
			return v1(p12, p22)
		else
			return p12
		end
	end
end