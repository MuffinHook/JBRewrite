return function() --[[ Line: 1 ]]
	local Math = require(script.parent.Math)
	describe("isNaN", function() --[[ Line: 4 | Upvalues: Math (copy) ]]
		it("should identify numbers", function() --[[ Line: 5 | Upvalues: Math (ref) ]]
			expect((Math.IsNaN(1))).to.equal(false)
		end)
		it("should identify non-numbers", function() --[[ Line: 9 | Upvalues: Math (ref) ]]
			expect((Math.IsNaN((0 / 0)))).to.equal(true)
		end)
	end)
end