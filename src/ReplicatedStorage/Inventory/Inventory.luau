local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 6
    local module = {}
    setmetatable(module, module_upvr)
    module.obj = arg1
    return module
end
local InventoryUtils_upvr = require(script.Parent.InventoryUtils)
function module_upvr.HasItem(arg1, arg2) -- Line 14
    return InventoryUtils_upvr.doesInventoryValueHave(arg1.obj, arg2)
end
function module_upvr.Destroy(arg1) -- Line 17
end
return module_upvr