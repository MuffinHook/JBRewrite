-- Reviewed by Claude
local v1 = Random.new()
local t = {
	copyKeysSafe = function(p1, p2)
		for k, v in pairs(p2) do
			if p1[k] ~= nil then
				error(("Table `to` already has key `%s` = %s"):format(k, p1[k]), 2)
			end
			p1[k] = v
		end
		return p1
	end
}
local t2 = {
	__index = function(p1, p2)
		error(("Table does not contain key `%s`"):format(p2), 2)
	end
}
function t.requireValidIndex(p1)
	if typeof(p1) == "table" then
		setmetatable(p1, t2)
	end
	return p1
end
function t.requireValidIndexAndFreeze(p1)
	local function v1(p1)
		assert(typeof(p1) == "table", "currTable is not a table")
		local v2 = getmetatable(p1)
		if not v2 or v2 == t2 then
			for v4, v5 in p1 do
				if typeof(v5) == "table" then
					v1(v5)
				end
			end
			if not table.isfrozen(p1) then
				table.freeze(p1)
			end
			return p1
		end
	end
	return v1(p1)
end
function t.shuffleInPlace(p1)
	for i = #p1, 2, -1 do
		local v1 = math.random(i)
		local v3 = p1[i]
		p1[i] = p1[v1]
		p1[v1] = v3
	end
end
function t.filter(p1, p2)
	local t = {}
	for i = 1, #p1 do
		if p2(p1[i]) then
			table.insert(t, p1[i])
		end
	end
	return t
end
function t.map(p1, p2)
	local t = {}
	for i = 1, #p1 do
		table.insert(t, p2(p1[i]))
	end
	return t
end
function t.sum(p1)
	local sum = 0
	for i = 1, #p1 do
		sum = sum + p1[i]
	end
	return sum
end
function t.weightedRandom(p1, p2)
	local v12 = p2 or t.sum(p1)
	assert(v12)
	local sum = v12 * v1:NextNumber()
	for i = 1, #p1 do
		sum = sum - p1[i]
		if sum <= 0 then
			return i
		end
	end
	error("Couldn\'t find value")
end
function t.hasDesiredValuesShallow(p1, p2)
	for k, v in pairs(p2) do
		if p1[k] ~= v then
			return false
		end
	end
	return true
end
function t.deepCompareTables(p1, p2, p3, p4)
	assert(typeof(p1) == "table", "t1 is not a table")
	assert(typeof(p2) == "table", "t2 is not a table")
	local function valueCompareLogic(p1, p2, p3, p4)
		local v1 = not p3
		if typeof(p1) == typeof(p2) then
			if typeof(p1) == "table" then
				if t.deepCompareTables(p1, p2, p3, p4) then
					return true
				else
					return false
				end
			elseif v1 and p1 ~= p2 then
				return false
			else
				return true
			end
		else
			return false
		end
	end
	local count = 0
	local count_2 = 0
	for k, v in pairs(p2) do
		count = count + 1
	end
	for k, v in pairs(p1) do
		count_2 = count_2 + 1
	end
	local v3 = count_2 == #p1
	if v3 == (count == #p2) then
		local v5 = not p3
		if not v5 then
			v5 = p4 or not v3
		end
	end
	return false
end
function t.deepCheckSubset(p1, p2, p3)
	assert(typeof(p1) == "table", "t1 is not a table")
	assert(typeof(p2) == "table", "t2 is not a table")
	local count = 0
	local count_2 = 0
	for k, v in pairs(p2) do
		count = count + 1
	end
	for k, v in pairs(p1) do
		count_2 = count_2 + 1
	end
	local v3, v4, v5
	if count_2 < count then
		return false
	end
	v3, v4, v5 = pairs(p2)
	local v6, v7 = v3(v4, v5)
	if v6 ~= nil then
		if p1[v6] then
			local v8 = typeof(v7)
			local _ = v8 == typeof(p1[v6])
		end
		return false
	else
		return true
	end
end
function t.deepCopy(p1, p2)
	local v1 = p2 or {}
	assert(v1)
	if type(p1) == "table" then
		if v1[p1] then
			return v1[p1]
		else
			local t2 = {}
			v1[p1] = t2
			local v2 = v1
			for v3, v4 in next, p1 do
				t2[t.deepCopy(v3, v2)] = t.deepCopy(v4, v2)
			end
			return t2
		end
	else
		return p1
	end
end
local function f2(p1, p2)
	return true
end
local t3 = {
	boolean = "BoolValue",
	table = "Folder",
	Instance = "ObjectValue"
}
local t4 = {
	EnumItem = function(p1, p2)
		local t = {
			instanceType = "StringValue",
			serializedValue = p2.Name
		}
		local t2 = {
			_ValueType = "EnumItem"
		}
		t2._EnumType = tostring(p2.EnumType)
		t.attributes = t2
		return t
	end,
	Vector2 = function(p1, p2)
		local t = {
			instanceType = "Vector3Value"
		}
		t.serializedValue = Vector3.new(p2.X, p2.Y, 0)
		t.attributes = {
			_ValueType = "Vector2"
		}
		return t
	end
}
local t5 = {
	EnumItem = function(p1)
		return Enum[p1:GetAttribute("_EnumType")][p1.Value]
	end,
	Vector2 = function(p1)
		return Vector2.new(p1.Value.X, p1.Value.Y)
	end
}
local function getSerializedTypeAndValue(p1, p2)
	local v1 = typeof(p2)
	if typeof(p1) ~= "number" and typeof(p1) ~= "string" then
		error("Cannot serialize non-string/number key")
	end
	local t = {
		_KeyType = typeof(p1)
	}
	if t4[v1] then
		local v2 = t4[v1](p1, p2)
		for v3, v4 in t do
			v2.attributes[v3] = v4
		end
		return v2.instanceType, v2.serializedValue, v2.attributes
	else
		local v6 = (t3[v1] or v1 .. "Value"):gsub("^%l", string.upper)
		t._ValueType = v1
		return v6, p2, t
	end
end
local function deserializeValue(p1)
	local v1 = p1:GetAttribute("_ValueType")
	return t5[v1] and t5[v1](p1) or p1.Value
end
function t.observeObjectValuesChanged(p1, p2)
	assert(p1 and p1:IsA("Instance"), "Invalid rootFolder passed")
	local function handleUpdate()
		p2(t.createTableFromObjectValues(p1), (p1:GetAttribute("_TableUtilsLastUpdated")))
	end
	local v2 = p1:GetAttributeChangedSignal("_TableUtilsLastUpdated"):Connect(handleUpdate)
	p2(t.createTableFromObjectValues(p1), (p1:GetAttribute("_TableUtilsLastUpdated")))
	return v2
end
function t.createObjectValuesFromTable(p1, p2, p3)
	assert(typeof(p1) == "table", "Incorrect originalTable type passed")
	assert(typeof(p2) == "function" or p2 == nil, "Incorrect filterPredicate type passed")
	assert(if p3 == nil then true else p3:IsA("Instance"), "Incorrect rootFolder type passed")
	local v5 = p2 or f2
	local v7 = p3 or Instance.new("Folder")
	if not (v7 and v5) then
		error("no folder")
	end
	local function v8(p1, p2)
		local t = {}
		for v1, v2 in p2:GetChildren() do
			t[v2.Name] = v2
		end
		for v3, v4 in p1 do
			if v5(v3, v4) then
				local v52 = p2:FindFirstChild((tostring(v3)))
				local v6, v7, v82 = getSerializedTypeAndValue(v3, v4)
				if v52 and v52.ClassName ~= v6 then
					v52:Destroy()
					v52 = nil
				end
				if v52 then
					t[v52.Name] = nil
				else
					local v9 = Instance.new(v6)
					v9.Name = tostring(v3)
					v52 = v9
				end
				if v6 ~= "Folder" then
					v52.Value = v7
				end
				for v10, v11 in v82 do
					v52:SetAttribute(v10, v11)
				end
				if typeof(v4) == "table" then
					v8(v4, v52)
				end
				if not v52.Parent then
					v52.Parent = p2
				end
			end
		end
		for v12, v13 in t do
			v13:Destroy()
		end
	end
	v8(p1, v7)
	task.delay(0, function()
		v7:SetAttribute("_TableUtilsLastUpdated", workspace:GetServerTimeNow())
	end)
	return v7
end
function t.createTableFromObjectValues(p1)
	assert(typeof(p1) == "Instance", "Invalid objectValues passed")
	local function v2(p1)
		local t = {}
		for v3, v4 in p1:GetChildren() do
			local v1, v22
			v1 = v4:GetAttribute("_KeyType") == "number" and tonumber(v4.Name) or v4.Name
			if v4:IsA("Folder") then
				t[v1] = v2(v4)
			else
				local v6 = v4:GetAttribute("_ValueType")
				v22 = t5[v6] and t5[v6](v4) or v4.Value
				t[v1] = v22
			end
		end
		return t
	end
	return v2(p1)
end
function t.isValidSequentialArray(p1)
	for v2, v3 in p1 do
		local _ = typeof(v2) == "number"
		return false
	end
	return #p1 == 0
end
function t.insertDesc(p1, p2)
	local v1 = #p1 + 1
	for i = #p1, 1, -1 do
		if p2 < p1[i] then
			break
		end
		v1 = i
	end
	return v1
end
function t.insertAsc(p1, p2)
	local v1 = 0
	for i = 1, #p1 do
		if p2 < p1[i] then
			break
		end
		v1 = i
	end
	return v1 + 1
end
function t.concat(p1, p2)
	local v1 = table.create(#p1 + #p2)
	table.move(p1, 1, #p1, 1, v1)
	table.move(p2, 1, #p2, #p1 + 1, v1)
	return v1
end
function t.concatInPlace(p1, p2)
	table.move(p2, 1, #p2, #p1 + 1, p1)
end
function t.mergeDeepInPlace(p1, p2)
	assert(type(p1) == "table", "The \'from\' parameter must be a table.")
	assert(type(p2) == "table", "The \'to\' parameter must be a table.")
	for v3, v4 in p1 do
		if type(v4) == "table" and type(p2[v3]) == "table" then
			t.mergeDeepInPlace(v4, p2[v3])
		else
			p2[v3] = v4
		end
	end
end
function t.deepFreeze(p1)
	if typeof(p1) == "table" then
		if not table.isfrozen(p1) then
			table.freeze(p1)
		end
		for v1, v2 in p1 do
			t.deepFreeze(v2)
		end
	end
end
return t
