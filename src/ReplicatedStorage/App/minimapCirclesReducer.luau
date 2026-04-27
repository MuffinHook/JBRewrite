local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addMinimapCircle = function(state, action)
		assert(action.circle.name ~= nil, "minimap circle missing unique name")
		local localTable = {}
		for i, circle in ipairs(state) do
			if circle.name ~= action.circle.name then
				table.insert(localTable, circle)
			end
		end
		table.insert(localTable, action.circle)
		return localTable
	end,
	removeMinimapCircle = function(state, action)
		assert(action.name ~= nil, "minimap circle missing unique name")
		local localTable = {}
		for i, circle in ipairs(state) do
			if circle.name ~= action.name then
				table.insert(localTable, circle)
			end
		end
		return localTable
	end
})
