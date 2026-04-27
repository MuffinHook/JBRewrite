local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local store = require(ReplicatedStorage.App.store)
return {
	init = function()
		waitForChild(ReplicatedStorage, RewardSpinnerConsts.SPIN_REMOTE_NAME):andThen(function(spinRemote)
			spinRemote.OnClientEvent:Connect(function(configData)
				store:dispatch(Dictionary.merge({
					type = "setRewardSpinnerConfig"
				}, configData))
			end)
		end)
	end
}
