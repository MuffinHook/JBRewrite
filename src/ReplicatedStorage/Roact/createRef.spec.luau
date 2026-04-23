return function() --[[ Line: 1 ]]
	local Binding = require(script.Parent.Binding)
	local Type = require(script.Parent.Type)
	local createRef = require(script.Parent.createRef)
	it("should create refs, which are specialized bindings", function() --[[ Line: 7 | Upvalues: createRef (copy), Type (copy) ]]
		local v1 = createRef()
		expect(Type.of(v1)).to.equal(Type.Binding)
		expect(v1.current).to.equal(nil)
	end)
	it("should have a \'current\' field that is the same as the internal binding\'s value", function() --[[ Line: 14 | Upvalues: createRef (copy), Binding (copy) ]]
		local v1 = createRef()
		expect(v1.current).to.equal(nil)
		Binding.update(v1, 10)
		expect(v1.current).to.equal(10)
	end)
	it("should support tostring on refs", function() --[[ Line: 23 | Upvalues: createRef (copy), Binding (copy) ]]
		local v1 = createRef()
		expect(v1.current).to.equal(nil)
		expect((tostring(v1))).to.equal("RoactRef(nil)")
		Binding.update(v1, 10)
		expect((tostring(v1))).to.equal("RoactRef(10)")
	end)
	it("should not allow assignments to the \'current\' field", function() --[[ Line: 33 | Upvalues: createRef (copy), Binding (copy) ]]
		local v1 = createRef()
		expect(v1.current).to.equal(nil)
		Binding.update(v1, 99)
		expect(v1.current).to.equal(99)
		expect(function() --[[ Line: 41 | Upvalues: v1 (copy) ]]
			v1.current = 77
		end).to.throw()
		expect(v1.current).to.equal(99)
	end)
	it("should return the same thing from getValue as its current field", function() --[[ Line: 48 | Upvalues: createRef (copy), Binding (copy) ]]
		local v1 = createRef()
		Binding.update(v1, 10)
		expect(v1:getValue()).to.equal(10)
		expect(v1:getValue()).to.equal(v1.current)
	end)
end