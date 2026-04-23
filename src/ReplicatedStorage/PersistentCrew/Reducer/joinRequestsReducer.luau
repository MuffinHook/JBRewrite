local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setJoinRequests = function(p1, p2) --[[ Name: setJoinRequests | Line: 5 ]]
		assert(p2.value ~= nil, "join requests cannot be nil; try blank table?")
		return p2.value
	end
})