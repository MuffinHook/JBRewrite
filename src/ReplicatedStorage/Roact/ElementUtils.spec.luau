-- Reviewed by Claude
-- variables reassigned
return function()
	local ElementUtils = require(script.Parent.ElementUtils)
	local createElement = require(script.Parent.createElement)
	local createFragment = require(script.Parent.createFragment)
	local Type = require(script.Parent.Type)
	describe("iterateElements", function()
 it("should iterate once for a single child", function()
 local state1 = createElement("TextLabel")
 local state2 = ElementUtils.iterateElements(state1)
 local newState, currentState = state2()
 expect(newState).to.equal(ElementUtils.UseParentKey)
 expect(currentState).to.equal(state1)
 expect((state2())).to.equal(nil)
 end)
 it("should iterate over tables", function()
 local tbl = {
 a = createElement("TextLabel"),
 b = createElement("TextLabel")
 }
 local tableObj = {}
 local count = 0
 for state1, state2 in ElementUtils.iterateElements(tbl) do
 expect((typeof(state1))).to.equal("string")
 expect(Type.of(state2)).to.equal(Type.Element)
 tableObj[state2] = state1
 count = count + 1
 end
 expect(count).to.equal(2)
 expect(tableObj[tbl.a]).to.equal("a")
 expect(tableObj[tbl.b]).to.equal("b")
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
 local state1 = createElement("TextLabel")
 it("should return the element if the key is UseParentKey", function()
 expect(ElementUtils.getElementByKey(state1, ElementUtils.UseParentKey)).to.equal(state1)
 end)
 it("should return nil if the key is not UseParentKey", function()
 expect(ElementUtils.getElementByKey(state1, "test")).to.equal(nil)
 end)
 end)
 it("should return the corresponding element from a table", function()
 local tbl = {
 a = createElement("TextLabel"),
 b = createElement("TextLabel")
 }
 expect(ElementUtils.getElementByKey(tbl, "a")).to.equal(tbl.a)
 expect(ElementUtils.getElementByKey(tbl, "b")).to.equal(tbl.b)
 end)
 it("should return nil if the key does not exist", function()
 expect(ElementUtils.getElementByKey(createFragment({}), "a")).to.equal(nil)
 end)
	end)
end
