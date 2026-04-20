local module = {}
local PlankBinder_upvr = require(script.Parent.PlankBinder)
function module.init() -- Line 4
    PlankBinder_upvr:Start()
end
return module