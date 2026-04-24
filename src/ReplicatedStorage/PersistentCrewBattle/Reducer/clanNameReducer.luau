-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setClanName = function(arg1, self)
		assert(self.clanId ~= nil, "missing clanId")
		local local2 = table.clone(arg1)
		local2[self.clanId] = self.value
		return local2
	end
})
