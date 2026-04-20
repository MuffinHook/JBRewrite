local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_2_upvr.new(arg1) -- Line 13
    local var5 = arg1
    assert(var5)
    if 0 >= arg1 then
        var5 = false
    else
        var5 = true
    end
    assert(var5)
    local module = {}
    setmetatable(module, module_2_upvr)
    module.Maid = Maid_upvr.new()
    module.Duration = arg1
    module.BornAt = os.clock()
    module.OnCompleted = Signal_upvr.new()
    module.Maid:GiveTask(module.OnCompleted)
    module.OnCanceled = Signal_upvr.new()
    module.Maid:GiveTask(module.OnCanceled)
    module.IsCompleted = false
    return module
end
function module_2_upvr.Update(arg1) -- Line 33
    local var7 = (os.clock() - arg1.BornAt) / arg1.Duration
    if 1 <= var7 and arg1.IsCompleted == false then
        arg1.IsCompleted = true
        arg1.OnCompleted:Fire()
    end
    return math.clamp(var7, 0, 1)
end
function module_2_upvr.Destroy(arg1) -- Line 45
    if arg1.Maid == nil then
    else
        arg1.Maid = nil
        if arg1.IsCompleted == false then
            arg1.OnCanceled:Fire()
        end
        arg1.Maid:Destroy()
    end
end
return module_2_upvr