-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setStartedAt = function(p1, p2)
		assert(p2.clanId ~= nil, "missing clanId")
		local v2 = table.clone(p1)
		v2[p2.clanId] = p2.value
		return v2
	end
})
