local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CameraShakeInstance_upvr = require(ReplicatedStorage.Game.CamShaker.CameraShakeInstance)
local ProximityCamShakeConsts_upvr = require(script.Parent.ProximityCamShakeConsts)
local function _(arg1) -- Line 16, Named "Ease_InOutQuad"
    local var4
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var4 = 2 * arg1 * arg1
        return var4
    end
    if arg1 >= 0.5 or not decompInlinedCondition() then
        var4 = -1 - 2 * (arg1 - 2) * arg1
    end
    return var4
end
local module_upvr = {}
module_upvr.__index = module_upvr
local function _() -- Line 23, Named "makeCamShakeInst"
    local any_new_result1 = CameraShakeInstance_upvr.new(2, 6, 1, 1)
    any_new_result1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    any_new_result1.RotationInfluence = Vector3.new(1, 1, 1)
    return any_new_result1
end
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new(arg1) -- Line 30
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    if not arg1:GetAttribute(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME) then
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME, false)
    end
    if not arg1:GetAttribute(ProximityCamShakeConsts_upvr.RADIUS_ATTR_NAME) then
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.RADIUS_ATTR_NAME, 32)
    end
    if not arg1:GetAttribute(ProximityCamShakeConsts_upvr.MAGNITUDE_ATTR_NAME) then
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.MAGNITUDE_ATTR_NAME, 1)
    end
    module_upvr_2._maid:GiveTask(arg1:GetAttributeChangedSignal(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME):Connect(function() -- Line 47, Named "updateEnabled"
        if arg1:GetAttribute(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME) then
            module_upvr_2:Listen(arg1)
        else
            module_upvr_2._maid._listenLoop = nil
        end
    end))
    if arg1:GetAttribute(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME) then
        module_upvr_2:Listen(arg1)
        return module_upvr_2
    end
    module_upvr_2._maid._listenLoop = nil
    return module_upvr_2
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.Listen(arg1, arg2) -- Line 60
    arg1._maid._listenLoop = Interval_upvr.every(0.5):Connect(function() -- Line 61
        local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
        if not any_getRootPart_result1 then
        elseif (any_getRootPart_result1.Position - arg2.Position).Magnitude / arg2:GetAttribute(ProximityCamShakeConsts_upvr.RADIUS_ATTR_NAME) <= 1 and not arg1._maid._camUpdater then
            arg1:StartUpdater(arg2)
        end
    end)
end
local CurrentCamera_upvr = workspace.CurrentCamera
local CamShaker_upvr = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local RunService_upvr = game:GetService("RunService")
local random_state_upvr = Random.new()
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
function module_upvr.StartUpdater(arg1, arg2) -- Line 76
    local CFrame_upvw = CurrentCamera_upvr.CFrame
    local any_new_result1_3_upvr = CamShaker_upvr.new(Enum.RenderPriority.Camera.Value + 5, function(arg1_2) -- Line 79
        CFrame_upvw = CurrentCamera_upvr.CFrame
        CurrentCamera_upvr.CFrame *= arg1_2
    end)
    any_new_result1_3_upvr._renderName = "ProximityCamShake_"..tostring(random_state_upvr:NextInteger(1, 1000000000))
    any_new_result1_3_upvr:Start()
    local any_new_result1_2 = CameraShakeInstance_upvr.new(2, 6, 1, 1)
    any_new_result1_2.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    any_new_result1_2.RotationInfluence = Vector3.new(1, 1, 1)
    local any_ShakeSustain_result1_upvr = any_new_result1_3_upvr:ShakeSustain(any_new_result1_2)
    arg1._maid._camUpdater = RunService_upvr.Heartbeat:Connect(function() -- Line 91
        local var26 = (CurrentCamera_upvr.CFrame.Position - arg2.Position).Magnitude / arg2:GetAttribute(ProximityCamShakeConsts_upvr.RADIUS_ATTR_NAME)
        local var27
        if var27 < var26 or not arg2:GetAttribute(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME) then
            var27 = arg1
            var27 = var27._maid
            var27._stop = nil
        else
            var27 = 1 - var26
            local var28 = var27
            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var27 = 2 * var28 * var28
                return var27
            end
            if var28 >= 0.5 or not decompInlinedCondition_2() then
                var27 = -1 - 2 * (var28 - 2) * var28
            end
            var27 *= arg2:GetAttribute(ProximityCamShakeConsts_upvr.MAGNITUDE_ATTR_NAME)
            any_ShakeSustain_result1_upvr:SetScaleMagnitude(var27)
        end
    end)
    local any_Connect_result1_upvr = RunService_upvr.Heartbeat:Connect(function() -- Line 83
        CurrentCamera_upvr.CFrame = CFrame_upvw
    end)
    arg1._maid._stop = function() -- Line 106
        any_ShakeSustain_result1_upvr:StartFadeOut(1)
        Promise_upvr.delay(1):andThen(function() -- Line 110
            any_new_result1_3_upvr:Stop()
            any_Connect_result1_upvr:Disconnect()
        end):catch(warn)
        if arg1._maid then
            arg1._maid._camUpdater = nil
        end
    end
end
function module_upvr.Destroy(arg1) -- Line 121
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr