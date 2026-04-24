-- Reviewed by Claude
-- variables reassigned
local weakKeyMetatable = {
	__mode = "k"
}
local function isCallable(p1)
	if type(p1) == "function" then
		return true
	elseif type(p1) == "table" then
		local v1 = getmetatable(p1)
		if v1 and type((rawget(v1, "__call"))) == "function" then
			return true
		else
			return false
		end
	else
		return false
	end
end
local function makeEnum(p1, p2)
	local t = {}
	for i, v in ipairs(p2) do
		t[v] = v
	end
	return setmetatable(t, {
		__index = function(p12, p2)
			error(string.format("%s is not in %s!", p2, p1), 2)
		end,
		__newindex = function()
			error(string.format("Creating new members in %s is not allowed!", p1), 2)
		end
	})
end
local PromiseError = {
	Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
}
PromiseError.__index = PromiseError
function PromiseError.new(p1, p2)
	local v1 = p1 or {}
	local t = {}
	t.error = tostring(v1.error) or "[This error has no error text.]"
	t.trace = v1.trace
	t.context = v1.context
	t.kind = v1.kind
	t.parent = p2
	t.createdTick = os.clock()
	t.createdTrace = debug.traceback()
	return setmetatable(t, PromiseError)
end
function PromiseError.is(p1)
	if type(p1) == "table" then
		local v1 = getmetatable(p1)
		if type(v1) == "table" then
			return if rawget(p1, "error") == nil then false else type((rawget(v1, "extend"))) == "function"
		else
			return false
		end
	else
		return false
	end
end
function PromiseError.isKind(p1, p2)
	assert(p2 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil")
	return PromiseError.is(p1) and p1.kind == p2
end
function PromiseError.extend(p1, p2)
	local errorOptions = p2 or {}
	errorOptions.kind = errorOptions.kind or p1.kind
	return PromiseError.new(errorOptions, p1)
end
function PromiseError.getErrorChain(p1)
	local t = { p1 }
	while t[#t].parent do
		table.insert(t, t[#t].parent)
	end
	return t
end
function PromiseError.__tostring(p1)
	local t = { string.format("-- Promise.Error(%s) --", p1.kind or "?") }
	for i, v in ipairs(p1:getErrorChain()) do
		local concat = table.concat
		local t2 = {}
		t2[1] = v.trace or v.error
		t2[2] = v.context
		table.insert(t, concat(t2, "\n"))
	end
	return table.concat(t, "\n")
end
local function pack(...)
	return select("#", ...), { ... }
end
local function packResult(p1, ...)
	return p1, select("#", ...), { ... }
end
local function makeErrorHandler(traceback)
	assert(traceback ~= nil, "traceback is nil")
	return function(err)
		if type(err) == "table" then
			return err
		else
			return PromiseError.new({
				error = err,
				kind = PromiseError.Kind.ExecutionError,
				trace = debug.traceback(tostring(err), 2),
				context = "Promise created at:\n\n" .. traceback
			})
		end
	end
end
local function runExecutor(traceback, fn, ...)
	local xpcallFunc = xpcall
	assert(traceback ~= nil, "traceback is nil")
	return packResult(xpcallFunc(fn, function(err)
		if type(err) == "table" then
			return err
		else
			return PromiseError.new({
				error = err,
				kind = PromiseError.Kind.ExecutionError,
				trace = debug.traceback(tostring(err), 2),
				context = "Promise created at:\n\n" .. traceback
			})
		end
	end, ...))
end
local function createAdvancer(traceback, fn, onResolve, onReject)
	return function(...)
		local success, count, values = runExecutor(traceback, fn, ...)
		if success then
			onResolve(unpack(values, 1, count))
		else
			onReject(values[1])
		end
	end
end
local function isEmpty(p1)
	return next(p1) == nil
end
local Promise = {
	Error = PromiseError,
	Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
	_getTime = os.clock,
	_timeEvent = game:GetService("RunService").Heartbeat,
	_unhandledRejectionCallbacks = {},
	prototype = {}
}
Promise.__index = Promise.prototype
function Promise._new(traceback, executor, parentPromise)
	if parentPromise ~= nil and not Promise.is(parentPromise) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end
	local promise = {
		_thread = nil,
		_source = traceback,
		_status = Promise.Status.Started,
		_values = nil,
		_valuesLength = -1,
		_unhandledRejection = true,
		_queuedResolve = {},
		_queuedReject = {},
		_queuedFinally = {},
		_cancellationHook = nil,
		_parent = parentPromise
	}
	promise._consumers = setmetatable({}, weakKeyMetatable)
	if parentPromise and parentPromise._status == Promise.Status.Started then
		parentPromise._consumers[promise] = true
	end
	setmetatable(promise, Promise)
	local function resolve(...)
		promise:_resolve(...)
	end
	local function reject(...)
		promise:_reject(...)
	end
	local function onCancel(hook)
		if hook and promise._status == Promise.Status.Cancelled then
			hook()
		elseif hook then
			promise._cancellationHook = hook
		end
		return promise._status == Promise.Status.Cancelled
	end
	promise._thread = coroutine.create(function()
		local success, _, values = runExecutor(promise._source, executor, resolve, reject, onCancel)
		if not success then
			reject(values[1])
		end
	end)
	task.spawn(promise._thread)
	return promise
end
function Promise.new(executor)
	return Promise._new(debug.traceback(nil, 2), executor)
end
function Promise.__tostring(p1)
	return string.format("Promise(%s)", p1._status)
end
function Promise.defer(fn)
	local traceback = debug.traceback(nil, 2)
	return Promise._new(traceback, function(resolve, reject, onCancel)
		local connection = nil
		connection = Promise._timeEvent:Connect(function()
			connection:Disconnect()
			local success, _, values = runExecutor(traceback, fn, resolve, reject, onCancel)
			if not success then
				reject(values[1])
			end
		end)
	end)
end
Promise.async = Promise.defer
function Promise.resolve(...)
	local count, values = pack(...)
	return Promise._new(debug.traceback(nil, 2), function(resolve)
		resolve(unpack(values, 1, count))
	end)
end
function Promise.reject(...)
	local count, values = pack(...)
	return Promise._new(debug.traceback(nil, 2), function(resolve, reject)
		reject(unpack(values, 1, count))
	end)
end
function Promise._try(traceback, fn, ...)
	local count, values = pack(...)
	return Promise._new(traceback, function(resolve)
		resolve(fn(unpack(values, 1, count)))
	end)
end
function Promise.try(fn, ...)
	return Promise._try(debug.traceback(nil, 2), fn, ...)
end
function Promise._all(traceback, promises, requiredCount)
	if type(promises) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
	end
	for k, v in pairs(promises) do
		if not Promise.is(v) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(k))), 3)
		end
	end
	if #promises == 0 or requiredCount == 0 then
		return Promise.resolve({})
	else
		return Promise._new(traceback, function(resolve, reject, onCancel)
			local results = {}
			local allPromises = {}
			local resolvedCount = 0
			local rejectedCount = 0
			local finished = false
			local function cancelAll()
				for i, v in ipairs(allPromises) do
					v:cancel()
				end
			end
			local function resolveOne(index, ...)
				if not finished then
					resolvedCount = resolvedCount + 1
					if requiredCount == nil then
						results[index] = ...
					else
						results[resolvedCount] = ...
					end
					if (requiredCount or #promises) <= resolvedCount then
						finished = true
						resolve(results)
						for i, v in ipairs(allPromises) do
							v:cancel()
						end
					end
				end
			end
			onCancel(cancelAll)
			for i, v in ipairs(promises) do
				allPromises[i] = v:andThen(function(...)
					resolveOne(i, ...)
				end, function(...)
					rejectedCount = rejectedCount + 1
					if requiredCount == nil or #promises - rejectedCount < requiredCount then
						for i, v in ipairs(allPromises) do
							v:cancel()
						end
						finished = true
						reject(...)
					end
				end)
			end
			if finished then
				for i, v in ipairs(allPromises) do
					v:cancel()
				end
			end
		end)
	end
end
function Promise.all(promises)
	return Promise._all(debug.traceback(nil, 2), promises)
end
function Promise.fold(p1, p2, p3)
	assert(type(p1) == "table", "Bad argument #1 to Promise.fold: must be a table")
	local v2
	if type(p2) == "function" then
		v2 = true
	elseif type(p2) == "table" then
		local v3 = getmetatable(p2)
		v2 = if v3 then type((rawget(v3, "__call"))) == "function" else false
	else
		v2 = false
	end
	assert(v2, "Bad argument #2 to Promise.fold: must be a function")
	local v5 = t3.resolve(p3)
	return t3.each(p1, function(p1, p22)
		v5 = v5:andThen(function(p12)
			return p2(p12, p1, p22)
		end)
	end):andThen(function()
		return v5
	end)
end
function Promise.some(p1, p2)
	assert(type(p2) == "number", "Bad argument #2 to Promise.some: must be a number")
	return t3._all(debug.traceback(nil, 2), p1, p2)
end
function Promise.any(p1)
	return t3._all(debug.traceback(nil, 2), p1, 1):andThen(function(p1)
		return p1[1]
	end)
end
function Promise.allSettled(p1)
	if type(p1) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
	end
	for k, v in pairs(p1) do
		if not t3.is(v) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(k))), 2)
		end
	end
	if #p1 == 0 then
		return t3.resolve({})
	else
		return t3._new(debug.traceback(nil, 2), function(p12, p2, p3)
			local t = {}
			local t2 = {}
			local v1 = 0
			local function resolveOne(p13, ...)
				v1 = v1 + 1
				t[p13] = ...
				if #p1 <= v1 then
					p12(t)
				end
			end
			p3(function()
				for i, v in ipairs(t2) do
					v:cancel()
				end
			end)
			for i, v in ipairs(p1) do
				t2[i] = v:finally(function(...)
					resolveOne(i, ...)
				end)
			end
		end)
	end
end
function Promise.race(p1)
	local v1 = type(p1) == "table"
	assert(v1, string.format("Please pass a list of promises to %s", "Promise.race"))
	for k, v in pairs(p1) do
		local v2 = t3.is(v)
		local format_2 = string.format
		assert(v2, format_2("Non-promise value passed into %s at index %s", "Promise.race", (tostring(k))))
	end
	return t3._new(debug.traceback(nil, 2), function(p12, p2, p3)
		local list = {}
		local v1 = false
		local function cancel()
			for i, v in ipairs(list) do
				v:cancel()
			end
		end
		local function finalize(p1)
			return function(...)
				for i, v in ipairs(list) do
					v:cancel()
				end
				v1 = true
				return p1(...)
			end
		end
		if not p3(function(...)
			for i, v in ipairs(list) do
				v:cancel()
			end
			v1 = true
			return p2(...)
		end) then
			for i, v in ipairs(p1) do
				list[i] = v:andThen(function(...)
					for i, v in ipairs(list) do
						v:cancel()
					end
					v1 = true
					return p12(...)
				end, function(...)
					for i, v in ipairs(list) do
						v:cancel()
					end
					v1 = true
					return p2(...)
				end)
			end
			if v1 then
				for i, v in ipairs(list) do
					v:cancel()
				end
			end
		end
	end)
end
function Promise.each(p1, p2)
	assert(type(p1) == "table", string.format("Please pass a list of promises to %s", "Promise.each"))
	local v2
	if type(p2) == "function" then
		v2 = true
	elseif type(p2) == "table" then
		local v3 = getmetatable(p2)
		v2 = if v3 then type((rawget(v3, "__call"))) == "function" else false
	else
		v2 = false
	end
	assert(v2, string.format("Please pass a handler function to %s!", "Promise.each"))
	return t3._new(debug.traceback(nil, 2), function(p12, p22, p3)
		local t = {}
		local list = {}
		local v1 = false
		local function cancel()
			for i, v in ipairs(list) do
				v:cancel()
			end
		end
		p3(function()
			v1 = true
			for i, v in ipairs(list) do
				v:cancel()
			end
		end)
		local list2 = {}
		for i, v in ipairs(p1) do
			if t3.is(v) then
				if v:getStatus() == Promise.Status.Cancelled then
					for i2, v2 in ipairs(list) do
						v2:cancel()
					end
					return p22(t2.new({
						error = "Promise is cancelled",
						kind = t2.Kind.AlreadyCancelled,
						context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
					}))
				end
				if v:getStatus() == Promise.Status.Rejected then
					for i2, v2 in ipairs(list) do
						v2:cancel()
					end
					return p22(select(2, v:await()))
				end
				local v2 = v:andThen(function(...)
					return ...
				end)
				table.insert(list, v2)
				list2[i] = v2
			else
				list2[i] = v
			end
		end
		for i, v in ipairs(list2) do
			if t3.is(v) then
				local v3, v4 = v:await()
				v = v4
				if not v3 then
					for i2, v2 in ipairs(list) do
						v2:cancel()
					end
					return p22(v4)
				end
			end
			if v1 then
				return
			end
			local v5 = t3.resolve(p2(v, i))
			table.insert(list, v5)
			local v6, v7 = v5:await()
			if not v6 then
				for i2, v2 in ipairs(list) do
					v2:cancel()
				end
				return p22(v7)
			end
			t[i] = v7
		end
		p12(t)
	end)
end
function Promise.is(value)
	if type(value) == "table" then
		local mt = getmetatable(value)
		if mt == Promise then
			return true
		elseif mt == nil then
			local andThen = value.andThen
			if type(andThen) == "function" then
				return true
			elseif type(andThen) == "table" then
				local mtAndThen = getmetatable(andThen)
				if mtAndThen and type((rawget(mtAndThen, "__call"))) == "function" then
					return true
				else
					return false
				end
			else
				return false
			end
		elseif type(mt) == "table" and type((rawget(mt, "__index"))) == "table" then
			local indexAndThen = rawget(rawget(mt, "__index"), "andThen")
			local isCallable
			if type(indexAndThen) == "function" then
				isCallable = true
			elseif type(indexAndThen) == "table" then
				local mtIndexAndThen = getmetatable(indexAndThen)
				isCallable = if mtIndexAndThen then type((rawget(mtIndexAndThen, "__call"))) == "function" else false
			else
				isCallable = false
			end
			if isCallable then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end
function Promise.promisify(fn)
	return function(...)
		return Promise._try(debug.traceback(nil, 2), fn, ...)
	end
end
local delayListHead = nil
local delayConnection = nil
function Promise.delay(seconds)
	assert(type(seconds) == "number", "Bad argument #1 to Promise.delay, must be a number.")
	if not (seconds >= 1 / 60) or seconds == (1 / 0) then
		seconds = 1 / 60
	end
	return Promise._new(debug.traceback(nil, 2), function(resolve, reject, onCancel)
		local startTime = Promise._getTime()
		local endTime = startTime + seconds
		local delayNode = {
			resolve = resolve,
			startTime = startTime,
			endTime = endTime
		}
		if delayConnection == nil then
			delayListHead = delayNode
			delayConnection = Promise._timeEvent:Connect(function()
				while delayListHead ~= nil and delayListHead.endTime < Promise._getTime() do
					local currentNode = delayListHead
					delayListHead = currentNode.next
					if delayListHead == nil then
						delayConnection:Disconnect()
						delayConnection = nil
					else
						delayListHead.previous = nil
					end
					currentNode.resolve(Promise._getTime() - currentNode.startTime)
				end
			end)
		elseif delayListHead.endTime < endTime then
			local currentNode = delayListHead
			local nextNode = currentNode.next
			while nextNode ~= nil and nextNode.endTime < endTime do
				nextNode, currentNode = nextNode.next, nextNode
			end
			currentNode.next = delayNode
			delayNode.previous = currentNode
			if nextNode ~= nil then
				delayNode.next = nextNode
				nextNode.previous = delayNode
			end
		else
			delayNode.next = delayListHead
			delayListHead.previous = delayNode
			delayListHead = delayNode
		end
		onCancel(function()
			local nextNode = delayNode.next
			if delayListHead == delayNode then
				if nextNode == nil then
					delayConnection:Disconnect()
					delayConnection = nil
				else
					nextNode.previous = nil
				end
				delayListHead = nextNode
			else
				local prevNode = delayNode.previous
				prevNode.next = nextNode
				if nextNode ~= nil then
					nextNode.previous = prevNode
				end
			end
		end)
	end)
end
local function timeout(self, seconds, timeoutError)
	local traceback = debug.traceback(nil, 2)
	return Promise.race({ Promise.delay(seconds):andThen(function()
			return Promise.reject(timeoutError == nil and PromiseError.new({
				kind = PromiseError.Kind.TimedOut,
				error = "Timed out",
				context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", seconds, traceback)
			}) or timeoutError)
		end), self })
end
Promise.prototype.timeout = timeout
local function getStatus(self)
	return self._status
end
Promise.prototype.getStatus = getStatus
local function _andThen(self, traceback, onResolve, onReject)
	self._unhandledRejection = false
	if self._status == Promise.Status.Cancelled then
		local cancelled = Promise.new(function()  end)
		cancelled:cancel()
		return cancelled
	else
		return Promise._new(traceback, function(resolve, reject, onCancel)
			local resolveHandler
			if onResolve then
				local tracebackRef = traceback
				local onResolveRef = onResolve
				resolveHandler = function(...)
					local success, count, values = runExecutor(tracebackRef, onResolveRef, ...)
					if success then
						resolve(unpack(values, 1, count))
					else
						reject(values[1])
					end
				end
			else
				resolveHandler = resolve
			end
			local rejectHandler
			if onReject then
				local tracebackRef = traceback
				local onRejectRef = onReject
				rejectHandler = function(...)
					local success, count, values = runExecutor(tracebackRef, onRejectRef, ...)
					if success then
						resolve(unpack(values, 1, count))
					else
						reject(values[1])
					end
				end
			else
				rejectHandler = reject
			end
			if self._status == Promise.Status.Started then
				table.insert(self._queuedResolve, resolveHandler)
				table.insert(self._queuedReject, rejectHandler)
				onCancel(function()
					if self._status == Promise.Status.Started then
						table.remove(self._queuedResolve, table.find(self._queuedResolve, resolveHandler))
						table.remove(self._queuedReject, table.find(self._queuedReject, rejectHandler))
					end
				end)
			elseif self._status == Promise.Status.Resolved then
				resolveHandler(unpack(self._values, 1, self._valuesLength))
			elseif self._status == Promise.Status.Rejected then
				rejectHandler(unpack(self._values, 1, self._valuesLength))
			end
		end, self)
	end
end
Promise.prototype._andThen = _andThen
local function andThen(self, onResolve, onReject)
	local resolveValid
	if onResolve == nil or type(onResolve) == "function" then
		resolveValid = true
	elseif type(onResolve) == "table" then
		local mtResolve = getmetatable(onResolve)
		resolveValid = if mtResolve then type((rawget(mtResolve, "__call"))) == "function" else false
	else
		resolveValid = false
	end
	assert(resolveValid, string.format("Please pass a handler function to %s!", "Promise:andThen"))
	local rejectValid
	if onReject == nil or type(onReject) == "function" then
		rejectValid = true
	elseif type(onReject) == "table" then
		local mtReject = getmetatable(onReject)
		rejectValid = if mtReject then type((rawget(mtReject, "__call"))) == "function" else false
	else
		rejectValid = false
	end
	assert(rejectValid, string.format("Please pass a handler function to %s!", "Promise:andThen"))
	return self:_andThen(debug.traceback(nil, 2), onResolve, onReject)
end
Promise.prototype.andThen = andThen
local function catch(self, onReject)
	local valid
	if onReject == nil or type(onReject) == "function" then
		valid = true
	elseif type(onReject) == "table" then
		local mt = getmetatable(onReject)
		valid = if mt then type((rawget(mt, "__call"))) == "function" else false
	else
		valid = false
	end
	assert(valid, string.format("Please pass a handler function to %s!", "Promise:catch"))
	return self:_andThen(debug.traceback(nil, 2), nil, onReject)
end
Promise.prototype.catch = catch
local function tap(self, fn)
	local valid
	if type(fn) == "function" then
		valid = true
	elseif type(fn) == "table" then
		local mt = getmetatable(fn)
		valid = if mt then type((rawget(mt, "__call"))) == "function" else false
	else
		valid = false
	end
	assert(valid, string.format("Please pass a handler function to %s!", "Promise:tap"))
	return self:_andThen(debug.traceback(nil, 2), function(...)
		local result = fn(...)
		if Promise.is(result) then
			local count, values = pack(...)
			return result:andThen(function()
				return unpack(values, 1, count)
			end)
		else
			return ...
		end
	end)
end
Promise.prototype.tap = tap
local function andThenCall(self, fn, ...)
	local valid
	if type(fn) == "function" then
		valid = true
	elseif type(fn) == "table" then
		local mt = getmetatable(fn)
		valid = if mt then type((rawget(mt, "__call"))) == "function" else false
	else
		valid = false
	end
	assert(valid, string.format("Please pass a handler function to %s!", "Promise:andThenCall"))
	local argCount, args = pack(...)
	return self:_andThen(debug.traceback(nil, 2), function()
		return fn(unpack(args, 1, argCount))
	end)
end
Promise.prototype.andThenCall = andThenCall
local function andThenReturn(self, ...)
	local count, values = pack(...)
	return self:_andThen(debug.traceback(nil, 2), function()
		return unpack(values, 1, count)
	end)
end
Promise.prototype.andThenReturn = andThenReturn
local function cancel(self)
	if self._status == Promise.Status.Started then
		self._status = Promise.Status.Cancelled
		if self._cancellationHook then
			self._cancellationHook()
		end
		coroutine.close(self._thread)
		if self._parent then
			self._parent:_consumerCancelled(self)
		end
		for k in pairs(self._consumers) do
			k:cancel()
		end
		self:_finalize()
	end
end
Promise.prototype.cancel = cancel
local function _consumerCancelled(self, consumer)
	if self._status == Promise.Status.Started then
		self._consumers[consumer] = nil
		if next(self._consumers) == nil then
			self:cancel()
		end
	end
end
Promise.prototype._consumerCancelled = _consumerCancelled
local function _finally(self, traceback, onFinally)
	self._unhandledRejection = false
	return Promise._new(traceback, function(resolve, reject, onCancel)
		local chainedPromise = nil
		onCancel(function()
			self:_consumerCancelled(self)
			if chainedPromise then
				chainedPromise:cancel()
			end
		end)
		local finallyHandler = if onFinally then function(status)
			local result = onFinally(...)
			if Promise.is(result) then
				chainedPromise = result
				result:finally(function(finalStatus)
					if finalStatus ~= Promise.Status.Rejected then
						resolve(self)
					end
				end):catch(function(...)
					reject(...)
				end)
			else
				resolve(self)
			end
		end else resolve
		if self._status == Promise.Status.Started then
			table.insert(self._queuedFinally, finallyHandler)
		else
			finallyHandler(self._status)
		end
	end)
end
Promise.prototype._finally = _finally
local function finally(self, onFinally)
	local valid
	if onFinally == nil or type(onFinally) == "function" then
		valid = true
	elseif type(onFinally) == "table" then
		local mt = getmetatable(onFinally)
		valid = if mt then type((rawget(mt, "__call"))) == "function" else false
	else
		valid = false
	end
	assert(valid, string.format("Please pass a handler function to %s!", "Promise:finally"))
	return self:_finally(debug.traceback(nil, 2), onFinally)
end
Promise.prototype.finally = finally
local function finallyCall(self, fn, ...)
	local valid
	if type(fn) == "function" then
		valid = true
	elseif type(fn) == "table" then
		local mt = getmetatable(fn)
		valid = if mt then type((rawget(mt, "__call"))) == "function" else false
	else
		valid = false
	end
	assert(valid, string.format("Please pass a handler function to %s!", "Promise:finallyCall"))
	local argCount, args = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return fn(unpack(args, 1, argCount))
	end)
end
Promise.prototype.finallyCall = finallyCall
local function finallyReturn(self, ...)
	local count, values = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return unpack(values, 1, count)
	end)
end
Promise.prototype.finallyReturn = finallyReturn
local function awaitStatus(self)
	self._unhandledRejection = false
	if self._status == Promise.Status.Started then
		local runningThread = coroutine.running()
		self:finally(function()
			task.spawn(runningThread)
		end):catch(function()  end)
		coroutine.yield()
	end
	if self._status == Promise.Status.Resolved or self._status == Promise.Status.Rejected then
		return self._status, unpack(self._values, 1, self._valuesLength)
	else
		return self._status
	end
end
Promise.prototype.awaitStatus = awaitStatus
local function awaitHelper(status, ...)
	return status == Promise.Status.Resolved, ...
end
local function await(self)
	return awaitHelper(self:awaitStatus())
end
Promise.prototype.await = await
local function expectHelper(status, ...)
	if status ~= Promise.Status.Resolved then
		error(if ... == nil then "Expected Promise rejected with no value." else ..., 3)
	end
	return ...
end
local function expect(self)
	return expectHelper(self:awaitStatus())
end
Promise.prototype.expect = expect
Promise.prototype.awaitValue = Promise.prototype.expect
local function _unwrap(self)
	if self._status == Promise.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end
	return self._status == Promise.Status.Resolved, unpack(self._values, 1, self._valuesLength)
end
Promise.prototype._unwrap = _unwrap
local function _resolve(self, ...)
	if self._status == Promise.Status.Started then
		if Promise.is((...)) then
			if select("#", ...) > 1 then
				warn((string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", self._source)))
			end
			local chainedPromise = ...
			local chainedConnection = chainedPromise:andThen(function(...)
				self:_resolve(...)
			end, function(...)
				local chainedError = chainedPromise._values[1]
				if chainedPromise._error then
					chainedError = PromiseError.new({
						error = chainedPromise._error,
						kind = PromiseError.Kind.ExecutionError,
						context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
					})
				end
				if PromiseError.isKind(chainedError, PromiseError.Kind.ExecutionError) then
					return self:_reject(chainedError:extend({
						error = "This Promise was chained to a Promise that errored.",
						trace = "",
						context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", self._source)
					}))
				end
				self:_reject(...)
			end)
			if chainedConnection._status == Promise.Status.Cancelled then
				self:cancel()
			elseif chainedConnection._status == Promise.Status.Started then
				self._parent = chainedConnection
				chainedConnection._consumers[self] = true
			end
		else
			self._status = Promise.Status.Resolved
			local count, values = pack(...)
			self._valuesLength = count
			self._values = values
			for i, v in ipairs(self._queuedResolve) do
				coroutine.wrap(v)(...)
			end
			self:_finalize()
		end
	elseif Promise.is((...)) then
		(...):_consumerCancelled(self)
	end
end
Promise.prototype._resolve = _resolve
local function _reject(self, ...)
	if self._status == Promise.Status.Started then
		self._status = Promise.Status.Rejected
		local count, values = pack(...)
		self._valuesLength = count
		self._values = values
		if next(self._queuedReject) == nil then
			local errorStr = tostring((...))
			coroutine.wrap(function()
				Promise._timeEvent:Wait()
				if self._unhandledRejection then
					local message = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", errorStr, self._source)
					for i, v in ipairs(Promise._unhandledRejectionCallbacks) do
						task.spawn(v, self, unpack(self._values, 1, self._valuesLength))
					end
					if not Promise.TEST then
						warn(message)
					end
				end
			end)()
		else
			for i, v in ipairs(self._queuedReject) do
				coroutine.wrap(v)(...)
			end
		end
		self:_finalize()
	end
end
Promise.prototype._reject = _reject
local function _finalize(self)
	for i, v in ipairs(self._queuedFinally) do
		coroutine.wrap(v)(self._status)
	end
	self._queuedFinally = nil
	self._queuedReject = nil
	self._queuedResolve = nil
	if not Promise.TEST then
		self._parent = nil
		self._consumers = nil
	end
	task.defer(coroutine.close, self._thread)
end
Promise.prototype._finalize = _finalize
local function now(self, error)
	local traceback = debug.traceback(nil, 2)
	if self._status == Promise.Status.Resolved then
		return self:_andThen(traceback, function(...)
			return ...
		end)
	else
		return Promise.reject(error == nil and PromiseError.new({
			kind = PromiseError.Kind.NotResolvedInTime,
			error = "This Promise was not resolved in time for :now()",
			context = ":now() was called at:\n\n" .. traceback
		}) or error)
	end
end
Promise.prototype.now = now
function Promise.retry(fn, timesRemaining, ...)
	local fnValid
	if type(fn) == "function" then
		fnValid = true
	elseif type(fn) == "table" then
		local mt = getmetatable(fn)
		fnValid = if mt then type((rawget(mt, "__call"))) == "function" else false
	else
		fnValid = false
	end
	assert(fnValid, "Parameter #1 to Promise.retry must be a function")
	assert(type(timesRemaining) == "number", "Parameter #2 to Promise.retry must be a number")
	local args = { ... }
	local argCount = select("#", ...)
	return Promise.resolve(fn(...)):catch(function(...)
		if timesRemaining > 0 then
			return Promise.retry(fn, timesRemaining - 1, unpack(args, 1, argCount))
		else
			return Promise.reject(...)
		end
	end)
end
function Promise.retryWithDelay(fn, timesRemaining, delaySeconds, ...)
	local fnValid
	if type(fn) == "function" then
		fnValid = true
	elseif type(fn) == "table" then
		local mt = getmetatable(fn)
		fnValid = if mt then type((rawget(mt, "__call"))) == "function" else false
	else
		fnValid = false
	end
	assert(fnValid, "Parameter #1 to Promise.retry must be a function")
	assert(type(timesRemaining) == "number", "Parameter #2 (times) to Promise.retry must be a number")
	assert(type(delaySeconds) == "number", "Parameter #3 (seconds) to Promise.retry must be a number")
	local args = { ... }
	local argCount = select("#", ...)
	return Promise.resolve(fn(...)):catch(function(...)
		if timesRemaining > 0 then
			Promise.delay(delaySeconds):await()
			return Promise.retryWithDelay(fn, timesRemaining - 1, delaySeconds, unpack(args, 1, argCount))
		else
			return Promise.reject(...)
		end
	end)
end
function Promise.fromEvent(signal, predicate)
	local predicateFn = predicate or function()
		return true
	end
	return Promise._new(debug.traceback(nil, 2), function(resolve, reject, onCancel)
		local connection = nil
		local disconnected = false
		local function disconnect()
			connection:Disconnect()
			connection = nil
		end
		connection = signal:Connect(function(...)
			local predicateResult = predicateFn(...)
			if predicateResult == true then
				resolve(...)
				if connection then
					connection:Disconnect()
					connection = nil
				else
					disconnected = true
				end
			elseif type(predicateResult) ~= "boolean" then
				error("Promise.fromEvent predicate should always return a boolean")
			end
		end)
		if disconnected and connection then
			return disconnect()
		end
		onCancel(disconnect)
	end)
end
function Promise.onUnhandledRejection(callback)
	table.insert(Promise._unhandledRejectionCallbacks, callback)
	return function()
		local index = table.find(Promise._unhandledRejectionCallbacks, callback)
		if index then
			table.remove(Promise._unhandledRejectionCallbacks, index)
		end
	end
end
return Promise
