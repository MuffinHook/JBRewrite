-- Reviewed by Claude
-- variables reassigned
return function(reducersMap)
	return function(state, action)
 if state == nil then
 state = {}
 end
 local newState = {}
 for key, reducer in pairs(reducersMap) do
 newState[key] = reducer(state[key], action)
 end
 return newState
	end
end
