-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setJoinRequests = function(arg1, self)
		assert(self.value ~= nil, "join requests cannot be nil; try blank table?")
		return self.value
	end
})
