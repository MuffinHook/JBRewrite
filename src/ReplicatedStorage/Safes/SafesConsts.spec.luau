local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function()
	local SafesConsts = require(script.Parent.SafesConsts)
	local getItemPropsFromRewardData = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
	describe("safe items", function()
 it("all exist", function()
 local count = 0
 for safeId, safeData in SafesConsts.SAFE_DATA do
 for rewardId, rewardData in safeData.RewardData do
 local didSucceed, errorMessage = pcall(function()
 getItemPropsFromRewardData(rewardData)
 end)
 if not didSucceed then
 warn(errorMessage)
 count = count + 1
 end
 end
 end
 expect(count).to.equal(0)
 end)
	end)
end
