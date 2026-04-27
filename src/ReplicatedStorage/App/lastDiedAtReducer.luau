local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(0, {
	setLastDiedAt = function(state, action)
		assert(action.lastDiedAt, "missing lastDiedAt")
		return action.lastDiedAt
	end
})
