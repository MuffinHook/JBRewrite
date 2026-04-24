-- Reviewed by Claude
-- variables reassigned
local Binding = require(script.Parent.Binding)
return function()
	local result1, _ = Binding.create(nil)
	local tableObj = {}
	setmetatable(tableObj, {
 __index = function(self, callback)
 if callback == "current" then
 return result1:getValue()
 else
 return result1[callback]
 end
 end,
 __newindex = function(self, callback, self)
 if callback == "current" then
 error("Cannot assign to the \'current\' property of refs", 2)
 end
 result1[callback] = self
 end,
 __tostring = function(self)
 return ("RoactRef(%s)"):format((tostring(result1:getValue())))
 end
	})
	return tableObj
end
