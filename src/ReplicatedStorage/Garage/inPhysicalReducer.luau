local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setInPhysical = function(currentState, action)
		assert(action.inPhysical ~= nil, "missing inPhysical value")
		return action.inPhysical
	end
})
