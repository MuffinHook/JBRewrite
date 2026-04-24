-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addMinimapPoint = function(p1, p2)
		assert(p2.point.name ~= nil, "minimap point missing unique name")
		local localTable = {}
		for i, v in ipairs(p1) do
			if v.name ~= p2.point.name then
				table.insert(localTable, v)
			end
		end
		table.insert(localTable, p2.point)
		return localTable
	end,
	removeMinimapPoint = function(p1, p2)
		assert(p2.name ~= nil, "minimap point missing unique name")
		local localTable = {}
		for i, v in ipairs(p1) do
			if v.name ~= p2.name then
				table.insert(localTable, v)
			end
		end
		return localTable
	end
})