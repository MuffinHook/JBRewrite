-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setCategoryItemFavorited = function(currentState, action)
		assert(action.category ~= nil, "missing category")
		assert(action.name ~= nil, "missing name")
		assert(action.favorited ~= nil, "missing favorited")
		local newState = {}
		for k, v in pairs(currentState) do
			newState[k] = v
		end
		if not newState[action.category] then
			newState[action.category] = {}
		end
		newState[action.category][action.name] = action.favorited
		return newState
	end,
	setFavoritedRaw = function(currentState, action)
		assert(action.favorited ~= nil, "missing favorited table")
		return action.favorited
	end
})
