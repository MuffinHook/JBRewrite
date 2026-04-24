-- Reviewed by Claude
local t = {
	_value = require(script.Parent.fallbackPopularSortData)
}
function t.setRaw(p1)
	t._value = p1
end
function t.getRaw()
	return t._value
end
return t
