return function() --[[ Line: 1 ]]
	local Symbol = require(script.Parent.Symbol)
	describe("named", function() --[[ Line: 4 | Upvalues: Symbol (copy) ]]
		it("should give an opaque object", function() --[[ Line: 5 | Upvalues: Symbol (ref) ]]
			expect((Symbol.named("foo"))).to.be.a("userdata")
		end)
		it("should coerce to the given name", function() --[[ Line: 11 | Upvalues: Symbol (ref) ]]
			expect(tostring((Symbol.named("foo"))):find("foo")).to.be.ok()
		end)
		it("should be unique when constructed", function() --[[ Line: 17 | Upvalues: Symbol (ref) ]]
			local v1 = Symbol.named("abc")
			local v2 = Symbol.named("abc")
			expect(v1).never.to.equal(v2)
		end)
	end)
	describe("unnamed", function() --[[ Line: 25 | Upvalues: Symbol (copy) ]]
		it("should give an opaque object", function() --[[ Line: 26 | Upvalues: Symbol (ref) ]]
			expect((Symbol.unnamed())).to.be.a("userdata")
		end)
		it("should coerce to some string", function() --[[ Line: 32 | Upvalues: Symbol (ref) ]]
			expect((tostring((Symbol.unnamed())))).to.be.a("string")
		end)
		it("should be unique when constructed", function() --[[ Line: 38 | Upvalues: Symbol (ref) ]]
			local v1 = Symbol.unnamed()
			local v2 = Symbol.unnamed()
			expect(v1).never.to.equal(v2)
		end)
	end)
end