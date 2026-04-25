-- Reviewed by Claude
-- variables reassigned
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
function WorldMarkerGroup.Add(self, p2)
	p2:SetEnabled(self._enabled)
	table.insert(self._listWorldMarker, p2)
end
function WorldMarkerGroup.Remove(self, p2)
	local v1 = table.find(self._listWorldMarker, p2)
	assert(v1, "Removing worldMarker that doesn\'t exist in _listWorldMarker")
	table.remove(self._listWorldMarker, v1)
end
function WorldMarkerGroup.Update(self)
	if self._enabled then
		for i = #self._listWorldMarker, 1, -1 do
			local v1 = self._listWorldMarker[i]
			assert(v1.Update, "destroyed/nil worldMarker is being Updated")
			v1:Update()
		end
	end
end
function WorldMarkerGroup.SetEnabled(self, p2)
	self._enabled = p2
	for i, v in ipairs(self._listWorldMarker) do
		v:SetEnabled(p2)
	end
end
function WorldMarkerGroup.GetAll(self)
	return self._listWorldMarker
end
return WorldMarkerGroup
