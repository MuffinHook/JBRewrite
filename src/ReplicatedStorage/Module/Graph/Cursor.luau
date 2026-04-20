local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.new(arg1, arg2) -- Line 6
    assert(arg1)
    assert(arg2)
    local module = {}
    setmetatable(module, module_2_upvr)
    module.Graph = arg1
    module.Node = arg2
    return module
end
local Signal_upvr = require(game:GetService("ReplicatedStorage").Std.Signal)
function module_2_upvr.GetOnWalkedSignal(arg1) -- Line 18
    if arg1._onWalkedSignal == nil then
        arg1._onWalkedSignal = Signal_upvr.new()
    end
    return arg1._onWalkedSignal
end
function module_2_upvr.WalkTo(arg1, arg2) -- Line 24
    assert(arg2)
    if arg1.Graph:HasEdge(arg1.Node, arg2) then
        arg1.Node = arg2
        if arg1._onWalkedSignal then
            arg1._onWalkedSignal:Fire(arg2)
        end
        return true
    end
    return false
end
return module_2_upvr