-- Reviewed by Claude
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
local function makeErrorHandler(p1)
	assert(p1 ~= nil, "traceback is nil")
	return function(p12)
		if type(p12) == "table" then
			return p12
		else
			return t2.new({
				error = p12,
				kind = t2.Kind.ExecutionError,
				trace = debug.traceback(tostring(p12), 2),
				context = "Promise created at:\n\n" .. p1
			})
		end
	end
end
local function runExecutor(p1, p2, ...)
	local v2 = xpcall
	assert(p1 ~= nil, "traceback is nil")
	return packResult(v2(p2, function(p12)
		if type(p12) == "table" then
			return p12
		else
			return t2.new({
				error = p12,
				kind = t2.Kind.ExecutionError,
				trace = debug.traceback(tostring(p12), 2),
				context = "Promise created at:\n\n" .. p1
			})
		end
	end, ...))
end
local function createAdvancer(p1, p2, p3, p4)
	return function(...)
		local v1, v2, v3 = runExecutor(p1, p2, ...)
		if v1 then
			p3(unpack(v3, 1, v2))
		else
			p4(v3[1])
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
function Promise._new(p1, p2, p3)
	if p3 ~= nil and not Promise.is(p3) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end
	local t2 = {
		_thread = nil,
		_source = p1,
		_status = Promise.Status.Started,
		_values = nil,
		_valuesLength = -1,
		_unhandledRejection = true,
		_queuedResolve = {},
		_queuedReject = {},
		_queuedFinally = {},
		_cancellationHook = nil,
		_parent = p3
	}
	t2._consumers = setmetatable({}, weakKeyMetatable)
	if p3 and p3._status == Promise.Status.Started then
		p3._consumers[t2] = true
	end
	setmetatable(t2, Promise)
	local function resolve(...)
		t2:_resolve(...)
	end
	local function reject(...)
		t2:_reject(...)
	end
	local function onCancel(p1)
		if p1 and t2._status == Promise.Status.Cancelled then
			p1()
		elseif p1 then
			t2._cancellationHook = p1
		end
		return t2._status == Promise.Status.Cancelled
	end
	t2._thread = coroutine.create(function()
		local v1, _, v2 = runExecutor(t2._source, p2, resolve, reject, onCancel)
		if not v1 then
			reject(v2[1])
		end
	end)
	task.spawn(t2._thread)
	return t2
end
function Promise.new(p1)
	return t3._new(debug.traceback(nil, 2), p1)
end
function Promise.__tostring(p1)
	return string.format("Promise(%s)", p1._status)
end
function Promise.defer(p1)
	local v1 = debug.traceback(nil, 2)
	return t3._new(v1, function(p12, p2, p3)
		local v12 = nil
		v12 = t3._timeEvent:Connect(function()
			v12:Disconnect()
			local v13, _, v2 = runExecutor(v1, p1, p12, p2, p3)
			if not v13 then
				p2(v2[1])
			end
		end)
	end)
end
Promise.async = Promise.defer
function Promise.resolve(...)
	local v1, v2 = pack(...)
	return t3._new(debug.traceback(nil, 2), function(p1)
		p1(unpack(v2, 1, v1))
	end)
end
function Promise.reject(...)
	local v1, v2 = pack(...)
	return t3._new(debug.traceback(nil, 2), function(p1, p2)
		p2(unpack(v2, 1, v1))
	end)
end
function Promise._try(p1, p2, ...)
	local v1, v2 = pack(...)
	return t3._new(p1, function(p1)
		p1(p2(unpack(v2, 1, v1)))
	end)
end
function Promise.try(p1, ...)
	return t3._try(debug.traceback(nil, 2), p1, ...)
end
function Promise._all(p1, p2, p3)
	if type(p2) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
	end
	for k, v in pairs(p2) do
		if not t3.is(v) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(k))), 3)
		end
	end
	if #p2 == 0 or p3 == 0 then
		return t3.resolve({})
	else
		return t3._new(p1, function(p1, p22, p32)
			local t = {}
			local list = {}
			local v1 = 0
			local v2 = 0
			local v3 = false
			local function cancel()
				for i, v in ipairs(list) do
					v:cancel()
				end
			end
			local function resolveOne(p12, ...)
				if not v3 then
					v1 = v1 + 1
					if p3 == nil then
						t[p12] = ...
					else
						t[v1] = ...
					end
					if (p3 or #p2) <= v1 then
						v3 = true
						p1(t)
						for i, v in ipairs(list) do
							v:cancel()
						end
					end
				end
			end
			p32(cancel)
			for i, v in ipairs(p2) do
				list[i] = v:andThen(function(...)
					resolveOne(i, ...)
				end, function(...)
					v2 = v2 + 1
					if p3 == nil or #p2 - v2 < p3 then
						for i, v in ipairs(list) do
							v:cancel()
						end
						v3 = true
						p22(...)
					end
				end)
			end
			if v3 then
				for i, v in ipairs(list) do
					v:cancel()
				end
			end
		end)
	end
end
function Promise.all(p1)
	return t3._all(debug.traceback(nil, 2), p1)
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
function t3.is(p1)
	if type(p1) == "table" then
		local v1 = getmetatable(p1)
		if v1 == t3 then
			return true
		elseif v1 == nil then
			local andThen = p1.andThen
			if type(andThen) == "function" then
				return true
			elseif type(andThen) == "table" then
				local v2 = getmetatable(andThen)
				if v2 and type((rawget(v2, "__call"))) == "function" then
					return true
				else
					return false
				end
			else
				return false
			end
		elseif type(v1) == "table" and type((rawget(v1, "__index"))) == "table" then
			local v6 = rawget(rawget(v1, "__index"), "andThen")
			local v7
			if type(v6) == "function" then
				v7 = true
			elseif type(v6) == "table" then
				local v8 = getmetatable(v6)
				v7 = if v8 then type((rawget(v8, "__call"))) == "function" else false
			else
				v7 = false
			end
			if v7 then
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
function t3.promisify(p1)
	return function(...)
		return t3._try(debug.traceback(nil, 2), p1, ...)
	end
end
local v1 = nil
local v2 = nil
function t3.delay(p1)
	assert(type(p1) == "number", "Bad argument #1 to Promise.delay, must be a number.")
	if not (p1 >= 1 / 60) or p1 == (1 / 0) then
		p1 = 1 / 60
	end
	return t3._new(debug.traceback(nil, 2), function(p12, p2, p3)
		local v12 = t3._getTime()
		local v22 = v12 + p1
		local t = {
			resolve = p12,
			startTime = v12,
			endTime = v22
		}
		if v2 == nil then
			v1 = t
			v2 = t3._timeEvent:Connect(function()
				while v1 ~= nil and v1.endTime < t3._getTime() do
					local v22 = v1
					v1 = v22.next
					if v1 == nil then
						v2:Disconnect()
						v2 = nil
					else
						v1.previous = nil
					end
					v22.resolve(t3._getTime() - v22.startTime)
				end
			end)
		elseif v1.endTime < v22 then
			local v3 = v1
			local v4 = v3.next
			while v4 ~= nil and v4.endTime < v22 do
				v4, v3 = v4.next, v4
			end
			v3.next = t
			t.previous = v3
			if v4 ~= nil then
				t.next = v4
				v4.previous = t
			end
		else
			t.next = v1
			v1.previous = t
			v1 = t
		end
		p3(function()
			local v12 = t.next
			if v1 == t then
				if v12 == nil then
					v2:Disconnect()
					v2 = nil
				else
					v12.previous = nil
				end
				v1 = v12
			else
				local previous = t.previous
				previous.next = v12
				if v12 ~= nil then
					v12.previous = previous
				end
			end
		end)
	end)
end
local function timeout(p1, p2, p3)
	local v1 = debug.traceback(nil, 2)
	return t3.race({ t3.delay(p2):andThen(function()
			return t3.reject(p3 == nil and t2.new({
				kind = t2.Kind.TimedOut,
				error = "Timed out",
				context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", p2, v1)
			}) or p3)
		end), p1 })
end
t3.prototype.timeout = timeout
local function getStatus(p1)
	return p1._status
end
t3.prototype.getStatus = getStatus
local function _andThen(p1, p2, p3, p4)
	p1._unhandledRejection = false
	if p1._status == Promise.Status.Cancelled then
		local v1 = t3.new(function()  end)
		v1:cancel()
		return v1
	else
		return t3._new(p2, function(p12, p22, p32)
			local v1
			if p3 then
				local v2 = p2
				local v3 = p3
				v1 = function(...)
					local v1, v22, v32 = runExecutor(v2, v3, ...)
					if v1 then
						p12(unpack(v32, 1, v22))
					else
						p22(v32[1])
					end
				end
			else
				v1 = p12
			end
			local v4
			if p4 then
				local v5 = p2
				local v6 = p4
				v4 = function(...)
					local v1, v2, v3 = runExecutor(v5, v6, ...)
					if v1 then
						p12(unpack(v3, 1, v2))
					else
						p22(v3[1])
					end
				end
			else
				v4 = p22
			end
			if p1._status == Promise.Status.Started then
				table.insert(p1._queuedResolve, v1)
				table.insert(p1._queuedReject, v4)
				p32(function()
					if p1._status == Promise.Status.Started then
						table.remove(p1._queuedResolve, table.find(p1._queuedResolve, v1))
						table.remove(p1._queuedReject, table.find(p1._queuedReject, v4))
					end
				end)
			elseif p1._status == Promise.Status.Resolved then
				v1(unpack(p1._values, 1, p1._valuesLength))
			elseif p1._status == Promise.Status.Rejected then
				v4(unpack(p1._values, 1, p1._valuesLength))
			end
		end, p1)
	end
end
t3.prototype._andThen = _andThen
local function andThen(p1, p2, p3)
	local v1
	if p2 == nil or type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, string.format("Please pass a handler function to %s!", "Promise:andThen"))
	local v4
	if p3 == nil or type(p3) == "function" then
		v4 = true
	elseif type(p3) == "table" then
		local v5 = getmetatable(p3)
		v4 = if v5 then type((rawget(v5, "__call"))) == "function" else false
	else
		v4 = false
	end
	assert(v4, string.format("Please pass a handler function to %s!", "Promise:andThen"))
	return p1:_andThen(debug.traceback(nil, 2), p2, p3)
end
t3.prototype.andThen = andThen
local function catch(p1, p2)
	local v1
	if p2 == nil or type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, string.format("Please pass a handler function to %s!", "Promise:catch"))
	return p1:_andThen(debug.traceback(nil, 2), nil, p2)
end
t3.prototype.catch = catch
local function tap(p1, p2)
	local v1
	if type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, string.format("Please pass a handler function to %s!", "Promise:tap"))
	return p1:_andThen(debug.traceback(nil, 2), function(...)
		local v1 = p2(...)
		if t3.is(v1) then
			local v2, v3 = pack(...)
			return v1:andThen(function()
				return unpack(v3, 1, v2)
			end)
		else
			return ...
		end
	end)
end
t3.prototype.tap = tap
local function andThenCall(p1, p2, ...)
	local v1
	if type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, string.format("Please pass a handler function to %s!", "Promise:andThenCall"))
	local v4, v5 = pack(...)
	return p1:_andThen(debug.traceback(nil, 2), function()
		return p2(unpack(v5, 1, v4))
	end)
end
t3.prototype.andThenCall = andThenCall
local function andThenReturn(p1, ...)
	local v1, v2 = pack(...)
	return p1:_andThen(debug.traceback(nil, 2), function()
		return unpack(v2, 1, v1)
	end)
end
t3.prototype.andThenReturn = andThenReturn
local function cancel(p1)
	if p1._status == Promise.Status.Started then
		p1._status = Promise.Status.Cancelled
		if p1._cancellationHook then
			p1._cancellationHook()
		end
		coroutine.close(p1._thread)
		if p1._parent then
			p1._parent:_consumerCancelled(p1)
		end
		for k in pairs(p1._consumers) do
			k:cancel()
		end
		p1:_finalize()
	end
end
t3.prototype.cancel = cancel
local function _consumerCancelled(p1, p2)
	if p1._status == Promise.Status.Started then
		p1._consumers[p2] = nil
		if next(p1._consumers) == nil then
			p1:cancel()
		end
	end
end
t3.prototype._consumerCancelled = _consumerCancelled
local function _finally(p1, p2, p3)
	p1._unhandledRejection = false
	return t3._new(p2, function(p12, p2, p32)
		local v1 = nil
		p32(function()
			p1:_consumerCancelled(p1)
			if v1 then
				v1:cancel()
			end
		end)
		local v2 = if p3 then function(...)
	local v12 = p3(...)
	if t3.is(v12) then
		v1 = v12
		v12:finally(function(p13)
			if p13 ~= Promise.Status.Rejected then
				p12(p1)
			end
		end):catch(function(...)
			p2(...)
		end)
	else
		p12(p1)
	end
end else p12
		if p1._status == Promise.Status.Started then
			table.insert(p1._queuedFinally, v2)
		else
			v2(p1._status)
		end
	end)
end
t3.prototype._finally = _finally
local function finally(p1, p2)
	local v1
	if p2 == nil or type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, string.format("Please pass a handler function to %s!", "Promise:finally"))
	return p1:_finally(debug.traceback(nil, 2), p2)
end
t3.prototype.finally = finally
local function finallyCall(p1, p2, ...)
	local v1
	if type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, string.format("Please pass a handler function to %s!", "Promise:finallyCall"))
	local v4, v5 = pack(...)
	return p1:_finally(debug.traceback(nil, 2), function()
		return p2(unpack(v5, 1, v4))
	end)
end
t3.prototype.finallyCall = finallyCall
local function finallyReturn(p1, ...)
	local v1, v2 = pack(...)
	return p1:_finally(debug.traceback(nil, 2), function()
		return unpack(v2, 1, v1)
	end)
end
t3.prototype.finallyReturn = finallyReturn
local function awaitStatus(p1)
	p1._unhandledRejection = false
	if p1._status == Promise.Status.Started then
		local v1 = coroutine.running()
		p1:finally(function()
			task.spawn(v1)
		end):catch(function()  end)
		coroutine.yield()
	end
	if p1._status == Promise.Status.Resolved or p1._status == Promise.Status.Rejected then
		return p1._status, unpack(p1._values, 1, p1._valuesLength)
	else
		return p1._status
	end
end
t3.prototype.awaitStatus = awaitStatus
local function awaitHelper(p1, ...)
	return p1 == Promise.Status.Resolved, ...
end
local function await(p1)
	return awaitHelper(p1:awaitStatus())
end
t3.prototype.await = await
local function expectHelper(p1, ...)
	if p1 ~= Promise.Status.Resolved then
		error(if ... == nil then "Expected Promise rejected with no value." else ..., 3)
	end
	return ...
end
local function expect(p1)
	return expectHelper(p1:awaitStatus())
end
t3.prototype.expect = expect
t3.prototype.awaitValue = t3.prototype.expect
local function _unwrap(p1)
	if p1._status == Promise.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end
	return p1._status == Promise.Status.Resolved, unpack(p1._values, 1, p1._valuesLength)
end
t3.prototype._unwrap = _unwrap
local function _resolve(p1, ...)
	if p1._status == Promise.Status.Started then
		if t3.is((...)) then
			if select("#", ...) > 1 then
				warn((string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", p1._source)))
			end
			local v2 = ...
			local v3 = v2:andThen(function(...)
				p1:_resolve(...)
			end, function(...)
				local v1 = v2._values[1]
				if v2._error then
					v1 = t2.new({
						error = v2._error,
						kind = t2.Kind.ExecutionError,
						context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
					})
				end
				if t2.isKind(v1, t2.Kind.ExecutionError) then
					return p1:_reject(v1:extend({
						error = "This Promise was chained to a Promise that errored.",
						trace = "",
						context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", p1._source)
					}))
				end
				p1:_reject(...)
			end)
			if v3._status == Promise.Status.Cancelled then
				p1:cancel()
			elseif v3._status == Promise.Status.Started then
				p1._parent = v3
				v3._consumers[p1] = true
			end
		else
			p1._status = Promise.Status.Resolved
			local v4, v5 = pack(...)
			p1._valuesLength = v4
			p1._values = v5
			for i, v in ipairs(p1._queuedResolve) do
				coroutine.wrap(v)(...)
			end
			p1:_finalize()
		end
	elseif t3.is((...)) then
		(...):_consumerCancelled(p1)
	end
end
t3.prototype._resolve = _resolve
local function _reject(p1, ...)
	if p1._status == Promise.Status.Started then
		p1._status = Promise.Status.Rejected
		local v1, v2 = pack(...)
		p1._valuesLength = v1
		p1._values = v2
		if next(p1._queuedReject) == nil then
			local v4 = tostring((...))
			coroutine.wrap(function()
				t3._timeEvent:Wait()
				if p1._unhandledRejection then
					local v1 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", v4, p1._source)
					for i, v in ipairs(t3._unhandledRejectionCallbacks) do
						task.spawn(v, p1, unpack(p1._values, 1, p1._valuesLength))
					end
					if not t3.TEST then
						warn(v1)
					end
				end
			end)()
		else
			for i, v in ipairs(p1._queuedReject) do
				coroutine.wrap(v)(...)
			end
		end
		p1:_finalize()
	end
end
t3.prototype._reject = _reject
local function _finalize(p1)
	for i, v in ipairs(p1._queuedFinally) do
		coroutine.wrap(v)(p1._status)
	end
	p1._queuedFinally = nil
	p1._queuedReject = nil
	p1._queuedResolve = nil
	if not t3.TEST then
		p1._parent = nil
		p1._consumers = nil
	end
	task.defer(coroutine.close, p1._thread)
end
t3.prototype._finalize = _finalize
local function now(p1, p2)
	local v1 = debug.traceback(nil, 2)
	if p1._status == Promise.Status.Resolved then
		return p1:_andThen(v1, function(...)
			return ...
		end)
	else
		return t3.reject(p2 == nil and t2.new({
			kind = t2.Kind.NotResolvedInTime,
			error = "This Promise was not resolved in time for :now()",
			context = ":now() was called at:\n\n" .. v1
		}) or p2)
	end
end
t3.prototype.now = now
function t3.retry(p1, p2, ...)
	local v1
	if type(p1) == "function" then
		v1 = true
	elseif type(p1) == "table" then
		local v2 = getmetatable(p1)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, "Parameter #1 to Promise.retry must be a function")
	assert(type(p2) == "number", "Parameter #2 to Promise.retry must be a number")
	local t = { ... }
	local v5 = select("#", ...)
	return t3.resolve(p1(...)):catch(function(...)
		if p2 > 0 then
			return t3.retry(p1, p2 - 1, unpack(t, 1, v5))
		else
			return t3.reject(...)
		end
	end)
end
function t3.retryWithDelay(p1, p2, p3, ...)
	local v1
	if type(p1) == "function" then
		v1 = true
	elseif type(p1) == "table" then
		local v2 = getmetatable(p1)
		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end
	assert(v1, "Parameter #1 to Promise.retry must be a function")
	assert(type(p2) == "number", "Parameter #2 (times) to Promise.retry must be a number")
	assert(type(p3) == "number", "Parameter #3 (seconds) to Promise.retry must be a number")
	local t = { ... }
	local v6 = select("#", ...)
	return t3.resolve(p1(...)):catch(function(...)
		if p2 > 0 then
			t3.delay(p3):await()
			return t3.retryWithDelay(p1, p2 - 1, p3, unpack(t, 1, v6))
		else
			return t3.reject(...)
		end
	end)
end
function t3.fromEvent(p1, p2)
	local v2 = p2 or function()
		return true
	end
	return t3._new(debug.traceback(nil, 2), function(p12, p2, p3)
		local v1 = nil
		local v22 = false
		local function disconnect()
			v1:Disconnect()
			v1 = nil
		end
		v1 = p1:Connect(function(...)
			local v12 = v2(...)
			if v12 == true then
				p12(...)
				if v1 then
					v1:Disconnect()
					v1 = nil
				else
					v22 = true
				end
			elseif type(v12) ~= "boolean" then
				error("Promise.fromEvent predicate should always return a boolean")
			end
		end)
		if v22 and v1 then
			return disconnect()
		end
		p3(disconnect)
	end)
end
function t3.onUnhandledRejection(p1)
	table.insert(t3._unhandledRejectionCallbacks, p1)
	return function()
		local v1 = table.find(t3._unhandledRejectionCallbacks, p1)
		if v1 then
			table.remove(t3._unhandledRejectionCallbacks, v1)
		end
	end
end
return t3
