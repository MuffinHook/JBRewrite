local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
        arg1_2:setState({
            visible = true;
        })
    end
    local Tooltip_upvr = require(script.Parent.Tooltip)
    function any_extend_result1.render(arg1_3) -- Line 13
        return createElement_upvr(Tooltip_upvr, {
            text = "noice";
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 18
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 21
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end