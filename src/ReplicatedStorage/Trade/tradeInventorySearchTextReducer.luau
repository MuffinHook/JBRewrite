-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer("", {
	setTradeInventorySearchText = function(state, action)
		assert(action.value ~= nil, "missing value")
		return action.value
	end
})
