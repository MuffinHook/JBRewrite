-- Reviewed by Claude
-- variables reassigned
local t = {}
function t.__index(p1, p2)
	if t[p2] then
		return t[p2]
	end
	if p1._map[p2] then
		return p1._map[p2]
	end
	error(("Enum does not contain item: `%s`"):format(p2))
end
function t.GetEnumItems(p1)
	return p1._array
end
function t.GetValueFromEnum(p1, p2)
	return p1._array[p2]
end
function t.__iter(p1)
	error("Cannot iter enum")
end
return function(p1)
	local t2 = {
		_array = p1,
		_map = {}
	}
	for v1, v2 in p1 do
		t2._map[v2] = v1
	end
	table.freeze(t2._map)
	if not table.isfrozen(t2._array) then
		table.freeze(t2._array)
	end
	setmetatable(t2, t)
	table.freeze(t2)
	return t2
end
