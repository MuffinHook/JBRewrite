local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setClanName = function(state, action)
		assert(action.clanId ~= nil, "missing clanId")
		local updatedState = table.clone(state)
		updatedState[action.clanId] = action.value
		return updatedState
	end
})
