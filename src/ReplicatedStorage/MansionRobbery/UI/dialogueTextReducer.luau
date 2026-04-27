local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer("", {
	setDialogueText = function(currentState, action)
		assert(action.text ~= nil, "missing dialogue text")
		return action.text
	end
})
