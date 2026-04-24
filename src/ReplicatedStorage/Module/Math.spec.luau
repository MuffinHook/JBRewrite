-- Reviewed by Claude
return function()
	local Math = require(script.parent.Math)
	describe("isNaN", function()
		it("should identify numbers", function()
			expect((Math.IsNaN(1))).to.equal(false)
		end)
		it("should identify non-numbers", function()
			expect((Math.IsNaN((0 / 0)))).to.equal(true)
		end)
	end)
end
