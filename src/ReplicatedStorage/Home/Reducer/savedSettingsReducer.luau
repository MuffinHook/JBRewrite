local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	setSavedSetting = function(state, action)
		if state[action.key] == action.value then
			return state
		else
			local tbl = table.clone(state)
			tbl[action.key] = action.value
			return tbl
		end
	end
})
