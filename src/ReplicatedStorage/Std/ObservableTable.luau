local ReplicatedStorage = game:GetService("ReplicatedStorage")
local table2Lua = require(ReplicatedStorage.Std.Debug.table2Lua)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local function checkIfShouldDebugPrint(p1) --[[ Line: 8 ]]
	return false
end
local function checkIfShouldDebugPrintMultiple(p1) --[[ Line: 14 ]]
	for v1, v2 in p1 do
		if not false then
			return false
		end
	end
	return true
end
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 57 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	v2._rawTable = p1
	v2._mapKeyToCallbacks = {}
	v2._mapUpdateInProgress = {}
	return v2
end
function t.GetRawTable(p1) --[[ Line: 64 ]]
	return p1._rawTable
end
function t.Get(p1, p2) --[[ Line: 67 | Upvalues: TableUtils (copy) ]]
	assert(typeof(p2) == "string", "key must be string")
	local v2 = p1._rawTable[p2]
	if typeof(v2) == "table" then
		TableUtils.deepFreeze(v2)
	end
	return v2
end
local function errHandler(p1) --[[ Line: 75 ]]
	print(p1)
	warn("^^^ _mapKeyToCallbacks err ^^^")
end
function t._rawSet(p1, p2, p3) --[[ Line: 79 | Upvalues: TableUtils (copy), errHandler (copy) ]]
	assert(typeof(p2) == "string", "key must be string")
	if typeof(p3) == "table" then
		TableUtils.deepFreeze(p3)
	end
	if p1._rawTable[p2] ~= p3 then
		p1._rawTable[p2] = p3
		if p1._mapKeyToCallbacks[p2] then
			for v2, v3 in p1._mapKeyToCallbacks[p2] do
				local v4 = task.delay(0, function() --[[ Line: 91 | Upvalues: p2 (copy) ]]
					warn((("ObservableTable:Observe callback on %* took too long"):format(p2)))
				end)
				xpcall(v3, errHandler, p3)
				task.cancel(v4)
			end
		end
	end
end
function t._set(p1, p2, p3) --[[ Line: 101 ]]
	assert(typeof(p2) == "string", "key must be string")
	if p1:_getIsUpdateInProgress(p2) then
		error("Cannot set, key update in progress: " .. p2)
	end
	p1:_setIsUpdateInProgress(p2, true)
	p1:_rawSet(p2, p3)
	p1:_setIsUpdateInProgress(p2, false)
end
function t._setIsUpdateInProgress(p1, p2, p3) --[[ Line: 115 ]]
	assert(typeof(p2) == "string", "key must be string")
	assert(typeof(p3) == "boolean", "isUpdating must be boolean")
	if p3 == (p1._mapUpdateInProgress[p2] == true) then
		error("Trying to set same isUpdating value on key, shouldn\'t be valid: " .. p2)
	end
	p1._mapUpdateInProgress[p2] = if p3 then true else nil
end
function t._getIsUpdateInProgress(p1, p2) --[[ Line: 129 ]]
	assert(typeof(p2) == "string", "key must be string")
	return p1._mapUpdateInProgress[p2] == true
end
function t.Update(p1, p2, p3) --[[ Line: 133 ]]
	assert(typeof(p2) == "string", "key must be string")
	local v2 = p1:UpdateMultiple({ p2 }, function(p1) --[[ Line: 135 | Upvalues: p3 (copy) ]]
		return { (p3(p1[1])) }
	end)
	if v2 == nil then
		return nil
	else
		return v2[1]
	end
end
function t.UpdateMultiple(p1, p2, p3) --[[ Line: 144 | Upvalues: TableUtils (copy), table2Lua (copy) ]]
	local v1 = true
	for v2, v3 in p2 do
		if not false then
			v1 = false
			break
		end
	end
	if v1 then
		print("ObservableTable:UpdateMultiple starting", p2)
	end
	assert(if typeof(p2) == "table" then #p2 > 0 else false, "keys must be non-empty table")
	local t = {}
	for v7, v8 in p2 do
		local v6
		v6 = typeof(v8) == "string"
		assert(v6, "key must be string")
		assert(not t[v8], "keys must be unique")
		t[v8] = true
	end
	local function finishUpdate() --[[ Line: 155 | Upvalues: p2 (copy), p1 (copy) ]]
		for v1, v2 in p2 do
			p1:_setIsUpdateInProgress(v2, false)
		end
	end
	local v10 = TableUtils.filter(p2, function(p12) --[[ Line: 165 | Upvalues: p1 (copy) ]]
		return p1:_getIsUpdateInProgress(p12)
	end)
	if #v10 > 0 then
		error("Cannot update, keys already updating: " .. table.concat(v10, ", "))
	end
	for v11, v12 in p2 do
		p1:_setIsUpdateInProgress(v12, true)
	end
	local t2 = {}
	for v13, v14 in p2 do
		local v15 = p1:Get(v14)
		if typeof(v15) == "table" then
			v15 = TableUtils.deepCopy(v15)
		end
		table.insert(t2, v15)
	end
	local v17 = task.delay(0, function() --[[ Line: 187 | Upvalues: table2Lua (ref), p2 (copy) ]]
		warn((("ObservableTable:Update callback on %* took too long: %*"):format(table2Lua(p2), (debug.traceback()))))
	end)
	local v18, v19 = pcall(p3, t2)
	task.cancel(v17)
	if not v18 then
		warn(debug.traceback("ObservableTable:Update callback error: " .. tostring(v19)))
		finishUpdate()
		return nil
	end
	local v20 = true
	for v21, v22 in p2 do
		if not false then
			v20 = false
			break
		end
	end
	if v20 then
		print("ObservableTable:Update callback return", p2, v19)
	end
	if v19 == nil then
		local v24 = true
		for v25, v26 in p2 do
			if not false then
				v24 = false
				break
			end
		end
		if v24 then
			print("ObservableTable:Update callback returned nil overall", p2)
		end
		finishUpdate()
		return nil
	else
		for i = 1, #p2 do
			if v19[i] == nil then
				local _ = p2[i] == "dailyQuestProgress"
				finishUpdate()
				return nil
			end
		end
		local v29 = true
		for v30, v31 in p2 do
			if not false then
				v29 = false
				break
			end
		end
		if v29 then
			print("ObservableTable:Update set starting", p2)
		end
		for v33, v34 in p2 do
			p1:_rawSet(v34, v19[v33])
		end
		local v35 = true
		for v36, v37 in p2 do
			if not false then
				v35 = false
				break
			end
		end
		if v35 then
			print("ObservableTable:Update set finished", p2)
		end
		finishUpdate()
		return v19
	end
end
function t.Remove(p1, p2) --[[ Line: 231 ]]
	assert(typeof(p2) == "string", "key must be string")
	p1:_set(p2, nil)
end
function t.Connect(p1, p2, p3) --[[ Line: 235 ]]
	assert(typeof(p2) == "string", "key must be string")
	local v2 = p1._mapKeyToCallbacks[p2]
	if not v2 then
		v2 = {}
		p1._mapKeyToCallbacks[p2] = v2
	end
	table.insert(v2, p3)
	return function() --[[ Line: 243 | Upvalues: v2 (ref), p1 (copy), p2 (copy), p3 (copy) ]]
		v2 = p1._mapKeyToCallbacks[p2]
		local v1 = table.find(v2, p3)
		if v1 then
			table.remove(v2, v1)
		end
		if #v2 == 0 then
			p1._mapKeyToCallbacks[p2] = nil
		end
	end
end
function t.Observe(p1, p2, p3) --[[ Line: 254 ]]
	assert(typeof(p2) == "string", "key must be string")
	p3(p1:Get(p2))
	return p1:Connect(p2, p3)
end
return t