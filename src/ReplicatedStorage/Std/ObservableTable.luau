local ReplicatedStorage = game:GetService("ReplicatedStorage")
local table2Lua = require(ReplicatedStorage.Std.Debug.table2Lua)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local function checkIfShouldDebugPrint(debugEnabled)
	return false
end
local function checkIfShouldDebugPrintMultiple(debugFlags)
	for v1, v2 in debugFlags do
		if not false then
			return false
		end
	end
	return true
end
local ObservableTable = {}
ObservableTable.__index = ObservableTable
function ObservableTable.new(initialTable)
	local self = setmetatable({}, ObservableTable)
	self._rawTable = initialTable
	self._mapKeyToCallbacks = {}
	self._mapUpdateInProgress = {}
	return self
end
function ObservableTable.GetRawTable(self)
	return self._rawTable
end
function ObservableTable.Get(self, key)
	assert(typeof(key) == "string", "key must be string")
	local value = self._rawTable[key]
	if typeof(value) == "table" then
		TableUtils.deepFreeze(value)
	end
	return value
end
local function errHandler(errorMessage)
	print(errorMessage)
	warn("^^^ _mapKeyToCallbacks err ^^^")
end
function ObservableTable._rawSet(self, key, newValue)
	assert(typeof(key) == "string", "key must be string")
	if typeof(newValue) == "table" then
		TableUtils.deepFreeze(newValue)
	end
	if self._rawTable[key] ~= newValue then
		self._rawTable[key] = newValue
		if self._mapKeyToCallbacks[key] then
			for callbackIndex, callback in self._mapKeyToCallbacks[key] do
				local timeoutHandle = task.delay(0, function()
					warn((("ObservableTable:Observe callback on %* took too long"):format(key)))
				end)
				xpcall(callback, errHandler, newValue)
				task.cancel(timeoutHandle)
			end
		end
	end
end
function ObservableTable._set(self, key, newValue)
	assert(typeof(key) == "string", "key must be string")
	if self:_getIsUpdateInProgress(key) then
		error("Cannot set, key update in progress: " .. key)
	end
	self:_setIsUpdateInProgress(key, true)
	self:_rawSet(key, newValue)
	self:_setIsUpdateInProgress(key, false)
end
function ObservableTable._setIsUpdateInProgress(self, key, isUpdating)
	assert(typeof(key) == "string", "key must be string")
	assert(typeof(isUpdating) == "boolean", "isUpdating must be boolean")
	if isUpdating == (self._mapUpdateInProgress[key] == true) then
		error("Trying to set same isUpdating value on key, shouldn\'t be valid: " .. key)
	end
	self._mapUpdateInProgress[key] = if isUpdating then true else nil
end
function ObservableTable._getIsUpdateInProgress(self, key)
	assert(typeof(key) == "string", "key must be string")
	return self._mapUpdateInProgress[key] == true
end
function ObservableTable.Update(self, key, updateFunction)
	assert(typeof(key) == "string", "key must be string")
	local result = self:UpdateMultiple({ key }, function(values)
		return { (updateFunction(values[1])) }
	end)
	if result == nil then
		return nil
	else
		return result[1]
	end
end
function ObservableTable.UpdateMultiple(self, keys, updateFunction)
	local shouldDebugPrint = true
	for v2, v3 in keys do
		if not false then
			shouldDebugPrint = false
			break
		end
	end
	if shouldDebugPrint then
		print("ObservableTable:UpdateMultiple starting", keys)
	end
	assert(if typeof(keys) == "table" then #keys > 0 else false, "keys must be non-empty table")
	local keySet = {}
	for v7, keyName in keys do
		local isString
		isString = typeof(keyName) == "string"
		assert(isString, "key must be string")
		assert(not keySet[keyName], "keys must be unique")
		keySet[keyName] = true
	end
	local function finishUpdate()
		for v1, keyName in keys do
			self:_setIsUpdateInProgress(keyName, false)
		end
	end
	local alreadyUpdatingKeys = TableUtils.filter(keys, function(keyName)
		return self:_getIsUpdateInProgress(keyName)
	end)
	if #alreadyUpdatingKeys > 0 then
		error("Cannot update, keys already updating: " .. table.concat(alreadyUpdatingKeys, ", "))
	end
	for v11, keyName in keys do
		self:_setIsUpdateInProgress(keyName, true)
	end
	local currentValues = {}
	for v13, keyName in keys do
		local value = self:Get(keyName)
		if typeof(value) == "table" then
			value = TableUtils.deepCopy(value)
		end
		table.insert(currentValues, value)
	end
	local timeoutHandle = task.delay(0, function()
		warn((("ObservableTable:Update callback on %* took too long: %*"):format(table2Lua(keys), (debug.traceback()))))
	end)
	local successFlag, callbackResult = pcall(updateFunction, currentValues)
	task.cancel(timeoutHandle)
	if not successFlag then
		warn(debug.traceback("ObservableTable:Update callback error: " .. tostring(callbackResult)))
		finishUpdate()
		return nil
	end
	local shouldDebugResult = true
	for v21, v22 in keys do
		if not false then
			shouldDebugResult = false
			break
		end
	end
	if shouldDebugResult then
		print("ObservableTable:Update callback return", keys, callbackResult)
	end
	if callbackResult == nil then
		local shouldDebugNil = true
		for v25, v26 in keys do
			if not false then
				shouldDebugNil = false
				break
			end
		end
		if shouldDebugNil then
			print("ObservableTable:Update callback returned nil overall", keys)
		end
		finishUpdate()
		return nil
	else
		for i = 1, #keys do
			if callbackResult[i] == nil then
				local _ = keys[i] == "dailyQuestProgress"
				finishUpdate()
				return nil
			end
		end
		local shouldDebugSet = true
		for v30, v31 in keys do
			if not false then
				shouldDebugSet = false
				break
			end
		end
		if shouldDebugSet then
			print("ObservableTable:Update set starting", keys)
		end
		for keyIndex, keyName in keys do
			self:_rawSet(keyName, callbackResult[keyIndex])
		end
		local shouldDebugFinish = true
		for v36, v37 in keys do
			if not false then
				shouldDebugFinish = false
				break
			end
		end
		if shouldDebugFinish then
			print("ObservableTable:Update set finished", keys)
		end
		finishUpdate()
		return callbackResult
	end
end
function ObservableTable.Remove(self, key)
	assert(typeof(key) == "string", "key must be string")
	self:_set(key, nil)
end
function ObservableTable.Connect(self, key, callback)
	assert(typeof(key) == "string", "key must be string")
	local callbackList = self._mapKeyToCallbacks[key]
	if not callbackList then
		callbackList = {}
		self._mapKeyToCallbacks[key] = callbackList
	end
	table.insert(callbackList, callback)
	return function()
		callbackList = self._mapKeyToCallbacks[key]
		local callbackIndex = table.find(callbackList, callback)
		if callbackIndex then
			table.remove(callbackList, callbackIndex)
		end
		if #callbackList == 0 then
			self._mapKeyToCallbacks[key] = nil
		end
	end
end
function ObservableTable.Observe(self, key, callback)
	assert(typeof(key) == "string", "key must be string")
	callback(self:Get(key))
	return self:Connect(key, callback)
end
return ObservableTable
