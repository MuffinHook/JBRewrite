return function()
	local Store = require(script.Parent.Store)
	local thunkMiddleware = require(script.Parent.thunkMiddleware)
	it("should dispatch thunks", function()
 local function reducer(state, action)
 return state
 end
 local dispatchCount = 0
 Store.new(reducer, {}, { thunkMiddleware }):dispatch(function(dispatch)
 dispatchCount = dispatchCount + 1
 end)
 expect(dispatchCount).to.equal(1)
	end)
	it("should allow normal actions to pass through", function()
 local reducerCallCount = 0
 local function reducer(state, action)
 reducerCallCount = reducerCallCount + 1
 return state
 end
 Store.new(reducer, {}, { thunkMiddleware }):dispatch({
 type = "test"
 })
 expect(reducerCallCount).to.equal(2)
	end)
	it("should return the value from the thunk", function()
 local function reducer(state, action)
 return state
 end
 expect((Store.new(reducer, {}, { thunkMiddleware }):dispatch(function(dispatch)
 return "test"
 end))).to.equal("test")
	end)
	it("should report errors captured in thunks via the provided error reporter", function()
 local capturedState = nil
 local capturedAction = nil
 local capturedError = nil
 local errorReporter = {
 reportReducerError = function(state, action, error)
 capturedState = state
 capturedAction = action
 capturedError = error
 end
 }
 local function reducer(state, action)
 return state
 end
 local store = Store.new(reducer, {
 Value = 1
 }, { thunkMiddleware }, errorReporter)
 local function thunk(dispatch)
 error("thunk failed")
 end
 store:dispatch(thunk)
 expect(capturedState.Value).to.equal(1)
 expect(capturedAction).to.equal(thunk)
 expect(capturedError.message).to.equal("Caught error in thunk")
	end)
	it("should recover and continue to update after a thunk errors", function()
 local capturedErrorMessage = nil
 local errorReporter = {
 reportReducerError = function(state, action, error)
 capturedErrorMessage = error
 end
 }
 local function reducer(state, action)
 return state
 end
 local store = Store.new(reducer, {
 Value = 1
 }, { thunkMiddleware }, errorReporter)
 local function errorThunk(dispatch)
 error("thunk failed")
 end
 local safeThunkExecuted = false
 local function safeThunk(dispatch)
 safeThunkExecuted = true
 end
 store:dispatch(errorThunk)
 expect(capturedErrorMessage.message).to.equal("Caught error in thunk")
 store:dispatch(safeThunk)
 expect(safeThunkExecuted).to.equal(true)
	end)
end
