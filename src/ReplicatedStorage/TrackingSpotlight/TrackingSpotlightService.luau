local module = {}
local TrackingSpotlightBinder_upvr = require(script.Parent.TrackingSpotlightBinder)
function module.init() -- Line 3
    TrackingSpotlightBinder_upvr:Start()
end
return module