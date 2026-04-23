return function() --[[ Line: 1 ]]
	local ElementKind = require(script.Parent.ElementKind)
	local Type = require(script.Parent.Type)
	local createFragment = require(script.Parent.createFragment)
	it("should create new primitive elements", function() --[[ Line: 7 | Upvalues: createFragment (copy), Type (copy), ElementKind (copy) ]]
		local v1 = createFragment({})
		expect(v1).to.be.ok()
		expect(Type.of(v1)).to.equal(Type.Element)
		expect(ElementKind.of(v1)).to.equal(ElementKind.Fragment)
	end)
	it("should accept children", function() --[[ Line: 15 | Upvalues: createFragment (copy) ]]
		local v1 = createFragment({})
		expect(createFragment({
			key = v1
		}).elements.key).to.equal(v1)
	end)
end