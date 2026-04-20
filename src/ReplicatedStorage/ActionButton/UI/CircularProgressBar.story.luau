local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local CircularProgressBar_upvr = require(script.Parent.CircularProgressBar)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0.3)
        arg1_2.progress = any_createBinding_result1
        arg1_2.updateProgress = any_createBinding_result2
        arg1_2.updateProgress(0.1)
    end
    function any_extend_result1.render(arg1_3) -- Line 11
        return Roact_upvr.createElement(CircularProgressBar_upvr, {
            progressBinding = arg1_3.progress;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 16
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 19
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end