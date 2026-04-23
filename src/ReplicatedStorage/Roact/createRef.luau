local Binding = require(script.Parent.Binding)
return function() --[[ Name: createRef | Line: 7 | Upvalues: Binding (copy) ]]
	local v1, _ = Binding.create(nil)
	local t = {}
	setmetatable(t, {
		__index = function(p1, p2) --[[ Name: __index | Line: 16 | Upvalues: v1 (copy) ]]
			if p2 == "current" then
				return v1:getValue()
			else
				return v1[p2]
			end
		end,
		__newindex = function(p1, p2, p3) --[[ Name: __newindex | Line: 23 | Upvalues: v1 (copy) ]]
			if p2 == "current" then
				error("Cannot assign to the \'current\' property of refs", 2)
			end
			v1[p2] = p3
		end,
		__tostring = function(p1) --[[ Name: __tostring | Line: 30 | Upvalues: v1 (copy) ]]
			return ("RoactRef(%s)"):format((tostring(v1:getValue())))
		end
	})
	return t
end