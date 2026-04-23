local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local EnumSort = require(script.Parent.EnumSort)
return Rodux.createReducer(EnumSort.Popular, {
	setSort = function(p1, p2) --[[ Name: setSort | Line: 7 ]]
		assert(p2.id ~= nil, "missing id")
		return p2.id
	end
})