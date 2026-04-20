local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextMessageUI_upvr = require(ReplicatedStorage.Game.ContextMessage.ContextMessageUI)
local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.__ClassName = "BaseTutorial"
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new(arg1, arg2) -- Line 9
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._remoteEvent = arg1:WaitForChild("RemoteEvent")
    module_upvr_2.Messages = arg2
    module_upvr_2._maid:GiveTask(module_upvr_2._remoteEvent.OnClientEvent:Connect(function(...) -- Line 18
        module_upvr_2:_onClientEvent(...)
    end))
    module_upvr_2._runningValue = arg1:WaitForChild("Running")
    module_upvr_2._maid:GiveTask(module_upvr_2._runningValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line 24
        if module_upvr_2._runningValue.Value then
            module_upvr_2:SetEdge(module_upvr_2._edgeValue.Value)
        else
            if ContextMessageUI_upvr.isOpen() then
                ContextMessageUI_upvr.close()
            end
            module_upvr_2._maid.updatePosition = nil
        end
    end))
    module_upvr_2._edgeValue = arg1:WaitForChild("Edge")
    module_upvr_2:SetEdge(module_upvr_2._edgeValue.Value)
    module_upvr_2._maid:GiveTask(module_upvr_2._edgeValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line 40
        module_upvr_2:SetEdge(module_upvr_2._edgeValue.Value)
    end))
    return module_upvr_2
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.SetEdge(arg1, arg2) -- Line 48
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1._maid.updatePosition = nil
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.GetRunning(arg1) -- Line 87
    return arg1._runningValue.Value
end
function module_upvr._onClientEvent(arg1) -- Line 90
end
function module_upvr.Destroy(arg1) -- Line 91
    assert(arg1._maid)
    arg1._maid:Destroy()
    arg1._maid = nil
end
return module_upvr