local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0)
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Slider), {
        size = UDim2.new(0.5, 0, 0, 30);
        position = UDim2.new(0.25, 0, 0.5, 0);
        min = 0;
        max = 50;
        step = 1;
        value = any_createBinding_result1;
        updateValue = any_createBinding_result2;
        text = any_createBinding_result1:map(function(arg1_2) -- Line 20
            return string.format("%d", (1 - arg1_2) * 0 + arg1_2 * 50);
        end);
    }), arg1)
    return function() -- Line 26
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end