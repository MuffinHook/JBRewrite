return function(p1, p2) --[[ Name: strict | Line: 2 ]]
	local v1 = p2 or tostring(p1)
	return setmetatable(p1, {
		__index = function(p1, p2) --[[ Name: __index | Line: 8 | Upvalues: v1 (copy) ]]
			error(("%q (%s) is not a valid member of %s"):format(tostring(p2), typeof(p2), v1), 2)
		end,
		__newindex = function(p1, p2, p3) --[[ Name: __newindex | Line: 14 | Upvalues: v1 (copy) ]]
			error(("%q (%s) is not a valid member of %s"):format(tostring(p2), typeof(p2), v1), 2)
		end
	})
end