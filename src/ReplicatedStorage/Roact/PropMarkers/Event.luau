-- Reviewed by Claude
local Type = require(script.Parent.Parent.Type)
local tbl = {}
local t2 = {
	__tostring = function(p1)
 return ("RoactHostEvent(%s)"):format(p1.name)
	end
}
setmetatable(tbl, {
	__index = function(p1, p2)
 local t3 = {
 [Type] = Type.HostEvent,
 name = p2
 }
 setmetatable(t3, t2)
 tbl[p2] = t3
 return t3
	end
})
return tbl