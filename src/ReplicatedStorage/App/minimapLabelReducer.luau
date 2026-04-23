local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local function addLabel(p1, p2) --[[ Line: 5 ]]
	assert(p2.title, "minimap label missing unique title")
	table.insert(p1, {
		title = p2.title,
		imageId = p2.imageId,
		position = p2.position,
		updatePosition = p2.updatePosition,
		adornee = p2.adornee,
		markerColor = p2.markerColor,
		updateMarkerColor = p2.updateMarkerColor,
		scale = p2.scale
	})
end
return Rodux.createReducer({}, {
	addMinimapLabel = function(p1, p2) --[[ Name: addMinimapLabel | Line: 19 | Upvalues: addLabel (copy) ]]
		assert(p2.title, "minimap label missing unique title")
		local t = {}
		for i, v in ipairs(p1) do
			if v.title ~= p2.title then
				table.insert(t, v)
			end
		end
		addLabel(t, p2)
		return t
	end,
	addMinimapLabels = function(p1, p2) --[[ Name: addMinimapLabels | Line: 30 | Upvalues: addLabel (copy) ]]
		assert(p2.labels, "missing labels")
		local v1 = table.clone(p1)
		for i, v in ipairs(p2.labels) do
			addLabel(v1, v)
		end
		return v1
	end,
	removeMinimapLabel = function(p1, p2) --[[ Name: removeMinimapLabel | Line: 38 ]]
		assert(p2.title, "minimap label missing unique title")
		local t = {}
		for i, v in ipairs(p1) do
			if v.title ~= p2.title then
				table.insert(t, v)
			end
		end
		return t
	end
})