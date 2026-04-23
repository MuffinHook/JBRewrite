local Wheel = require(script.Parent.Wheel)
local t = {}
t.__index = t
setmetatable(t, Wheel)
function t.new(p1) --[[ Line: 6 | Upvalues: Wheel (copy) ]]
	return Wheel.new(p1, true)
end
return t