local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setMembers = function(previousState, action)
		assert(action.value ~= nil, "members cannot be nil; try blank table?")
		return action.value
	end
})
