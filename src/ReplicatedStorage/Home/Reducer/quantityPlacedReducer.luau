local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setQuantityPlaced = function(currentState, action)
		return action.value
	end
})
