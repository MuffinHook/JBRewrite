-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local Signal = require(script.Parent.Signal)
local Interval = {}
Interval.__index = Interval
local intervalListHead = nil
local function _getCallerName(traceback)
	local lineCount = 0
	for line in traceback:gmatch("[^\n]+") do
		local funcName
		lineCount = lineCount + 1
		if lineCount == 2 then
			local fileName = line:match("%.?([%w_]+):%d+")
			local functionName = line:match("function (%w+)")
			if fileName and functionName then
				return fileName .. "." .. functionName
			else
				funcName = functionName or (fileName or "Unknown")
				return funcName
			end
		end
	end
	return "Unknown"
end
local function _insertNode(node)
	if intervalListHead == nil then
		intervalListHead = node
	elseif intervalListHead.endTime < node.endTime then
		local current = intervalListHead
		local next = current.next
		while next ~= nil and next.endTime < node.endTime do
			next, current = next.next, next
		end
		current.next = node
		node.previous = current
		if next ~= nil then
			node.next = next
			next.previous = node
		end
	else
		node.next = intervalListHead
		intervalListHead.previous = node
		intervalListHead = node
	end
end
RunService.Heartbeat:Connect(function()
	local currentTime = os.clock()
	while intervalListHead ~= nil and intervalListHead.endTime <= currentTime do
		local node = intervalListHead
		intervalListHead = node.next
		if intervalListHead then
			intervalListHead.previous = nil
		end
		local startTime = node.endTime - node.duration
		node.endTime = node.endTime + node.duration
		node.next = nil
		_insertNode(node)
		debug.profilebegin("Interval::" .. node.name)
		node.signal:Fire(currentTime - startTime)
		debug.profileend()
	end
end)
function Interval.every(duration)
	assert(type(duration) == "number", "Bad argument #1 to Interval.every, must be a number.")
	assert(duration == duration, "Bad argument #1 to Interval.every, must not be NaN.")
	assert(duration < (1 / 0), "Bad argument #1 to Interval.every, must not be infinity.")
	if not (duration >= 1 / 60) then
		warn("Interval.every: duration is less than 1/60, changing to 1/60")
		duration = 1 / 60
	end
	local interval = {}
	setmetatable(interval, Interval)
	interval._signal = Signal.new()
	local node = {
		name = _getCallerName((debug.traceback())),
		signal = interval._signal,
		endTime = os.clock() + duration,
		duration = duration
	}
	_insertNode(node)
	interval._node = node
	return interval
end
local function _removeNode(node)
	local nextNode = node.next
	if intervalListHead == node then
		if nextNode ~= nil then
			nextNode.previous = nil
		end
		intervalListHead = nextNode
	else
		local prevNode = node.previous
		prevNode.next = nextNode
		if nextNode ~= nil then
			nextNode.previous = prevNode
		end
	end
end
function Interval.Connect(self, callback)
	self._signal:Connect(callback)
	return self
end
function Interval.Destroy(self)
	local node = self._node
	local nextNode = node.next
	if intervalListHead == node then
		if nextNode ~= nil then
			nextNode.previous = nil
		end
		intervalListHead = nextNode
	else
		local prevNode = node.previous
		prevNode.next = nextNode
		if nextNode ~= nil then
			nextNode.previous = prevNode
		end
	end
	self._signal:Destroy()
	self._signal = nil
end
Interval.Disconnect = Interval.Destroy
return Interval
