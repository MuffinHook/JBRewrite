-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setCasinoKeypadCallback = function(state, action)
		assert(action.callback ~= nil, "missing callback")
		return action.callback
	end
})