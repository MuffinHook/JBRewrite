-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setGamepassOwned = function(p1, p2)
		assert(typeof(p2.gamepassEnum) == "number", "Incorrect gamepassEnum passed")
		assert(typeof(p2.gamepassOwned) == "boolean", "Incorrect gamepassOwned value passed")
		local v3 = table.clone(p1)
		v3[p2.gamepassEnum] = p2.gamepassOwned
		return v3
	end
})
