local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setTimeTook = function(p1, p2) --[[ Name: setTimeTook | Line: 5 ]]
		assert(p2.clanId ~= nil, "missing clanId")
		local v2 = table.clone(p1)
		v2[p2.clanId] = p2.value
		return v2
	end
})