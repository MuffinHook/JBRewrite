-- Reviewed by Claude
return function()
	local ElementKind = require(script.Parent.ElementKind)
	local Type = require(script.Parent.Type)
	local createFragment = require(script.Parent.createFragment)
	it("should create new primitive elements", function()
 local v1 = createFragment({})
 expect(v1).to.be.ok()
 expect(Type.of(v1)).to.equal(Type.Element)
 expect(ElementKind.of(v1)).to.equal(ElementKind.Fragment)
	end)
	it("should accept children", function()
 local v1 = createFragment({})
 expect(createFragment({
 key = v1
 }).elements.key).to.equal(v1)
	end)
end