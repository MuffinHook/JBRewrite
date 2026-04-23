return function() --[[ Line: 1 ]]
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	it("should be extendable", function() --[[ Line: 6 | Upvalues: Component (copy), Type (copy) ]]
		local v1 = Component:extend("The Senate")
		expect(v1).to.be.ok()
		expect(Type.of(v1)).to.equal(Type.StatefulComponentClass)
	end)
	it("should prevent extending a user component", function() --[[ Line: 13 | Upvalues: Component (copy) ]]
		local v1 = Component:extend("Sheev")
		expect(function() --[[ Line: 16 | Upvalues: v1 (copy) ]]
			v1:extend("Frank")
		end).to.throw()
	end)
	it("should use a given name", function() --[[ Line: 21 | Upvalues: Component (copy) ]]
		local v2 = tostring((Component:extend("FooBar")))
		expect(v2).to.be.a("string")
		expect(v2:find("FooBar")).to.be.ok()
	end)
end