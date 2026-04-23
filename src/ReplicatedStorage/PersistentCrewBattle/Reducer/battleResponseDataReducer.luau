local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setBattleResponseData = function(p1, p2) --[[ Name: setBattleResponseData | Line: 5 ]]
		return p2.value
	end
})