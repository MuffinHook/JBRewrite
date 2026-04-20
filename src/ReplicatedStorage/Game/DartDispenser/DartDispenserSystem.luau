local module = {}
local DartDispenserBinder_upvr = require(script.Parent.DartDispenserBinder)
function module.init() -- Line 4
    DartDispenserBinder_upvr:Start()
end
return module