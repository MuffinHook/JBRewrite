local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
return function(arg1, arg2) -- Line 6
    local any_Get_result1_2 = arg1:Get(arg2)
    if any_Get_result1_2 then
        return Promise_upvr.resolve(any_Get_result1_2)
    end
    local any_new_result1_upvr = Maid_upvr.new()
    local any_defer_result1_upvr = Promise_upvr.defer(function(arg1_2) -- Line 12
        local any_Get_result1 = arg1:Get(arg2)
        if any_Get_result1 then
            arg1_2(any_Get_result1)
        else
            any_new_result1_upvr:GiveTask(arg1:ObserveInstance(arg2, function(arg1_3) -- Line 17
                arg1_2(arg1_3)
            end))
        end
    end)
    any_defer_result1_upvr:finally(function() -- Line 22
        any_new_result1_upvr:Destroy()
    end)
    task.delay(5, function() -- Line 25
        if any_defer_result1_upvr:getStatus() == Promise_upvr.Status.Started then
            warn(("[promiseBoundClass] - Infinite yield possible on %q for binder %q\n"):format(arg2:GetFullName(), arg1:GetTag()))
        end
    end)
    return any_defer_result1_upvr
end
