local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local SpinnerConsts_upvr = require(script.Parent.SpinnerConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new(arg1, arg2) -- Line 13
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.manifest = arg2
    any_new_result1_upvr._pos = 0
    any_new_result1_upvr._vel = 0
    any_new_result1_upvr:_updateSpinning()
    any_new_result1_upvr.maid:GiveTask(arg1:GetAttributeChangedSignal(SpinnerConsts_upvr.ENABLED_ATTR_NAME):Connect(function() -- Line 21
        any_new_result1_upvr:_updateSpinning()
    end))
    any_new_result1_upvr._fadeOut = false
    return any_new_result1_upvr
end
local RunService_upvr = game:GetService("RunService")
function module_upvr._updateSpinning(arg1) -- Line 28
    local var8
    if arg1.obj:GetAttribute(SpinnerConsts_upvr.ENABLED_ATTR_NAME) ~= true then
        var8 = false
    else
        var8 = true
    end
    if var8 then
        arg1._fadeOut = false
        local var10_upvr = arg1.obj:GetAttribute(SpinnerConsts_upvr.ACCEL_ATTR_NAME) or 1
        local var11_upvr = arg1.obj:GetAttribute(SpinnerConsts_upvr.DRAG_PCT_ATTR_NAME) or 0.05
        arg1.maid.spinning = RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 36
            if not arg1._fadeOut then
                local var12 = arg1
                var12._vel += var10_upvr * 1 * arg1_2
            end
            local var13 = arg1
            var13._vel *= 1 - var11_upvr
            local var14 = arg1
            var14._pos += arg1._vel * arg1_2
            arg1.manifest.innerModel:PivotTo(arg1.obj:GetPivot() * CFrame.Angles(0, arg1._pos, 0))
            if arg1._fadeOut and math.abs(arg1._vel) < 0.1 then
                arg1.maid.spinning = nil
            end
        end)
    else
        var10_upvr = true
        arg1._fadeOut = var10_upvr
    end
end
return require(ReplicatedStorage.ManifestBinder).new(SpinnerConsts_upvr.TAG_NAME, {
    innerModel = require(ReplicatedStorage.Door2.DoorConsts).INNER_MODEL_NAME;
}, module_upvr)