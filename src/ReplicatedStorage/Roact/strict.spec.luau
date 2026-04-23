return function() --[[ Line: 1 ]]
	local strict = require(script.Parent.strict)
	it("should error when getting a nonexistent key", function() --[[ Line: 4 | Upvalues: strict (copy) ]]
		local v1 = strict({
			a = 1,
			b = 2
		})
		expect(function() --[[ Line: 10 | Upvalues: v1 (copy) ]]
			return v1.c
		end).to.throw()
	end)
	it("should error when setting a nonexistent key", function() --[[ Line: 15 | Upvalues: strict (copy) ]]
		local v1 = strict({
			a = 1,
			b = 2
		})
		expect(function() --[[ Line: 21 | Upvalues: v1 (copy) ]]
			v1.c = 3
		end).to.throw()
	end)
end