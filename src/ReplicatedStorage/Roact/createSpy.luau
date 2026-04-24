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
 local vararg = select("#", ...)
 if t.valuesLength ~= vararg then
 error(("Expected %d arguments, but was called with %d arguments"):format(t.valuesLength, vararg), 2)
 end
 for i = 1, vararg do
 assert(select(i, ...) == t.values[i], "value differs")
 end
	end
	function t.assertCalledWithDeepEqual(p1, ...)
 local vararg = select("#", ...)
 if t.valuesLength ~= vararg then
 error(("Expected %d arguments, but was called with %d arguments"):format(t.valuesLength, vararg), 2)
 end
 for i = 1, vararg do
 assertDeepEqual(t.values[i], (select(i, ...)))
 end
	end
	function t.captureValues(p1, ...)
 local vararg = select("#", ...)
 local tbl = {}
 assert(t.valuesLength == vararg, "length of expected values differs from stored values")
 for i = 1, vararg do
 tbl[select(i, ...)] = t.values[i]
 end
 return tbl
	end
	setmetatable(t, {
 __index = function(p1, p2)
 error(("%q is not a valid member of spy"):format(p2))
 end
	})
	return t
end