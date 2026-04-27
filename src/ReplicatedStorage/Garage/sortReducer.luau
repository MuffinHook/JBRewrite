local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local EnumSort = require(script.Parent.EnumSort)
return Rodux.createReducer(EnumSort.Popular, {
	setSort = function(currentState, action)
		assert(action.id ~= nil, "missing id")
		return action.id
	end
})
