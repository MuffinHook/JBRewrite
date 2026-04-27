local WorldMarkerGroup = {}
WorldMarkerGroup.__index = WorldMarkerGroup
WorldMarkerGroup.__ClassName = "WorldMarkerGroup"
function WorldMarkerGroup.new()
	local newInstance = {}
	setmetatable(newInstance, WorldMarkerGroup)
	newInstance._listWorldMarker = {}
	newInstance._enabled = true
	return newInstance
end
function WorldMarkerGroup.Add(self, worldMarker)
	worldMarker:SetEnabled(self._enabled)
	table.insert(self._listWorldMarker, worldMarker)
end
function WorldMarkerGroup.Remove(self, worldMarker)
	local markerIndex = table.find(self._listWorldMarker, worldMarker)
	assert(markerIndex, "Removing worldMarker that doesn\'t exist in _listWorldMarker")
	table.remove(self._listWorldMarker, markerIndex)
end
function WorldMarkerGroup.Update(self)
	if self._enabled then
		for i = #self._listWorldMarker, 1, -1 do
			local currentMarker = self._listWorldMarker[i]
			assert(currentMarker.Update, "destroyed/nil worldMarker is being Updated")
			currentMarker:Update()
		end
	end
end
function WorldMarkerGroup.SetEnabled(self, isEnabled)
	self._enabled = isEnabled
	for i, marker in ipairs(self._listWorldMarker) do
		marker:SetEnabled(isEnabled)
	end
end
function WorldMarkerGroup.GetAll(self)
	return self._listWorldMarker
end
return WorldMarkerGroup
