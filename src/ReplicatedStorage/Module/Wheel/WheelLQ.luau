-- Reviewed by Claude
local Wheel = require(script.Parent.Wheel)
local t = {}
t.__index = t
setmetatable(t, Wheel)
function t.new(p1)
	return Wheel.new(p1, true)
end
return t
