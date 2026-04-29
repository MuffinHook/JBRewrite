return function()
	local Store = require(script.Parent.Store)
	describe("new", function()
 it("should instantiate with a reducer", function()
 local store = Store.new(function(state, action)
 return "hello, world"
 end)
 expect(store).to.be.ok()
 expect(store:getState()).to.equal("hello, world")
 store:destruct()
 end)
 it("should instantiate with a reducer and an initial state", function()
 local store = Store.new(function(state, action)
 return state
 end, "initial state")
 expect(store).to.be.ok()
 expect(store:getState()).to.equal("initial state")
 store:destruct()
 end)
 it("should instantiate with a reducer, initial state, and middlewares", function()
 local store = Store.new(function(state, action)
 return state
 end, "initial state", {})
 expect(store).to.be.ok()
 expect(store:getState()).to.equal("initial state")
 store:destruct()
 end)
 it("should modify the dispatch method when middlewares are passed", function()
 local middlewareCallCount = 0
 local dispatchCallCount = 0
 local capturedMiddlewareState = nil
 local capturedMiddlewareStore = nil
 local capturedDispatchAction = nil
 local function reducer(state, action)
 if action.type == "test" then
 return "test state"
 else
 return state
 end
 end
 local store = Store.new(reducer, "initial state", { function(middlewareState, middlewareStore)
 middlewareCallCount = middlewareCallCount + 1
 capturedMiddlewareState = middlewareState
 capturedMiddlewareStore = middlewareStore
 return function(action)
 dispatchCallCount = dispatchCallCount + 1
 capturedDispatchAction = action
 middlewareState(action)
 end
 end })
 expect(middlewareCallCount).to.equal(1)
 expect(dispatchCallCount).to.equal(0)
 expect(capturedMiddlewareState).to.be.a("function")
 expect(capturedMiddlewareStore).to.equal(store)
 store:dispatch({
 type = "test"
 })
 expect(middlewareCallCount).to.equal(1)
 expect(dispatchCallCount).to.equal(1)
 expect(capturedDispatchAction.type).to.equal("test")
 store:flush()
 expect(store:getState()).to.equal("test state")
 store:destruct()
 end)
 it("should execute middleware left-to-right", function()
 local tbl = {}
 local function reducer(state)
 return state
 end
 local store = Store.new(reducer, 5, { function(middlewareState, middlewareStore)
 table.insert(tbl, "instantiate a")
 return function(action)
 table.insert(tbl, "execute a")
 return middlewareState(action)
 end
 end, function(middlewareState, middlewareStore)
 table.insert(tbl, "instantiate b")
 return function(action)
 table.insert(tbl, "execute b")
 return middlewareState(action)
 end
 end })
 expect(#tbl).to.equal(2)
 expect(tbl[1]).to.equal("instantiate b")
 expect(tbl[2]).to.equal("instantiate a")
 store:dispatch({
 type = "test"
 })
 expect(#tbl).to.equal(4)
 expect(tbl[3]).to.equal("execute a")
 expect(tbl[4]).to.equal("execute b")
 store:destruct()
 end)
 it("should send an initial action with a 'type' field", function()
 local capturedAction = nil
 local initActionCount = 0
 local store = Store.new(function(state, action)
 capturedAction = action
 initActionCount = initActionCount + 1
 return state
 end)
 expect(initActionCount).to.equal(1)
 expect(capturedAction).to.be.a("table")
 expect(capturedAction.type).to.be.ok()
 store:destruct()
 end)
 it("should report a reducer error thrown when handling the INIT action", function()
 local capturedState = nil
 local capturedAction = nil
 local capturedError = nil
 local errorReporter = {
 reportReducerError = function(state, action, errorInfo)
 capturedState = state
 capturedAction = action
 capturedError = errorInfo
 end,
 reportUpdateError = function() end
 }
 local store = Store.new(function(state, action)
 error("Z4PH0D")
 end, {
 Value = 1
 }, nil, errorReporter)
 expect(capturedState.Value).to.equal(1)
 expect(capturedAction.type).to.equal("@@INIT")
 expect(capturedError.message).to.equal("Caught error in reducer with init")
 expect(string.find(capturedError.thrownValue, "Z4PH0D")).to.be.ok()
 expect(string.find(capturedError.thrownValue, script.Name)).to.be.ok()
 store:destruct()
 end)
 it("should report a reducer error thrown when handling a subsequent action", function()
 local capturedState = nil
 local capturedAction = nil
 local capturedError = nil
 local errorReporter = {
 reportReducerError = function(state, action, errorInfo)
 capturedState = state
 capturedAction = action
 capturedError = errorInfo
 end,
 reportUpdateError = function() end
 }
 local store = Store.new(function(state, action)
 if action.type == "ThrowError" then
 error("Z4PH0D")
 elseif action.type == "Increment" then
 return {
 Value = state.Value + 1
 }
 else
 return state
 end
 end, {
 Value = 1
 }, nil, errorReporter)
 expect(capturedState).to.equal(nil)
 expect(capturedAction).to.equal(nil)
 expect(capturedError).to.equal(nil)
 store:dispatch({
 type = "Increment"
 })
 store:dispatch({
 type = "ThrowError"
 })
 expect(capturedState.Value).to.equal(2)
 expect(capturedAction.type).to.equal("ThrowError")
 expect(capturedError.message).to.equal("Caught error in reducer")
 expect(string.find(capturedError.thrownValue, "Z4PH0D")).to.be.ok()
 expect(string.find(capturedError.thrownValue, script.Name)).to.be.ok()
 store:destruct()
 end)
	end)
	describe("getState", function()
 it("should get the current state", function()
 local store = Store.new(function(state, action)
 return "foo"
 end)
 expect((store:getState())).to.equal("foo")
 store:destruct()
 end)
 it("should throw errors if triggered during dispatches", function()
 local store = nil
 store = Store.new(function(state, action)
 if action.type ~= "@@INIT" then
 store:getState()
 end
 end)
 expect(function()
 store:dispatch({
 type = "SomeAction"
 })
 end).to.throw()
 store:destruct()
 end)
	end)
	describe("dispatch", function()
 it("should be sent through the reducer", function()
 local store = Store.new(function(state, action)
 local currentState = state or "foo"
 if action.type == "act" then
 return "bar"
 else
 return currentState
 end
 end)
 expect(store).to.be.ok()
 expect(store:getState()).to.equal("foo")
 store:dispatch({
 type = "act"
 })
 store:flush()
 expect(store:getState()).to.equal("bar")
 store:destruct()
 end)
 it("should trigger the changed event after a flush", function()
 local store = Store.new(function(state, action)
 local currentState = state or 0
 if action.type == "increment" then
 return currentState + 1
 else
 return currentState
 end
 end)
 local changedEventCount = 0
 store.changed:connect(function(newState, oldState)
 expect(oldState).to.equal(0)
 expect(newState).to.equal(1)
 changedEventCount = changedEventCount + 1
 end)
 store:dispatch({
 type = "increment"
 })
 store:flush()
 expect(changedEventCount).to.equal(1)
 store:destruct()
 end)
 it("should handle actions dispatched within the changed event", function()
 local store = Store.new(function(state, action)
 local currentState = state or {
 value = 0
 }
 if action.type == "increment" then
 return {
 value = currentState.value + 1
 }
 elseif action.type == "decrement" then
 return {
 value = currentState.value - 1
 }
 else
 return currentState
 end
 end)
 local changedEventCount = 0
 store.changed:connect(function(newState, oldState)
 expect(newState).never.to.equal(oldState)
 if newState.value > 0 then
 store:dispatch({
 type = "decrement"
 })
 end
 changedEventCount = changedEventCount + 1
 end)
 store:dispatch({
 type = "increment"
 })
 store:flush()
 store:flush()
 expect(changedEventCount).to.equal(2)
 store:destruct()
 end)
 it("should prevent yielding from changed handler", function()
 local capturedErrorMessage = nil
 local capturedErrorValue = nil
 local errorReporter = {
 reportUpdateError = function(state, action, errorInfo, errorDetails)
 capturedErrorMessage = errorDetails.message
 capturedErrorValue = errorDetails.thrownValue
 end,
 reportReducerError = function() end
 }
 local changedEventInvokeCount = 0
 local changedEventCompleteCount = 0
 local store = Store.new(function(state, action)
 return (state or 0) + 1
 end, nil, nil, errorReporter)
 store.changed:connect(function(newState, oldState)
 changedEventInvokeCount = changedEventInvokeCount + 1
 task.wait()
 changedEventCompleteCount = changedEventCompleteCount + 1
 end)
 store:dispatch({
 type = "increment"
 })
 store:flush()
 expect(changedEventInvokeCount).to.equal(1)
 expect(changedEventCompleteCount).to.equal(0)
 expect(capturedErrorMessage).to.equal("Caught error flushing store updates")
 expect(string.find(capturedErrorValue, script.Name)).to.be.ok()
 expect(string.find(capturedErrorValue, "to yield")).to.be.ok()
 store:destruct()
 end)
 it("should throw if an action is dispatched without a type field", function()
 local store = Store.new(function(state, action)
 return state
 end)
 expect(function()
 store:dispatch({})
 end).to.throw()
 store:destruct()
 end)
 it("should throw if the action is not a function or table", function()
 local store = Store.new(function(state, action)
 return state
 end)
 expect(function()
 store:dispatch(1)
 end).to.throw()
 store:destruct()
 end)
 it("should report an error if the listeners error when flushing", function()
 local capturedInitialState = nil
 local capturedAction = nil
 local capturedDispatchedActions = nil
 local capturedNewState = nil
 local errorReporter = {
 reportReducerError = function() end,
 reportUpdateError = function(initialState, newState, dispatchedActions, errorInfo)
 capturedInitialState = initialState
 capturedNewState = newState
 capturedDispatchedActions = dispatchedActions
 capturedAction = errorInfo
 end
 }
 local store = Store.new(function(state, action)
 if action.type == "Increment" then
 return {
 Value = state.Value + action.amount
 }
 else
 return state
 end
 end, {
 Value = 1
 }, nil, errorReporter)
 store.changed:connect(function(newState, oldState)
 if newState.Value == 15 then
 error("Z4PH0D")
 end
 end)
 local list = {
 {
 type = "Increment",
 amount = 1
 },
 {
 type = "Increment",
 amount = 3
 },
 {
 type = "Increment",
 amount = 10
 }
 }
 for i, v in ipairs(list) do
 store:dispatch(v)
 end
 store:flush()
 expect(capturedAction.message).to.equal("Caught error flushing store updates")
 expect(string.find(capturedAction.thrownValue, script.Name)).to.be.ok()
 expect(capturedDispatchedActions[1]).to.equal(list[1])
 expect(capturedDispatchedActions[2]).to.equal(list[2])
 expect(capturedDispatchedActions[3]).to.equal(list[3])
 expect(capturedInitialState.Value).to.equal(1)
 expect(capturedNewState.Value).to.equal(15)
 store:destruct()
 end)
 it("should throw errors if dispatching while a dispatch is already happening", function()
 local store = nil
 store = Store.new(function(state, action)
 if action.type == "SomeAction" then
 store:dispatch({
 type = "MidDispatchAction"
 })
 end
 end)
 expect(function()
 store:dispatch({
 type = "SomeAction"
 })
 end).to.throw()
 store:destruct()
 end)
	end)
	describe("flush", function()
 it("should not fire a changed event if there were no dispatches", function()
 local store = Store.new(function() end)
 local changedEventCount = 0
 store.changed:connect(function()
 changedEventCount = changedEventCount + 1
 end)
 store:flush()
 expect(changedEventCount).to.equal(0)
 store:dispatch({
 type = "increment"
 })
 store:flush()
 expect(changedEventCount).to.equal(1)
 store:flush()
 expect(changedEventCount).to.equal(1)
 store:destruct()
 end)
	end)
end
