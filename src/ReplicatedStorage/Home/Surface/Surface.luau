local SurfaceUtils_upvr = require(script.Parent.SurfaceUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.__ClassName = "Surface"
local Maid_upvr = require(game:GetService("ReplicatedStorage").Std.Maid)
function module_upvr.new(arg1) -- Line 9
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    module._obj = arg1
    return module
end
function module_upvr.GetPlacementPrism(arg1) -- Line 18
    return SurfaceUtils_upvr.getPlacementPrism(arg1._obj.CFrame, arg1._obj.Size)
end
function module_upvr.GetStandingPrism(arg1) -- Line 21
    return SurfaceUtils_upvr.getStandingPrism(arg1._obj.CFrame, arg1._obj.Size)
end
function module_upvr.Destroy(arg1) -- Line 24
    local _maid = arg1._maid
    local var6
    if _maid == nil then
        var6 = false
    else
        var6 = true
    end
    assert(var6)
    arg1._maid = nil
    _maid:Destroy()
end
return module_upvr