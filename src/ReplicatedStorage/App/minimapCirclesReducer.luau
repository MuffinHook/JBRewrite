-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addMinimapCircle = function(p1, p2)
		assert(p2.circle.name ~= nil, "minimap circle missing unique name")
		local localTable = {}
		for i, v in ipairs(p1) do
			if v.name ~= p2.circle.name then
				table.insert(localTable, v)
			end
		end
		table.insert(localTable, p2.circle)
		return localTable
	end,
	removeMinimapCircle = function(p1, p2)
		assert(p2.name ~= nil, "minimap circle missing unique name")
		local localTable = {}
		for i, v in ipairs(p1) do
			if v.name ~= p2.name then
				table.insert(localTable, v)
			end
		end
		return localTable
	end
})