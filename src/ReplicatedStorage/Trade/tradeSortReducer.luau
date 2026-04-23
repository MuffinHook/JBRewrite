local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local EnumSort = require(ReplicatedStorage.Garage.EnumSort)
return Rodux.createReducer(EnumSort.Newest, {
	setTradeSortId = function(p1, p2) --[[ Name: setTradeSortId | Line: 7 ]]
		assert(p2.sortId ~= nil, "missing sortId")
		return p2.sortId
	end
})