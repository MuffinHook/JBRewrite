local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function _(arg1) -- Line 7, Named "f"
    if arg1 / 2 % 1 < 0.5 then
        return arg1 % 1
    end
    return 1 - arg1 % 1
end
local Roact_upvr = require(ReplicatedStorage.Roact)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local TweenService_upvr = game:GetService("TweenService")
return function(arg1) -- Line 14
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 17
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(1)
        arg1_2.pctClosed = any_createBinding_result1
        arg1_2.updatePctClosed = any_createBinding_result2
        arg1_2.maid = Maid_upvr.new()
    end
    function any_extend_result1.didMount(arg1_3) -- Line 21
        arg1_3.maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 22
            local os_clock_result1 = os.clock()
            local var12
            if os_clock_result1 / 2 % 1 < 0.5 then
                var12 = os_clock_result1 % 1
            else
                var12 = 1 - os_clock_result1 % 1
            end
            arg1_3.updatePctClosed(TweenService_upvr:GetValue(var12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
        end))
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 28
        arg1_4.maid:DoCleaning()
    end
    local Eyelids_upvr = require(script.Parent.Eyelids)
    function any_extend_result1.render(arg1_5) -- Line 31
        return Roact_upvr.createElement(Eyelids_upvr, {
            pctClosed = arg1_5.pctClosed;
        })
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 38
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end