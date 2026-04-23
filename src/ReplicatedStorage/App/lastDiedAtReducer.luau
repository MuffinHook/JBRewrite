local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(0, {
	setLastDiedAt = function(p1, p2) --[[ Name: setLastDiedAt | Line: 5 ]]
		assert(p2.lastDiedAt, "missing lastDiedAt")
		return p2.lastDiedAt
	end
})