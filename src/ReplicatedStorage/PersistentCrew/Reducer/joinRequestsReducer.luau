local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setJoinRequests = function(state, action)
		assert(action.value ~= nil, "join requests cannot be nil; try blank table?")
		return action.value
	end
})
