local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
        arg1_2:setState({
            countInner = 3;
            countOuter = 4;
        })
    end
    local Grid_upvr = require(script.Parent.Grid)
    function any_extend_result1.render(arg1_3) -- Line 13
        return Roact_upvr.createElement(Grid_upvr, {
            position = UDim2.new(1, 0, 1, 0);
            anchorPoint = Vector2.new(1, 1);
            size = UDim2.new(0.2, 0, 0.5, 0);
            countInner = arg1_3.state.countInner;
            countOuter = arg1_3.state.countOuter;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 22
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 25
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end