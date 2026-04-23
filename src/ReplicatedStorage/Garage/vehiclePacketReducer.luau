local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setLocalVehiclePacket = function(p1, p2) --[[ Name: setLocalVehiclePacket | Line: 5 ]]
		assert(p2.packet ~= nil, "missing Packet")
		return p2.packet
	end
})