local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local AlexRagdoll_upvr = require(ReplicatedStorage_upvr.Module.AlexRagdoll)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Signal = require(ReplicatedStorage_upvr.Std.Signal)
local Paraglide_upvr = require(ReplicatedStorage_upvr.Game.Paraglide)
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local var9_upvw
local ControllerImage_upvr = require(ReplicatedStorage_upvr.ControllerImage)
local TagUtils_upvr = require(ReplicatedStorage_upvr.Tag.TagUtils)
local var12_upvw
local var13_upvw
local function _() -- Line 34, Named "GuiUpdateInput"
    if UserInputService_upvr.GamepadEnabled then
        var13_upvw.Button.Gamepad.Image = ControllerImage_upvr.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
        var13_upvw.Button.Gamepad.Visible = true
    else
        var13_upvw.Button.Gamepad.Visible = false
    end
end
local function _() -- Line 42, Named "GuiPromptSkydive"
    var13_upvw.Enabled = true
    var13_upvw.Button.Image = ("rbxassetid://%d"):format(4915090302)
    if UserInputService_upvr.GamepadEnabled then
        var13_upvw.Button.Gamepad.Image = ControllerImage_upvr.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
        var13_upvw.Button.Gamepad.Visible = true
    else
        var13_upvw.Button.Gamepad.Visible = false
    end
end
local function _() -- Line 47, Named "GuiPromptParachute"
    var13_upvw.Enabled = true
    var13_upvw.Button.Image = ("rbxassetid://%d"):format(4915089706)
    if UserInputService_upvr.GamepadEnabled then
        var13_upvw.Button.Gamepad.Image = ControllerImage_upvr.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
        var13_upvw.Button.Gamepad.Visible = true
    else
        var13_upvw.Button.Gamepad.Visible = false
    end
end
local function _() -- Line 52, Named "GuiPromptNone"
    var13_upvw.Enabled = false
end
local function _() -- Line 56, Named "GetHumanoid"
    local Character_9 = LocalPlayer_upvr.Character
    if Character_9 == nil then
        return nil
    end
    return Character_9:FindFirstChild("Humanoid")
end
local function _() -- Line 64, Named "getRootPart"
    local Character_10 = LocalPlayer_upvr.Character
    if not Character_10 then return end
    return Character_10.PrimaryPart
end
local function GetMass_upvr(arg1) -- Line 78, Named "GetMass"
    assert(arg1)
    local var22 = 0
    for _, v in next, arg1:GetChildren() do
        if v:IsA("BasePart") then
            var22 += v:GetMass()
        end
        var22 += GetMass_upvr(v)
    end
    return var22
end
local any_new_result1_upvr = Signal.new()
local any_new_result1_upvr_3 = Signal.new()
local any_new_result1_upvr_2 = Signal.new()
local var26_upvw = false
local var27_upvw = false
local var28_upvw = 0
local var29_upvw = false
local var30_upvw = false
local var31_upvw
local var32_upvw
local var33_upvw
local var34_upvw = 0
local var35_upvw = 0
local var36_upvw = 0
local var37_upvw
local var38_upvw
local var39_upvw
local CharacterAnim_upvr = require(ReplicatedStorage_upvr.Game.CharacterAnim)
local CharacterUtils_upvr = require(ReplicatedStorage_upvr.Std.CharacterUtils)
local HapticEffect_upvr = require(ReplicatedStorage_upvr.App.HapticEffect)
local function StartSkydiving_upvr() -- Line 124, Named "StartSkydiving"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var43
    if var29_upvw ~= false then
        var43 = false
    else
        var43 = true
    end
    assert(var43)
    var43 = LocalPlayer_upvr
    var43 = var43.Character
    if var43 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local Humanoid = var43:FindFirstChild("Humanoid")
    if Humanoid == nil then
        var43 = false
        return var43
    end
    var43 = true
    var29_upvw = var43
    var43 = var31_upvw
    if var43 then
        var31_upvw:Stop()
        var43 = nil
        var31_upvw = var43
    end
    var43 = CharacterAnim_upvr
    var43 = var43.getSkydiveTrack()
    var31_upvw = var43
    var31_upvw:Play(0.3)
    var43 = GetMass_upvr(Humanoid.Parent)
    var33_upvw = var43
    var43 = Instance.new("VectorForce")
    var32_upvw = var43
    var43 = var32_upvw
    var43.Force = Vector3.new(0, 0, 0)
    var43 = var32_upvw
    var43.Attachment0 = CharacterUtils_upvr.getRootAttachment(Humanoid.RootPart)
    var43 = var32_upvw
    var43.Parent = Humanoid.RootPart
    var43 = var13_upvw
    var43.Enabled = true
    var43 = var13_upvw
    var43 = var43.Button
    var43.Image = ("rbxassetid://%d"):format(4915089706)
    var43 = UserInputService_upvr
    var43 = var43.GamepadEnabled
    if var43 then
        var43 = var13_upvw
        var43 = var43.Button
        var43 = var43.Gamepad
        var43.Image = ControllerImage_upvr.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
        var43 = var13_upvw
        var43 = var43.Button
        var43 = var43.Gamepad
        var43.Visible = true
    else
        var43 = var13_upvw
        var43 = var43.Button
        var43 = var43.Gamepad
        var43.Visible = false
    end
    var43 = var37_upvw
    if var43 ~= nil then
        var37_upvw:Stop()
        var37_upvw:Destroy()
        var43 = nil
        var37_upvw = var43
    end
    var43 = Audio_upvr
    var43 = var43.ObjectLocal
    var43 = var43(LocalPlayer_upvr.PlayerGui, 9058653424, {
        Volume = 0;
        Looped = true;
    })
    var37_upvw = var43
    var43 = var38_upvw
    if var43 then
        var38_upvw:Disconnect()
        var43 = nil
        var38_upvw = var43
    end
    var43 = Audio_upvr
    var43 = var43.FadeTo(var37_upvw, 0.4, 4)
    var38_upvw = var43
    var43 = var39_upvw
    if var43 then
        var39_upvw:Destroy()
    end
    var43 = HapticEffect_upvr
    var43 = var43.basic(0.15, math.huge)
    var39_upvw = var43
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function StopSkydiving_upvr() -- Line 163, Named "StopSkydiving"
    local var46
    if var29_upvw ~= true then
        var46 = false
    else
        var46 = true
    end
    assert(var46)
    var29_upvw = false
    if var31_upvw then
        var31_upvw:Stop()
        var31_upvw = nil
    end
    if var32_upvw then
        var32_upvw:Destroy()
    end
    if var37_upvw then
        local var47_upvw = var37_upvw
        var46 = nil
        var37_upvw = var46
        var46 = var38_upvw
        if var46 then
            var38_upvw:Disconnect()
            var46 = nil
            var38_upvw = var46
        end
        var46 = Audio_upvr
        var46 = var46.FadeTo(var47_upvw, 0, 0.1)
        var38_upvw = var46
        var46 = delay
        var46(1, function() -- Line 183
            var47_upvw:Destroy()
            var47_upvw = nil
        end)
    end
    if var39_upvw then
        var39_upvw:Destroy()
        var39_upvw = nil
    end
end
local InventoryItemSystem_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemSystem)
local function StartRagdolling_upvr(arg1) -- Line 193, Named "StartRagdolling"
    local var54
    if var54 == true then
        if arg1 ~= nil then
            var34_upvw = arg1
        else
            var54 = 1.2
            var34_upvw = var54
        end
        var54 = tick()
        var28_upvw = var54
        var54 = true
        return var54
    end
    local Character_5 = LocalPlayer_upvr.Character
    if Character_5 == nil then
        var54 = nil
    else
        var54 = Character_5:FindFirstChild("Humanoid")
    end
    if var54 == nil then
        return false
    end
    if var54.Sit or var54.PlatformStand then
        return false
    end
    for _, v_2 in ipairs(InventoryItemSystem_upvr.getEquippedFor(LocalPlayer_upvr)) do
        if not InventoryItemSystem_upvr.toggleEquip(v_2) then
            return false
        end
    end
    if arg1 ~= nil then
        var34_upvw = arg1
    else
        var34_upvw = 1.2
    end
    any_new_result1_upvr:Fire()
    var26_upvw = true
    var28_upvw = tick()
    AlexRagdoll_upvr.Ragdoll(var54.Parent)
    any_new_result1_upvr_3:Fire()
    var12_upvw:FireServer('h'..("uk26uhm"):sub(3, 5):reverse():reverse():reverse()..""..""..("xup2drsj"):sub(4, 6):reverse():reverse():reverse():reverse():reverse()..""..'o')
    return true
end
local function _(arg1) -- Line 233, Named "StartFalling"
    local var59
    if var30_upvw ~= false then
        var59 = false
    else
        var59 = true
    end
    assert(var59)
    var35_upvw = arg1
    var30_upvw = true
end
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local function StopFalling_upvr(arg1) -- Line 238, Named "StopFalling"
    local var69
    if var30_upvw ~= true then
        var69 = false
    else
        var69 = true
    end
    assert(var69)
    var30_upvw = false
    if var29_upvw == true then
        StopSkydiving_upvr()
    end
    var69 = false
    var13_upvw.Enabled = var69
    if arg1 then
        var69 = var35_upvw
        local var70 = var69 - arg1
        var69 = 32
        if var69 < var70 then
            var69 = var26_upvw
            if var69 == false then
                local Character_11 = LocalPlayer_upvr.Character
                if not Character_11 then
                    var69 = nil
                else
                    var69 = Character_11.PrimaryPart
                end
                if var69 and not TagUtils_upvr.isPointInTag(var69.Position, "NoRagdoll") then
                    StartRagdolling_upvr()
                end
            end
        end
        if 24 < var70 then
            if not RunUtils_upvr.isTradeWorld() then
                local Character_8 = LocalPlayer_upvr.Character
                if not Character_8 then
                else
                end
                if Character_8.PrimaryPart then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    if not TagUtils_upvr.isPointInTag(Character_8.PrimaryPart.Position, "NoFallDamage") then
                        var12_upvw:FireServer('r'..("iku3p88miu"):sub(4, 7):reverse():reverse():reverse()..""..""..("ek9bnb95"):sub(4, 4):reverse():reverse():reverse():reverse():reverse().."".."hq", var70)
                    end
                end
            end
        end
    end
    var36_upvw = 0
end
local function _() -- Line 270, Named "StartParachuting"
    local var73
    if Paraglide_upvr.IsFlying() ~= false then
        var73 = false
    else
        var73 = true
    end
    assert(var73)
    if var30_upvw == true then
        StopFalling_upvr()
    end
    Paraglide_upvr.Parachute()
    var73 = true
    var13_upvw.Enabled = var73
    var73 = ("rbxassetid://%d"):format(4915090302)
    var13_upvw.Button.Image = var73
    if UserInputService_upvr.GamepadEnabled then
        var73 = ControllerImage_upvr
        var73 = var73.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
        var13_upvw.Button.Gamepad.Image = var73
        var73 = true
        var13_upvw.Button.Gamepad.Visible = var73
    else
        var73 = false
        var13_upvw.Button.Gamepad.Visible = var73
    end
end
local function _() -- Line 279, Named "StopParachuting"
    local var74
    if Paraglide_upvr.IsFlying() ~= true then
        var74 = false
    else
        var74 = true
    end
    assert(var74)
    Paraglide_upvr.ParachuteStop()
end
local tbl_upvr = {}
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Exclude
local var77_upvw
local Raycast_upvr = require(ReplicatedStorage_upvr.Std.Raycast)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local var80_upvw
local function Heartbeat_upvr() -- Line 291, Named "Heartbeat"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var81
    if var81 ~= nil then
        var81 = var77_upvw
    else
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    var77_upvw = tick()
    local Character_3 = LocalPlayer_upvr.Character
    if Character_3 == nil then
        var81 = nil
    else
        var81 = Character_3:FindFirstChild("Humanoid")
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if var30_upvw == true then
        StopFalling_upvr()
    end
    if var80_upvw ~= nil then
        var80_upvw = nil
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function _() -- Line 417, Named "AttemptUseParachute"
    local var83
    if Paraglide_upvr.IsFlying() == true then
        if Paraglide_upvr.IsFlying() ~= true then
            var83 = false
        else
            var83 = true
        end
        assert(var83)
        Paraglide_upvr.ParachuteStop()
    end
    if var29_upvw and Paraglide_upvr.IsFlying() == false then
        if Paraglide_upvr.IsFlying() ~= false then
            var83 = false
        else
            var83 = true
        end
        assert(var83)
        if var30_upvw == true then
            StopFalling_upvr()
        end
        Paraglide_upvr.Parachute()
        var83 = true
        var13_upvw.Enabled = var83
        var83 = ("rbxassetid://%d"):format(4915090302)
        var13_upvw.Button.Image = var83
        if UserInputService_upvr.GamepadEnabled then
            var83 = ControllerImage_upvr
            var83 = var83.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
            var13_upvw.Button.Gamepad.Image = var83
            var83 = true
            var13_upvw.Button.Gamepad.Visible = var83
            return
        end
        var83 = false
        var13_upvw.Button.Gamepad.Visible = var83
    end
end
local var84_upvw
local DefaultActions_upvr = require(ReplicatedStorage_upvr.Game.DefaultActions)
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local RunService_upvr = game:GetService("RunService")
local CollectionService_upvr = game:GetService("CollectionService")
local C4Consts_upvr = require(ReplicatedStorage_upvr.Game.C4.C4Consts)
return {
    Init = function(arg1) -- Line 428, Named "Init"
        var12_upvw = arg1.Event
        var84_upvw = arg1.em
        var13_upvw = ReplicatedStorage_upvr.StarterGui:FindFirstChild("FallingGui")
        var13_upvw.Parent = LocalPlayer_upvr.PlayerGui
        var9_upvw = require(ReplicatedStorage_upvr.Game.JetPack.JetPack)
        function var84_upvw.hilf3hub(arg1_2) -- Line 436
            if arg1_2 then
                local Character_4 = LocalPlayer_upvr.Character
                if Character_4 == nil then
                    local _
                else
                end
                if Character_4:FindFirstChild("Humanoid") then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    if 0 < Character_4:FindFirstChild("Humanoid").Health then
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        AlexRagdoll_upvr.Unragdoll(Character_4:FindFirstChild("Humanoid").Parent)
                        any_new_result1_upvr_2:Fire()
                    end
                end
            end
            var26_upvw = false
            var27_upvw = false
        end
        DefaultActions_upvr.onJumpPressed:Connect(function() -- Line 449
            local var95
            if Paraglide_upvr.IsFlying() == true then
                if Paraglide_upvr.IsFlying() ~= true then
                    var95 = false
                else
                    var95 = true
                end
                assert(var95)
                Paraglide_upvr.ParachuteStop()
            end
            if var29_upvw and Paraglide_upvr.IsFlying() == false then
                if Paraglide_upvr.IsFlying() ~= false then
                    var95 = false
                else
                    var95 = true
                end
                assert(var95)
                if var30_upvw == true then
                    StopFalling_upvr()
                end
                Paraglide_upvr.Parachute()
                var95 = true
                var13_upvw.Enabled = var95
                var95 = ("rbxassetid://%d"):format(4915090302)
                var13_upvw.Button.Image = var95
                if UserInputService_upvr.GamepadEnabled then
                    var95 = ControllerImage_upvr
                    var95 = var95.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
                    var13_upvw.Button.Gamepad.Image = var95
                    var95 = true
                    var13_upvw.Button.Gamepad.Visible = var95
                    return
                end
                var95 = false
                var13_upvw.Button.Gamepad.Visible = var95
            end
        end)
        var13_upvw.Button.MouseButton1Down:Connect(function() -- Line 452
            local var97
            if Paraglide_upvr.IsFlying() == true then
                if Paraglide_upvr.IsFlying() ~= true then
                    var97 = false
                else
                    var97 = true
                end
                assert(var97)
                Paraglide_upvr.ParachuteStop()
            end
            if var29_upvw and Paraglide_upvr.IsFlying() == false then
                if Paraglide_upvr.IsFlying() ~= false then
                    var97 = false
                else
                    var97 = true
                end
                assert(var97)
                if var30_upvw == true then
                    StopFalling_upvr()
                end
                Paraglide_upvr.Parachute()
                var97 = true
                var13_upvw.Enabled = var97
                var97 = ("rbxassetid://%d"):format(4915090302)
                var13_upvw.Button.Image = var97
                if UserInputService_upvr.GamepadEnabled then
                    var97 = ControllerImage_upvr
                    var97 = var97.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
                    var13_upvw.Button.Gamepad.Image = var97
                    var97 = true
                    var13_upvw.Button.Gamepad.Visible = var97
                    return
                end
                var97 = false
                var13_upvw.Button.Gamepad.Visible = var97
            end
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, "AttemptUseParachute"):andThen(function(arg1_3) -- Line 455
            arg1_3.OnClientEvent:Connect(function(arg1_4) -- Line 456
                if arg1_4 then
                    if Paraglide_upvr.IsFlying() ~= false then
                    else
                    end
                    assert(true)
                    if var30_upvw == true then
                        StopFalling_upvr()
                    end
                    Paraglide_upvr.Parachute()
                    var13_upvw.Enabled = true
                    var13_upvw.Button.Image = ("rbxassetid://%d"):format(4915090302)
                    if UserInputService_upvr.GamepadEnabled then
                        var13_upvw.Button.Gamepad.Image = ControllerImage_upvr.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
                        var13_upvw.Button.Gamepad.Visible = true
                    else
                        var13_upvw.Button.Gamepad.Visible = false
                    end
                end
                local var100
                if Paraglide_upvr.IsFlying() == true then
                    if Paraglide_upvr.IsFlying() ~= true then
                        var100 = false
                    else
                        var100 = true
                    end
                    assert(var100)
                    Paraglide_upvr.ParachuteStop()
                end
                if var29_upvw and Paraglide_upvr.IsFlying() == false then
                    if Paraglide_upvr.IsFlying() ~= false then
                        var100 = false
                    else
                        var100 = true
                    end
                    assert(var100)
                    if var30_upvw == true then
                        StopFalling_upvr()
                    end
                    Paraglide_upvr.Parachute()
                    var100 = true
                    var13_upvw.Enabled = var100
                    var100 = ("rbxassetid://%d"):format(4915090302)
                    var13_upvw.Button.Image = var100
                    if UserInputService_upvr.GamepadEnabled then
                        var100 = ControllerImage_upvr
                        var100 = var100.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
                        var13_upvw.Button.Gamepad.Image = var100
                        var100 = true
                        var13_upvw.Button.Gamepad.Visible = var100
                        return
                    end
                    var100 = false
                    var13_upvw.Button.Gamepad.Visible = var100
                end
            end)
        end)
        RunService_upvr.Heartbeat:Connect(function() -- Line 465
            Heartbeat_upvr()
        end)
        Paraglide_upvr.OnParachuteStopped:Connect(function() -- Line 469
            var13_upvw.Enabled = false
        end)
        Players_upvr.LocalPlayer.CharacterAdded:Connect(function(arg1_5) -- Line 473
            var26_upvw = false
            table.insert(tbl_upvr, arg1_5)
        end)
        Players_upvr.LocalPlayer.CharacterRemoving:Connect(function(arg1_6) -- Line 477
            local table_find_result1_2 = table.find(tbl_upvr, arg1_6)
            if table_find_result1_2 then
                table.remove(tbl_upvr, table_find_result1_2)
            end
        end)
        if Players_upvr.LocalPlayer.Character then
            table.insert(tbl_upvr, Players_upvr.LocalPlayer.Character)
        end
        CollectionService_upvr:GetInstanceAddedSignal(C4Consts_upvr.TAG_NAME):Connect(function(arg1_7) -- Line 487
            table.insert(tbl_upvr, arg1_7)
        end)
        CollectionService_upvr:GetInstanceRemovedSignal(C4Consts_upvr.TAG_NAME):Connect(function(arg1_8) -- Line 490
            local table_find_result1 = table.find(tbl_upvr, arg1_8)
            if table_find_result1 then
                table.remove(tbl_upvr, table_find_result1)
            end
        end)
    end;
    IsSkydiving = function() -- Line 106, Named "IsSkydiving"
        return var29_upvw
    end;
    IsRagdolling = function() -- Line 109, Named "IsRagdolling"
        return var26_upvw
    end;
    StopSkydiving = StopSkydiving_upvr;
    StartRagdolling = StartRagdolling_upvr;
    OnRagdoll = any_new_result1_upvr;
    OnRagdolled = any_new_result1_upvr_3;
    OnUnragdolled = any_new_result1_upvr_2;
}
