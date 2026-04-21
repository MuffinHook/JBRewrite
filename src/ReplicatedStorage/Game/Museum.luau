local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function PlaySound_upvr(arg1, arg2) -- Line 23, Named "PlaySound"
    local Sound_upvr_2 = Instance.new("Sound")
    Sound_upvr_2.SoundId = string.format("rbxassetid://%d", arg2);
    Sound_upvr_2.Volume = 0.75
    Sound_upvr_2.Parent = arg1
    Sound_upvr_2:Play()
    task.delay(1, function() -- Line 29
        game.Debris:AddItem(Sound_upvr_2, Sound_upvr_2.TimeLength)
    end)
end
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local UI_upvr = require(ReplicatedStorage.Module.UI)
local CollectionService_upvr = game:GetService("CollectionService")
return function(arg1) -- Line 34
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Event_upvr = arg1.Event
    local em_upvr = arg1.em
    local Sound_upvr = Instance.new("Sound")
    Sound_upvr.SoundId = "rbxassetid://1841825097"
    Sound_upvr.Looped = true
    Sound_upvr.SoundGroup = game:GetService("SoundService").RobberyMusic
    Sound_upvr.Parent = LocalPlayer_upvr.PlayerGui
    local var38_upvw = 0
    local function FadeInSound_upvr() -- Line 46, Named "FadeInSound"
        local var40 = var38_upvw + 1
        var38_upvw = var40
        Sound_upvr:Play()
        for i = 0, 1, 0.015 do
            if var38_upvw ~= var40 then return end
            Sound_upvr.Volume = i
            task.wait()
        end
    end
    local function FadeOutSound_upvr() -- Line 60, Named "FadeOutSound"
        local var42 = var38_upvw + 1
        var38_upvw = var42
        for i_2 = 1, 0, -0.015 do
            if var38_upvw ~= var42 then return end
            Sound_upvr.Volume = i_2
            task.wait()
        end
        Sound_upvr:Stop()
    end
    local var43_upvw = false
    local function EnterRobbery_upvr() -- Line 76, Named "EnterRobbery"
        if var43_upvw then
            return error("Already in robbery")
        end
        var43_upvw = true
        PlaySound_upvr(LocalPlayer_upvr, 1837831244)
        task.delay(1, function() -- Line 82
            PlaySound_upvr(LocalPlayer_upvr, 1843025542)
        end)
        task.spawn(FadeInSound_upvr)
    end
    local function _() -- Line 87, Named "ExitRobbery"
        if not var43_upvw then
            return error("Player not in robbery")
        end
        var43_upvw = false
        task.spawn(FadeOutSound_upvr)
    end
    function em_upvr.wwgjdqav() -- Line 95
        EnterRobbery_upvr()
    end
    function em_upvr.zivj88bp() -- Line 98
        if not var43_upvw then
        else
            var43_upvw = false
            task.spawn(FadeOutSound_upvr)
        end
    end
    local function _(arg1_2) -- Line 102, Named "Ease_InOutQuad"
        local var45
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var45 = 2 * arg1_2 * arg1_2
            return var45
        end
        if arg1_2 >= 0.5 or not decompInlinedCondition() then
            var45 = -1 - 2 * (arg1_2 - 2) * arg1_2
        end
        return var45
    end
    local tbl_upvw = {}
    local any_new_result1_upvr = Maid_upvr.new()
    local var48_upvw
    function em_upvr.xykvglgj(arg1_3) -- Line 108
        if not var48_upvw then
            return false
        end
        var48_upvw:Disconnect()
        var48_upvw = nil
        any_new_result1_upvr:DoCleaning()
        for _, v in next, arg1_3 do
            v.Part.Transparency = 1
            v.Part.Color = Color3.fromRGB(153, 153, 153)
        end
    end
    function em_upvr.yva2ki1r(arg1_4) -- Line 120
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        if var48_upvw then
            em_upvr.xykvglgj()
        end
        for _, v_2 in next, arg1_4 do
            v_2.Part.Transparency = 0
        end
        for _, v_3_upvr in ipairs(arg1_4) do
            local tick_result1_2_upvw = tick()
            any_new_result1_upvr:GiveTask(v_3_upvr.Part.Touched:Connect(function(arg1_5) -- Line 130
                if not arg1_5:IsDescendantOf(LocalPlayer_upvr.Character) then
                else
                    local tick_result1 = tick()
                    if tick_result1 - tick_result1_2_upvw < 0.2 then return end
                    if 0.5 <= tick_result1 - v_3_upvr.LastDamage then
                        tick_result1_2_upvw = tick_result1
                        v_3_upvr.LastDamage = tick_result1
                        Event_upvr:FireServer('a'.."".."auv6byw1":sub(5, 5):reverse().."".."".."qipae3w":sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."".."w3i2dn9":sub(3, 5):reverse().."".."".."l2vmfi":sub(3, 3):reverse()..""..'g')
                    end
                end
            end))
            local _
        end
        local function _(arg1_6) -- Line 146, Named "getPeriod"
            return 0.5 * arg1_6.Duration * arg1_6._speed
        end
        var48_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 149
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            for _, v_4 in next, arg1_4 do
                local var83
                if not v_4._speed then
                    v_4._speed = 0
                    v_4._offset = 0
                end
                local Part = v_4.Part
                local var85
                var83 = tbl_upvw
                var83 = var83.SecurityTripped
                if var83 then
                    var83 = Color3.fromRGB(253, 106, 97)
                    var85 = var83
                else
                    var83 = Color3.fromRGB(153, 153, 153)
                    var85 = var83
                end
                Part.Color = var85
                var83 = 1
                if tbl_upvw.SecurityTripped then
                    var83 = 2
                end
                local workspace_GetServerTimeNow_result1 = workspace:GetServerTimeNow()
                local var87 = 0.5 * v_4.Duration * v_4._speed
                if var83 ~= v_4._speed then
                    v_4._speed = var83
                    local var88 = 0.5 * v_4.Duration * v_4._speed
                    v_4._offset += (var88 - var87) * workspace_GetServerTimeNow_result1
                    var87 = var88
                end
                local var89 = GeomUtils_upvr.waveTriangle(var87 * workspace_GetServerTimeNow_result1 - v_4._offset) / 2 + 0.5
                if var89 >= 0.5 or not (2 * var89 * var89) then
                end
                Part.CFrame = v_4.StartCF:lerp(v_4.EndCF, -1 - 2 * (var89 - 2) * var89)
            end
        end)
    end
    function em_upvr.esytu38w(arg1_7) -- Line 184
        tbl_upvw = arg1_7
    end
    local CircleAction_upvr = UI_upvr.CircleAction
    local function Action(arg1_8, arg2) -- Line 190
        if arg2 then
            PlaySound_upvr(LocalPlayer_upvr, 1843025542)
            Event_upvr:FireServer('o'.."twikn9zb5q":sub(5, 9):reverse():reverse():reverse().."".."d6", arg1_8.Part)
            return true
        end
    end
    local function PreUpdateFun(arg1_9) -- Line 197
        local var91
        if arg1_9.Part.Parent.Arm.Transparency >= 0.5 then
            var91 = false
        else
            var91 = true
        end
        arg1_9.Enabled = var91
    end
    local function AddedFun(arg1_10) -- Line 200
        local tbl = {}
        tbl.Part = arg1_10
        tbl.ValidRoot = arg1_10.Parent
        tbl.Name = "Place Dynamite"
        tbl.Timed = true
        tbl.Duration = 1
        tbl.Dist = 10
        tbl.Callback = Action
        tbl.PreUpdateFun = PreUpdateFun
        tbl.PreUpdatePeriod = 0.1
        CircleAction_upvr.Add(tbl, arg1_10)
    end
    local function RemovedFun(arg1_11) -- Line 214
        CircleAction_upvr.Remove(arg1_11)
    end
    for _, v_5 in next, CollectionService_upvr:GetTagged("Museum_DynamiteNode") do
        CircleAction_upvr.Add({
            Part = v_5;
            ValidRoot = v_5.Parent;
            Name = "Place Dynamite";
            Timed = true;
            Duration = 1;
            Dist = 10;
            Callback = Action;
            PreUpdateFun = PreUpdateFun;
            PreUpdatePeriod = 0.1;
        }, v_5)
    end
    CollectionService_upvr:GetInstanceAddedSignal("Museum_DynamiteNode"):Connect(AddedFun)
    CollectionService_upvr:GetInstanceRemovedSignal("Museum_DynamiteNode"):Connect(RemovedFun)
    local function Action_upvr(arg1_12, arg2) -- Line 225, Named "Action"
        if arg2 then
            PlaySound_upvr(LocalPlayer_upvr, 1988477690)
            PlaySound_upvr(LocalPlayer_upvr, 8473658289)
            Event_upvr:FireServer('z'.."oxclssv3":sub(2, 6):reverse():reverse():reverse().."".."e5", arg1_12.Part)
            return true
        end
    end
    local function PreUpdateFun_upvr(arg1_13) -- Line 234, Named "PreUpdateFun"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local HidePart = arg1_13.HidePart
        if not HidePart then
            HidePart = arg1_13.Part
        end
        if HidePart.Transparency >= 0.999 then
        else
        end
        arg1_13.Enabled = true
    end
    local function AddedFun(arg1_14) -- Line 242
        local var97
        local var98
        local var99 = 2
        local Name = arg1_14.Name
        if Name == "DonutNode" then
            Name = "Giant Donut"
            var97 = arg1_14.Parent.Model.Bread
        elseif Name == "SpinnerRim" then
            Name = "Spinner Rim"
        elseif Name == "DinoBone" then
            Name = "Bone"
            var99 = 1
        elseif Name == "MummyNode" then
            Name = "Mummy"
            var97 = arg1_14.Parent.Glass
            var98 = arg1_14.Parent
            var99 = 3
        elseif Name == "Picture" then
            var98 = arg1_14.Parent
        end
        local tbl_3 = {}
        tbl_3.Part = arg1_14
        tbl_3.Name = "Grab "..Name
        tbl_3.Timed = true
        tbl_3.Duration = var99
        tbl_3.Dist = 10
        tbl_3.Callback = Action_upvr
        tbl_3.PreUpdateFun = PreUpdateFun_upvr
        tbl_3.PreUpdatePeriod = 0.5
        tbl_3.HidePart = var97
        tbl_3.ValidRoot = var98
        CircleAction_upvr.Add(tbl_3, arg1_14)
    end
    local function RemovedFun(arg1_15) -- Line 277
        CircleAction_upvr.Remove(arg1_15)
    end
    for _, v_6 in next, CollectionService_upvr:GetTagged("Museum_Item") do
        AddedFun(v_6)
        local var104
    end
    CollectionService_upvr:GetInstanceAddedSignal("Museum_Item"):Connect(var104)
    CollectionService_upvr:GetInstanceRemovedSignal("Museum_Item"):Connect(RemovedFun)
    function Action_upvr(arg1_16, arg2) -- Line 290, Named "Action"
        if arg2 then
            PlaySound_upvr(LocalPlayer_upvr, 1837831244)
            Event_upvr:FireServer('q'.."b99umt0rs":sub(4, 7):reverse().."".."5ye", arg1_16.Part)
            return true
        end
    end
    local var105_upvr = Action_upvr
    function PreUpdateFun_upvr(arg1_17) -- Line 299, Named "PreUpdateFun"
        local var107
        if arg1_17.Part.Reflectance >= 0.15 then
            var107 = false
        else
            var107 = true
        end
        arg1_17.Enabled = var107
    end
    local var106_upvr = PreUpdateFun_upvr
    for _, v_7 in next, CollectionService_upvr:GetTagged("Museum_Lever") do
        CircleAction_upvr.Add({
            Part = v_7;
            Name = "Pull Lever";
            Timed = true;
            Duration = 1;
            Dist = 10;
            Callback = var105_upvr;
            PreUpdateFun = var106_upvr;
            PreUpdatePeriod = 0.5;
        }, v_7)
        local _
    end
    CollectionService_upvr:GetInstanceAddedSignal("Museum_Lever"):Connect(function(arg1_18) -- Line 304, Named "AddedFun"
        local tbl_2 = {}
        tbl_2.Part = arg1_18
        tbl_2.Name = "Pull Lever"
        tbl_2.Timed = true
        tbl_2.Duration = 1
        tbl_2.Dist = 10
        tbl_2.Callback = var105_upvr
        tbl_2.PreUpdateFun = var106_upvr
        tbl_2.PreUpdatePeriod = 0.5
        CircleAction_upvr.Add(tbl_2, arg1_18)
    end)
    CollectionService_upvr:GetInstanceRemovedSignal("Museum_Lever"):Connect(function(arg1_19) -- Line 317, Named "RemovedFun"
        CircleAction_upvr.Remove(arg1_19)
    end)
end