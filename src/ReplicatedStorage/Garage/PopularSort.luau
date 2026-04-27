local popularSortModule = {
	_value = require(script.Parent.fallbackPopularSortData)
}
function popularSortModule.setRaw(rawData)
	popularSortModule._value = rawData
end
function popularSortModule.getRaw()
	return popularSortModule._value
end
return popularSortModule
