-- Reviewed by Claude
-- variables reassigned
return function()
	local None = require(script.Parent.None)
	local assign = require(script.Parent.assign)
	it("should accept zero additional tables", function()
 local tableObj = {}
 local v1 = assign(tableObj)
 expect(tableObj).to.equal(v1)
	end)
	it("should merge multiple tables onto the given target table", function()
 local tableObj = {
 a = 5,
 b = 6
 }
 local tbl2 = {
 b = 7,
 c = 8
 }
 local metadata = {
 b = 8
 }
 assign(tableObj, tbl2, metadata)
 expect(tableObj.a).to.equal(5)
 expect(tableObj.b).to.equal(metadata.b)
 expect(tableObj.c).to.equal(tbl2.c)
	end)
	it("should remove keys if specified as None", function()
 local tableObj = {
 foo = 2,
 bar = 3
 }
 assign(tableObj, {
 foo = None
 })
 expect(tableObj.foo).to.equal(nil)
 expect(tableObj.bar).to.equal(3)
	end)
	it("should re-add keys if specified after None", function()
 local tableObj = {
 foo = 2
 }
 local tbl2 = {
 foo = 3
 }
 assign(tableObj, {
 foo = None
 }, tbl2)
 expect(tableObj.foo).to.equal(tbl2.foo)
	end)
end
