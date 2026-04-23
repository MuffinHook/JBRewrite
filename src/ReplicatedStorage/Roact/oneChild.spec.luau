return function() --[[ Line: 1 ]]
	local createElement = require(script.Parent.createElement)
	local oneChild = require(script.Parent.oneChild)
	it("should get zero children from a table", function() --[[ Line: 6 | Upvalues: oneChild (copy) ]]
		expect(oneChild({})).to.equal(nil)
	end)
	it("should get exactly one child", function() --[[ Line: 12 | Upvalues: createElement (copy), oneChild (copy) ]]
		local v1 = createElement("Frame")
		expect(oneChild({
			foo = v1
		})).to.equal(v1)
	end)
	it("should error with more than one child", function() --[[ Line: 21 | Upvalues: createElement (copy), oneChild (copy) ]]
		local t = {
			a = createElement("Frame"),
			b = createElement("Frame")
		}
		expect(function() --[[ Line: 27 | Upvalues: oneChild (ref), t (copy) ]]
			oneChild(t)
		end).to.throw()
	end)
	it("should handle being passed nil", function() --[[ Line: 32 | Upvalues: oneChild (copy) ]]
		expect(oneChild(nil)).to.equal(nil)
	end)
end