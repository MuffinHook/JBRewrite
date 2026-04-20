local Basic_upvr = require(script.Parent.Basic)
local module_upvr = {
    __ClassName = "Handcuffs";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
local Handcuffs_upvr = require(game:GetService("ReplicatedStorage").Game.ItemConfig.Handcuffs)
function module_upvr.new(arg1, arg2, arg3) -- Line 11
    local any_new_result1 = Basic_upvr.new(arg1, arg2, Handcuffs_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.SpringItemOffset:SetTarget(Vector3.new(0, 0.30000, -1))
    return any_new_result1
end
function module_upvr.InputBegan(arg1, ...) -- Line 19
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 22
end
return module_upvr