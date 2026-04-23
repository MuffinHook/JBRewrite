return function(p1) --[[ Name: combineReducers | Line: 4 ]]
	return function(p12, p2) --[[ Line: 5 | Upvalues: p1 (copy) ]]
		if p12 == nil then
			p12 = {}
		end
		local t = {}
		for k, v in pairs(p1) do
			t[k] = v(p12[k], p2)
		end
		return t
	end
end