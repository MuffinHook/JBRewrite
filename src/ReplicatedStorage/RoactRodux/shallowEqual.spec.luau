-- Reviewed by Claude
return function()
	local shallowEqual = require(script.Parent.shallowEqual)
	it("should compare dictionaries", function()
 local t = {
 a = "a",
 b = {},
 c = 6
 }
 local t2 = {
 b = t.b,
 c = t.c,
 a = t.a
 }
 local t3 = {
 b = {},
 a = t.a,
 c = t.c
 }
 local t4 = {
 a = t.a,
 b = t.b,
 c = t.c,
 d = "hello"
 }
 expect(shallowEqual(t, t)).to.equal(true)
 expect(shallowEqual(t, t2)).to.equal(true)
 expect(shallowEqual(t, t3)).to.equal(false)
 expect(shallowEqual(t2, t3)).to.equal(false)
 expect(shallowEqual(t, t4)).to.equal(false)
 expect(shallowEqual(t2, t4)).to.equal(false)
	end)
	it("should handle nil for either argument", function()
 local t = {}
 expect(shallowEqual(nil, nil)).to.equal(true)
 expect(shallowEqual(t, nil)).to.equal(false)
 expect(shallowEqual(nil, t)).to.equal(false)
	end)
end