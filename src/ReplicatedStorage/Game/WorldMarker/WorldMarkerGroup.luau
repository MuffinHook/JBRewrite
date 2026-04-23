local t = {}
t.__index = t
t.__ClassName = "WorldMarkerGroup"
function t.new() --[[ Line: 4 | Upvalues: t (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._listWorldMarker = {}
	t2._enabled = true
	return t2
end
function t.Add(p1, p2) --[[ Line: 13 ]]
	p2:SetEnabled(p1._enabled)
	table.insert(p1._listWorldMarker, p2)
end
function t.Remove(p1, p2) --[[ Line: 17 ]]
	local v1 = table.find(p1._listWorldMarker, p2)
	assert(v1, "Removing worldMarker that doesn\'t exist in _listWorldMarker")
	table.remove(p1._listWorldMarker, v1)
end
function t.Update(p1) --[[ Line: 22 ]]
	if p1._enabled then
		for i = #p1._listWorldMarker, 1, -1 do
			local v1 = p1._listWorldMarker[i]
			assert(v1.Update, "destroyed/nil worldMarker is being Updated")
			v1:Update()
		end
	end
end
function t.SetEnabled(p1, p2) --[[ Line: 32 ]]
	p1._enabled = p2
	for i, v in ipairs(p1._listWorldMarker) do
		v:SetEnabled(p2)
	end
end
function t.GetAll(p1) --[[ Line: 38 ]]
	return p1._listWorldMarker
end
return t