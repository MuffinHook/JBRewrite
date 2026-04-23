local v1 = nil
local function acquireRunnerThreadAndCallEventHandler(p1, ...) --[[ Line: 51 | Upvalues: v1 (ref) ]]
	local v12 = v1
	v1 = nil
	p1(...)
	v1 = v12
end
local function runEventHandlerInFreeThread() --[[ Line: 62 | Upvalues: acquireRunnerThreadAndCallEventHandler (copy) ]]
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 77 | Upvalues: t (copy) ]]
	return setmetatable({
		_connected = true,
		_signal = p1,
		_fn = p2,
		_next = false
	}, t)
end
function t.Disconnect(p1) --[[ Line: 86 ]]
	p1._connected = false
	if p1._signal._handlerListHead == p1 then
		p1._signal._handlerListHead = p1._next
	else
		local _handlerListHead = p1._signal._handlerListHead
		while _handlerListHead and _handlerListHead._next ~= p1 do
			_handlerListHead = _handlerListHead._next
		end
		if _handlerListHead then
			_handlerListHead._next = p1._next
		end
	end
end
t.Destroy = t.Disconnect
setmetatable(t, {
	__index = function(p1, p2) --[[ Name: __index | Line: 110 ]]
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p2))), 2)
	end,
	__newindex = function(p1, p2, p3) --[[ Name: __newindex | Line: 113 ]]
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p2))), 2)
	end
})
local t3 = {}
t3.__index = t3
function t3.new() --[[ Line: 122 | Upvalues: t3 (copy) ]]
	return setmetatable({
		_handlerListHead = false
	}, t3)
end
function t3.Connect(p1, p2) --[[ Line: 129 | Upvalues: t (copy) ]]
	local v1 = t.new(p1, p2)
	if p1._handlerListHead then
		v1._next = p1._handlerListHead
	end
	p1._handlerListHead = v1
	return v1
end
function t3.DisconnectAll(p1) --[[ Line: 142 ]]
	p1._handlerListHead = false
end
function t3.Fire(p1, ...) --[[ Line: 150 | Upvalues: v1 (ref), runEventHandlerInFreeThread (copy) ]]
	local _handlerListHead = p1._handlerListHead
	while _handlerListHead do
		if _handlerListHead._connected then
			if not v1 then
				v1 = coroutine.create(runEventHandlerInFreeThread)
				coroutine.resume(v1)
			end
			task.spawn(v1, _handlerListHead._fn, ...)
		end
		_handlerListHead = _handlerListHead._next
	end
end
function t3.Wait(p1) --[[ Line: 167 ]]
	local v1 = coroutine.running()
	local v2 = nil
	v2 = p1:Connect(function(...) --[[ Line: 170 | Upvalues: v2 (ref), v1 (copy) ]]
		v2:Disconnect()
		task.spawn(v1, ...)
	end)
	return coroutine.yield()
end
function t3.Once(p1, p2) --[[ Line: 179 ]]
	local v1 = nil
	v1 = p1:Connect(function(...) --[[ Line: 181 | Upvalues: v1 (ref), p2 (copy) ]]
		if v1._connected then
			v1:Disconnect()
		end
		p2(...)
	end)
	return v1
end
t3.Destroy = t3.DisconnectAll
setmetatable(t3, {
	__index = function(p1, p2) --[[ Name: __index | Line: 194 ]]
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p2))), 2)
	end,
	__newindex = function(p1, p2, p3) --[[ Name: __newindex | Line: 197 ]]
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p2))), 2)
	end
})
return t3