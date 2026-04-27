return function(initialState, actionsTable)
	return function(state, action)
 if state == nil then
 state = initialState
 end
 local actionHandler = actionsTable[action.type]
 if actionHandler then
 return actionHandler(state, action)
 else
 return state
 end
	end
end
