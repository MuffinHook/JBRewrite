local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Board), {}), arg1)
    return function() -- Line 7
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end