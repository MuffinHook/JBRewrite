local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.LicensePlate), {
        size = UDim2.new(0.5, 0, 0.5, 0);
        position = UDim2.new(0.25, 0, 0.25, 0);
    }), arg1)
    return function() -- Line 13
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end