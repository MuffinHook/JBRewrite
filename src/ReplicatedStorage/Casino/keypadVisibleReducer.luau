-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setCasinoKeypadVisible = function(state, action)
		assert(action.visible ~= nil, "missing visible")
		return action.visible
	end
})