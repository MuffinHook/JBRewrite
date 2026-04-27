local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({
	visible = false,
	countdownTil = 0
}, {
	setLikePromptConfig = function(currentState, configUpdate)
		local updatedState = table.clone(currentState)
		updatedState.visible = configUpdate.visible
		updatedState.countdownTil = configUpdate.countdownTil
		return updatedState
	end
})
