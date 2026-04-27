local randomGenerator = Random.new()
local TableUtils = {
	copyKeysSafe = function(destination, source)
		for k, v in pairs(source) do
			if destination[k] ~= nil then
				error(("Table `to` already has key `%s` = %s"):format(k, destination[k]), 2)
			end
			destination[k] = v
		end
		return destination
	end
}
local strictMetatable = {
	__index = function(targetTable, requestedKey)
		error(("Table does not contain key `%s`"):format(requestedKey), 2)
	end
}
function TableUtils.requireValidIndex(tbl)
	if typeof(tbl) == "table" then
		setmetatable(tbl, strictMetatable)
	end
	return tbl
end
function TableUtils.requireValidIndexAndFreeze(tbl)
	local function freezeRecursively(currTable)
		assert(typeof(currTable) == "table", "currTable is not a table")
		local mt = getmetatable(currTable)
		if not mt or mt == strictMetatable then
			for k, v in currTable do
				if typeof(v) == "table" then
					freezeRecursively(v)
				end
			end
			if not table.isfrozen(currTable) then
				table.freeze(currTable)
			end
			return currTable
		end
	end
	return freezeRecursively(tbl)
end
function TableUtils.shuffleInPlace(array)
	for i = #array, 2, -1 do
		local randomIndex = math.random(i)
		local temp = array[i]
		array[i] = array[randomIndex]
		array[randomIndex] = temp
	end
end
function TableUtils.filter(array, predicate)
	local result = {}
	for i = 1, #array do
		if predicate(array[i]) then
			table.insert(result, array[i])
		end
	end
	return result
end
function TableUtils.map(array, fn)
	local result = {}
	for i = 1, #array do
		table.insert(result, fn(array[i]))
	end
	return result
end
function TableUtils.sum(array)
	local sum = 0
	for i = 1, #array do
		sum = sum + array[i]
	end
	return sum
end
function TableUtils.weightedRandom(array, totalWeight)
	local weightSum = totalWeight or TableUtils.sum(array)
	assert(weightSum)
	local randomValue = weightSum * randomGenerator:NextNumber()
	for i = 1, #array do
		randomValue = randomValue - array[i]
		if randomValue <= 0 then
			return i
		end
	end
	error("Couldn\'t find value")
end
function TableUtils.hasDesiredValuesShallow(table1, table2)
	for k, v in pairs(table2) do
		if table1[k] ~= v then
			return false
		end
	end
	return true
end
function TableUtils.deepCompareTables(table1, table2, ignoreValues, option4)
	assert(typeof(table1) == "table", "t1 is not a table")
	assert(typeof(table2) == "table", "t2 is not a table")
	local function valueCompareLogic(val1, val2, ignoreVals, opt4)
		local shouldIgnore = not ignoreVals
		if typeof(val1) == typeof(val2) then
			if typeof(val1) == "table" then
				if TableUtils.deepCompareTables(val1, val2, ignoreVals, opt4) then
					return true
				else
					return false
				end
			elseif shouldIgnore and val1 ~= val2 then
				return false
			else
				return true
			end
		else
			return false
		end
	end
	local count2Keys = 0
	local count1Keys = 0
	for k, v in pairs(table2) do
		count2Keys = count2Keys + 1
	end
	for k, v in pairs(table1) do
		count1Keys = count1Keys + 1
	end
	local isSequential1 = count1Keys == #table1
	if isSequential1 == (count2Keys == #table2) then
		local shouldCompare = not ignoreValues
		if not shouldCompare then
			shouldCompare = option4 or not isSequential1
		end
	end
	return false
end
function TableUtils.deepCheckSubset(table1, table2, option3)
	assert(typeof(table1) == "table", "t1 is not a table")
	assert(typeof(table2) == "table", "t2 is not a table")
	local count2Keys = 0
	local count1Keys = 0
	for k, v in pairs(table2) do
		count2Keys = count2Keys + 1
	end
	for k, v in pairs(table1) do
		count1Keys = count1Keys + 1
	end
	local pairsFunc, pairsState, pairsVar
	if count1Keys < count2Keys then
		return false
	end
	pairsFunc, pairsState, pairsVar = pairs(table2)
	local firstKey, firstValue = pairsFunc(pairsState, pairsVar)
	if firstKey ~= nil then
		if table1[firstKey] then
			local firstType = typeof(firstValue)
			local _ = firstType == typeof(table1[firstKey])
		end
		return false
	else
		return true
	end
end
function TableUtils.deepCopy(value, memoTable)
	local memo = memoTable or {}
	assert(memo)
	if type(value) == "table" then
		if memo[value] then
			return memo[value]
		else
			local copied = {}
			memo[value] = copied
			local memoRef = memo
			for k, v in next, value do
				copied[TableUtils.deepCopy(k, memoRef)] = TableUtils.deepCopy(v, memoRef)
			end
			return copied
		end
	else
		return value
	end
end
local function acceptAll(key, value)
	return true
end
local typeToInstanceMap = {
	boolean = "BoolValue",
	table = "Folder",
	Instance = "ObjectValue"
}
local customSerializers = {
	EnumItem = function(key, enumValue)
		local result = {
			instanceType = "StringValue",
			serializedValue = enumValue.Name
		}
		local attributes = {
			_ValueType = "EnumItem"
		}
		attributes._EnumType = tostring(enumValue.EnumType)
		result.attributes = attributes
		return result
	end,
	Vector2 = function(key, vec2Value)
		local result = {
			instanceType = "Vector3Value"
		}
		result.serializedValue = Vector3.new(vec2Value.X, vec2Value.Y, 0)
		result.attributes = {
			_ValueType = "Vector2"
		}
		return result
	end
}
local customDeserializers = {
	EnumItem = function(instance)
		return Enum[instance:GetAttribute("_EnumType")][instance.Value]
	end,
	Vector2 = function(instance)
		return Vector2.new(instance.Value.X, instance.Value.Y)
	end
}
local function getSerializedTypeAndValue(key, value)
	local valueType = typeof(value)
	if typeof(key) ~= "number" and typeof(key) ~= "string" then
		error("Cannot serialize non-string/number key")
	end
	local attributes = {
		_KeyType = typeof(key)
	}
	if customSerializers[valueType] then
		local serialized = customSerializers[valueType](key, value)
		for attrKey, attrValue in attributes do
			serialized.attributes[attrKey] = attrValue
		end
		return serialized.instanceType, serialized.serializedValue, serialized.attributes
	else
		local instanceClassName = (typeToInstanceMap[valueType] or valueType .. "Value"):gsub("^%l", string.upper)
		attributes._ValueType = valueType
		return instanceClassName, value, attributes
	end
end
local function deserializeValue(instance)
	local valueType = instance:GetAttribute("_ValueType")
	return customDeserializers[valueType] and customDeserializers[valueType](instance) or instance.Value
end
function TableUtils.observeObjectValuesChanged(rootFolder, callback)
	assert(rootFolder and rootFolder:IsA("Instance"), "Invalid rootFolder passed")
	local function handleUpdate()
		callback(TableUtils.createTableFromObjectValues(rootFolder), (rootFolder:GetAttribute("_TableUtilsLastUpdated")))
	end
	local connection = rootFolder:GetAttributeChangedSignal("_TableUtilsLastUpdated"):Connect(handleUpdate)
	callback(TableUtils.createTableFromObjectValues(rootFolder), (rootFolder:GetAttribute("_TableUtilsLastUpdated")))
	return connection
end
function TableUtils.createObjectValuesFromTable(originalTable, filterPredicate, rootFolder)
	assert(typeof(originalTable) == "table", "Incorrect originalTable type passed")
	assert(typeof(filterPredicate) == "function" or filterPredicate == nil, "Incorrect filterPredicate type passed")
	assert(if rootFolder == nil then true else rootFolder:IsA("Instance"), "Incorrect rootFolder type passed")
	local filter = filterPredicate or acceptAll
	local folder = rootFolder or Instance.new("Folder")
	if not (folder and filter) then
		error("no folder")
	end
	local function populateFolder(tableData, parentInstance)
		local existingInstances = {}
		for i, child in parentInstance:GetChildren() do
			existingInstances[child.Name] = child
		end
		for key, value in tableData do
			if filter(key, value) then
				local existingInstance = parentInstance:FindFirstChild((tostring(key)))
				local instanceType, serializedValue, attributes = getSerializedTypeAndValue(key, value)
				if existingInstance and existingInstance.ClassName ~= instanceType then
					existingInstance:Destroy()
					existingInstance = nil
				end
				if existingInstance then
					existingInstances[existingInstance.Name] = nil
				else
					local newInstance = Instance.new(instanceType)
					newInstance.Name = tostring(key)
					existingInstance = newInstance
				end
				if instanceType ~= "Folder" then
					existingInstance.Value = serializedValue
				end
				for attrKey, attrValue in attributes do
					existingInstance:SetAttribute(attrKey, attrValue)
				end
				if typeof(value) == "table" then
					populateFolder(value, existingInstance)
				end
				if not existingInstance.Parent then
					existingInstance.Parent = parentInstance
				end
			end
		end
		for unusedName, unusedInstance in existingInstances do
			unusedInstance:Destroy()
		end
	end
	populateFolder(originalTable, folder)
	task.delay(0, function()
		folder:SetAttribute("_TableUtilsLastUpdated", workspace:GetServerTimeNow())
	end)
	return folder
end
function TableUtils.createTableFromObjectValues(rootInstance)
	assert(typeof(rootInstance) == "Instance", "Invalid objectValues passed")
	local function reconstructTable(instance)
		local result = {}
		for i, child in instance:GetChildren() do
			local key, value
			key = child:GetAttribute("_KeyType") == "number" and tonumber(child.Name) or child.Name
			if child:IsA("Folder") then
				result[key] = reconstructTable(child)
			else
				local valueType = child:GetAttribute("_ValueType")
				value = customDeserializers[valueType] and customDeserializers[valueType](child) or child.Value
				result[key] = value
			end
		end
		return result
	end
	return reconstructTable(rootInstance)
end
function TableUtils.isValidSequentialArray(array)
	for key, value in array do
		local _ = typeof(key) == "number"
		return false
	end
	return #array == 0
end
function TableUtils.insertDesc(array, value)
	local position = #array + 1
	for i = #array, 1, -1 do
		if value < array[i] then
			break
		end
		position = i
	end
	return position
end
function TableUtils.insertAsc(array, value)
	local position = 0
	for i = 1, #array do
		if value < array[i] then
			break
		end
		position = i
	end
	return position + 1
end
function TableUtils.concat(array1, array2)
	local result = table.create(#array1 + #array2)
	table.move(array1, 1, #array1, 1, result)
	table.move(array2, 1, #array2, #array1 + 1, result)
	return result
end
function TableUtils.concatInPlace(array1, array2)
	table.move(array2, 1, #array2, #array1 + 1, array1)
end
function TableUtils.mergeDeepInPlace(fromTable, toTable)
	assert(type(fromTable) == "table", "The \'from\' parameter must be a table.")
	assert(type(toTable) == "table", "The \'to\' parameter must be a table.")
	for key, value in fromTable do
		if type(value) == "table" and type(toTable[key]) == "table" then
			TableUtils.mergeDeepInPlace(value, toTable[key])
		else
			toTable[key] = value
		end
	end
end
function TableUtils.deepFreeze(tbl)
	if typeof(tbl) == "table" then
		if not table.isfrozen(tbl) then
			table.freeze(tbl)
		end
		for k, v in tbl do
			TableUtils.deepFreeze(v)
		end
	end
end
return TableUtils
