local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setLocalVehiclePacket = function(state, action)
		assert(action.packet ~= nil, "missing Packet")
		return action.packet
	end
})
