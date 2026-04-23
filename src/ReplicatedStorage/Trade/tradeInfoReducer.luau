local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setTradeInfo = function(p1, p2) --[[ Name: setTradeInfo | Line: 5 ]]
		return p2.info
	end
})