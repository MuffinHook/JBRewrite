-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Signal = require(script.Parent.Signal)
local NoYield = require(script.Parent.NoYield)
local t = {
	reportReducerError = function(p1, p2, p3)
 error(string.format("Received error: %s\n\n%s", p3.message, p3.thrownValue))
	end,
	reportUpdateError = function(p1, p2, p3, p4)
 error(string.format("Received error: %s\n\n%s", p4.message, p4.thrownValue))
	end
}
local function tracebackReporter(p1)
	return debug.traceback((tostring(p1)))
end
local t2 = {
	_flushEvent = RunService.Heartbeat
}
t2.__index = t2
function t2.new(p1, p2, p3, p4)
	assert(typeof(p1) == "function", "Bad argument #1 to Store.new, expected function.")
	assert(p3 == nil or typeof(p3) == "table", "Bad argument #3 to Store.new, expected nil or table.")
	if p3 ~= nil then
 for i = 1, #p3 do
 assert(typeof(p3[i]) == "function", ("Expected the middleware (\'%s\') at index %d to be a function."):format(tostring(p3[i]), i))
 end
	end
	local t3 = {}
	t3._errorReporter = p4 or t
	t3._isDispatching = false
	t3._reducer = p1
	local t4 = {
 type = "@@INIT"
	}
	t3._actionLog = { t4 }
	local v8, v9 = xpcall(function()
 t3._state = p1(p2, t4)
	end, tracebackReporter)
	if not v8 then
 t3._errorReporter.reportReducerError(p2, t4, {
 message = "Caught error in reducer with init",
 thrownValue = v9
 })
 t3._state = p2
	end
	t3._lastState = t3._state
	t3._mutatedSinceFlush = false
	t3._connections = {}
	t3.changed = Signal.new(t3)
	setmetatable(t3, t2)
	table.insert(t3._connections, (t3._flushEvent:Connect(function()
 t3:flush()
	end)))
	if p3 then
 local dispatch = t3.dispatch
 local function f12(...)
 return dispatch(t3, ...)
 end
 for j = #p3, 1, -1 do
 f12 = p3[j](f12, t3)
 end
 function t3.dispatch(p1, ...)
 return f12(...)
 end
	end
	return t3
end
function t2.getState(p1)
	if p1._isDispatching then
 local v1 = error
 v1(("You may not call store:getState() while the reducer is executing. The reducer (%s) has already received the state as an argument. Pass it down from the top reducer instead of reading it from the store."):format((tostring(p1._reducer))))
	end
	return p1._state
end
function t2.dispatch(p1, p2)
	if typeof(p2) ~= "table" then
 error(("Actions must be tables. Use custom middleware for %q actions."):format((typeof(p2))), 2)
	end
	if p2.type == nil then
 error("Actions may not have an undefined \'type\' property. " .. "Have you misspelled a constant? \n" .. tostring(p2), 2)
	end
	if p1._isDispatching then
 error("Reducers may not dispatch actions.")
	end
	local v1, v2 = pcall(function()
 p1._isDispatching = true
 p1._state = p1._reducer(p1._state, p2)
 p1._mutatedSinceFlush = true
	end)
	p1._isDispatching = false
	if not v1 then
 p1._errorReporter.reportReducerError(p1._state, p2, {
 message = "Caught error in reducer",
 thrownValue = v2
 })
	end
	if #p1._actionLog == 3 then
 table.remove(p1._actionLog, 1)
	end
	table.insert(p1._actionLog, p2)
end
function t2.destruct(p1)
	for i, v in ipairs(p1._connections) do
 v:Disconnect()
	end
	p1._connections = nil
end
function t2.flush(p1)
	if p1._mutatedSinceFlush then
 p1._mutatedSinceFlush = false
 local _state = p1._state
 local v1, v2 = xpcall(function()
 NoYield(function()
 p1.changed:fire(_state, p1._lastState)
 end)
 end, tracebackReporter)
 if not v1 then
 p1._errorReporter.reportUpdateError(p1._lastState, _state, p1._actionLog, {
 message = "Caught error flushing store updates",
 thrownValue = v2
 })
 end
 p1._lastState = _state
	end
end
return t2