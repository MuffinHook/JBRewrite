-- Reviewed by Claude
return function()
	local shallowEqual = require(script.Parent.shallowEqual)
	it("should compare dictionaries", function()
 local tbl = {
 a = "a",
 b = {},
 c = 6
 }
 local t2 = {
 b = tbl.b,
 c = tbl.c,
 a = tbl.a
 }
 local t3 = {
 b = {},
 a = tbl.a,
 c = tbl.c
 }
 local t4 = {
 a = tbl.a,
 b = tbl.b,
 c = tbl.c,
 d = "hello"
 }
 expect(shallowEqual(tbl, tbl)).to.equal(true)
 expect(shallowEqual(tbl, t2)).to.equal(true)
 expect(shallowEqual(tbl, t3)).to.equal(false)
 expect(shallowEqual(t2, t3)).to.equal(false)
 expect(shallowEqual(tbl, t4)).to.equal(false)
 expect(shallowEqual(t2, t4)).to.equal(false)
	end)
	it("should handle nil for either argument", function()
 local tbl = {}
 expect(shallowEqual(nil, nil)).to.equal(true)
 expect(shallowEqual(tbl, nil)).to.equal(false)
 expect(shallowEqual(nil, tbl)).to.equal(false)
	end)
end