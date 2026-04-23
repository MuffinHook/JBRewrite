local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function() --[[ Line: 3 | Upvalues: ReplicatedStorage (copy) ]]
	local SafesConsts = require(script.Parent.SafesConsts)
	local getItemPropsFromRewardData = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
	describe("safe items", function() --[[ Line: 7 | Upvalues: SafesConsts (copy), getItemPropsFromRewardData (copy) ]]
		it("all exist", function() --[[ Line: 8 | Upvalues: SafesConsts (ref), getItemPropsFromRewardData (ref) ]]
			local count = 0
			for v1, v2 in SafesConsts.SAFE_DATA do
				for v3, v4 in v2.RewardData do
					local v5, v6 = pcall(function() --[[ Line: 14 | Upvalues: getItemPropsFromRewardData (ref), v4 (copy) ]]
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