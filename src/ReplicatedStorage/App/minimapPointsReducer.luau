local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addMinimapPoint = function(state, action)
		assert(action.point.name ~= nil, "minimap point missing unique name")
		local localTable = {}
		for i, point in ipairs(state) do
			if point.name ~= action.point.name then
				table.insert(localTable, point)
			end
		end
		table.insert(localTable, action.point)
		return localTable
	end,
	removeMinimapPoint = function(state, action)
		assert(action.name ~= nil, "minimap point missing unique name")
		local localTable = {}
		for i, point in ipairs(state) do
			if point.name ~= action.name then
				table.insert(localTable, point)
			end
		end
		return localTable
	end
})
