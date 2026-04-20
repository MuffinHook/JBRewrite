local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NPCUtils_upvr = require(ReplicatedStorage.NPC.NPCUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local setupAnimations_upvr = require(ReplicatedStorage.NPC.setupAnimations)
local NPCShared_upvr = require(ReplicatedStorage.NPC.NPCShared)
function module_upvr.new(arg1, arg2) -- Line 12
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2.maid = Maid_upvr.new()
    module_upvr_2._maid = module_upvr_2.maid
    module_upvr_2.obj = arg1
    module_upvr_2.manifest = arg2
    module_upvr_2.humanoid = arg2.humanoid
    module_upvr_2._humanoid = module_upvr_2.humanoid
    module_upvr_2.maid:GiveTask(task.delay(0.5, function() -- Line 28
        module_upvr_2.maid:GiveTask(setupAnimations_upvr(arg1))
    end))
    NPCShared_upvr.setup(module_upvr_2)
    return module_upvr_2
end
local Players_upvr = game:GetService("Players")
function module_upvr.IsLocallyOwned(arg1) -- Line 35
    local var10
    if NPCUtils_upvr.getNetworkOwner(arg1.obj) ~= Players_upvr.LocalPlayer then
        var10 = false
    else
        var10 = true
    end
    return var10
end
function module_upvr.GetTargetType(arg1) -- Line 38
    return NPCUtils_upvr.getTargetType(arg1.obj)
end
function module_upvr.SetTargetType(arg1, arg2) -- Line 41
    NPCUtils_upvr.setTargetType(arg1.obj, arg2)
end
function module_upvr.GetTarget(arg1) -- Line 44
    return NPCUtils_upvr.getTarget(arg1.obj)
end
function module_upvr.SetLookAt(arg1, arg2, arg3) -- Line 48
    NPCUtils_upvr.setLookAt(arg1.obj, arg2, arg3)
end
function module_upvr.Destroy(arg1) -- Line 51
    arg1.maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr