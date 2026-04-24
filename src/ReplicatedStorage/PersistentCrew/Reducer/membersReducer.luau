-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setMembers = function(p1, p2)
		assert(p2.value ~= nil, "members cannot be nil; try blank table?")
		return p2.value
	end
})
