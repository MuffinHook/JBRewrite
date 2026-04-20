return function() -- Line 1
    local Math_upvr = require(script.parent.Math)
    describe("isNaN", function() -- Line 4
        it("should identify numbers", function() -- Line 5
            expect(Math_upvr.IsNaN(1)).to.equal(false)
        end)
        it("should identify non-numbers", function() -- Line 9
            expect(Math_upvr.IsNaN(tonumber("nan"))).to.equal(true)
        end)
    end)
end