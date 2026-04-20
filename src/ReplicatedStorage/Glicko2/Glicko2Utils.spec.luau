local Glicko2Utils_upvr = require(game:GetService("ReplicatedStorage").Glicko2.Glicko2Utils)
return function() -- Line 9
    describe("checkSingleBattle", function() -- Line 11
        it("single battle rating should be correct", function() -- Line 12
            local any_calculateNewRatingData_result1, any_calculateNewRatingData_result2, any_calculateNewRatingData_result3 = Glicko2Utils_upvr.calculateNewRatingData(1500, 350, 0.06, {1500}, {350}, {1})
            local var11
            if 0.01 < math.abs(any_calculateNewRatingData_result1 - 1662.31) then
                var11 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result2 - 290.319) then
                var11 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result3 - 0.05999968) then
                var11 = false
            end
            if not var11 then
                print(any_calculateNewRatingData_result1, any_calculateNewRatingData_result2, any_calculateNewRatingData_result3)
            end
            expect(var11).to.equal(true)
        end)
    end)
    describe("checkMultipleBattles", function() -- Line 38
        it("single battle rating should be correct", function() -- Line 39
            local any_calculateNewRatingData_result1_2, any_calculateNewRatingData_result2_2, any_calculateNewRatingData_result3_2 = Glicko2Utils_upvr.calculateNewRatingData(1500, 200, 0.06, {1400, 1550, 1700}, {30, 100, 300}, {1, 0, 0})
            local var20
            if 0.01 < math.abs(any_calculateNewRatingData_result1_2 - 1464.06) then
                var20 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result2_2 - 151.52) then
                var20 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result3_2 - 0.05999) then
                var20 = false
            end
            if not var20 then
                print(any_calculateNewRatingData_result1_2, any_calculateNewRatingData_result2_2, any_calculateNewRatingData_result3_2)
            end
            expect(var20).to.equal(true)
        end)
    end)
end