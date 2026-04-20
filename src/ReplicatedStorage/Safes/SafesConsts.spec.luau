local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return function() -- Line 3
    local SafesConsts_upvr = require(script.Parent.SafesConsts)
    local getItemPropsFromRewardData_upvr = require(ReplicatedStorage_upvr.RewardSpinner.getItemPropsFromRewardData)
    describe("safe items", function() -- Line 7
        it("all exist", function() -- Line 8
            local var15
            for _, v in SafesConsts_upvr.SAFE_DATA do
                for _, v_2_upvr in v.RewardData do
                    local pcall_result1, pcall_result2 = pcall(function() -- Line 14
                        getItemPropsFromRewardData_upvr(v_2_upvr)
                    end)
                    if not pcall_result1 then
                        warn(pcall_result2)
                        var15 += 1
                    end
                end
            end
            expect(var15).to.equal(0)
        end)
    end)
end