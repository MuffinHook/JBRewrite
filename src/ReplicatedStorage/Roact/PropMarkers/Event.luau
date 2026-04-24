-- Reviewed by Claude
local Type = require(script.Parent.Parent.Type)
local t = {}
local t2 = {
	__tostring = function(p1)
 return ("RoactHostEvent(%s)"):format(p1.name)
	end
}
setmetatable(t, {
	__index = function(p1, p2)
 local t3 = {
 [Type] = Type.HostEvent,
 name = p2
 }
 setmetatable(t3, t2)
 t[p2] = t3
 return t3
	end
})
return t