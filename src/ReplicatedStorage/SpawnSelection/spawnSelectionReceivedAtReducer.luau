local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(0, {
	setSpawnSelectionReceivedAt = function(state, action)
		assert(action.receivedAt, "missing receivedAt")
		return action.receivedAt
	end
})
