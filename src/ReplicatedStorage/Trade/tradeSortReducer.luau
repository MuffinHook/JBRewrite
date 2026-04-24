-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local EnumSort = require(ReplicatedStorage.Garage.EnumSort)
return Rodux.createReducer(EnumSort.Newest, {
	setTradeSortId = function(state, action)
		assert(action.sortId ~= nil, "missing sortId")
		return action.sortId
	end
})
