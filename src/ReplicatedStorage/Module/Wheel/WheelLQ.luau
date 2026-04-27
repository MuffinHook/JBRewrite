local Wheel = require(script.Parent.Wheel)
local WheelLQ = {}
WheelLQ.__index = WheelLQ
setmetatable(WheelLQ, Wheel)
function WheelLQ.new(config)
	return Wheel.new(config, true)
end
return WheelLQ
