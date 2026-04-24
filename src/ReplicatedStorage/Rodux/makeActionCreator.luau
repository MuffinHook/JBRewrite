-- Reviewed by Claude
return function(p1, p2)
	assert(type(p1) == "string", "Bad argument #1: Expected a string name for the action creator")
	assert(type(p2) == "function", "Bad argument #2: Expected a function that creates action objects")
	return setmetatable({
 name = p1
	}, {
 __call = function(p12, ...)
 local v1 = p2(...)
 assert(type(v1) == "table", "Invalid action: An action creator must return a table")
 v1.type = p1
 return v1
 end
	})
end