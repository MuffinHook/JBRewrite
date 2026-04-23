local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setPenaltyText = function(p1, p2) --[[ Name: setPenaltyText | Line: 5 ]]
		return p2.value
	end
})