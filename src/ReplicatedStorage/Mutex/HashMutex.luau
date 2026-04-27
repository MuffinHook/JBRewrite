local HashMutex = {}
HashMutex.__index = HashMutex
function HashMutex.new()
	local instance = {}
	setmetatable(instance, HashMutex)
	instance._data = {}
	instance._observe = {}
	return instance
end
function HashMutex.AcquireFor(self, key, duration)
	if self._data[key] then
		return false
	else
		self._data[key] = {
			thread = task.delay(duration, function()
				self._data[key] = nil
				self:_fireKeyChangedCallbacks(key)
			end)
		}
		self:_fireKeyChangedCallbacks(key)
		return true
	end
end
function HashMutex.ReleaseFor(self, key)
	local lockEntry = self._data[key]
	if lockEntry then
		task.cancel(lockEntry.thread)
		self._data[key] = nil
		self:_fireKeyChangedCallbacks(key)
	end
	return lockEntry ~= nil
end
function HashMutex._fireKeyChangedCallbacks(self, key)
	local isHeld = self._data[key] ~= nil
	if self._observe[key] then
		for _, callback in self._observe[key] do
			callback(isHeld)
		end
	end
end
function HashMutex.AddKeyChangedCallback(self, key, callback)
	if not self._observe[key] then
		self._observe[key] = {}
	end
	table.insert(self._observe[key], callback)
	return function()
		if self._observe[key] then
			local foundIndex = table.find(self._observe[key], callback)
			if foundIndex then
			table.remove(self._observe[key], foundIndex)
				if #self._observe[key] == 0 then
					self._observe[key] = nil
				end
				return true
			else
				return false
			end
		else
			return false
		end
	end
end
function HashMutex.ObserveKey(self, key, callback)
	callback(self._data[key] ~= nil)
	return self:AddKeyChangedCallback(key, callback)
end
function HashMutex.Destroy(self)
	for key in self._data do
		self:ReleaseFor(key)
	end
	setmetatable(self, nil)
end
return HashMutex
