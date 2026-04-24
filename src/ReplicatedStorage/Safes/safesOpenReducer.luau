-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setSafesOpen = function(p1, p2)
		assert(p2.value ~= nil, "missing value")
		return p2.value
	end,
	toggleSafesOpen = function(p1)
		return not p1
	end
})
