local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 6
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr(require(script.Parent.Countdown), {
        endTime = workspace:GetServerTimeNow() + 1000;
    }), arg1)
    return function() -- Line 14
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end