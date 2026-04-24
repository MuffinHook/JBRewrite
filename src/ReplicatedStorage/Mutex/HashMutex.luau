-- Reviewed by Claude
local HashMutex = {}
HashMutex.__index = HashMutex
function HashMutex.new()
	local instance = {}
	setmetatable(instance, HashMutex)
	instance._data = {}
	instance._observe = {}
	return instance
end
function HashMutex.AcquireFor(p1, p2, p3)
	if p1._data[p2] then
		return false
	else
		p1._data[p2] = {
			thread = task.delay(p3, function()
				p1._data[p2] = nil
				p1:_fireKeyChangedCallbacks(p2)
			end)
		}
		p1:_fireKeyChangedCallbacks(p2)
		return true
	end
end
function HashMutex.ReleaseFor(p1, p2)
	local lockEntry = p1._data[p2]
	if lockEntry then
		task.cancel(lockEntry.thread)
		p1._data[p2] = nil
		p1:_fireKeyChangedCallbacks(p2)
	end
	return lockEntry ~= nil
end
function HashMutex._fireKeyChangedCallbacks(p1, p2)
	local isHeld = p1._data[p2] ~= nil
	if p1._observe[p2] then
		for _, callback in p1._observe[p2] do
			callback(isHeld)
		end
	end
end
function HashMutex.AddKeyChangedCallback(p1, p2, p3)
	if not p1._observe[p2] then
		p1._observe[p2] = {}
	end
	table.insert(p1._observe[p2], p3)
	return function()
		if p1._observe[p2] then
			local foundIndex = table.find(p1._observe[p2], p3)
			if foundIndex then
			table.remove(p1._observe[p2], foundIndex)
				if #p1._observe[p2] == 0 then
					p1._observe[p2] = nil
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
function HashMutex.ObserveKey(p1, p2, p3)
	p3(p1._data[p2] ~= nil)
	return p1:AddKeyChangedCallback(p2, p3)
end
function HashMutex.Destroy(p1)
	for key in p1._data do
		p1:ReleaseFor(key)
	end
	setmetatable(p1, nil)
end
return HashMutex
