local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(0, {
	setCash = function(state, action)
		assert(action.cash, "missing cash value")
		return action.cash
	end
})
