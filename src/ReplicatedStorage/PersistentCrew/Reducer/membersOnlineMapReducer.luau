local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setMembersOnlineMap = function(p1, p2) --[[ Name: setMembersOnlineMap | Line: 5 ]]
		return p2.value
	end
})