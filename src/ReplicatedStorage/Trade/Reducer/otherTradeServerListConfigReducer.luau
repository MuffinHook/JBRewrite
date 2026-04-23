local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setOtherTradeServerInfo = function(p1, p2) --[[ Name: setOtherTradeServerInfo | Line: 5 ]]
		local v1 = table.clone(p1)
		v1.otherTradeServerInfo = p2.value
		return v1
	end,
	setOtherTradeServerListVisible = function(p1, p2) --[[ Name: setOtherTradeServerListVisible | Line: 10 ]]
		local v1 = table.clone(p1)
		v1.visible = p2.value
		return v1
	end
})