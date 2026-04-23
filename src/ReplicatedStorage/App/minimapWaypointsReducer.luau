-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addWaypoint = function(p1, p2)
		assert(if p2.position == nil then p2.part ~= nil else true, "missing position or part")
		assert(p2.priority ~= nil, "missing priority")
		assert(p2.name ~= nil, "missing name")
		local v4 = table.clone(p1)
		for i = #v4, 1, -1 do
			if v4[i].name == p2.name then
				table.remove(v4, i)
				break
			end
		end
		local v5 = #v4 + 1
		for j = 1, #v4 do
			if v4[j].priority > p2.priority then
				v5 = j
				break
			end
		end
		table.insert(v4, v5, {
			position = p2.position,
			part = p2.part,
			priority = p2.priority,
			name = p2.name,
			minDist = p2.minDist or 48,
			message = p2.message
		})
		return v4
	end,
	removeWaypointByName = function(p1, p2)
		assert(p2.name ~= nil, "missing name")
		local v2 = table.clone(p1)
		for i = #v2, 1, -1 do
			if v2[i].name == p2.name then
				table.remove(v2, i)
				return v2
			end
		end
		return v2
	end,
	removeWaypointCurrent = function(p1)
		local v1 = table.clone(p1)
		if #v1 > 0 then
			table.remove(v1, #v1)
		end
		return v1
	end
})