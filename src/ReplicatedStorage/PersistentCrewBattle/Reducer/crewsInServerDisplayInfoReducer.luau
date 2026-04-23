local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setCrewsInServerDisplayInfo = function(p1, p2) --[[ Name: setCrewsInServerDisplayInfo | Line: 5 ]]
		assert(p2.value ~= nil, "missing value")
		return p2.value
	end
})