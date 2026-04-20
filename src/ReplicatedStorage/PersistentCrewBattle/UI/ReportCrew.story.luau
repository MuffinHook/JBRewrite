local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local ReportCrew_upvr = require(script.Parent.ReportCrew)
    function any_extend_result1.render(arg1_3) -- Line 8
        return Roact_upvr.createElement(ReportCrew_upvr, {
            onSubmit = function(arg1_4, arg2) -- Line 10, Named "onSubmit"
                print(arg1_4)
                print(arg2)
            end;
            onClose = function() -- Line 14, Named "onClose"
                print("wants to close")
            end;
        })
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 19
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 22
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end