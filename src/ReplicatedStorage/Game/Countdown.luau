local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.new(arg1) -- Line 10
    if arg1 == nil then
    else
    end
    assert(true, "Missing deadlineUnix")
    local any_new_result1_upvr = BaseObject_upvr.new(nil)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.deadlineUnix = arg1
    any_new_result1_upvr.onTick = Signal_upvr.new()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.onTick)
    any_new_result1_upvr.onFinished = Signal_upvr.new()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.onFinished)
    any_new_result1_upvr.finished = false
    any_new_result1_upvr.maid.tickInterval = Interval_upvr.every(1):Connect(function() -- Line 22
        local any_GetRemaining_result1 = any_new_result1_upvr:GetRemaining()
        if any_GetRemaining_result1 <= 0 then
            any_new_result1_upvr.onTick:Fire(any_GetRemaining_result1)
            if not any_new_result1_upvr.finished then
                any_new_result1_upvr.onFinished:Fire(any_GetRemaining_result1)
            end
            any_new_result1_upvr.finished = true
            any_new_result1_upvr.maid.tickInterval = nil
        else
            any_new_result1_upvr.onTick:Fire(any_GetRemaining_result1)
        end
    end)
    return any_new_result1_upvr
end
function module_upvr.GetNowUnix(arg1) -- Line 38
    return DateTime.now().UnixTimestamp
end
function module_upvr.GetRemaining(arg1) -- Line 41
    return arg1.deadlineUnix - arg1:GetNowUnix()
end
function module_upvr.IsFinished(arg1) -- Line 44
    return arg1.finished
end
return module_upvr