local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	battleInvitesSet = function(state, action)
		assert(action.list ~= nil, "missing list")
		return action.list
	end,
	battleInvitesRemoveByIndex = function(state, action)
		assert(action.index ~= nil, "missing index")
		local clonedState = table.clone(state)
		table.remove(clonedState, action.index)
		return clonedState
	end
})
