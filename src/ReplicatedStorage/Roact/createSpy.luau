-- Reviewed by Claude
local assertDeepEqual = require(script.Parent.assertDeepEqual)
return function(p1)
	local t = {
 callCount = 0,
 values = {},
 valuesLength = 0
	}
	function t.value(...)
 t.callCount = t.callCount + 1
 t.values = { ... }
 t.valuesLength = select("#", ...)
 if p1 == nil then
 return nil
 else
 return p1(...)
 end
	end
	function t.assertCalledWith(p1, ...)
 local v1 = select("#", ...)
 if t.valuesLength ~= v1 then
 error(("Expected %d arguments, but was called with %d arguments"):format(t.valuesLength, v1), 2)
 end
 for i = 1, v1 do
 assert(select(i, ...) == t.values[i], "value differs")
 end
	end
	function t.assertCalledWithDeepEqual(p1, ...)
 local v1 = select("#", ...)
 if t.valuesLength ~= v1 then
 error(("Expected %d arguments, but was called with %d arguments"):format(t.valuesLength, v1), 2)
 end
 for i = 1, v1 do
 assertDeepEqual(t.values[i], (select(i, ...)))
 end
	end
	function t.captureValues(p1, ...)
 local v1 = select("#", ...)
 local t2 = {}
 assert(t.valuesLength == v1, "length of expected values differs from stored values")
 for i = 1, v1 do
 t2[select(i, ...)] = t.values[i]
 end
 return t2
	end
	setmetatable(t, {
 __index = function(p1, p2)
 error(("%q is not a valid member of spy"):format(p2))
 end
	})
	return t
end