local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setAttackingClanId = function(p1, p2) --[[ Name: setAttackingClanId | Line: 5 ]]
		return p2.value
	end
})