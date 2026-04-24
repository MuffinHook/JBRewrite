-- Reviewed by Claude
local None = require(script.Parent.None)
return function(self, ...)
	for i = 1, select("#", ...) do
 local vararg = select(i, ...)
 if vararg ~= nil then
 for k, v in pairs(vararg) do
 if v == None then
 self[k] = nil
 else
 self[k] = v
 end
 end
 end
	end
	return self
end
