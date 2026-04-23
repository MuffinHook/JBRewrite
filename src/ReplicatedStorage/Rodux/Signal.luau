local function immutableAppend(p1, ...) --[[ Line: 7 ]]
	local v1 = #p1
	local t = {}
	for i = 1, v1 do
		t[i] = p1[i]
	end
	for j = 1, select("#", ...) do
		t[v1 + j] = select(j, ...)
	end
	return t
end
local function immutableRemoveValue(p1, p2) --[[ Line: 22 ]]
	local t = {}
	for i = 1, #p1 do
		if p1[i] ~= p2 then
			table.insert(t, p1[i])
		end
	end
	return t
end
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 38 | Upvalues: t (copy) ]]
	local t2 = {
		_listeners = {},
		_store = p1
	}
	setmetatable(t2, t)
	return t2
end
function t.connect(p1, p2) --[[ Line: 49 | Upvalues: immutableAppend (copy), immutableRemoveValue (copy) ]]
	if typeof(p2) ~= "function" then
		error("Expected the listener to be a function.")
	end
	if p1._store and p1._store._isDispatching then
		error("You may not call store.changed:connect() while the reducer is executing. If you would like to be notified after the store has been updated, subscribe from a component and invoke store:getState() in the callback to access the latest state. ")
	end
	local t = {
		callback = p2,
		disconnected = false,
		connectTraceback = debug.traceback(),
		disconnectTraceback = nil
	}
	p1._listeners = immutableAppend(p1._listeners, t)
	return {
		disconnect = function() --[[ Name: disconnect | Line: 71 | Upvalues: t (copy), p1 (copy), immutableRemoveValue (ref) ]]
			if t.disconnected then
				error(("Listener connected at: \n%s\nwas already disconnected at: \n%s\n"):format(tostring(t.connectTraceback), (tostring(t.disconnectTraceback))))
			end
			if p1._store and p1._store._isDispatching then
				error("You may not unsubscribe from a store listener while the reducer is executing.")
			end
			t.disconnected = true
			t.disconnectTraceback = debug.traceback()
			p1._listeners = immutableRemoveValue(p1._listeners, t)
		end
	}
end
function t.fire(p1, ...) --[[ Line: 95 ]]
	for i, v in ipairs(p1._listeners) do
		if not v.disconnected then
			v.callback(...)
		end
	end
end
return t