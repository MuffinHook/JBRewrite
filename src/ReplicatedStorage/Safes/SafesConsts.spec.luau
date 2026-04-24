-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function()
	local SafesConsts = require(script.Parent.SafesConsts)
	local getItemPropsFromRewardData = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
	describe("safe items", function()
 it("all exist", function()
 local count = 0
 for v1, v2 in SafesConsts.SAFE_DATA do
 for v3, v4 in v2.RewardData do
 local v5, v6 = pcall(function()
 getItemPropsFromRewardData(v4)
 end)
 if not v5 then
 warn(v6)
 count = count + 1
 end
 end
 end
 expect(count).to.equal(0)
 end)
	end)
end