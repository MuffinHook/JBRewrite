-- Reviewed by Claude
-- variables reassigned
local freeRunnerThread = nil
local function acquireRunnerThreadAndCallEventHandler(handler, ...)
	local savedThread = freeRunnerThread
	freeRunnerThread = nil
	handler(...)
	freeRunnerThread = savedThread
end
local function runEventHandlerInFreeThread()
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end
local Connection = {}
Connection.__index = Connection
function Connection.new(signal, handler)
	return setmetatable({
		_connected = true,
		_signal = signal,
		_fn = handler,
		_next = false
	}, Connection)
end
function Connection.Disconnect(self)
	self._connected = false
	if self._signal._handlerListHead == self then
		self._signal._handlerListHead = self._next
	else
		local currentHandler = self._signal._handlerListHead
		while currentHandler and currentHandler._next ~= self do
			currentHandler = currentHandler._next
		end
		if currentHandler then
			currentHandler._next = self._next
		end
	end
end
Connection.Destroy = Connection.Disconnect
setmetatable(Connection, {
	__index = function(self, key)
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(key))), 2)
	end,
	__newindex = function(self, key, value)
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(key))), 2)
	end
})
local Signal = {}
Signal.__index = Signal
function Signal.new()
	return setmetatable({
		_handlerListHead = false
	}, Signal)
end
function Signal.Connect(self, handler)
	local connection = Connection.new(self, handler)
	if self._handlerListHead then
		connection._next = self._handlerListHead
	end
	self._handlerListHead = connection
	return connection
end
function Signal.DisconnectAll(self)
	self._handlerListHead = false
end
function Signal.Fire(self, ...)
	local currentHandler = self._handlerListHead
	while currentHandler do
		if currentHandler._connected then
			if not freeRunnerThread then
				freeRunnerThread = coroutine.create(runEventHandlerInFreeThread)
				coroutine.resume(freeRunnerThread)
			end
			task.spawn(freeRunnerThread, currentHandler._fn, ...)
		end
		currentHandler = currentHandler._next
	end
end
function Signal.Wait(self)
	local runningThread = coroutine.running()
	local connection = nil
	connection = self:Connect(function(...)
		connection:Disconnect()
		task.spawn(runningThread, ...)
	end)
	return coroutine.yield()
end
function Signal.Once(self, handler)
	local connection = nil
	connection = self:Connect(function(...)
		if connection._connected then
			connection:Disconnect()
		end
		handler(...)
	end)
	return connection
end
Signal.Destroy = Signal.DisconnectAll
setmetatable(Signal, {
	__index = function(self, key)
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(key))), 2)
	end,
	__newindex = function(self, key, value)
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(key))), 2)
	end
})
return Signal
