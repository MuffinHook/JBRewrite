local prettyPrint = require(script.Parent.prettyPrint)
local loggerMiddleware = {
	outputFunction = print
}
function loggerMiddleware.middleware(nextDispatch, store)
	return function(action)
 local result = nextDispatch(action)
 loggerMiddleware.outputFunction(("Action dispatched: %s\nState changed to: %s"):format(prettyPrint(action), prettyPrint(store:getState())))
 return result
	end
end
return loggerMiddleware
