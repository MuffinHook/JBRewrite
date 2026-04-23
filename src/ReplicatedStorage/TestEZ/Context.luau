return {
	new = function(p1) --[[ Name: new | Line: 7 ]]
		local t = {}
		local t2 = {}
		t.__index = t2
		if p1 then
			for k, v in pairs(getmetatable(p1).__index) do
				t2[k] = v
			end
		end
		function t.__newindex(p1, p2, p3) --[[ Line: 18 | Upvalues: t2 (copy) ]]
			assert(t2[p2] == nil, string.format("Cannot reassign %s in context", (tostring(p2))))
			t2[p2] = p3
		end
		return setmetatable({}, t)
	end
}