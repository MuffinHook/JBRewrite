local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setCategoryItemOwned = function(p1, p2) --[[ Name: setCategoryItemOwned | Line: 5 ]]
		assert(p2.category ~= nil, "missing category")
		assert(p2.name ~= nil, "missing name")
		local t = {}
		for k, v in pairs(p1) do
			t[k] = v
		end
		if not t[p2.category] then
			t[p2.category] = {}
		end
		t[p2.category][p2.name] = true
		return t
	end,
	setOwnedRaw = function(p1, p2) --[[ Name: setOwnedRaw | Line: 19 ]]
		assert(p2.owned ~= nil, "missing owned table")
		return p2.owned
	end
})