-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setCrewLeaderboard = function(arg1, self)
		assert(self.value ~= nil, "missing value")
		return self.value
	end
})
