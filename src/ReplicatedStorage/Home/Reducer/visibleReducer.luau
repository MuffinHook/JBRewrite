-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setVisible = function(p1, p2)
		assert(p2.value ~= nil, "action.value must not be nil")
		return p2.value
	end,
	toggleVisible = function(p1, p2)
		return not p1
	end
})
