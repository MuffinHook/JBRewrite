local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Binder).new("ShootingRangeTarget", function(arg1) -- Line 8
    local any_new_result1 = Maid_upvr.new()
    local var7_upvw = true
    local var8_upvw
    any_new_result1:GiveTask(function() -- Line 13
        var7_upvw = false
        if var8_upvw then
            var8_upvw:cancel()
        end
    end)
    any_new_result1:GivePromise(DoorUtils_upvr.promiseInnerModel(arg1):andThen(function(arg1_2) -- Line 19
        task.wait(0.5)
        local ShootingRangePart = arg1_2:FindFirstChild("ShootingRangePart")
        if ShootingRangePart then
            ShootingRangePart.CanCollide = true
        end
        while var7_upvw do
            var8_upvw = Promise_upvr.resolve():andThenCall(DoorUtils_upvr.setOpen, arg1, not DoorUtils_upvr.getOpen(arg1)):andThenCall(Promise_upvr.delay, DoorUtils_upvr.getDuration(arg1) or 1)
            var8_upvw:await()
        end
    end))
    return any_new_result1
end):Start()