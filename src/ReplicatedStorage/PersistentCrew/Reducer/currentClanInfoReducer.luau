local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setCurrentClanInfo = function(p1, p2) --[[ Name: setCurrentClanInfo | Line: 5 ]]
		return p2.value
	end
})