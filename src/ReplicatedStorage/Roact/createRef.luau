-- Reviewed by Claude
local Binding = require(script.Parent.Binding)
return function()
	local v1, _ = Binding.create(nil)
	local tbl = {}
	setmetatable(tbl, {
 __index = function(p1, p2)
 if p2 == "current" then
 return v1:getValue()
 else
 return v1[p2]
 end
 end,
 __newindex = function(p1, p2, p3)
 if p2 == "current" then
 error("Cannot assign to the \'current\' property of refs", 2)
 end
 v1[p2] = p3
 end,
 __tostring = function(p1)
 return ("RoactRef(%s)"):format((tostring(v1:getValue())))
 end
	})
	return tbl
end