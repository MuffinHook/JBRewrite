local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer("", {
	setTradeInventorySearchText = function(p1, p2) --[[ Name: setTradeInventorySearchText | Line: 5 ]]
		assert(p2.value ~= nil, "missing value")
		return p2.value
	end
})