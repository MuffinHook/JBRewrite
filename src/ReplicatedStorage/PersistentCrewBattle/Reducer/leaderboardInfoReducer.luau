local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setCrewLeaderboard = function(p1, p2) --[[ Name: setCrewLeaderboard | Line: 5 ]]
		assert(p2.value ~= nil, "missing value")
		return p2.value
	end
})