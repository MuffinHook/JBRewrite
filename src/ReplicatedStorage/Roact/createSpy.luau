-- Reviewed by Claude
-- variables reassigned
local assertDeepEqual = require(script.Parent.assertDeepEqual)
return function(self)
	local tbl = {
 callCount = 0,
 values = {},
 valuesLength = 0
	}
	function tbl.value(...)
 tbl.callCount = tbl.callCount + 1
 tbl.values = { ... }
 tbl.valuesLength = select("#", ...)
 if self == nil then
 return nil
 else
 return self(...)
 end
	end
	function tbl.assertCalledWith(self, ...)
 local vararg = select("#", ...)
 if tbl.valuesLength ~= vararg then
 error(("Expected %d arguments, but was called with %d arguments"):format(tbl.valuesLength, vararg), 2)
 end
 for i = 1, vararg do
 assert(select(i, ...) == tbl.values[i], "value differs")
 end
	end
	function tbl.assertCalledWithDeepEqual(self, ...)
 local vararg = select("#", ...)
 if tbl.valuesLength ~= vararg then
 error(("Expected %d arguments, but was called with %d arguments"):format(tbl.valuesLength, vararg), 2)
 end
 for i = 1, vararg do
 assertDeepEqual(tbl.values[i], (select(i, ...)))
 end
	end
	function tbl.captureValues(self, ...)
 local vararg = select("#", ...)
 local tableObj = {}
 assert(tbl.valuesLength == vararg, "length of expected values differs from stored values")
 for i = 1, vararg do
 tableObj[select(i, ...)] = tbl.values[i]
 end
 return tableObj
	end
	setmetatable(tbl, {
 __index = function(self, callback)
 error(("%q is not a valid member of spy"):format(callback))
 end
	})
	return tbl
end
