-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setSpawnSelectionOfferVisible = function(state, action)
		return action.visible
	end
})
