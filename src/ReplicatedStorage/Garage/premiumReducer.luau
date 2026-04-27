local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setPremium = function(state, action)
		assert(action.premium ~= nil, "missing premium value")
		return action.premium
	end
})
