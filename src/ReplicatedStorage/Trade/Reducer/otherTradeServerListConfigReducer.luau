local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setOtherTradeServerInfo = function(state, action)
		local updatedState = table.clone(state)
		updatedState.otherTradeServerInfo = action.value
		return updatedState
	end,
	setOtherTradeServerListVisible = function(state, action)
		local updatedState = table.clone(state)
		updatedState.visible = action.value
		return updatedState
	end
})
