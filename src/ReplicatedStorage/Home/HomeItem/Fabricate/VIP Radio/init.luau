local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RadioConsts_upvr = require(script.RadioConsts)
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Radio_upvr = require(ReplicatedStorage.Game.Radio.Radio)
local RadioPlayer_upvr = require(ReplicatedStorage.Game.Radio.RadioPlayer)
local HomeItemSystem_upvr = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local HomeSystem_upvr = require(ReplicatedStorage.Home.HomeSystem)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local CurrentCamera_upvr = workspace.CurrentCamera
local Time_upvr = require(ReplicatedStorage.Module.Time)
local RunService_upvr = game:GetService("RunService")
function tbl_upvr.new(arg1) -- Line 21
    local module_upvr = {}
    setmetatable(module_upvr, tbl_upvr)
    local _obj_upvr = arg1._obj
    module_upvr._obj = _obj_upvr
    module_upvr._maid = Maid_upvr.new()
    local any_new_result1_upvr = Maid_upvr.new()
    local function action_upvr(arg1_2, arg2) -- Line 30, Named "action"
        if arg2 then
            Radio_upvr.Open()
            any_new_result1_upvr.listenOnClose = Radio_upvr.Window:GetOnClosedSignal():Connect(function() -- Line 33
                any_new_result1_upvr:Destroy()
            end)
            any_new_result1_upvr.listenOnSongStarted = RadioPlayer_upvr.OnSongStarted:Connect(function(arg1_3) -- Line 36
                _obj_upvr:FindFirstChild(RadioConsts_upvr.PLAY_REMOTE_NAME):FireServer(arg1_3)
            end)
            arg1_2.Enabled = false
            return true
        end
        return false
    end
    local function preUpdateFun_upvr(arg1_4) -- Line 45, Named "preUpdateFun"
        local var20
        if var20 then
            var20 = not HomeItemSystem_upvr.isCustomizing()
        end
        local any_queryCurrentStandingHome_result1 = HomeSystem_upvr.queryCurrentStandingHome()
        if not any_queryCurrentStandingHome_result1 then
            var20 = false
        end
        local any_GetHome_result1 = arg1:GetHome()
        if any_GetHome_result1 ~= any_queryCurrentStandingHome_result1 then
            var20 = false
        elseif not any_GetHome_result1:HasPermissionToEdit(LocalPlayer_upvr) then
            var20 = false
        end
        arg1_4.Enabled = var20
    end
    module_upvr._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(_obj_upvr, "Radio", function(arg1_5, arg2) -- Line 61
        local tbl = {}
        tbl.Part = arg1_5
        tbl.Name = "Open Radio"
        tbl.Timed = false
        tbl.Dist = 10
        tbl.Callback = action_upvr
        tbl.PreUpdateFun = preUpdateFun_upvr
        tbl.PreUpdatePeriod = 0.1
        CircleAction_upvr.Add(tbl, arg1_5)
        arg2:GiveTask(function() -- Line 72
            CircleAction_upvr.Remove(arg1_5)
        end)
    end))
    local var26_upvw = 0
    local var27_upvw = 0
    local function updateCameraFov_upvr() -- Line 81, Named "updateCameraFov"
        local var28
        if not RadioPlayer_upvr.CurrentSound then
        else
            local PlaybackLoudness = RadioPlayer_upvr.CurrentSound.PlaybackLoudness
            if PlaybackLoudness ~= PlaybackLoudness then
                PlaybackLoudness = 0
            end
            var28 = var26_upvw
            if var26_upvw ~= var28 then
                var26_upvw = 0
            end
            var28 = var27_upvw
            if var27_upvw ~= var28 then
                var27_upvw = 0
            end
            var28 = 999
            if var28 < var26_upvw then
                var26_upvw = 0
            end
            var28 = 999
            if var28 < var27_upvw then
                var27_upvw = 0
            end
            var28 = -999
            if var26_upvw < var28 then
                var26_upvw = 0
            end
            var28 = -999
            if var27_upvw < var28 then
                var27_upvw = 0
            end
            var28 = var27_upvw * 0.86
            var27_upvw = var28 + PlaybackLoudness * 0.14
            var28 = (PlaybackLoudness - var27_upvw) / 150
            var28 = var26_upvw * 0.97 + math.tanh(var28) * 0.030000000000000027
            var26_upvw = var28
            var28 = var26_upvw
            if var28 < -1 then
                var28 = -1
            end
            if 1 < var28 then
            end
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            if 1 ~= 1 then
            end
            CurrentCamera_upvr.FieldOfView = 0 * 10 + 70
        end
    end
    local function _(arg1_6) -- Line 123, Named "playId"
        RadioPlayer_upvr.PlayRandomSongAfter = false
        RadioPlayer_upvr.PlayId(arg1_6, Time_upvr.GetNowSync() - module_upvr:GetStartedAt(), false)
        module_upvr._maid.updateFov = RunService_upvr.Heartbeat:Connect(updateCameraFov_upvr)
    end
    module_upvr._maid:GiveTask(module_upvr._obj:GetAttributeChangedSignal(RadioConsts_upvr.SONG_ID_ATTR_NAME):Connect(function() -- Line 134
        if arg1:GetHome() == HomeSystem_upvr.queryCurrentStandingHome() then
            local any_GetSongId_result1_4 = module_upvr:GetSongId()
            if any_GetSongId_result1_4 then
                RadioPlayer_upvr.PlayRandomSongAfter = false
                RadioPlayer_upvr.PlayId(any_GetSongId_result1_4, Time_upvr.GetNowSync() - module_upvr:GetStartedAt(), false)
                module_upvr._maid.updateFov = RunService_upvr.Heartbeat:Connect(updateCameraFov_upvr)
                return
            end
            RadioPlayer_upvr.Stop()
            module_upvr._maid.updateFov = nil
        end
    end))
    module_upvr._maid:GiveTask(HomeSystem_upvr.onEntered:Connect(function(arg1_7) -- Line 147
        if arg1:GetHome() == arg1_7 then
            local any_GetSongId_result1_2 = module_upvr:GetSongId()
            if any_GetSongId_result1_2 then
                RadioPlayer_upvr.PlayRandomSongAfter = false
                RadioPlayer_upvr.PlayId(any_GetSongId_result1_2, Time_upvr.GetNowSync() - module_upvr:GetStartedAt(), false)
                module_upvr._maid.updateFov = RunService_upvr.Heartbeat:Connect(updateCameraFov_upvr)
            end
        end
    end))
    module_upvr._maid:GiveTask(HomeSystem_upvr.onExited:Connect(function(arg1_8) -- Line 155
        if arg1:GetHome() == arg1_8 then
            local any_GetSongId_result1_3 = module_upvr:GetSongId()
            if any_GetSongId_result1_3 and RadioPlayer_upvr.CurrentSoundId == any_GetSongId_result1_3 then
                RadioPlayer_upvr.Stop()
                module_upvr._maid.updateFov = nil
            end
        end
    end))
    return module_upvr
end
function tbl_upvr.GetSongId(arg1) -- Line 169
    return arg1._obj:GetAttribute(RadioConsts_upvr.SONG_ID_ATTR_NAME)
end
function tbl_upvr.GetStartedAt(arg1) -- Line 172
    return arg1._obj:GetAttribute(RadioConsts_upvr.STARTED_AT_ATTR_NAME)
end
function tbl_upvr.Destroy(arg1) -- Line 175
    local _maid = arg1._maid
    local var38
    if _maid == nil then
        var38 = false
    else
        var38 = true
    end
    assert(var38)
    arg1._maid = nil
    _maid:Destroy()
end
return {
    setup = function(arg1) -- Line 183, Named "setup"
        local any_new_result1 = tbl_upvr.new(arg1)
        arg1._maid:GiveTask(any_new_result1)
        arg1._radio = any_new_result1
    end;
}