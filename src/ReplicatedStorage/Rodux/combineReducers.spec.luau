return function()
	local combineReducers = require(script.Parent.combineReducers)
	it("should invoke each sub-reducer for every action", function()
 local callCountA = 0
 local callCountB = 0
 combineReducers({
 a = function(state, action)
 callCountA = callCountA + 1
 end,
 b = function(state, action)
 callCountB = callCountB + 1
 end
 })({}, {})
 expect(callCountA).to.equal(1)
 expect(callCountB).to.equal(1)
	end)
	it("should assign each sub-reducer\'s value to the new state", function()
 local reducerResult = combineReducers({
 a = function(state, action)
 return (state or 0) + 1
 end,
 b = function(state, action)
 return (state or 0) + 3
 end
 })({}, {})
 expect(reducerResult.a).to.equal(1)
 expect(reducerResult.b).to.equal(3)
	end)
	it("should not throw when state is nil", function()
 local combinedReducer = combineReducers({
 a = function(state, action)
 return (state or 0) + 1
 end,
 b = function(state, action)
 return (state or 0) + 3
 end
 })
 expect(function()
 combinedReducer(nil, {})
 end).to.never.throw()
	end)
end
