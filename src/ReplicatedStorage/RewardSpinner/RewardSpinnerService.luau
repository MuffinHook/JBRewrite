-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local store = require(ReplicatedStorage.App.store)
return {
	init = function()
		waitForChild(ReplicatedStorage, RewardSpinnerConsts.SPIN_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function(p1)
				store:dispatch(Dictionary.merge({
					type = "setRewardSpinnerConfig"
				}, p1))
			end)
		end)
	end
}
