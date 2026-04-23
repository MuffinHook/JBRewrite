local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(0, {
	setSpawnSelectionReceivedAt = function(p1, p2) --[[ Name: setSpawnSelectionReceivedAt | Line: 5 ]]
		assert(p2.receivedAt, "missing receivedAt")
		return p2.receivedAt
	end
})