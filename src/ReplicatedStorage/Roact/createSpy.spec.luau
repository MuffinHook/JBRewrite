return function() --[[ Line: 1 ]]
	local createSpy = require(script.Parent.createSpy)
	describe("createSpy", function() --[[ Line: 4 | Upvalues: createSpy (copy) ]]
		it("should create spies", function() --[[ Line: 5 | Upvalues: createSpy (ref) ]]
			expect((createSpy(function() --[[ Line: 6 ]] end))).to.be.ok()
		end)
		it("should throw if spies are indexed by an invalid key", function() --[[ Line: 11 | Upvalues: createSpy (ref) ]]
			local v1 = createSpy(function() --[[ Line: 12 ]] end)
			expect(function() --[[ Line: 14 | Upvalues: v1 (copy) ]]
				return v1.test
			end).to.throw()
		end)
	end)
	describe("value", function() --[[ Line: 20 | Upvalues: createSpy (copy) ]]
		it("should increment callCount when called", function() --[[ Line: 21 | Upvalues: createSpy (ref) ]]
			local v1 = createSpy(function() --[[ Line: 22 ]] end)
			v1.value()
			expect(v1.callCount).to.equal(1)
		end)
		it("should store all values passed", function() --[[ Line: 28 | Upvalues: createSpy (ref) ]]
			local v1 = createSpy(function() --[[ Line: 29 ]] end)
			v1.value(1, true, "3")
			expect(v1.valuesLength).to.equal(3)
			expect(v1.values[1]).to.equal(1)
			expect(v1.values[2]).to.equal(true)
			expect(v1.values[3]).to.equal("3")
		end)
		it("should return the value of the inner function", function() --[[ Line: 38 | Upvalues: createSpy (ref) ]]
			expect(createSpy(function() --[[ Line: 39 ]]
				return true
			end).value()).to.equal(true)
		end)
	end)
	describe("assertCalledWith", function() --[[ Line: 47 | Upvalues: createSpy (copy) ]]
		it("should throw if the number of values differs", function() --[[ Line: 48 | Upvalues: createSpy (ref) ]]
			local v1 = createSpy(function() --[[ Line: 49 ]] end)
			v1.value(1, 2)
			expect(function() --[[ Line: 52 | Upvalues: v1 (copy) ]]
				v1:assertCalledWith(1)
			end).to.throw()
		end)
		it("should throw if any value differs", function() --[[ Line: 57 | Upvalues: createSpy (ref) ]]
			local v1 = createSpy(function() --[[ Line: 58 ]] end)
			v1.value(1, 2)
			expect(function() --[[ Line: 61 | Upvalues: v1 (copy) ]]
				v1:assertCalledWith(1, 3)
			end).to.throw()
			expect(function() --[[ Line: 65 | Upvalues: v1 (copy) ]]
				v1:assertCalledWith(2, 3)
			end).to.throw()
		end)
	end)
	describe("captureValues", function() --[[ Line: 71 | Upvalues: createSpy (copy) ]]
		it("should throw if the number of values differs", function() --[[ Line: 72 | Upvalues: createSpy (ref) ]]
			local v1 = createSpy(function() --[[ Line: 73 ]] end)
			v1.value(1, 2)
			expect(function() --[[ Line: 76 | Upvalues: v1 (copy) ]]
				v1:captureValues("a")
			end).to.throw()
		end)
		it("should capture all values in a table", function() --[[ Line: 81 | Upvalues: createSpy (ref) ]]
			local v1 = createSpy(function() --[[ Line: 82 ]] end)
			v1.value(1, 2)
			local v2 = v1:captureValues("a", "b")
			expect(v2.a).to.equal(1)
			expect(v2.b).to.equal(2)
		end)
	end)
end