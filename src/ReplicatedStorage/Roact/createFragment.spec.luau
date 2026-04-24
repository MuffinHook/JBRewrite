-- Reviewed by Claude
-- variables reassigned
return function()
	local ElementKind = require(script.Parent.ElementKind)
	local Type = require(script.Parent.Type)
	local createFragment = require(script.Parent.createFragment)
	it("should create new primitive elements", function()
 local varType = createFragment({})
 expect(varType).to.be.ok()
 expect(Type.of(varType)).to.equal(Type.Element)
 expect(ElementKind.of(varType)).to.equal(ElementKind.Fragment)
	end)
	it("should accept children", function()
 local varType = createFragment({})
 expect(createFragment({
 key = varType
 }).elements.key).to.equal(varType)
	end)
end
