local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Glicko2Utils = require(ReplicatedStorage.Glicko2.Glicko2Utils)
return function()
	describe("checkSingleBattle", function()
		it("single battle rating should be correct", function()
			local newRating, newDeviation, newVolatility = Glicko2Utils.calculateNewRatingData(1500, 350, 0.06, { 1500 }, { 350 }, { 1 })
			local isValid = not (math.abs(newRating - 1662.31) > 0.01)
			if math.abs(newDeviation - 290.319) > 0.01 then
				isValid = false
			end
			if math.abs(newVolatility - 0.05999968) > 0.01 then
				isValid = false
			end
			if not isValid then
				print(newRating, newDeviation, newVolatility)
			end
			expect(isValid).to.equal(true)
		end)
	end)
	describe("checkMultipleBattles", function()
		it("single battle rating should be correct", function()
			local newRating, newDeviation, newVolatility = Glicko2Utils.calculateNewRatingData(1500, 200, 0.06, { 1400, 1550, 1700 }, { 30, 100, 300 }, { 1, 0, 0 })
			local isValid = not (math.abs(newRating - 1464.06) > 0.01)
			if math.abs(newDeviation - 151.52) > 0.01 then
				isValid = false
			end
			if math.abs(newVolatility - 0.05999) > 0.01 then
				isValid = false
			end
			if not isValid then
				print(newRating, newDeviation, newVolatility)
			end
			expect(isValid).to.equal(true)
		end)
	end)
end
