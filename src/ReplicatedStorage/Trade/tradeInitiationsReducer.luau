-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	tradeInitiationsSet = function(state, action)
		assert(action.list ~= nil, "missing list")
		return action.list
	end,
	tradeInitiationsRemoveByIndex = function(state, action)
		assert(action.index ~= nil, "missing index")
		local updatedList = table.clone(state)
		table.remove(updatedList, action.index)
		return updatedList
	end
})
