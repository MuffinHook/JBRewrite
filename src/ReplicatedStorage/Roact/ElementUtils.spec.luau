return function() --[[ Line: 1 ]]
	local ElementUtils = require(script.Parent.ElementUtils)
	local createElement = require(script.Parent.createElement)
	local createFragment = require(script.Parent.createFragment)
	local Type = require(script.Parent.Type)
	describe("iterateElements", function() --[[ Line: 7 | Upvalues: createElement (copy), ElementUtils (copy), Type (copy) ]]
		it("should iterate once for a single child", function() --[[ Line: 8 | Upvalues: createElement (ref), ElementUtils (ref) ]]
			local v1 = createElement("TextLabel")
			local v2 = ElementUtils.iterateElements(v1)
			local v3, v4 = v2()
			expect(v3).to.equal(ElementUtils.UseParentKey)
			expect(v4).to.equal(v1)
			expect((v2())).to.equal(nil)
		end)
		it("should iterate over tables", function() --[[ Line: 20 | Upvalues: createElement (ref), ElementUtils (ref), Type (ref) ]]
			local t = {
				a = createElement("TextLabel"),
				b = createElement("TextLabel")
			}
			local t2 = {}
			local count = 0
			for v1, v2 in ElementUtils.iterateElements(t) do
				expect((typeof(v1))).to.equal("string")
				expect(Type.of(v2)).to.equal(Type.Element)
				t2[v2] = v1
				count = count + 1
			end
			expect(count).to.equal(2)
			expect(t2[t.a]).to.equal("a")
			expect(t2[t.b]).to.equal("b")
		end)
		it("should return a zero-element iterator for booleans", function() --[[ Line: 41 | Upvalues: ElementUtils (ref) ]]
			expect(ElementUtils.iterateElements(false)()).to.equal(nil)
		end)
		it("should return a zero-element iterator for nil", function() --[[ Line: 46 | Upvalues: ElementUtils (ref) ]]
			expect(ElementUtils.iterateElements(nil)()).to.equal(nil)
		end)
		it("should throw if given an illegal value", function() --[[ Line: 51 | Upvalues: ElementUtils (ref) ]]
			expect(function() --[[ Line: 52 | Upvalues: ElementUtils (ref) ]]
				ElementUtils.iterateElements(1)
			end).to.throw()
		end)
	end)
	describe("getElementByKey", function() --[[ Line: 58 | Upvalues: ElementUtils (copy), createElement (copy), createFragment (copy) ]]
		it("should return nil for booleans", function() --[[ Line: 59 | Upvalues: ElementUtils (ref) ]]
			expect(ElementUtils.getElementByKey(true, "test")).to.equal(nil)
		end)
		it("should return nil for nil", function() --[[ Line: 63 | Upvalues: ElementUtils (ref) ]]
			expect(ElementUtils.getElementByKey(nil, "test")).to.equal(nil)
		end)
		describe("single elements", function() --[[ Line: 67 | Upvalues: createElement (ref), ElementUtils (ref) ]]
			local v1 = createElement("TextLabel")
			it("should return the element if the key is UseParentKey", function() --[[ Line: 70 | Upvalues: ElementUtils (ref), v1 (copy) ]]
				expect(ElementUtils.getElementByKey(v1, ElementUtils.UseParentKey)).to.equal(v1)
			end)
			it("should return nil if the key is not UseParentKey", function() --[[ Line: 74 | Upvalues: ElementUtils (ref), v1 (copy) ]]
				expect(ElementUtils.getElementByKey(v1, "test")).to.equal(nil)
			end)
		end)
		it("should return the corresponding element from a table", function() --[[ Line: 79 | Upvalues: createElement (ref), ElementUtils (ref) ]]
			local t = {
				a = createElement("TextLabel"),
				b = createElement("TextLabel")
			}
			expect(ElementUtils.getElementByKey(t, "a")).to.equal(t.a)
			expect(ElementUtils.getElementByKey(t, "b")).to.equal(t.b)
		end)
		it("should return nil if the key does not exist", function() --[[ Line: 89 | Upvalues: createFragment (ref), ElementUtils (ref) ]]
			expect(ElementUtils.getElementByKey(createFragment({}), "a")).to.equal(nil)
		end)
	end)
end