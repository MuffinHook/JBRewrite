-- Reviewed by Claude
return function()
	local combineReducers = require(script.Parent.combineReducers)
	it("should invoke each sub-reducer for every action", function()
 local v1 = 0
 local v2 = 0
 combineReducers({
 a = function(p1, p2)
 v1 = v1 + 1
 end,
 b = function(p1, p2)
 v2 = v2 + 1
 end
 })({}, {})
 expect(v1).to.equal(1)
 expect(v2).to.equal(1)
	end)
	it("should assign each sub-reducer\'s value to the new state", function()
 local v1 = combineReducers({
 a = function(p1, p2)
 return (p1 or 0) + 1
 end,
 b = function(p1, p2)
 return (p1 or 0) + 3
 end
 })({}, {})
 expect(v1.a).to.equal(1)
 expect(v1.b).to.equal(3)
	end)
	it("should not throw when state is nil", function()
 local v1 = combineReducers({
 a = function(p1, p2)
 return (p1 or 0) + 1
 end,
 b = function(p1, p2)
 return (p1 or 0) + 3
 end
 })
 expect(function()
 v1(nil, {})
 end).to.never.throw()
	end)
end