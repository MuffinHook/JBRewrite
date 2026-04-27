local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setTradeInventoryOpen = function(state, action)
		assert(action.value ~= nil, "missing value")
		return action.value
	end
})
