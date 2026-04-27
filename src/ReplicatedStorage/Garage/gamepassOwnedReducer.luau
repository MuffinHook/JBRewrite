local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setGamepassOwned = function(state, action)
		assert(typeof(action.gamepassEnum) == "number", "Incorrect gamepassEnum passed")
		assert(typeof(action.gamepassOwned) == "boolean", "Incorrect gamepassOwned value passed")
		local newState = table.clone(state)
		newState[action.gamepassEnum] = action.gamepassOwned
		return newState
	end
})
