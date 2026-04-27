local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local function addLabel(currentState, payload)
	assert(payload.title, "minimap label missing unique title")
	table.insert(currentState, {
		title = payload.title,
		imageId = payload.imageId,
		position = payload.position,
		updatePosition = payload.updatePosition,
		adornee = payload.adornee,
		markerColor = payload.markerColor,
		updateMarkerColor = payload.updateMarkerColor,
		scale = payload.scale
	})
end
return Rodux.createReducer({}, {
	addMinimapLabel = function(currentState, payload)
		assert(payload.title, "minimap label missing unique title")
		local localTable = {}
		for i, label in ipairs(currentState) do
			if label.title ~= payload.title then
				table.insert(localTable, label)
			end
		end
		addLabel(localTable, payload)
		return localTable
	end,
	addMinimapLabels = function(currentState, payload)
		assert(payload.labels, "missing labels")
		local clonedState = table.clone(currentState)
		for i, label in ipairs(payload.labels) do
			addLabel(clonedState, label)
		end
		return clonedState
	end,
	removeMinimapLabel = function(currentState, payload)
		assert(payload.title, "minimap label missing unique title")
		local localTable = {}
		for i, label in ipairs(currentState) do
			if label.title ~= payload.title then
				table.insert(localTable, label)
			end
		end
		return localTable
	end
})
