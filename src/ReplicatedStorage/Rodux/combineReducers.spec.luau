return function() --[[ Line: 1 ]]
	local combineReducers = require(script.Parent.combineReducers)
	it("should invoke each sub-reducer for every action", function() --[[ Line: 4 | Upvalues: combineReducers (copy) ]]
		local v1 = 0
		local v2 = 0
		combineReducers({
			a = function(p1, p2) --[[ Name: a | Line: 9 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end,
			b = function(p1, p2) --[[ Name: b | Line: 12 | Upvalues: v2 (ref) ]]
				v2 = v2 + 1
			end
		})({}, {})
		expect(v1).to.equal(1)
		expect(v2).to.equal(1)
	end)
	it("should assign each sub-reducer\'s value to the new state", function() --[[ Line: 23 | Upvalues: combineReducers (copy) ]]
		local v1 = combineReducers({
			a = function(p1, p2) --[[ Name: a | Line: 25 ]]
				return (p1 or 0) + 1
			end,
			b = function(p1, p2) --[[ Name: b | Line: 28 ]]
				return (p1 or 0) + 3
			end
		})({}, {})
		expect(v1.a).to.equal(1)
		expect(v1.b).to.equal(3)
	end)
	it("should not throw when state is nil", function() --[[ Line: 38 | Upvalues: combineReducers (copy) ]]
		local v1 = combineReducers({
			a = function(p1, p2) --[[ Name: a | Line: 40 ]]
				return (p1 or 0) + 1
			end,
			b = function(p1, p2) --[[ Name: b | Line: 43 ]]
				return (p1 or 0) + 3
			end
		})
		expect(function() --[[ Line: 48 | Upvalues: v1 (copy) ]]
			v1(nil, {})
		end).to.never.throw()
	end)
end