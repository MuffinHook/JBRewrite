local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setSafesOpen = function(currentState, action)
		assert(action.value ~= nil, "missing value")
		return action.value
	end,
	toggleSafesOpen = function(currentState)
		return not currentState
	end
})
