-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	toggleGroupVisible = function(p1)
		return not p1
	end,
	setGroupVisible = function(p1, p2)
		return p2.value
	end
})
