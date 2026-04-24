-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	battleInvitesSet = function(arg1, self)
		assert(self.list ~= nil, "missing list")
		return self.list
	end,
	battleInvitesRemoveByIndex = function(arg1, self)
		assert(self.index ~= nil, "missing index")
		local local2 = table.clone(arg1)
		table.remove(local2, self.index)
		return local2
	end
})
