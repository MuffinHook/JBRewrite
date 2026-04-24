-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setInPhysical = function(p1, p2)
		assert(p2.inPhysical ~= nil, "missing inPhysical value")
		return p2.inPhysical
	end
})
