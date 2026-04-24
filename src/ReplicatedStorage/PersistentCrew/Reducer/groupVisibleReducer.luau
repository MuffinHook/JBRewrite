-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	toggleGroupVisible = function(arg1)
		return not arg1
	end,
	setGroupVisible = function(arg1, self)
		return self.value
	end
})
