local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setViewingClanInfo = function(p1, p2) --[[ Name: setViewingClanInfo | Line: 5 ]]
		return p2.value
	end
})