local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local PlaneConsts_upvr = require(ReplicatedStorage.Plane.PlaneConsts)
local PlaneUtils_upvr = require(ReplicatedStorage.Plane.PlaneUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local RunService_upvr = game:GetService("RunService")
function module_upvr.new(arg1) -- Line 14
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.maid:GiveTask(RxInstanceUtils_upvr.observeAttribute(arg1, PlaneConsts_upvr.BORN_AT_ATTR_NAME, function(arg1_2, arg2) -- Line 18
        if not arg1_2 then
        else
            arg2:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 22
                any_new_result1_upvr:_update(arg1_2)
            end))
        end
    end))
    any_new_result1_upvr._lastPosition = Vector3.new()
    return any_new_result1_upvr
end
function module_upvr._update(arg1, arg2) -- Line 31
    local var11 = workspace:GetServerTimeNow() - arg2
    local any_GetDuration_result1 = arg1:GetDuration()
    local any_GetPositionAt_result1 = arg1:GetPositionAt(var11)
    arg1.obj:PivotTo(CFrame.new(any_GetPositionAt_result1, arg1._lastPosition) * CFrame.Angles(0, math.pi, 0) * CFrame.Angles(0, 0, math.cos(var11) * 0.4))
    arg1._lastPosition = any_GetPositionAt_result1
    if var11 < 1 then
        local maximum = math.max(0, 1 - (var11 - 0) / 1)
        arg1.obj.Engine.Transparency = maximum
        arg1.obj.Wings.Transparency = maximum
    elseif any_GetDuration_result1 - 1 < var11 then
        local minimum = math.min(1, (var11 - any_GetDuration_result1 + 1) / 1)
        arg1.obj.Engine.Transparency = minimum
        arg1.obj.Wings.Transparency = minimum
    end
end
function module_upvr.SetOrigin(arg1, arg2) -- Line 55
    return PlaneUtils_upvr.setOrigin(arg1.obj, arg2)
end
function module_upvr.GetOrigin(arg1) -- Line 58
    return PlaneUtils_upvr.getOrigin(arg1.obj)
end
function module_upvr.SetTarget(arg1, arg2) -- Line 61
    return PlaneUtils_upvr.setTarget(arg1.obj, arg2)
end
function module_upvr.GetTarget(arg1) -- Line 64
    return PlaneUtils_upvr.getTarget(arg1.obj)
end
function module_upvr.SetSpeed(arg1, arg2) -- Line 67
    return PlaneUtils_upvr.setSpeed(arg1.obj, arg2)
end
function module_upvr.GetSpeed(arg1) -- Line 70
    return PlaneUtils_upvr.getSpeed(arg1.obj)
end
function module_upvr.SetTypeEnum(arg1, arg2) -- Line 73
    return PlaneUtils_upvr.setTypeEnum(arg1.obj, arg2)
end
function module_upvr.GetTypeEnum(arg1) -- Line 76
    return PlaneUtils_upvr.getTypeEnum(arg1.obj)
end
function module_upvr.SetBornAt(arg1, arg2) -- Line 79
    return PlaneUtils_upvr.setBornAt(arg1.obj, arg2)
end
function module_upvr.GetBornAt(arg1) -- Line 82
    return PlaneUtils_upvr.getBornAt(arg1.obj)
end
function module_upvr.GetDuration(arg1) -- Line 85
    local any_GetSpeed_result1 = arg1:GetSpeed()
    local var17
    if 0 >= any_GetSpeed_result1 then
        var17 = false
    else
        var17 = true
    end
    assert(var17, "speed must be > 0")
    var17 = (arg1:GetTarget() - arg1:GetOrigin()).Magnitude
    return var17 / any_GetSpeed_result1
end
function module_upvr.GetPositionAt(arg1, arg2) -- Line 94
    local any_GetOrigin_result1 = arg1:GetOrigin()
    if not any_GetOrigin_result1 then return end
    local any_GetTarget_result1 = arg1:GetTarget()
    if not any_GetTarget_result1 then return end
    return PlaneUtils_upvr.getPositionAt(arg2, any_GetOrigin_result1, any_GetTarget_result1, PlaneConsts_upvr.DRIFT_WIDTH, arg1:GetDuration())
end
return require(ReplicatedStorage.Std.Binder).new(PlaneConsts_upvr.TAG_NAME, module_upvr)