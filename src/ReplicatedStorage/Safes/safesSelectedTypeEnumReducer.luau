-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(1, {
	setSafesSelectedSafeTypeEnum = function(p1, p2)
		assert(p2.typeEnum ~= nil, "missing typeEnum")
		return p2.typeEnum
	end
})
