-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	battleInvitesSet = function(p1, p2)
		assert(p2.list ~= nil, "missing list")
		return p2.list
	end,
	battleInvitesRemoveByIndex = function(p1, p2)
		assert(p2.index ~= nil, "missing index")
		local v2 = table.clone(p1)
		table.remove(v2, p2.index)
		return v2
	end
})
