local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setTradeResult = function(p1, p2) --[[ Name: setTradeResult | Line: 5 ]]
		return p2.value
	end
})