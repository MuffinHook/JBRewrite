-- Reviewed by Claude
local None = require(script.Parent.None)
return function(p1, ...)
	for i = 1, select("#", ...) do
 local v1 = select(i, ...)
 if v1 ~= nil then
 for k, v in pairs(v1) do
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