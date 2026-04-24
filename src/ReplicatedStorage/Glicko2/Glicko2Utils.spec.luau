-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Glicko2Utils = require(ReplicatedStorage.Glicko2.Glicko2Utils)
return function()
	describe("checkSingleBattle", function()
		it("single battle rating should be correct", function()
			local v1, v2, v3 = Glicko2Utils.calculateNewRatingData(1500, 350, 0.06, { 1500 }, { 350 }, { 1 })
			local v4 = not (math.abs(v1 - 1662.31) > 0.01)
			if math.abs(v2 - 290.319) > 0.01 then
				v4 = false
			end
			if math.abs(v3 - 0.05999968) > 0.01 then
				v4 = false
			end
			if not v4 then
				print(v1, v2, v3)
			end
			expect(v4).to.equal(true)
		end)
	end)
	describe("checkMultipleBattles", function()
		it("single battle rating should be correct", function()
			local v1, v2, v3 = Glicko2Utils.calculateNewRatingData(1500, 200, 0.06, { 1400, 1550, 1700 }, { 30, 100, 300 }, { 1, 0, 0 })
			local v4 = not (math.abs(v1 - 1464.06) > 0.01)
			if math.abs(v2 - 151.52) > 0.01 then
				v4 = false
			end
			if math.abs(v3 - 0.05999) > 0.01 then
				v4 = false
			end
			if not v4 then
				print(v1, v2, v3)
			end
			expect(v4).to.equal(true)
		end)
	end)
end
