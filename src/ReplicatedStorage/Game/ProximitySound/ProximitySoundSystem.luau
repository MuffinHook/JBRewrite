local module = {}
local ProximitySoundBinder_upvr = require(script.Parent.ProximitySoundBinder)
function module.init() -- Line 4
    ProximitySoundBinder_upvr:Start()
end
return module