local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(0, {
	setCash = function(p1, p2) --[[ Name: setCash | Line: 5 ]]
		assert(p2.cash, "missing cash value")
		return p2.cash
	end
})