return function(actionName, actionCreatorFn)
	assert(type(actionName) == "string", "Bad argument #1: Expected a string name for the action creator")
	assert(type(actionCreatorFn) == "function", "Bad argument #2: Expected a function that creates action objects")
	return setmetatable({
 name = actionName
	}, {
 __call = function(self, ...)
 local actionObject = actionCreatorFn(...)
 assert(type(actionObject) == "table", "Invalid action: An action creator must return a table")
 actionObject.type = actionName
 return actionObject
 end
	})
end
