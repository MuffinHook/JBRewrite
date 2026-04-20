local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local PolicyService_upvr = require(ReplicatedStorage.Policy.PolicyService)
require(ReplicatedStorage.Policy.promisePolicyInfoForPlayer)(LocalPlayer_upvr):andThen(function(arg1) -- Line 8
    PolicyService_upvr.setCachedPlayerPolicyInfo(LocalPlayer_upvr, arg1)
end)