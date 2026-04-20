local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    local any_createBinding_result1, any_createBinding_result2_upvr = Roact_upvr.createBinding("hello, world!")
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.TextButton), {
        size = UDim2.new(0.5, 0, 0, 30);
        position = UDim2.new(0.25, 0, 0.5, 0);
        text = any_createBinding_result1;
        onClick = function(arg1_2, arg2, arg3) -- Line 14, Named "onClick"
            any_createBinding_result2_upvr("click %d":format(arg3))
        end;
    }), arg1)
    return function() -- Line 20
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end