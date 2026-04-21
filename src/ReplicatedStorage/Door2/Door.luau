local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DoorConsts_upvr = require(script.Parent.DoorConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr.new(arg1, arg2) -- Line 13
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._updateCallback = nil
    module_upvr_2._maid:GiveTask(arg1:GetAttributeChangedSignal(DoorConsts_upvr.OPEN_ATTR_NAME):Connect(function() -- Line 19
        local var8
        if arg1:GetAttribute(DoorConsts_upvr.OPEN_ATTR_NAME) == true then
            var8 = 1
        else
            var8 = 0
        end
        module_upvr_2:_updateEndJ(arg1, var8)
    end))
    module_upvr_2._maid:GiveTask(arg1:GetAttributeChangedSignal(DoorConsts_upvr.MAX_ANGLE_ATTR_NAME):Connect(function() -- Line 23
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var10
        if arg1:GetAttribute(DoorConsts_upvr.PCT_OPEN_ATTR_NAME) == nil then
            if arg1:GetAttribute(DoorConsts_upvr.OPEN_ATTR_NAME) then
                var10 = 1
            else
                var10 = 0
            end
        end
        module_upvr_2:_updateEndJ(arg1, var10)
    end))
    module_upvr_2._maid:GiveTask(arg1:GetAttributeChangedSignal(DoorConsts_upvr.PCT_OPEN_ATTR_NAME):Connect(function() -- Line 30
        module_upvr_2:_updateEndJ(arg1, arg1:GetAttribute(DoorConsts_upvr.PCT_OPEN_ATTR_NAME))
    end))
    module_upvr_2._maid:GiveTask(RxInstanceUtils_upvr.observeProperty(arg1, "PrimaryPart", function(arg1_2, arg2_2) -- Line 35
        if arg1_2 then
            arg2_2:GiveTask(RxInstanceUtils_upvr.observeProperty(arg2.innerModel, "PrimaryPart", function(arg1_3) -- Line 38
                -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
                if arg1_3 then
                    local var14
                    if arg1:GetAttribute(DoorConsts_upvr.PCT_OPEN_ATTR_NAME) == nil then
                        if arg1:GetAttribute(DoorConsts_upvr.OPEN_ATTR_NAME) then
                            var14 = 1
                        else
                            var14 = 0
                        end
                    end
                    module_upvr_2._lastJ = var14
                    module_upvr_2:_updateEndJ(arg1, var14, true)
                end
            end))
        end
    end))
    return module_upvr_2
end
function module_upvr.SetUpdateCallback(arg1, arg2) -- Line 54
    arg1._updateCallback = arg2
    return function() -- Line 56
        if arg1._updateCallback == arg2 then
            arg1._updateCallback = nil
            return true
        end
        return false
    end
end
local RunService_upvr = game:GetService("RunService")
local TweenService_upvr = game:GetService("TweenService")
local DoorUtils_upvr = require(script.Parent.DoorUtils)
local function getTargetPctOpen(arg1)
    local pctOpen = arg1:GetAttribute(DoorConsts_upvr.PCT_OPEN_ATTR_NAME)
    if pctOpen ~= nil then
        return pctOpen
    end
    return arg1:GetAttribute(DoorConsts_upvr.OPEN_ATTR_NAME) == true and 1 or 0
end
function module_upvr._updateEndJ(arg1, arg2, arg3, arg4) -- Line 64
    local SOME_upvr = arg2:FindFirstChild(DoorConsts_upvr.INNER_MODEL_NAME)
    local PrimaryPart_upvr = arg2.PrimaryPart
    if not SOME_upvr or not SOME_upvr.PrimaryPart or not PrimaryPart_upvr then
        return
    end
    arg3 = if arg3 ~= nil then arg3 else getTargetPctOpen(arg2)
    local attribute_upvr = arg2:GetAttribute(DoorConsts_upvr.SHOULD_SWING_ATTR_NAME)
    local var23
    if attribute_upvr then
        var23 = arg2:GetAttribute(DoorConsts_upvr.MAX_ANGLE_ATTR_NAME) or math.rad(90)
    else
        var23 = SOME_upvr.PrimaryPart.Size.X
    end
    local var24_upvr = arg3 * var23
    arg1._lastValue = arg1._lastValue or 0
    if not arg4 then
        local var25_upvr = var24_upvr - arg1._lastValue
        local os_clock_result1_2_upvr = os.clock()
        local duration = arg2:GetAttribute(DoorConsts_upvr.DURATION_ATTR_NAME) or 0
        if var25_upvr == 0 or var23 == 0 or duration <= 0 then
            arg1._lastValue = var24_upvr
            DoorUtils_upvr.setValue(arg2, var24_upvr)
            if arg1._updateCallback then
                arg1._updateCallback(var24_upvr, 1)
            end
            return
        end
        local var28_upvr = math.abs(var25_upvr) / math.abs(var23) * duration
        local var29_upvr = Enum.EasingStyle[arg2:GetAttribute(DoorConsts_upvr.EASING_STYLE_ATTR_NAME) or "Quad"]
        local var30_upvr = Enum.EasingDirection[arg2:GetAttribute(DoorConsts_upvr.EASING_DIRECTION_ATTR_NAME) or "Out"]
        local var31_upvw = 0
        local SOME_upvr_2 = PrimaryPart_upvr:FindFirstChild(DoorConsts_upvr.MOTOR_OBJ_NAME)
        arg1._maid._animator = RunService_upvr.Heartbeat:Connect(function() -- Line 90
            local os_clock_result1 = os.clock()
            local any_GetValue_result1 = TweenService_upvr:GetValue((os_clock_result1 - os_clock_result1_2_upvr) / var28_upvr, var29_upvr, var30_upvr)
            local var35 = arg1._lastValue + var25_upvr * (any_GetValue_result1 - var31_upvw)
            var31_upvw = any_GetValue_result1
            if var28_upvr <= os_clock_result1 - os_clock_result1_2_upvr then
                var35 = var24_upvr
                arg1._maid._animator = nil
            end
            arg1._lastValue = var35
            DoorUtils_upvr.setValueRaw(PrimaryPart_upvr, SOME_upvr, SOME_upvr_2, attribute_upvr, var35)
            if arg1._updateCallback then
                arg1._updateCallback(var35, math.abs(var35 / var25_upvr))
            end
        end)
    else
        arg1._lastValue = var24_upvr
        var25_upvr = DoorUtils_upvr
        var25_upvr = var25_upvr.setValue
        var28_upvr = arg2
        os_clock_result1_2_upvr = var24_upvr
        var25_upvr(var28_upvr, os_clock_result1_2_upvr)
        var25_upvr = arg1._updateCallback
        if var25_upvr then
            var25_upvr = arg1._updateCallback
            var28_upvr = var24_upvr
            var25_upvr(var28_upvr)
        end
    end
end
function module_upvr.Destroy(arg1) -- Line 120
    arg1._maid:Destroy()
    arg1._maid = nil
    setmetatable(arg1, nil)
end
return module_upvr
