-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setIsReadiedUp = function(p1, p2)
		assert(p2.value ~= nil, "isReadiedUp cannot be nil; try boolean")
		return p2.value
	end
})
