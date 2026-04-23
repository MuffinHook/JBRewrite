return function(p1, p2) --[[ Name: makeActionCreator | Line: 4 ]]
	assert(type(p1) == "string", "Bad argument #1: Expected a string name for the action creator")
	assert(type(p2) == "function", "Bad argument #2: Expected a function that creates action objects")
	return setmetatable({
		name = p1
	}, {
		__call = function(p12, ...) --[[ Name: __call | Line: 12 | Upvalues: p2 (copy), p1 (copy) ]]
			local v1 = p2(...)
			assert(type(v1) == "table", "Invalid action: An action creator must return a table")
			v1.type = p1
			return v1
		end
	})
end