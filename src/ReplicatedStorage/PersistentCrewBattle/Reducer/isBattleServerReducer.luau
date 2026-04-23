local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setIsBattleServer = function(p1, p2) --[[ Name: setIsBattleServer | Line: 5 ]]
		return p2.value
	end
})