local module = {}
local TankBinder_upvr = require(script.Parent.TankBinder)
function module.init() -- Line 4
    TankBinder_upvr:Start()
end
function module.vehicleEnter(arg1) -- Line 8
end
function module.vehicleLeave(arg1) -- Line 9
end
return module