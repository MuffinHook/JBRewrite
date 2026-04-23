return function() --[[ Line: 1 ]]
	local None = require(script.Parent.None)
	local assign = require(script.Parent.assign)
	it("should accept zero additional tables", function() --[[ Line: 6 | Upvalues: assign (copy) ]]
		local t = {}
		local v1 = assign(t)
		expect(t).to.equal(v1)
	end)
	it("should merge multiple tables onto the given target table", function() --[[ Line: 13 | Upvalues: assign (copy) ]]
		local t = {
			a = 5,
			b = 6
		}
		local t2 = {
			b = 7,
			c = 8
		}
		local t3 = {
			b = 8
		}
		assign(t, t2, t3)
		expect(t.a).to.equal(5)
		expect(t.b).to.equal(t3.b)
		expect(t.c).to.equal(t2.c)
	end)
	it("should remove keys if specified as None", function() --[[ Line: 35 | Upvalues: None (copy), assign (copy) ]]
		local t = {
			foo = 2,
			bar = 3
		}
		assign(t, {
			foo = None
		})
		expect(t.foo).to.equal(nil)
		expect(t.bar).to.equal(3)
	end)
	it("should re-add keys if specified after None", function() --[[ Line: 51 | Upvalues: None (copy), assign (copy) ]]
		local t = {
			foo = 2
		}
		local t2 = {
			foo = 3
		}
		assign(t, {
			foo = None
		}, t2)
		expect(t.foo).to.equal(t2.foo)
	end)
end