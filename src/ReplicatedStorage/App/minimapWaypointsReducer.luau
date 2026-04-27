local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addWaypoint = function(currentWaypoints, waypointData)
		assert(if waypointData.position == nil then waypointData.part ~= nil else true, "missing position or part")
		assert(waypointData.priority ~= nil, "missing priority")
		assert(waypointData.name ~= nil, "missing name")
		local updatedWaypoints = table.clone(currentWaypoints)
		for i = #updatedWaypoints, 1, -1 do
			if updatedWaypoints[i].name == waypointData.name then
				table.remove(updatedWaypoints, i)
				break
			end
		end
		local insertionIndex = #updatedWaypoints + 1
		for j = 1, #updatedWaypoints do
			if updatedWaypoints[j].priority > waypointData.priority then
				insertionIndex = j
				break
			end
		end
		table.insert(updatedWaypoints, insertionIndex, {
			position = waypointData.position,
			part = waypointData.part,
			priority = waypointData.priority,
			name = waypointData.name,
			minDist = waypointData.minDist or 48,
			message = waypointData.message
		})
		return updatedWaypoints
	end,
	removeWaypointByName = function(currentWaypoints, waypointData)
		assert(waypointData.name ~= nil, "missing name")
		local updatedWaypoints = table.clone(currentWaypoints)
		for i = #updatedWaypoints, 1, -1 do
			if updatedWaypoints[i].name == waypointData.name then
				table.remove(updatedWaypoints, i)
				return updatedWaypoints
			end
		end
		return updatedWaypoints
	end,
	removeWaypointCurrent = function(currentWaypoints)
		local updatedWaypoints = table.clone(currentWaypoints)
		if #updatedWaypoints > 0 then
			table.remove(updatedWaypoints, #updatedWaypoints)
		end
		return updatedWaypoints
	end
})
