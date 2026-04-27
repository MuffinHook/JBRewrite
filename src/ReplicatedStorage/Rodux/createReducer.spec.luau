return function()
	local createReducer = require(script.Parent.createReducer)
	it("should handle actions", function()
 local reducer = createReducer({
 a = 0,
 b = 0
 }, {
 a = function(state, action)
 return {
 a = state.a + 1,
 b = state.b
 }
 end,
 b = function(state, action)
 return {
 a = state.a,
 b = state.b + 2
 }
 end
 })
 local nextState = reducer({
 a = 0,
 b = 0
 }, {
 type = "a"
 })
 expect(nextState.a).to.equal(1)
 expect(reducer(nextState, {
 type = "b"
 }).b).to.equal(2)
	end)
	it("should return the initial state if the state is nil", function()
 local resultState = createReducer({
 a = 0,
 b = 0
 }, {})(nil, {})
 expect(resultState).to.be.ok()
 expect(resultState.a).to.equal(0)
 expect(resultState.b).to.equal(0)
	end)
	it("should still run action handlers if the state is nil", function()
 local callCount = 0
 local reducer = createReducer(0, {
 foo = function(state, action)
 callCount = callCount + 1
 return nil
 end
 })
 expect(callCount).to.equal(0)
 local resultState = reducer(nil, {
 type = "foo"
 })
 expect(callCount).to.equal(1)
 expect(resultState).to.equal(nil)
 local secondResult = reducer(resultState, {
 type = "foo"
 })
 expect(callCount).to.equal(2)
 expect(secondResult).to.equal(nil)
	end)
	it("should return the same state if the action is not handled", function()
 local initialState = {
 a = 0,
 b = 0
 }
 expect((createReducer(initialState, {
 a = function(state, action)
 return {
 a = state.a + 1,
 b = state.b
 }
 end,
 b = function(state, action)
 return {
 a = state.a,
 b = state.b + 2
 }
 end
 })(initialState, {
 type = "c"
 }))).to.equal(initialState)
	end)
end
