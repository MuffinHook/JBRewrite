local function tracebackReporter(error)
	return debug.traceback(error)
end
return function(nextDispatch, store)
	return function(action)
 if typeof(action) == "function" then
 local success, result = xpcall(function()
 return action(store)
 end, tracebackReporter)
 if success then
 return result
 else
 store._errorReporter.reportReducerError(store:getState(), action, {
 message = "Caught error in thunk",
 thrownValue = result
 })
 return nil
 end
 else
 return nextDispatch(action)
 end
	end
end
