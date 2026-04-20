local Promise_upvr = require(game:GetService("ReplicatedStorage").Std.Promise)
local PolicyService_upvr = game:GetService("PolicyService")
return function(arg1) -- Line 4
    return Promise_upvr.new(function(arg1_2, arg2, arg3) -- Line 5
        if arg3() then
        else
            arg1_2(PolicyService_upvr:GetPolicyInfoForPlayerAsync(arg1))
        end
    end)
end