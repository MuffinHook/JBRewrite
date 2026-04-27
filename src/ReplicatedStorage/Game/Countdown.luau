local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Signal = require(ReplicatedStorage.Std.Signal)
local Interval = require(ReplicatedStorage.Std.Interval)
local Countdown = {}
Countdown.__index = Countdown
setmetatable(Countdown, BaseObject)
function Countdown.new(deadlineUnix)
	assert(deadlineUnix ~= nil, "Missing deadlineUnix")
	local countdown = BaseObject.new(nil)
	setmetatable(countdown, Countdown)
	countdown.deadlineUnix = deadlineUnix
	countdown.onTick = Signal.new()
	countdown.maid:GiveTask(countdown.onTick)
	countdown.onFinished = Signal.new()
	countdown.maid:GiveTask(countdown.onFinished)
	countdown.finished = false
	countdown.maid.tickInterval = Interval.every(1):Connect(function()
		local remainingTime = countdown:GetRemaining()
		if remainingTime <= 0 then
			countdown.onTick:Fire(remainingTime)
			if not countdown.finished then
				countdown.onFinished:Fire(remainingTime)
			end
			countdown.finished = true
			countdown.maid.tickInterval = nil
		else
			countdown.onTick:Fire(remainingTime)
		end
	end)
	return countdown
end
function Countdown.GetNowUnix(self)
	return DateTime.now().UnixTimestamp
end
function Countdown.GetRemaining(self)
	return self.deadlineUnix - self:GetNowUnix()
end
function Countdown.IsFinished(self)
	return self.finished
end
return Countdown
