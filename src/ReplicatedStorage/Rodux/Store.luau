local RunService = game:GetService("RunService")
local Signal = require(script.Parent.Signal)
local NoYield = require(script.Parent.NoYield)
local errorReporterDefaults = {
	reportReducerError = function(state, action, errorInfo)
 error(string.format("Received error: %s\n\n%s", errorInfo.message, errorInfo.thrownValue))
	end,
	reportUpdateError = function(oldState, newState, actionLog, errorInfo)
 error(string.format("Received error: %s\n\n%s", errorInfo.message, errorInfo.thrownValue))
	end
}
local function tracebackReporter(error)
	return debug.traceback((tostring(error)))
end
local StoreMetatable = {
	_flushEvent = RunService.Heartbeat
}
StoreMetatable.__index = StoreMetatable
function StoreMetatable.new(reducer, initialState, middlewares, errorReporter)
	assert(typeof(reducer) == "function", "Bad argument #1 to Store.new, expected function.")
	assert(middlewares == nil or typeof(middlewares) == "table", "Bad argument #3 to Store.new, expected nil or table.")
	if middlewares ~= nil then
 for i = 1, #middlewares do
 assert(typeof(middlewares[i]) == "function", ("Expected the middleware ('%s') at index %d to be a function."):format(tostring(middlewares[i]), i))
 end
	end
	local storeInstance = {}
	storeInstance._errorReporter = errorReporter or errorReporterDefaults
	storeInstance._isDispatching = false
	storeInstance._reducer = reducer
	local initAction = {
  type = "@@INIT"
	}
	storeInstance._actionLog = { initAction }
	local success, initializedState = xpcall(function()
  storeInstance._state = reducer(initialState, initAction)
	end, tracebackReporter)
	if not success then
  storeInstance._errorReporter.reportReducerError(initialState, initAction, {
  message = "Caught error in reducer with init",
  thrownValue = initializedState
  })
  storeInstance._state = initialState
	end
	storeInstance._lastState = storeInstance._state
	storeInstance._mutatedSinceFlush = false
	storeInstance._connections = {}
	storeInstance.changed = Signal.new(storeInstance)
	setmetatable(storeInstance, StoreMetatable)
	table.insert(storeInstance._connections, (storeInstance._flushEvent:Connect(function()
  storeInstance:flush()
	end)))
	if middlewares then
  local dispatch = storeInstance.dispatch
  local function createWrappedDispatch(...)
  return dispatch(storeInstance, ...)
  end
  for j = #middlewares, 1, -1 do
  createWrappedDispatch = middlewares[j](createWrappedDispatch, storeInstance)
  end
  function storeInstance.dispatch(self, ...)
  return createWrappedDispatch(...)
  end
	end
	return storeInstance
end
function StoreMetatable.getState(self)
	if self._isDispatching then
  local errorFunc = error
  errorFunc(("You may not call store:getState() while the reducer is executing. The reducer (%s) has already received the state as an argument. Pass it down from the top reducer instead of reading it from the store."):format((tostring(self._reducer))))
	end
	return self._state
end
function StoreMetatable.dispatch(self, action)
	if typeof(action) ~= "table" then
  error(("Actions must be tables. Use custom middleware for %q actions."):format((typeof(action))), 2)
	end
	if action.type == nil then
  error("Actions may not have an undefined 'type' property. " .. "Have you misspelled a constant? \n" .. tostring(action), 2)
	end
	if self._isDispatching then
  error("Reducers may not dispatch actions.")
	end
	local dispatchSuccess, dispatchError = pcall(function()
  self._isDispatching = true
  self._state = self._reducer(self._state, action)
  self._mutatedSinceFlush = true
	end)
	self._isDispatching = false
	if not dispatchSuccess then
  self._errorReporter.reportReducerError(self._state, action, {
  message = "Caught error in reducer",
  thrownValue = dispatchError
  })
	end
	if #self._actionLog == 3 then
  table.remove(self._actionLog, 1)
	end
	table.insert(self._actionLog, action)
end
function StoreMetatable.destruct(self)
	for i, connection in ipairs(self._connections) do
  connection:Disconnect()
	end
	self._connections = nil
end
function StoreMetatable.flush(self)
	if self._mutatedSinceFlush then
  self._mutatedSinceFlush = false
  local currentState = self._state
  local flushSuccess, flushError = xpcall(function()
  NoYield(function()
  self.changed:fire(currentState, self._lastState)
  end)
  end, tracebackReporter)
  if not flushSuccess then
  self._errorReporter.reportUpdateError(self._lastState, currentState, self._actionLog, {
  message = "Caught error flushing store updates",
  thrownValue = flushError
  })
  end
  self._lastState = currentState
	end
end
return StoreMetatable
