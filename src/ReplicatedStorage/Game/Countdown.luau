-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Signal = require(ReplicatedStorage.Std.Signal)
local Interval = require(ReplicatedStorage.Std.Interval)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	assert(p1 ~= nil, "Missing deadlineUnix")
	local v2 = BaseObject.new(nil)
	setmetatable(v2, t)
	v2.deadlineUnix = p1
	v2.onTick = Signal.new()
	v2.maid:GiveTask(v2.onTick)
	v2.onFinished = Signal.new()
	v2.maid:GiveTask(v2.onFinished)
	v2.finished = false
	v2.maid.tickInterval = Interval.every(1):Connect(function()
		local v1 = v2:GetRemaining()
		if v1 <= 0 then
			v2.onTick:Fire(v1)
			if not v2.finished then
				v2.onFinished:Fire(v1)
			end
			v2.finished = true
			v2.maid.tickInterval = nil
		else
			v2.onTick:Fire(v1)
		end
	end)
	return v2
end
function t.GetNowUnix(p1)
	return DateTime.now().UnixTimestamp
end
function t.GetRemaining(p1)
	return p1.deadlineUnix - p1:GetNowUnix()
end
function t.IsFinished(p1)
	return p1.finished
end
return t
