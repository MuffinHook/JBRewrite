local t = {
	_value = require(script.Parent.fallbackPopularSortData)
}
function t.setRaw(p1) --[[ Line: 3 | Upvalues: t (copy) ]]
	t._value = p1
end
function t.getRaw() --[[ Line: 6 | Upvalues: t (copy) ]]
	return t._value
end
return t