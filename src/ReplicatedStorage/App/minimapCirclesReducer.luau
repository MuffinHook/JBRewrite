local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addMinimapCircle = function(p1, p2) --[[ Name: addMinimapCircle | Line: 5 ]]
		assert(p2.circle.name ~= nil, "minimap circle missing unique name")
		local t = {}
		for i, v in ipairs(p1) do
			if v.name ~= p2.circle.name then
				table.insert(t, v)
			end
		end
		table.insert(t, p2.circle)
		return t
	end,
	removeMinimapCircle = function(p1, p2) --[[ Name: removeMinimapCircle | Line: 18 ]]
		assert(p2.name ~= nil, "minimap circle missing unique name")
		local t = {}
		for i, v in ipairs(p1) do
			if v.name ~= p2.name then
				table.insert(t, v)
			end
		end
		return t
	end
})