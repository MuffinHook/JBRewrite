local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setVisible = function(currentState, action)
		assert(action.value ~= nil, "action.value must not be nil")
		return action.value
	end,
	toggleVisible = function(currentState, action)
		return not currentState
	end
})
