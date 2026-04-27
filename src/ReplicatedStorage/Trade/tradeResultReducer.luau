local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setTradeResult = function(state, action)
		return action.value
	end
})
