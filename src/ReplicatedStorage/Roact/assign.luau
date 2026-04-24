-- Reviewed by Claude
local None = require(script.Parent.None)
return function(p1, ...)
	for i = 1, select("#", ...) do
 local vararg = select(i, ...)
 if vararg ~= nil then
 for k, v in pairs(vararg) do
 if v == None then
 p1[k] = nil
 else
 p1[k] = v
 end
 end
 end
	end
	return p1
end