local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    local any_createBinding_result1, _ = Roact_upvr.createBinding(0)
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Plot), {
        size = UDim2.new(0.5, 0, 0.5, 0);
        position = UDim2.new(0.25, 0, 0.25, 0);
        window = {0, 0, 100, 100};
    }), arg1)
    return function() -- Line 17
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end