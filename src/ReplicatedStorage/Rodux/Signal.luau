-- Reviewed by Claude
-- variables reassigned
local function immutableAppend(sourceTable, ...)
	local count = #sourceTable
	local tbl = {}
	for i = 1, count do
 tbl[i] = sourceTable[i]
	end
	for j = 1, select("#", ...) do
 tbl[count + j] = select(j, ...)
	end
	return tbl
end
local function immutableRemoveValue(sourceTable, valueToRemove)
	local tbl = {}
	for i = 1, #sourceTable do
 if sourceTable[i] ~= valueToRemove then
 table.insert(tbl, sourceTable[i])
 end
	end
	return tbl
end
local SignalMetatable = {}
SignalMetatable.__index = SignalMetatable
function SignalMetatable.new(storeInstance)
	local signal = {
 _listeners = {},
 _store = storeInstance
	}
	setmetatable(signal, SignalMetatable)
	return signal
end
function SignalMetatable.connect(self, listenerCallback)
	if typeof(listenerCallback) ~= "function" then
 error("Expected the listener to be a function.")
	end
	if self._store and self._store._isDispatching then
 error("You may not call store.changed:connect() while the reducer is executing. If you would like to be notified after the store has been updated, subscribe from a component and invoke store:getState() in the callback to access the latest state. ")
	end
	local listenerObject = {
 callback = listenerCallback,
 disconnected = false,
 connectTraceback = debug.traceback(),
 disconnectTraceback = nil
	}
	self._listeners = immutableAppend(self._listeners, listenerObject)
	return {
 disconnect = function()
 if listenerObject.disconnected then
 error(("Listener connected at: \n%s\nwas already disconnected at: \n%s\n"):format(tostring(listenerObject.connectTraceback), (tostring(listenerObject.disconnectTraceback))))
 end
 if self._store and self._store._isDispatching then
 error("You may not unsubscribe from a store listener while the reducer is executing.")
 end
 listenerObject.disconnected = true
 listenerObject.disconnectTraceback = debug.traceback()
 self._listeners = immutableRemoveValue(self._listeners, listenerObject)
 end
	}
end
function SignalMetatable.fire(self, ...)
	for i, listenerObj in ipairs(self._listeners) do
 if not listenerObj.disconnected then
 listenerObj.callback(...)
 end
	end
end
return SignalMetatable
