local EnumClass = {}
function EnumClass.__index(enumInstance, itemName)
	if EnumClass[itemName] then
		return EnumClass[itemName]
	end
	if enumInstance._map[itemName] then
		return enumInstance._map[itemName]
	end
	error(("Enum does not contain item: `%s`"):format(itemName))
end
function EnumClass.GetEnumItems(enumInstance)
	return enumInstance._array
end
function EnumClass.GetValueFromEnum(enumInstance, itemName)
	return enumInstance._array[itemName]
end
function EnumClass.__iter(enumInstance)
	error("Cannot iter enum")
end
return function(enumItemsArray)
	local enumInstance = {
		_array = enumItemsArray,
		_map = {}
	}
	for index, itemName in enumItemsArray do
		enumInstance._map[itemName] = index
	end
	table.freeze(enumInstance._map)
	if not table.isfrozen(enumInstance._array) then
		table.freeze(enumInstance._array)
	end
	setmetatable(enumInstance, EnumClass)
	table.freeze(enumInstance)
	return enumInstance
end
