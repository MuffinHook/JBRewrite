-- Reviewed by Claude
return function()
	local None = require(script.Parent.None)
	local assign = require(script.Parent.assign)
	it("should accept zero additional tables", function()
 local tbl = {}
 local v1 = assign(tbl)
 expect(tbl).to.equal(v1)
	end)
	it("should merge multiple tables onto the given target table", function()
 local tbl = {
 a = 5,
 b = 6
 }
 local t2 = {
 b = 7,
 c = 8
 }
 local t3 = {
 b = 8
 }
 assign(tbl, t2, t3)
 expect(tbl.a).to.equal(5)
 expect(tbl.b).to.equal(t3.b)
 expect(tbl.c).to.equal(t2.c)
	end)
	it("should remove keys if specified as None", function()
 local tbl = {
 foo = 2,
 bar = 3
 }
 assign(tbl, {
 foo = None
 })
 expect(tbl.foo).to.equal(nil)
 expect(tbl.bar).to.equal(3)
	end)
	it("should re-add keys if specified after None", function()
 local tbl = {
 foo = 2
 }
 local t2 = {
 foo = 3
 }
 assign(tbl, {
 foo = None
 }, t2)
 expect(tbl.foo).to.equal(t2.foo)
	end)
end