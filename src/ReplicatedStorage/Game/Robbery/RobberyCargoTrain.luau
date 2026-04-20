local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local var3_upvw
local function _(arg1) -- Line 11, Named "Ease_InOutQuad"
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
local function _(arg1) -- Line 14, Named "OpenRoofDoorRaw"
    if arg1.RoofDoorOpen then return end
    arg1.RoofDoorOpen = true
    local tick_result1_3_upvr = tick()
    local var6_upvw
    local function Heartbeat() -- Line 22
        local var7 = (tick() - tick_result1_3_upvr) * 0.5
        local var8
        if var8 <= var7 then
            var8 = var6_upvw:Disconnect
            var8()
            var7 = 1
        end
        local var9 = var7
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var8 = 2 * var9 * var9
            return var8
        end
        if var9 >= 0.5 or not decompInlinedCondition_2() then
            var8 = -1 - 2 * (var9 - 2) * var9
        end
        arg1.RoofDoorMotor.C1 = CFrame.new():lerp(arg1.RoofDoorOpenC1, var8)
    end
    var6_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
    arg1.RoofDoorSpec.Kill = true
    return true
end
local function _(arg1) -- Line 40, Named "OpenSideDoorRaw"
    if arg1.DoorOpen then return end
    arg1.DoorOpen = true
    local tick_result1_upvr = tick()
    local var11_upvw
    local function Heartbeat() -- Line 48
        local var12 = (tick() - tick_result1_upvr) * 0.5
        local var13
        if var13 <= var12 then
            var13 = var11_upvw:Disconnect
            var13()
            var12 = 1
        end
        local var14 = var12
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var13 = 2 * var14 * var14
            return var13
        end
        if var14 >= 0.5 or not decompInlinedCondition_3() then
            var13 = -1 - 2 * (var14 - 2) * var14
        end
        arg1.DoorMotor.C1 = CFrame.new():Lerp(arg1.DoorOpenC1, var13)
    end
    var11_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
    arg1.SideDoorSpec.Kill = true
    return true
end
local function OpenVaultDoorRaw_upvr(arg1) -- Line 64, Named "OpenVaultDoorRaw"
    if not arg1.VaultOpenC1 then return end
    if arg1.VaultOpened then return end
    if not arg1.RoofDoorOpen then return end
    arg1.VaultOpened = true
    local Root_2 = arg1.Model.Skeleton.Vault.Root
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://55224766"
    Sound.Parent = Root_2
    Sound.Volume = 0.6
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound:Play()
    game.Debris:AddItem(Sound, 5)
    local Explosion = Instance.new("Explosion")
    Explosion.Position = Root_2.Position
    Explosion.DestroyJointRadiusPercent = 0
    Explosion.BlastPressure = 5000
    Explosion.Parent = Root_2
    game.Debris:AddItem(Explosion, 5)
    wait(0.1)
    local tick_result1_2_upvr = tick()
    local var19_upvw
    local function Heartbeat() -- Line 96
        local var20 = (tick() - tick_result1_2_upvr) * 0.5
        local var21
        if var21 <= var20 then
            var21 = var19_upvw:Disconnect
            var21()
            var20 = 1
        end
        local var22 = var20
        local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var21 = 2 * var22 * var22
            return var21
        end
        if var22 >= 0.5 or not decompInlinedCondition_4() then
            var21 = -1 - 2 * (var22 - 2) * var22
        end
        arg1.VaultMotor.C1 = CFrame.new():Lerp(arg1.VaultOpenC1, var21)
    end
    var19_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
    arg1.VaultDoorSpec.Kill = true
    return true
end
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local function SetupBoxCar_upvr(arg1) -- Line 112, Named "SetupBoxCar"
    local tbl_4 = {}
    local Model = arg1.Model
    local function Action(arg1_2, arg2) -- Line 116
        if arg2 then
            local var26_upvr = arg1
            if var26_upvr.RoofDoorOpen then
            else
                var26_upvr.RoofDoorOpen = true
                local tick_result1_7_upvr = tick()
                local var28_upvw
                local function Heartbeat() -- Line 22
                    local var29 = (tick() - tick_result1_7_upvr) * 0.5
                    local var30
                    if var30 <= var29 then
                        var30 = var28_upvw:Disconnect
                        var30()
                        var29 = 1
                    end
                    local var31 = var29
                    local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var30 = 2 * var31 * var31
                        return var30
                    end
                    if var31 >= 0.5 or not decompInlinedCondition_5() then
                        var30 = -1 - 2 * (var31 - 2) * var31
                    end
                    var26_upvr.RoofDoorMotor.C1 = CFrame.new():lerp(var26_upvr.RoofDoorOpenC1, var30)
                end
                var28_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
                var26_upvr.RoofDoorSpec.Kill = true
            end
            if not true then
                var26_upvr = false
                return var26_upvr
            end
            var26_upvr = var3_upvw:FireServer
            var26_upvr('f'.."yd1k":sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."".."hqjndmo9v":sub(5, 6):reverse().."".."jon5", arg1.SystemId, arg1.Id)
        end
        return true
    end
    local RoofDoorClosed = Model.Skeleton.RoofDoorClosed
    local tbl_2 = {
        Part = RoofDoorClosed;
        Name = "Open Door";
        ValidRoot = arg1.Model;
        Timed = true;
        NoRay = true;
        Duration = 2;
        Dist = 10;
        Callback = Action;
    }
    CircleAction_upvr.Add(tbl_2, RoofDoorClosed)
    arg1.RoofDoorSpec = tbl_2
    table.insert(tbl_4, tbl_2)
    local function Action(arg1_3, arg2) -- Line 142
        if arg2 then
            local var34_upvr = arg1
            if var34_upvr.DoorOpen then
            else
                var34_upvr.DoorOpen = true
                local tick_result1_upvr_2 = tick()
                local var36_upvw
                local function Heartbeat() -- Line 48
                    local var37 = (tick() - tick_result1_upvr_2) * 0.5
                    local var38
                    if var38 <= var37 then
                        var38 = var36_upvw:Disconnect
                        var38()
                        var37 = 1
                    end
                    local var39 = var37
                    local function decompInlinedCondition_6() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var38 = 2 * var39 * var39
                        return var38
                    end
                    if var39 >= 0.5 or not decompInlinedCondition_6() then
                        var38 = -1 - 2 * (var39 - 2) * var39
                    end
                    var34_upvr.DoorMotor.C1 = CFrame.new():Lerp(var34_upvr.DoorOpenC1, var38)
                end
                var36_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
                var34_upvr.SideDoorSpec.Kill = true
            end
            if not true then
                var34_upvr = false
                return var34_upvr
            end
            var34_upvr = var3_upvw:FireServer
            var34_upvr('h'.."".."duk5qava3":sub(2, 5):reverse():reverse():reverse().."".."a19", arg1.SystemId, arg1.Id)
        end
        return true
    end
    local LeftDoorClosed = Model.Skeleton.LeftDoorClosed
    local tbl = {
        Part = LeftDoorClosed;
        Name = "Open Door";
        ValidRoot = arg1.Model;
        Timed = true;
        NoRay = true;
        Duration = 2;
        Dist = 10;
        Callback = Action;
    }
    CircleAction_upvr.Add(tbl, LeftDoorClosed)
    arg1.SideDoorSpec = tbl
    table.insert(tbl_4, tbl)
    local Root = Model.Skeleton.Vault.Root
    local tbl_3 = {
        Part = Root;
        Name = "Breach Vault";
        Timed = true;
        NoRay = true;
        Duration = 3;
        Dist = 20;
        Callback = function(arg1_4, arg2) -- Line 168, Named "Action"
            if arg2 then
                if not OpenVaultDoorRaw_upvr(arg1) then
                    return false
                end
                var3_upvw:FireServer('r'.."terddiw":sub(2, 5):reverse():reverse():reverse():reverse():reverse().."".."".."qt8kugw":sub(3, 4):reverse()..""..'g', arg1.SystemId, arg1.Id)
            end
            return true
        end;
    }
    CircleAction_upvr.Add(tbl_3, Root)
    arg1.VaultDoorSpec = tbl_3
    table.insert(tbl_4, tbl_3)
    arg1.CircleActionSpecs = tbl_4
end
local function OnCarCreated_upvr(arg1) -- Line 194, Named "OnCarCreated"
    if arg1.Name:find("BoxCar") then
        SetupBoxCar_upvr(arg1)
    end
end
local function OnCarDestroyed_upvr(arg1) -- Line 199, Named "OnCarDestroyed"
    if arg1.Name:find("BoxCar") then
        for _, v in next, arg1.CircleActionSpecs do
            if not v.Kill then
                v.Kill = true
            end
        end
    end
end
local var46_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local function OnCarEntered_upvr(arg1) -- Line 209, Named "OnCarEntered"
    if arg1.Name:find("BoxCar") then
        local var49_upvw = 0
        var46_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 213
            local tick_result1 = tick()
            if 1 < tick_result1 - var49_upvw then
                var49_upvw = tick_result1
                if arg1.VaultOpened and (arg1.Model.Model.Rob.Gold.Position - LocalPlayer_upvr.Character.Humanoid.RootPart.Position).Magnitude < 6 then
                    var3_upvw:FireServer('h'.."".."xsl8h":sub(3, 4):reverse():reverse():reverse():reverse():reverse().."".."".."kzvnzw8":sub(4, 4):reverse().."".."5p42", arg1.SystemId, arg1.Id)
                end
            end
        end)
    end
end
local function OnCarExited_upvr(arg1) -- Line 230, Named "OnCarExited"
    if arg1.Name:find("BoxCar") then
        if var46_upvw then
            var46_upvw:Disconnect()
            var46_upvw = nil
        end
        var3_upvw:FireServer('v'.."bqsiqyb8":sub(3, 4):reverse().."".."".."dhpynyp":sub(3, 5):reverse():reverse():reverse():reverse():reverse().."".."".."avffqkv":sub(4, 4):reverse():reverse():reverse():reverse():reverse()..""..'q', arg1.SystemId, arg1.Id)
    end
end
local var52_upvw
local TrainSystem_upvr = require(ReplicatedStorage.Game.TrainSystem)
return {
    Init = function(arg1) -- Line 240, Named "Init"
        var3_upvw = arg1.Event
        var52_upvw = arg1.em
        TrainSystem_upvr.Signals.OnCarCreated:Connect(OnCarCreated_upvr)
        TrainSystem_upvr.Signals.OnCarDestroyed:Connect(OnCarDestroyed_upvr)
        TrainSystem_upvr.Signals.OnCarEntered:Connect(OnCarEntered_upvr)
        TrainSystem_upvr.Signals.OnCarExited:Connect(OnCarExited_upvr)
        function var52_upvw.f1mdjon5(arg1_5, arg2) -- Line 248
            local any_GetSystemById_result1_3 = TrainSystem_upvr.GetSystemById(arg1_5)
            local any_GetCarById_result1_upvr_2 = TrainSystem_upvr.GetCarById(any_GetSystemById_result1_3, arg2)
            if not any_GetSystemById_result1_3 or not any_GetCarById_result1_upvr_2 then
                return nil
            end
            if any_GetCarById_result1_upvr_2.RoofDoorOpen then
            else
                any_GetCarById_result1_upvr_2.RoofDoorOpen = true
                local tick_result1_6_upvr = tick()
                local var57_upvw
                local function Heartbeat() -- Line 22
                    local var58 = (tick() - tick_result1_6_upvr) * 0.5
                    local var59
                    if var59 <= var58 then
                        var59 = var57_upvw:Disconnect
                        var59()
                        var58 = 1
                    end
                    local var60 = var58
                    local function decompInlinedCondition_7() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var59 = 2 * var60 * var60
                        return var59
                    end
                    if var60 >= 0.5 or not decompInlinedCondition_7() then
                        var59 = -1 - 2 * (var60 - 2) * var60
                    end
                    any_GetCarById_result1_upvr_2.RoofDoorMotor.C1 = CFrame.new():lerp(any_GetCarById_result1_upvr_2.RoofDoorOpenC1, var59)
                end
                var57_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
                any_GetCarById_result1_upvr_2.RoofDoorSpec.Kill = true
            end
            tick_result1_6_upvr = true
            return tick_result1_6_upvr
        end
        function var52_upvw.hq5kua19(arg1_6, arg2) -- Line 257
            local any_GetSystemById_result1_2 = TrainSystem_upvr.GetSystemById(arg1_6)
            local any_GetCarById_result1_upvr = TrainSystem_upvr.GetCarById(any_GetSystemById_result1_2, arg2)
            if not any_GetSystemById_result1_2 or not any_GetCarById_result1_upvr then
                return nil
            end
            if any_GetCarById_result1_upvr.DoorOpen then
            else
                any_GetCarById_result1_upvr.DoorOpen = true
                local tick_result1_4_upvr = tick()
                local var64_upvw
                var64_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 48, Named "Heartbeat"
                    local var65 = (tick() - tick_result1_4_upvr) * 0.5
                    local var66
                    if var66 <= var65 then
                        var66 = var64_upvw:Disconnect
                        var66()
                        var65 = 1
                    end
                    local var67 = var65
                    local function decompInlinedCondition_8() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var66 = 2 * var67 * var67
                        return var66
                    end
                    if var67 >= 0.5 or not decompInlinedCondition_8() then
                        var66 = -1 - 2 * (var67 - 2) * var67
                    end
                    any_GetCarById_result1_upvr.DoorMotor.C1 = CFrame.new():Lerp(any_GetCarById_result1_upvr.DoorOpenC1, var66)
                end)
                any_GetCarById_result1_upvr.SideDoorSpec.Kill = true
            end
            tick_result1_4_upvr = true
            return tick_result1_4_upvr
        end
        function var52_upvw.rddrek8g(arg1_7, arg2) -- Line 266
            local any_GetSystemById_result1 = TrainSystem_upvr.GetSystemById(arg1_7)
            local any_GetCarById_result1 = TrainSystem_upvr.GetCarById(any_GetSystemById_result1, arg2)
            if not any_GetSystemById_result1 or not any_GetCarById_result1 then
                return nil
            end
            if not OpenVaultDoorRaw_upvr(any_GetCarById_result1) then
                return nil
            end
            OpenVaultDoorRaw_upvr(any_GetCarById_result1)
            return true
        end
    end;
}