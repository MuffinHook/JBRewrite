local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local var5_upvw
local function PlaySound_upvr(arg1, arg2) -- Line 14, Named "PlaySound"
    local Sound_upvr = Instance.new("Sound")
    Sound_upvr.SoundId = string.format("rbxassetid://%d", arg2)
    Sound_upvr.Volume = 0.75
    Sound_upvr.Parent = arg1
    Sound_upvr:Play()
    delay(1, function() -- Line 20
        game.Debris:AddItem(Sound_upvr, Sound_upvr.TimeLength)
    end)
end
local function AddedJewel_upvr(arg1) -- Line 25, Named "AddedJewel"
    local function Action(arg1_2, arg2) -- Line 26
        if arg2 then
            var5_upvw:FireServer('d'.."wzxj6o1o":sub(4, 7):reverse():reverse():reverse():reverse():reverse().."".."uww", arg1.Name)
            Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6875006205, {
                Volume = 0.4;
            })
        end
        return true
    end
    local tbl_2 = {}
    tbl_2.Part = arg1
    tbl_2.Name = "Grab Jewel"
    tbl_2.Timed = true
    tbl_2.Duration = 3
    tbl_2.Dist = 8
    tbl_2.Callback = Action
    CircleAction_upvr.Add(tbl_2, arg1)
end
local function AddedLaserButton_upvr(arg1) -- Line 43, Named "AddedLaserButton"
    local tbl = {}
    tbl.Part = arg1
    tbl.Name = ""
    tbl.Dist = 8
    function tbl.Callback(arg1_3, arg2) -- Line 44, Named "Action"
        if arg2 then
            var5_upvw:FireServer('d'.."utbr1vy":sub(5, 5):reverse().."".."".."e30u6oi":sub(5, 6):reverse():reverse():reverse().."".."".."pqpujv":sub(4, 5):reverse().."".."ww", "LaserButton")
        end
        return true
    end
    CircleAction_upvr.Add(tbl, arg1)
end
local var11_upvw
local TweenService_upvr = game:GetService("TweenService")
local CamShaker_upvr = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local RunService_upvr = game:GetService("RunService")
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local CollectionService_upvr = game:GetService("CollectionService")
return {
    Init = function(arg1) -- Line 58, Named "Init"
        var5_upvw = arg1.Event
        var11_upvw = arg1.em
        local Sound_upvr_2 = Instance.new("Sound")
        Sound_upvr_2.SoundId = "rbxassetid://1837825257"
        Sound_upvr_2.Looped = true
        Sound_upvr_2.Volume = 0
        Sound_upvr_2.SoundGroup = game:GetService("SoundService").RobberyMusic
        Sound_upvr_2.Parent = LocalPlayer_upvr.PlayerGui
        local function FadeInSound_upvr() -- Line 69, Named "FadeInSound"
            Sound_upvr_2:Play()
            Audio_upvr.FadeTo(Sound_upvr_2, 1, 2)
        end
        local function FadeOutSound_upvr() -- Line 73, Named "FadeOutSound"
            Audio_upvr.FadeTo(Sound_upvr_2, 0, 2)
            task.wait(2)
            Sound_upvr_2:Stop()
        end
        function var11_upvw.q0lvn6pr(arg1_4) -- Line 79
            task.delay(0.2, function() -- Line 80
                arg1_4.Transparency = 0.25
                TweenService_upvr:Create(arg1_4, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
                    Transparency = 0.4;
                }):Play()
            end)
        end
        function var11_upvw.msjskw8t(arg1_5, arg2) -- Line 90
            PlaySound_upvr(LocalPlayer_upvr, 1837831244)
            delay(1, function() -- Line 92
                PlaySound_upvr(LocalPlayer_upvr, 1843025542)
            end)
            spawn(FadeInSound_upvr)
            if not arg1_5 then
            else
                for _, v_2_upvr in arg2 do
                    v_2_upvr.CanCollide = true
                    task.delay(2, function() -- Line 101
                        v_2_upvr.CanCollide = false
                    end)
                end
                local CurrentCamera_upvr = workspace.CurrentCamera
                local CFrame_upvw = CurrentCamera_upvr.CFrame
                local any_new_result1_upvr = CamShaker_upvr.new(Enum.RenderPriority.Camera.Value + 2, function(arg1_6) -- Line 107
                    CFrame_upvw = CurrentCamera_upvr.CFrame
                    CurrentCamera_upvr.CFrame *= arg1_6
                end)
                any_new_result1_upvr:Start()
                any_new_result1_upvr:Shake(CamShaker_upvr.Presets.Explosion)
                local any_Connect_result1_upvr = RunService_upvr.Heartbeat:Connect(function() -- Line 111
                    CurrentCamera_upvr.CFrame = CFrame_upvw
                end)
                Promise_upvr.delay(2):andThenCall(function() -- Line 117
                    any_new_result1_upvr:Stop()
                    any_Connect_result1_upvr:Disconnect()
                end)
            end
        end
        function var11_upvw.dcihzbw0() -- Line 122
            spawn(FadeOutSound_upvr)
        end
        for _, v in next, CollectionService_upvr:GetTagged("RobberyJewelryJewel") do
            if v:GetAttribute("LaserButton") then
                AddedLaserButton_upvr(v)
            else
                AddedJewel_upvr(v)
            end
        end
        CollectionService_upvr:GetInstanceAddedSignal("RobberyJewelryJewel"):Connect(function(arg1_7) -- Line 133
            if arg1_7:GetAttribute("LaserButton") then
                AddedLaserButton_upvr(arg1_7)
            else
                AddedJewel_upvr(arg1_7)
            end
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("RobberyJewelryJewel"):Connect(CircleAction_upvr.Remove)
    end;
}