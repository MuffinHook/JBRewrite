-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setCategoryItemFavorited = function(p1, p2)
		assert(p2.category ~= nil, "missing category")
		assert(p2.name ~= nil, "missing name")
		assert(p2.favorited ~= nil, "missing favorited")
		local t = {}
		for k, v in pairs(p1) do
			t[k] = v
		end
		if not t[p2.category] then
			t[p2.category] = {}
		end
		t[p2.category][p2.name] = p2.favorited
		return t
	end,
	setFavoritedRaw = function(p1, p2)
		assert(p2.favorited ~= nil, "missing favorited table")
		return p2.favorited
	end
})
