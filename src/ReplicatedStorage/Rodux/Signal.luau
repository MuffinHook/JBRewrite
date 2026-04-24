-- Reviewed by Claude
local function immutableAppend(p1, ...)
	local count = #p1
	local tbl = {}
	for i = 1, count do
 tbl[i] = p1[i]
	end
	for j = 1, select("#", ...) do
 tbl[count + j] = select(j, ...)
	end
	return tbl
end
local function immutableRemoveValue(p1, p2)
	local tbl = {}
	for i = 1, #p1 do
 if p1[i] ~= p2 then
 table.insert(tbl, p1[i])
 end
	end
	return tbl
end
local tbl = {}
tbl.__index = tbl
function tbl.new(p1)
	local t2 = {
 _listeners = {},
 _store = p1
	}
	setmetatable(t2, tbl)
	return t2
end
function tbl.connect(p1, p2)
	if typeof(p2) ~= "function" then
 error("Expected the listener to be a function.")
	end
	if p1._store and p1._store._isDispatching then
 error("You may not call store.changed:connect() while the reducer is executing. If you would like to be notified after the store has been updated, subscribe from a component and invoke store:getState() in the callback to access the latest state. ")
	end
	local tbl = {
 callback = p2,
 disconnected = false,
 connectTraceback = debug.traceback(),
 disconnectTraceback = nil
	}
	p1._listeners = immutableAppend(p1._listeners, tbl)
	return {
 disconnect = function()
 if tbl.disconnected then
 error(("Listener connected at: \n%s\nwas already disconnected at: \n%s\n"):format(tostring(tbl.connectTraceback), (tostring(tbl.disconnectTraceback))))
 end
 if p1._store and p1._store._isDispatching then
 error("You may not unsubscribe from a store listener while the reducer is executing.")
 end
 tbl.disconnected = true
 tbl.disconnectTraceback = debug.traceback()
 p1._listeners = immutableRemoveValue(p1._listeners, tbl)
 end
	}
end
function tbl.fire(p1, ...)
	for i, v in ipairs(p1._listeners) do
 if not v.disconnected then
 v.callback(...)
 end
	end
end
return tbl