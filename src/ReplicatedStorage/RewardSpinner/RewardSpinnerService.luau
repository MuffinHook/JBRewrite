local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local RewardSpinnerConsts_upvr = require(ReplicatedStorage_upvr.RewardSpinner.RewardSpinnerConsts)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local Dictionary_upvr = require(ReplicatedStorage_upvr.Std.Dictionary)
function module.init() -- Line 8
    waitForChild_upvr(ReplicatedStorage_upvr, RewardSpinnerConsts_upvr.SPIN_REMOTE_NAME):andThen(function(arg1) -- Line 9
        arg1.OnClientEvent:Connect(function(arg1_2) -- Line 10
            store_upvr:dispatch(Dictionary_upvr.merge({
                type = "setRewardSpinnerConfig";
            }, arg1_2))
        end)
    end)
end
return module