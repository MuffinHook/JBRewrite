local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local VoltConsts_upvr = require(ReplicatedStorage.Volt.VoltConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RunService_upvr = game:GetService("RunService")
function module_upvr.new(arg1) -- Line 11
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local Engine_upvr = any_new_result1.obj.Engine
    any_new_result1.maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 16
        local SOME = Engine_upvr:FindFirstChild(VoltConsts_upvr.ENGINE_SOUND_NAME)
        if SOME then
            SOME.PlaybackSpeed = (math.abs(Engine_upvr.Velocity.Magnitude) + 5) / 150
        end
    end))
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new(VoltConsts_upvr.TAG_NAME, module_upvr)