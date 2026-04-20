local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
local SpectateSelector_upvr = require(script.Parent.SpectateSelector)
return function(arg1) -- Line 6
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr(SpectateSelector_upvr, {}), arg1)
    return function() -- Line 8
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end