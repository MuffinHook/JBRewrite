-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setPremium = function(p1, p2)
		assert(p2.premium ~= nil, "missing premium value")
		return p2.premium
	end
})
