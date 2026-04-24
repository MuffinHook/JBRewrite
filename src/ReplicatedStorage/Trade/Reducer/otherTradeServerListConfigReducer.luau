-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setOtherTradeServerInfo = function(p1, p2)
		local v1 = table.clone(p1)
		v1.otherTradeServerInfo = p2.value
		return v1
	end,
	setOtherTradeServerListVisible = function(p1, p2)
		local v1 = table.clone(p1)
		v1.visible = p2.value
		return v1
	end
})
