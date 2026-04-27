local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setCategoryItemOwned = function(state, action)
		assert(action.category ~= nil, "missing category")
		assert(action.name ~= nil, "missing name")
		local stateCopy = {}
		for categoryKey, categoryState in pairs(state) do
			stateCopy[categoryKey] = categoryState
		end
		if not stateCopy[action.category] then
			stateCopy[action.category] = {}
		end
		stateCopy[action.category][action.name] = true
		return stateCopy
	end,
	setOwnedRaw = function(state, action)
		assert(action.owned ~= nil, "missing owned table")
		return action.owned
	end
})
