-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local Signal = require(script.Parent.Signal)
local t = {}
t.__index = t
local v1 = nil
local function _getCallerName(p1)
	local count = 0
	for v2 in p1:gmatch("[^\n]+") do
		local v1
		count = count + 1
		if count == 2 then
			local v3 = v2:match("%.?([%w_]+):%d+")
			local v4 = v2:match("function (%w+)")
			if v3 and v4 then
				return v3 .. "." .. v4
			else
				v1 = v4 or (v3 or "Unknown")
				return v1
			end
		end
	end
	return "Unknown"
end
local function _insert(p1)
	if v1 == nil then
		v1 = p1
	elseif v1.endTime < p1.endTime then
		local v12 = v1
		local v2 = v12.next
		while v2 ~= nil and v2.endTime < p1.endTime do
			v2, v12 = v2.next, v2
		end
		v12.next = p1
		p1.previous = v12
		if v2 ~= nil then
			p1.next = v2
			v2.previous = p1
		end
	else
		p1.next = v1
		v1.previous = p1
		v1 = p1
	end
end
RunService.Heartbeat:Connect(function()
	local v12 = os.clock()
	while v1 ~= nil and v1.endTime <= v12 do
		local v2 = v1
		v1 = v2.next
		if v1 then
			v1.previous = nil
		end
		local v3 = v2.endTime - v2.duration
		v2.endTime = v2.endTime + v2.duration
		v2.next = nil
		_insert(v2)
		debug.profilebegin("Interval::" .. v2.name)
		v2.signal:Fire(v12 - v3)
		debug.profileend()
	end
end)
function t.every(p1)
	assert(type(p1) == "number", "Bad argument #1 to Interval.every, must be a number.")
	assert(p1 == p1, "Bad argument #1 to Interval.every, must not be NaN.")
	assert(p1 < (1 / 0), "Bad argument #1 to Interval.every, must not be infinity.")
	if not (p1 >= 1 / 60) then
		warn("Interval.every: duration is less than 1/60, changing to 1/60")
		p1 = 1 / 60
	end
	local t2 = {}
	setmetatable(t2, t)
	t2._signal = Signal.new()
	local t3 = {
		name = _getCallerName((debug.traceback())),
		signal = t2._signal,
		endTime = os.clock() + p1,
		duration = p1
	}
	_insert(t3)
	t2._node = t3
	return t2
end
local function _remove(p1)
	local v12 = p1.next
	if v1 == p1 then
		if v12 ~= nil then
			v12.previous = nil
		end
		v1 = v12
	else
		local previous = p1.previous
		previous.next = v12
		if v12 ~= nil then
			v12.previous = previous
		end
	end
end
function t.Connect(p1, p2)
	p1._signal:Connect(p2)
	return p1
end
function t.Destroy(p1)
	local _node = p1._node
	local v12 = _node.next
	if v1 == _node then
		if v12 ~= nil then
			v12.previous = nil
		end
		v1 = v12
	else
		local previous = _node.previous
		previous.next = v12
		if v12 ~= nil then
			v12.previous = previous
		end
	end
	p1._signal:Destroy()
	p1._signal = nil
end
t.Disconnect = t.Destroy
return t
