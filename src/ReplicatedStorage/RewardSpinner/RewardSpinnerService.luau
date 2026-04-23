local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local store = require(ReplicatedStorage.App.store)
return {
	init = function() --[[ Name: init | Line: 8 | Upvalues: waitForChild (copy), ReplicatedStorage (copy), RewardSpinnerConsts (copy), store (copy), Dictionary (copy) ]]
		waitForChild(ReplicatedStorage, RewardSpinnerConsts.SPIN_REMOTE_NAME):andThen(function(p1) --[[ Line: 9 | Upvalues: store (ref), Dictionary (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 10 | Upvalues: store (ref), Dictionary (ref) ]]
				store:dispatch(Dictionary.merge({
					type = "setRewardSpinnerConfig"
				}, p1))
			end)
		end)
	end
}