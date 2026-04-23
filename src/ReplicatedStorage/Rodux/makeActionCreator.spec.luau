return function() --[[ Line: 1 ]]
	local makeActionCreator = require(script.Parent.makeActionCreator)
	it("should set the name of the actionCreator creator", function() --[[ Line: 4 | Upvalues: makeActionCreator (copy) ]]
		expect(makeActionCreator("foo", function() --[[ Line: 5 ]]
			return {}
		end).name).to.equal("foo")
	end)
	it("should return a table when called as a function", function() --[[ Line: 12 | Upvalues: makeActionCreator (copy) ]]
		expect(makeActionCreator("foo", function() --[[ Line: 13 ]]
			return {}
		end)()).to.be.a("table")
	end)
	it("should set the type of the action creator", function() --[[ Line: 20 | Upvalues: makeActionCreator (copy) ]]
		expect(makeActionCreator("foo", function() --[[ Line: 21 ]]
			return {}
		end)().type).to.equal("foo")
	end)
	it("should set values", function() --[[ Line: 28 | Upvalues: makeActionCreator (copy) ]]
		expect(makeActionCreator("foo", function(p1) --[[ Line: 29 ]]
			return {
				value = p1
			}
		end)(100).value).to.equal(100)
	end)
	it("should throw when its result does not return a table", function() --[[ Line: 38 | Upvalues: makeActionCreator (copy) ]]
		expect((makeActionCreator("foo", function() --[[ Line: 39 ]]
			return function() --[[ Line: 40 ]] end
		end))).to.throw()
	end)
	it("should throw if the first argument is not a string", function() --[[ Line: 46 | Upvalues: makeActionCreator (copy) ]]
		expect(function() --[[ Line: 47 | Upvalues: makeActionCreator (ref) ]]
			makeActionCreator(nil, function() --[[ Line: 48 ]]
				return {}
			end)
		end).to.throw()
		expect(function() --[[ Line: 53 | Upvalues: makeActionCreator (ref) ]]
			makeActionCreator(100, function() --[[ Line: 54 ]]
				return {}
			end)
		end).to.throw()
	end)
	it("should throw if the second argument is not a function", function() --[[ Line: 60 | Upvalues: makeActionCreator (copy) ]]
		expect(function() --[[ Line: 61 | Upvalues: makeActionCreator (ref) ]]
			makeActionCreator("foo", nil)
		end).to.throw()
		expect(function() --[[ Line: 65 | Upvalues: makeActionCreator (ref) ]]
			makeActionCreator("foo", {})
		end).to.throw()
	end)
end