local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local TradeChat_upvr = require(script.Parent.TradeChat)
    function any_extend_result1.render(arg1_3) -- Line 8
        return Roact_upvr.createElement(TradeChat_upvr, {
            size = UDim2.new(1, 0, 1, 0);
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 13
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 16
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end