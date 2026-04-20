local module = {}
local SurfaceBinder_upvr = require(script.Parent.SurfaceBinder)
function module.init() -- Line 4
    SurfaceBinder_upvr:Start()
end
return module