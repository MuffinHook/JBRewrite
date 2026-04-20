local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local Roact_upvr = require(ReplicatedStorage.Roact)
local BriefcaseConsts_upvr = require(ReplicatedStorage.AirDrop.BriefcaseConsts)
local BriefcaseUtils_upvr = require(ReplicatedStorage.AirDrop.BriefcaseUtils)
local tbl_upvr_2 = {9238451278, 9238451797, 9238452703, 9238452956, 9238453431, 9238453749}
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local RunService_upvr = game:GetService("RunService")
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local AirDropUtils_upvr = require(ReplicatedStorage.AirDrop.AirDropUtils)
local Players_upvr = game:GetService("Players")
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local createElement_upvr = Roact_upvr.createElement
local BriefcaseDisplay_upvr = require(ReplicatedStorage.AirDrop.UI.BriefcaseDisplay)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.new(arg1) -- Line 35
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.maid:GiveTask(RxInstanceUtils_upvr.observeAttribute(arg1, BriefcaseConsts_upvr.BORN_AT_ATTR_NAME, function(arg1_2, arg2) -- Line 44
        if not arg1_2 then
        else
            any_new_result1_upvr.maid.updatePositionThread = RunService_upvr.Heartbeat:Connect(function() -- Line 48
                any_new_result1_upvr:_update(arg1_2)
            end)
        end
    end))
    local any_getOpenDuration_result1 = BriefcaseUtils_upvr.getOpenDuration(any_new_result1_upvr.obj)
    assert(any_getOpenDuration_result1, "No opening duration for this briefcase")
    local tbl_upvr = {
        Name = "Open Crate";
        Timed = true;
        Duration = any_getOpenDuration_result1;
        Dist = 10;
        Callback = function(arg1_3, arg2) -- Line 54, Named "pressCallback"
            any_new_result1_upvr:_pressed(arg1_3, arg2)
            if arg2 then
                return any_new_result1_upvr:_collect()
            end
        end;
        ReleaseCallback = function(arg1_4, arg2) -- Line 60, Named "releaseCallback"
            any_new_result1_upvr:_released(arg1_4, arg2)
        end;
        GetAccumulation = function() -- Line 76, Named "getCurrentAccumulation"
            return any_new_result1_upvr.obj:GetAttribute(BriefcaseConsts_upvr.BRIEFCASE_PRESS_DURATION_ACCUMULATION_ATTRIBUTE_NAME)
        end;
        WhilePressedUpdate = function(arg1_5) -- Line 63, Named "whilePressedUpdate"
            local ceiled = math.ceil(arg1_5 * #tbl_upvr_2)
            for _, v in ipairs(arg1:FindFirstChild("Walls"):GetDescendants()) do
                if v:IsA("Decal") then
                    if tbl_upvr_2[ceiled] then
                        v.Texture = string.format("rbxassetid://%d", tbl_upvr_2[ceiled])
                    else
                        v.Texture = ""
                    end
                end
            end
        end;
    }
    local function onCollectedChanged() -- Line 94
        if any_new_result1_upvr:GetCollected() then
            tbl_upvr.Enabled = false
            arg1:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = true
            arg1:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = true
            local function _() -- Line 100, Named "onFinished"
                arg1:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = false
                arg1:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = false
            end
            local os_clock_result1_upvr_2 = os.clock()
            local var30_upvw
            var30_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 107
                local var31 = os.clock() - os_clock_result1_upvr_2
                if 0.4 < var31 then
                    var31 = 0.4
                    var30_upvw:Disconnect()
                    var30_upvw = nil
                    arg1:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = false
                    arg1:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = false
                end
                arg1:FindFirstChild("Particles").Transparency = var31 / 0.4
            end)
        end
    end
    onCollectedChanged()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr:GetCollectedChangedSignal():Connect(onCollectedChanged))
    local function onLandedChanged() -- Line 124
        if any_new_result1_upvr:GetLanded() then
            any_new_result1_upvr.maid.updatePositionThread = nil
            tbl_upvr.Part = any_new_result1_upvr.obj.PrimaryPart
            tbl_upvr.ValidRoot = any_new_result1_upvr.obj
            any_new_result1_upvr.maid:GiveTask(CircleAction_upvr.Add(tbl_upvr, any_new_result1_upvr.obj))
            any_new_result1_upvr:_update(arg1:GetAttribute(BriefcaseConsts_upvr.BORN_AT_ATTR_NAME))
            any_new_result1_upvr.maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 134
                local var33 = not AirDropUtils_upvr.getPlayerIsInAmbulanceStretcher(Players_upvr.LocalPlayer)
                if tbl_upvr.Enabled ~= var33 then
                    tbl_upvr.Enabled = var33
                end
            end))
            local os_clock_result1_upvr = os.clock()
            local var36_upvw
            local Chute_upvw = arg1:FindFirstChild("Chute")
            var36_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 149
                local var38 = os.clock() - os_clock_result1_upvr
                if 1 < var38 then
                    var38 = 1
                    var36_upvw:Disconnect()
                    var36_upvw = nil
                end
                if not Chute_upvw then
                    Chute_upvw = arg1:FindFirstChild("Chute")
                end
                if Chute_upvw then
                    Chute_upvw.Transparency = var38 / 1 * 0.75
                end
            end)
        end
    end
    onLandedChanged()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr:GetLandedChangedSignal():Connect(onLandedChanged))
    any_new_result1_upvr.maid:GivePromise(Promise_upvr.all({RxInstanceUtils_upvr.waitForChild(arg1, "RarityProbsDisplay"), RxInstanceUtils_upvr.waitForChild(arg1, BriefcaseConsts_upvr.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME), RxInstanceUtils_upvr.waitForChild(arg1, BriefcaseConsts_upvr.RELEASE_REMOTE_NAME), RxInstanceUtils_upvr.waitForChild(arg1, BriefcaseConsts_upvr.HOLD_UPDATE_REMOTE_NAME)}):andThen(function(arg1_6) -- Line 177
        local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("SurfaceGui", {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            ResetOnSpawn = false;
            PixelsPerStud = 16;
            Adornee = arg1_6[1];
            Face = Enum.NormalId.Front;
        }, {
            Display = createElement_upvr(BriefcaseDisplay_upvr, {
                probsFolder = arg1_6[2];
            });
        }), Players_upvr.LocalPlayer.PlayerGui, "BriefcaseGui")
        any_new_result1_upvr.maid:GiveTask(function() -- Line 192
            Roact_upvr.unmount(any_mount_result1_upvr)
        end)
        any_new_result1_upvr.maid:GiveTask(arg1_6[3].OnClientEvent:Connect(function() -- Line 197
            if tbl_upvr.Pressed then
                tbl_upvr.ForceRelease = true
            end
        end))
        local _4_upvr = arg1_6[4]
        any_new_result1_upvr.maid:GiveTask(Interval_upvr.every(0.3333333333333333):Connect(function() -- Line 202
            if tbl_upvr.Pressed then
                _4_upvr:FireServer()
            end
        end))
    end))
    return any_new_result1_upvr
end
function module_upvr._collect(arg1) -- Line 212
    arg1.obj:FindFirstChild(BriefcaseConsts_upvr.COLLECT_REMOTE_NAME):FireServer()
    return true
end
function module_upvr._pressed(arg1, arg2, arg3) -- Line 216
    arg1.obj:FindFirstChild(BriefcaseConsts_upvr.PRESS_REMOTE_NAME):FireServer(arg3)
    return true
end
function module_upvr._released(arg1, arg2, arg3) -- Line 220
    arg1.obj:FindFirstChild(BriefcaseConsts_upvr.RELEASE_REMOTE_NAME):FireServer(arg3)
    return true
end
function module_upvr._update(arg1, arg2) -- Line 224
    local var49 = workspace:GetServerTimeNow() - arg2
    local any_GetDuration_result1 = arg1:GetDuration()
    if any_GetDuration_result1 < var49 then
        var49 = any_GetDuration_result1
    end
    if not arg1.obj.PrimaryPart then
    else
        arg1.obj:PivotTo(arg1:GetCFrameAt(var49) * CFrame.new(0, arg1.obj.PrimaryPart.Size.Y * 0.5, 0))
    end
end
function module_upvr.SetOrigin(arg1, arg2) -- Line 243
    return BriefcaseUtils_upvr.setOrigin(arg1.obj, arg2)
end
function module_upvr.GetOrigin(arg1) -- Line 246
    return BriefcaseUtils_upvr.getOrigin(arg1.obj)
end
function module_upvr.SetTarget(arg1, arg2) -- Line 249
    return BriefcaseUtils_upvr.setTarget(arg1.obj, arg2)
end
function module_upvr.GetTarget(arg1) -- Line 252
    return BriefcaseUtils_upvr.getTarget(arg1.obj)
end
function module_upvr.SetTargetNormal(arg1, arg2) -- Line 255
    return BriefcaseUtils_upvr.setTargetNormal(arg1.obj, arg2)
end
function module_upvr.GetTargetNormal(arg1) -- Line 258
    return BriefcaseUtils_upvr.getTargetNormal(arg1.obj)
end
function module_upvr.SetSpeed(arg1, arg2) -- Line 261
    return BriefcaseUtils_upvr.setSpeed(arg1.obj, arg2)
end
function module_upvr.GetSpeed(arg1) -- Line 264
    return BriefcaseUtils_upvr.getSpeed(arg1.obj)
end
function module_upvr.SetBornAt(arg1, arg2) -- Line 267
    return BriefcaseUtils_upvr.setBornAt(arg1.obj, arg2)
end
function module_upvr.GetBornAt(arg1) -- Line 270
    return BriefcaseUtils_upvr.getBornAt(arg1.obj)
end
function module_upvr.SetLanded(arg1, arg2) -- Line 273
    return BriefcaseUtils_upvr.setLanded(arg1.obj, arg2)
end
function module_upvr.GetLanded(arg1) -- Line 276
    return BriefcaseUtils_upvr.getLanded(arg1.obj)
end
function module_upvr.GetLandedChangedSignal(arg1) -- Line 279
    return BriefcaseUtils_upvr.getLandedChangedSignal(arg1.obj)
end
function module_upvr.SetLandedTime(arg1, arg2) -- Line 282
    return BriefcaseUtils_upvr.setLandedTime(arg1.obj, arg2)
end
function module_upvr.GetLandedTime(arg1) -- Line 285
    return BriefcaseUtils_upvr.getLandedTime(arg1.obj)
end
function module_upvr.SetRarityProbabilities(arg1, arg2) -- Line 288
    return BriefcaseUtils_upvr.setRarityProbabilities(arg1.obj, arg2)
end
function module_upvr.GetRarityProbabilities(arg1) -- Line 291
    return BriefcaseUtils_upvr.getRarityProbabilities(arg1.obj)
end
function module_upvr.GetCollected(arg1) -- Line 294
    return BriefcaseUtils_upvr.getCollected(arg1.obj)
end
function module_upvr.SetCollected(arg1, arg2) -- Line 297
    return BriefcaseUtils_upvr.setCollected(arg1.obj, arg2)
end
function module_upvr.GetCollectedChangedSignal(arg1) -- Line 300
    return BriefcaseUtils_upvr.getCollectedChangedSignal(arg1.obj)
end
function module_upvr.GetDuration(arg1) -- Line 303
    local any_GetSpeed_result1 = arg1:GetSpeed()
    local var52
    if 0 >= any_GetSpeed_result1 then
        var52 = false
    else
        var52 = true
    end
    assert(var52, "speed must be > 0")
    var52 = (arg1:GetTarget() - arg1:GetOrigin()).Magnitude
    return var52 / any_GetSpeed_result1
end
function module_upvr.GetPositionAt(arg1, arg2) -- Line 312
    local any_GetOrigin_result1 = arg1:GetOrigin()
    if not any_GetOrigin_result1 then return end
    local any_GetTarget_result1_2 = arg1:GetTarget()
    if not any_GetTarget_result1_2 then return end
    return BriefcaseUtils_upvr.getPositionAt(arg2, any_GetOrigin_result1, any_GetTarget_result1_2, arg1:GetDuration())
end
function module_upvr.GetCFrameAt(arg1, arg2) -- Line 324
    local any_GetOrigin_result1_2 = arg1:GetOrigin()
    if not any_GetOrigin_result1_2 then return end
    local any_GetTarget_result1 = arg1:GetTarget()
    if not any_GetTarget_result1 then return end
    local any_GetTargetNormal_result1 = arg1:GetTargetNormal()
    if not any_GetTargetNormal_result1 then return end
    return BriefcaseUtils_upvr.getCFrameAt(arg2, any_GetOrigin_result1_2, any_GetTarget_result1, any_GetTargetNormal_result1, arg1:GetDuration())
end
return require(ReplicatedStorage.Std.Binder).new(BriefcaseConsts_upvr.TAG_NAME, module_upvr)
