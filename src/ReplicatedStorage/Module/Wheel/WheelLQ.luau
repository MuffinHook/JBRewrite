local Wheel_upvr = require(script.Parent.Wheel)
local module = {}
module.__index = module
setmetatable(module, Wheel_upvr)
function module.new(arg1) -- Line 6
    return Wheel_upvr.new(arg1, true)
end
return module