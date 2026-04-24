-- Reviewed by Claude
return function()
	local ElementUtils = require(script.Parent.ElementUtils)
	local createElement = require(script.Parent.createElement)
	local createFragment = require(script.Parent.createFragment)
	local Type = require(script.Parent.Type)
	describe("iterateElements", function()
 it("should iterate once for a single child", function()
 local v1 = createElement("TextLabel")
 local v2 = ElementUtils.iterateElements(v1)
 local v3, v4 = v2()
 expect(v3).to.equal(ElementUtils.UseParentKey)
 expect(v4).to.equal(v1)
 expect((v2())).to.equal(nil)
 end)
 it("should iterate over tables", function()
 local t = {
 a = createElement("TextLabel"),
 b = createElement("TextLabel")
 }
 local tbl = {}
 local count = 0
 for v1, v2 in ElementUtils.iterateElements(t) do
 expect((typeof(v1))).to.equal("string")
 expect(Type.of(v2)).to.equal(Type.Element)
 tbl[v2] = v1
 count = count + 1
 end
 expect(count).to.equal(2)
 expect(tbl[t.a]).to.equal("a")
 expect(tbl[t.b]).to.equal("b")
 end)
 it("should return a zero-element iterator for booleans", function()
 expect(ElementUtils.iterateElements(false)()).to.equal(nil)
 end)
 it("should return a zero-element iterator for nil", function()
 expect(ElementUtils.iterateElements(nil)()).to.equal(nil)
 end)
 it("should throw if given an illegal value", function()
 expect(function()
 ElementUtils.iterateElements(1)
 end).to.throw()
 end)
	end)
	describe("getElementByKey", function()
 it("should return nil for booleans", function()
 expect(ElementUtils.getElementByKey(true, "test")).to.equal(nil)
 end)
 it("should return nil for nil", function()
 expect(ElementUtils.getElementByKey(nil, "test")).to.equal(nil)
 end)
 describe("single elements", function()
 local v1 = createElement("TextLabel")
 it("should return the element if the key is UseParentKey", function()
 expect(ElementUtils.getElementByKey(v1, ElementUtils.UseParentKey)).to.equal(v1)
 end)
 it("should return nil if the key is not UseParentKey", function()
 expect(ElementUtils.getElementByKey(v1, "test")).to.equal(nil)
 end)
 end)
 it("should return the corresponding element from a table", function()
 local t = {
 a = createElement("TextLabel"),
 b = createElement("TextLabel")
 }
 expect(ElementUtils.getElementByKey(t, "a")).to.equal(t.a)
 expect(ElementUtils.getElementByKey(t, "b")).to.equal(t.b)
 end)
 it("should return nil if the key does not exist", function()
 expect(ElementUtils.getElementByKey(createFragment({}), "a")).to.equal(nil)
 end)
	end)
end