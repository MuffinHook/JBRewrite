local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setInVehicle = function(state, action)
		assert(action.inVehicle ~= nil, "missing inVehicle value")
		return action.inVehicle
	end
})
