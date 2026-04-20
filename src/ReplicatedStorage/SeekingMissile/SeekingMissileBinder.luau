local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
local SeekingMissileUtils_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local SeekingMissileShared_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileShared)
local NetworkOwnedBinder_upvr = require(ReplicatedStorage.NetworkOwned.NetworkOwnedBinder)
function module_upvr.new(arg1, arg2) -- Line 14
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.alignOrientation = arg2.alignOrientation
    any_new_result1_upvr.vectorForce = arg2.vectorForce
    any_new_result1_upvr.targetPartObj = arg2.targetPartObj
    any_new_result1_upvr.runMaid = Maid_upvr.new()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.runMaid)
    SeekingMissileShared_upvr._init(any_new_result1_upvr)
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.onApplyingThrustChanged:Connect(function() -- Line 26
        arg2.applyingThrustRemote:FireServer(any_new_result1_upvr.flagApplyingThrust)
    end))
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.onExploded:Connect(function(...) -- Line 30
        arg2.explodeRemote:FireServer(...)
    end))
    any_new_result1_upvr.maid:GiveTask(arg2.explodeRemote.OnClientEvent:Connect(function(...) -- Line 35
        any_new_result1_upvr.onExploded:Fire(...)
    end))
    any_new_result1_upvr.maid:GivePromise(NetworkOwnedBinder_upvr:Promise(arg1):andThen(function(arg1_2) -- Line 39
        local function handle() -- Line 40
            any_new_result1_upvr.runMaid:DoCleaning()
            if not arg2.targetPartObj.Value and not SeekingMissileUtils_upvr.getTargetPos(arg1) then
            else
                if not arg1_2:GetOwner() then return end
                SeekingMissileShared_upvr._run(any_new_result1_upvr)
            end
        end
        any_new_result1_upvr.runMaid:DoCleaning()
        if not arg2.targetPartObj.Value and not SeekingMissileUtils_upvr.getTargetPos(arg1) then
        elseif not arg1_2:GetOwner() then
        else
            SeekingMissileShared_upvr._run(any_new_result1_upvr)
        end
        any_new_result1_upvr.maid:GiveTask(arg2.targetPartObj.Changed:Connect(handle))
        any_new_result1_upvr.maid:GiveTask(SeekingMissileUtils_upvr.getTargetPosChangedSignal(arg1):Connect(handle))
        any_new_result1_upvr.maid:GiveTask(arg1_2:GetOwnerChangedSignal():Connect(handle))
    end))
    return any_new_result1_upvr
end
function module_upvr.SetTargetPart(arg1, arg2) -- Line 60
    arg1.targetPartObj.Value = arg2
end
function module_upvr.SetTargetPos(arg1, arg2) -- Line 63
    SeekingMissileUtils_upvr.setTargetPos(arg1.obj, arg2)
end
return require(ReplicatedStorage.ManifestBinder).new(SeekingMissileConsts.TAG_NAME, {
    alignOrientation = SeekingMissileConsts.ALIGN_ORIENTATION_NAME;
    vectorForce = SeekingMissileConsts.VECTOR_FORCE_NAME;
    targetPartObj = SeekingMissileConsts.TARGET_PART_OBJ_NAME;
    applyingThrustRemote = SeekingMissileConsts.APPLYING_THRUST_REMOTE_NAME;
    explodeRemote = SeekingMissileConsts.EXPLODE_REMOTE_NAME;
}, module_upvr)