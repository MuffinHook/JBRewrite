local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local UserInputService_upvr = game:GetService("UserInputService")
local CollectionService_upvr = game:GetService("CollectionService")
local Time_upvr = require(ReplicatedStorage_upvr.Module.Time)
local Missile_upvr = require(ReplicatedStorage_upvr.Game.Missile)
Missile_upvr.Init()
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
local InputUtils_upvr = require(ReplicatedStorage_upvr.Std.InputUtils)
local new_upvr = CFrame.new
local Angles_upvr = CFrame.Angles
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local function GetMoveVector_upvw() -- Line 40, Named "GetMoveVector"
    return Vector3.new()
end
local ControlModule = LocalPlayer_upvr.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
    local ControlModule_2_upvw = require(ControlModule)
    function GetMoveVector_upvw() -- Line 47, Named "GetMoveVector"
        return ControlModule_2_upvw:GetMoveVector()
    end
end
local tbl_2_upvw = {0, 0, 0, 0, 0, 0}
local module_upvr = {}
local function SpinProp_upvr(arg1, arg2) -- Line 60, Named "SpinProp"
    local PropAlpha = arg1.PropAlpha
    local TopRotorMotor = arg1.TopRotorMotor
    TopRotorMotor.C1 *= Angles_upvr(0, 31.4 * arg2 * PropAlpha, 0)
    local TailRotorMotor = arg1.TailRotorMotor
    TailRotorMotor.C1 *= Angles_upvr(0, 31.4 * arg2 * PropAlpha, 0)
    if arg1._lastPropAlpha ~= PropAlpha then
        arg1._lastPropAlpha = PropAlpha
        arg1.Model.Model.TailDisc.Transparency = 1 - PropAlpha * 0.15
        arg1.Model.Model.TopDisc.Transparency = 1 - PropAlpha * 0.15
    end
end
local function _(arg1) -- Line 74, Named "FadeInProp"
    local var21_upvr
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var21_upvr = arg1.OverrideSpinPropi + 1
        return var21_upvr
    end
    if not arg1.OverrideSpinPropi or not decompInlinedCondition() then
        var21_upvr = 0
    end
    arg1.OverrideSpinPropi = var21_upvr
    local var22_upvw = 0
    local var23_upvw
    local function Heartbeat(arg1_2) -- Line 79
        var22_upvw += arg1_2 * 1 / 3
        if 1 <= var22_upvw then
            var22_upvw = 1
        end
        arg1.PropAlpha = var22_upvw
        SpinProp_upvr(arg1, arg1_2)
        if 1 <= var22_upvw then
            arg1.OverrideSpinPropi = nil
            var23_upvw:disconnect()
        end
        if arg1.OverrideSpinPropi ~= var21_upvr then
            var23_upvw:disconnect()
            return
        end
    end
    var23_upvw = RunService_upvr.Heartbeat:connect(Heartbeat)
end
local function _(arg1) -- Line 97, Named "FadeOutProp"
    local var24_upvr
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var24_upvr = arg1.OverrideSpinPropi + 1
        return var24_upvr
    end
    if not arg1.OverrideSpinPropi or not decompInlinedCondition_2() then
        var24_upvr = 0
    end
    arg1.OverrideSpinPropi = var24_upvr
    local var25_upvw = 0
    local var26_upvw
    local function Heartbeat(arg1_3) -- Line 102
        var25_upvw += arg1_3 * 1 / 1
        if 1 <= var25_upvw then
            var25_upvw = 1
        end
        arg1.PropAlpha = 1 - var25_upvw
        SpinProp_upvr(arg1, arg1_3)
        if 1 <= var25_upvw then
            arg1.OverrideSpinPropi = nil
            var26_upvw:disconnect()
        end
        if arg1.OverrideSpinPropi ~= var24_upvr then
            var26_upvw:disconnect()
            return
        end
    end
    var26_upvw = RunService_upvr.Heartbeat:connect(Heartbeat)
end
local function _(arg1) -- Line 121, Named "FadeOutSpringSpin"
    local var27_upvr = (arg1.OverrideSpringFadePropi or 0) + 1
    arg1.OverrideSpringFadePropi = var27_upvr
    local var28_upvw = 0
    local var29_upvw
    local function Heartbeat(arg1_4) -- Line 126
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var28_upvw += arg1_4 * 1 / 1
        if 1 <= var28_upvw then
            var28_upvw = 1
        end
        local var30 = 1 - var28_upvw
        if arg1.IsUFO then
            module_upvr.SpinUFO(arg1, arg1_4, var30)
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1.IsDrone then
            module_upvr.SpinDrone(arg1, arg1_4, var30)
        elseif arg1.IsCrewCapsule then
            module_upvr.SpinCrewCapsule(arg1, arg1_4, var30)
        end
        if 1 <= var28_upvw then
            arg1.OverrideSpringFadePropi = nil
            var29_upvw:disconnect()
        end
        if arg1.OverrideSpringFadePropi ~= var27_upvr then
            var29_upvw:disconnect()
        else
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
    end
    var29_upvw = RunService_upvr.Heartbeat:connect(Heartbeat)
end
local function SetBladeEffectsVisible_upvr(arg1, arg2) -- Line 151, Named "SetBladeEffectsVisible"
    local Effects = arg1.Model:FindFirstChild("Effects")
    if not Effects then
        Effects = arg1.Model:FindFirstChild("Vents")
    end
    if Effects then
        for _, v in ipairs(Effects:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("Attachment") then
                v.Smoke.Enabled = arg2
            end
        end
    end
end
module_upvr.SpinProp = SpinProp_upvr
function module_upvr.SpinUFO(arg1, arg2, arg3) -- Line 163
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var39
    if arg3 == nil then
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var39 = arg1.SpringSpinAlpha:Update()
            return var39
        end
        if not arg1.SpringSpinAlpha or not decompInlinedCondition_3() then
            var39 = 1
        end
    end
    arg1.MotorUFOBody.C1 = arg1.MotorUFOBody.C1 * CFrame.Angles(0, arg2 * 2 * var39, 0)
end
function module_upvr.SpinCrewCapsule(arg1, arg2, arg3) -- Line 170
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var40
    if arg3 == nil then
        local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var40 = arg1.SpringSpinAlpha:Update()
            return var40
        end
        if not arg1.SpringSpinAlpha or not decompInlinedCondition_4() then
            var40 = 1
        end
    end
    arg1.MotorBody.C1 = arg1.MotorBody.C1 * CFrame.Angles(0, arg2 * 2 * var40, 0)
end
function module_upvr.SpinDrone(arg1, arg2, arg3) -- Line 177
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var49
    if arg3 == nil then
        local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var49 = arg1.SpringSpinAlpha:Update()
            return var49
        end
        if not arg1.SpringSpinAlpha or not decompInlinedCondition_5() then
            var49 = 1
        end
    end
    for _, v_2 in ipairs(arg1.ListBladeMotor) do
        v_2.C1 = v_2.C1 * v_2.C0:Inverse() * CFrame.Angles(0, arg2 * 20 * var49, 0) * v_2.C0
    end
end
local function _() -- Line 187, Named "GetMouseLocation"
    if InputUtils_upvr.isTouch() then
        local ViewportSize = CurrentCamera_upvr.ViewportSize
        return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
    end
    return UserInputService_upvr:GetMouseLocation()
end
local function _(arg1, arg2) -- Line 199, Named "projectCircleToSquare"
    local var54 = arg1 * arg1 + arg2 * arg2
    local squareroot_2 = math.sqrt(var54)
    if squareroot_2 <= 0.001 then
        var54 = 0
    else
        var54 = arg1 / math.max(math.abs(arg1), math.abs(arg2)) * squareroot_2
    end
    if squareroot_2 <= 0.001 then
        return var54, 0
    end
    return var54, arg2 / math.max(math.abs(arg1), math.abs(arg2)) * squareroot_2
end
local abs_upvr = math.abs
local TableUtils_upvr = require(ReplicatedStorage_upvr.Std.TableUtils)
local C4Consts_upvr = require(ReplicatedStorage_upvr.Game.C4.C4Consts)
local Raycast_upvr = require(ReplicatedStorage_upvr.Std.Raycast)
local new_upvr_2 = Vector3.new
function module_upvr.Update(arg1, arg2) -- Line 212
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local tick_result1_3 = tick()
    local var126
    if InputUtils_upvr.isTouch() then
        local GetMoveVector_result1_2 = GetMoveVector_upvw()
        local var128 = 0
        local var129 = 0
        local var130
        if 0.001 < GetMoveVector_result1_2.Magnitude then
            local Unit_2 = GetMoveVector_result1_2.Unit
            local X = Unit_2.X
            local Z_2 = Unit_2.Z
            var130 = X * X
            local var134 = var130 + Z_2 * Z_2
            local squareroot_3 = math.sqrt(var134)
            var130 = 0.001
            if squareroot_3 <= var130 then
                var134 = 0
            else
                var130 = X / math.max(math.abs(X), math.abs(Z_2))
                var134 = var130 * squareroot_3
            end
            if squareroot_3 <= 0.001 then
                var130 = 0
            else
                var130 = Z_2 / math.max(math.abs(X), math.abs(Z_2)) * squareroot_3
            end
            var128 = var134
            var129 = var130
        end
        var126 = -var128 * abs_upvr(var128)
    end
    if arg1.LockMovement then
        var126 = 0
    end
    if arg1.IsFalling then
        var126 *= 0.1
        local var136 = 0 * 0.1
    end
    if arg1.IsHeli then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    if arg1.IsLittleBird then
    elseif arg1.IsEscapeBot then
    elseif arg1.IsBlackHawk then
    elseif arg1.IsUFO then
    elseif arg1.IsDrone then
    elseif arg1.IsBlade or arg1.IsLia then
    elseif arg1.IsBionic then
    elseif arg1.IsCrewCapsule then
    elseif arg1.IsCelsior then
    end
    local var137
    if arg1.SpeedMult then
    end
    if arg1.ForwardMult then
        local var138 = 0.01 * arg1.ForwardMult
    end
    if arg1.UpMult then
    end
    if arg1.IsBionic and 0 * 0.1 == 0 and os.clock() - arg1._enteredAt < 0.2 then
    end
    local Model = arg1.Model
    local Engine = Model.Engine
    local Gyro = arg1.Gyro
    local Rotate_2 = arg1.Rotate
    var130 = Engine.Position
    var130 = var130.Y
    if arg1.MaxHeight >= var130 then
    else
    end
    var130 = arg1.IsBlade
    local function decompInlinedCondition_12() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var130 = arg1.IsLia
        return var130
    end
    local function decompInlinedCondition_13() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var130 = arg1.IsDrone
        return var130
    end
    local function decompInlinedCondition_14() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var130 = arg1.IsCrewCapsule
        return var130
    end
    local function decompInlinedCondition_15() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var130 = arg1.IsCelsior
        return var130
    end
    local function decompInlinedCondition_16() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var130 = arg1.IsBionic
        return var130
    end
    if var130 or decompInlinedCondition_12() or decompInlinedCondition_13() or decompInlinedCondition_14() or decompInlinedCondition_15() or decompInlinedCondition_16() then
        local Body = Model.Model:FindFirstChild("Body")
        if not Body or not Body:FindFirstChild("Ground") then
            local var145
        end
        if not arg1._bladeRaycastParams then
            arg1._bladeRaycastParams = RaycastParams.new()
            arg1._bladeRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
            arg1._bladeRaycastParamsLastUpdate = 0
        end
        local os_clock_result1 = os.clock()
        if 2 < os_clock_result1 - arg1._bladeRaycastParamsLastUpdate then
            arg1._bladeRaycastParamsLastUpdate = os_clock_result1
            local tbl_4 = {workspace.Vehicles}
            TableUtils_upvr.concatInPlace(tbl_4, CollectionService_upvr:GetTagged(C4Consts_upvr.TAG_NAME))
            arg1._bladeRaycastParams.FilterDescendantsInstances = tbl_4
        end
        local Position = Engine.Position
        var137 = 1000
        local any_collidable_result1 = Raycast_upvr.collidable(Position, Vector3.new(0, -1, 0), var137, arg1._bladeRaycastParams)
        if any_collidable_result1 then
            Position = any_collidable_result1.Position
        else
            var137 = Vector3.new(0, -1000, 0)
            Position = Engine.Position + var137
        end
        var137 = Engine.Position
        local Magnitude = (Position - var137).Magnitude
        if arg1.IsCrewCapsule then
            var137 = 22
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        if arg1.IsCelsior then
            var137 = 18
        else
            var137 = 40
        end
        if Magnitude < var137 then
            local _ = false
            if var145 then
                var145.WorldPosition = Position
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
        end
        if var137 - 10 < Magnitude then
            local _ = math.max(0, (var137 - Magnitude) / 10)
            if 0 < 0.6 then
            end
        end
        if true then
            if var145 and var145.Smoke.Enabled ~= false then
                var145.Smoke.Enabled = false
            end
            local const_number = -1
        elseif var145 and var145.Smoke.Enabled ~= true then
            var145.Smoke.Enabled = true
        end
    end
    if arg1.CrossHair then
        local var154
        if InputUtils_upvr.isTouch() then
            var137 = CurrentCamera_upvr.ViewportSize.X
            var137 = CurrentCamera_upvr.ViewportSize.Y * 0.375
            var154 = Vector3.new(var137 * 0.5, var137, 0)
        else
            var154 = UserInputService_upvr:GetMouseLocation()
        end
        arg1.CrossHair:Update(var154)
    end
    local RopePull_3 = Model.Preset:FindFirstChild("RopePull")
    if RopePull_3 ~= nil then
        if RopePull_3:FindFirstChild("IsHoldingObj") then
        end
    end
    if arg1.IsCelsior then
        if var136 < 0 then
            local var158 = var136 * 0.6666666666666666
        end
    end
    local vForward = arg1.vForward
    if var158 == 0 then
    else
    end
    local var160 = vForward + var158 * arg2 * 60 - vForward * var138 * arg2 * 60
    arg1.vForward = var160
    local vUp = arg1.vUp
    if const_number == 0 then
        var137 = 0.05
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    local var162 = vUp + const_number * arg2 * 60 - vUp * 0.05 * arg2 * 60
    arg1.vUp = var162
    local vHeading_2 = arg1.vHeading
    if var126 == 0 then
    else
    end
    local var164 = vHeading_2 + var126 * arg2 * 60 - vHeading_2 * 0.05 * arg2 * 60
    arg1.vHeading = var164
    if Engine.Velocity.Magnitude < 4 then
        local var165 = var160 * var138 + math.sin(tick_result1_3 * 1.6) * 0.005
        local var166 = var164 * 0.05 + math.cos(tick_result1_3 * 1.3) * 0.01
    end
    local BoundsDisabled = arg1.BoundsDisabled
    if not BoundsDisabled then
        if (Engine.Position - arg1.MapCenter).Magnitude > arg1.BoundRadius then
            BoundsDisabled = false
        else
            BoundsDisabled = true
        end
    end
    local var168
    var168 = 0
    local unit = new_upvr_2(Engine.CFrame.lookVector.X, var168, Engine.CFrame.lookVector.Z).unit
    var168 = unit * 155 * arg1.SpeedMult * 0.65
    var168 = (Vector3.new(0, 1, 0)) * (45 * arg1.UpMult) * (var162 * 0.05 + math.cos(tick_result1_3 * 2.3) * 0.02)
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if true and 0 < var168.Y then
        var168 = Vector3.new(0, 0, 0)
    end
    if arg1.IsFalling then
        var168 = Vector3.new(0, -5, 0)
        if arg1.DisableDuration < Time_upvr.GetNowSync() - arg1.FellAt then
            module_upvr.FallOutOfSkyEnd(arg1)
        end
    end
    local var170 = var168 * var165 + var168
    if not BoundsDisabled then
        var170 *= 0.1
    end
    arg1.Velocity.Velocity = var170
    if arg1.IsHeli or arg1.IsBlackHawk or arg1.IsLittleBird or arg1.IsEscapeBot then
        Rotate_2.AngularVelocity = Engine.CFrame:vectorToWorldSpace(new_upvr_2(0, var166 * 1.5, 0))
        Gyro.CFrame = new_upvr(Vector3.new(0, 0, 0), unit) * Angles_upvr(-var165 * 0.24, 0, var166 * 0.4)
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    if arg1.IsUFO then
        Rotate_2.AngularVelocity = Engine.CFrame:vectorToWorldSpace(new_upvr_2(0, var166 * 3, 0))
        Gyro.CFrame = new_upvr(Vector3.new(0, 0, 0), unit) * Angles_upvr(-var165 * 0.24, 0, var166 * 0.2)
    elseif arg1.IsBlade or arg1.IsLia or arg1.IsDrone or arg1.IsCrewCapsule or arg1.IsBionic then
        Rotate_2.AngularVelocity = Engine.CFrame:vectorToWorldSpace(new_upvr_2(0, var166 * 1.5, 0))
        Gyro.CFrame = new_upvr(Vector3.new(0, 0, 0), unit) * Angles_upvr(-var165 * 0.1, 0, var166 * 0.4)
    elseif arg1.IsCelsior then
        Rotate_2.AngularVelocity = Engine.CFrame:vectorToWorldSpace(new_upvr_2(0, var166 * 2, 0))
        Gyro.CFrame = new_upvr(Vector3.new(0, 0, 0), unit) * Angles_upvr(-var165 * 0.15, 0, var166 * 0.5)
    end
    if arg1.IsHeli or arg1.IsBlackHawk or arg1.IsLittleBird or not arg1.OverrideSpinPropi then
        SpinProp_upvr(arg1, arg2)
    end
    if arg1.IsDrone then
        module_upvr.SpinDrone(arg1, arg2)
    end
    if arg1.IsUFO then
        module_upvr.SpinUFO(arg1, arg2)
    end
    if arg1.IsCrewCapsule then
        module_upvr.SpinCrewCapsule(arg1, arg2)
    end
    if RopePull_3 then
        local Winch = Model.Winch
        RopePull_3.VectorForce.Force = -RopePull_3.Velocity * 15 + (Winch.Attachment.WorldPosition + Vector3.new(0, -Winch.RopeConstraint.Length, 0) - RopePull_3.Attachment.WorldPosition) * 50
    end
    if arg1.IsBlade or arg1.IsLia or arg1.IsDrone or arg1.IsCrewCapsule or arg1.IsCelsior or arg1.IsEscapeBot or arg1.IsBionic then
        local var172 = Engine.Velocity.Magnitude / 155 * arg1.SpeedMult * 0.65
        local var173 = (1 - var172) * 0.8 + var172 * 1.2
        if 0.001 < math.abs(arg1.RotorSound.PlaybackSpeed - var173) then
            arg1.RotorSound.PlaybackSpeed = var173
        end
        if arg1.BionicBendBeams then
            local var174 = 2 + var172 * 13
            if 0.01 < math.abs((arg1._lastBionicTextureSpeed or 0) - var174) then
                arg1._lastBionicTextureSpeed = var174
                for _, v_3 in arg1.BionicBendBeams do
                    v_3.TextureSpeed = var174
                    local _
                end
            end
        end
    end
    if var158 >= 0.000001 then
        local _ = false
        -- KONSTANTWARNING: Skipped task `defvar` above
    else
    end
    if arg1._flagBrakelightsEnabled ~= true then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1._flagBrakelightsEnabled = true
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        VehicleUtils_upvr.setBrakelightsEnabled(Model, true)
    end
end
function module_upvr.FallOutOfSkyEnd(arg1) -- Line 506
    arg1.IsFalling = nil
    arg1.FellAt = nil
    arg1.Velocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
end
function module_upvr.FallOutOfSky(arg1) -- Line 512
    print("falling out of sky now")
    arg1.FellAt = Time_upvr.GetNowSync()
    arg1.IsFalling = true
    arg1.Velocity.MaxForce = Vector3.new(1000000, 0, 1000000)
end
local tbl_3_upvr = {
    [Enum.KeyCode.W] = 1;
    [Enum.KeyCode.A] = 2;
    [Enum.KeyCode.S] = 3;
    [Enum.KeyCode.D] = 4;
    [Enum.KeyCode.Q] = 5;
    [Enum.KeyCode.E] = 6;
    [Enum.KeyCode.ButtonR2] = 6;
    [Enum.KeyCode.ButtonL2] = 5;
}
function module_upvr.InputBegan(arg1) -- Line 529
    if arg1.UserInputType == Enum.UserInputType.Keyboard then
        local KeyCode = arg1.KeyCode
        if tbl_3_upvr[KeyCode] then
            tbl_2_upvw[tbl_3_upvr[KeyCode]] = 1
        end
    end
end
function module_upvr.InputEnded(arg1) -- Line 537
    if arg1.UserInputType == Enum.UserInputType.Keyboard then
        local KeyCode_4 = arg1.KeyCode
        if tbl_3_upvr[KeyCode_4] then
            tbl_2_upvw[tbl_3_upvr[KeyCode_4]] = 0
        end
    end
end
function module_upvr.InputChanged(arg1) -- Line 545
    if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
        local KeyCode_3 = arg1.KeyCode
        local var182
        if KeyCode_3 == Enum.KeyCode.Thumbstick1 then
            local Position_4 = arg1.Position
            local X_3 = Position_4.X
            local Y = Position_4.Y
            local function decompInlinedCondition_17() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var182 = Y
                return var182
            end
            if 0.22 >= Y or not decompInlinedCondition_17() then
                var182 = 0
            end
            tbl_2_upvw[1] = var182
            local function decompInlinedCondition_18() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var182 = -Y
                return var182
            end
            if Y >= -0.22 or not decompInlinedCondition_18() then
                var182 = 0
            end
            tbl_2_upvw[3] = var182
            local function decompInlinedCondition_19() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var182 = -X_3
                return var182
            end
            if X_3 >= -0.22 or not decompInlinedCondition_19() then
                var182 = 0
            end
            tbl_2_upvw[2] = var182
            local function decompInlinedCondition_20() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var182 = X_3
                return var182
            end
            if 0.22 >= X_3 or not decompInlinedCondition_20() then
                var182 = 0
            end
            tbl_2_upvw[4] = var182
            return
        end
        if KeyCode_3 == Enum.KeyCode.ButtonR2 or KeyCode_3 == Enum.KeyCode.ButtonL2 then
            local Z = arg1.Position.Z
            var182 = tbl_3_upvr
            local function decompInlinedCondition_21() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var182 = Z ^ 0.5
                return var182
            end
            if 0.1 >= Z or not decompInlinedCondition_21() then
                var182 = 0
            end
            tbl_2_upvw[var182[KeyCode_3]] = var182
        end
    end
end
local var188_upvw
local Bomb_upvr = require(script.Bomb)
local any_new_result1_upvr = require(ReplicatedStorage_upvr.Std.Binder).new("HeliSpotlight", require(ReplicatedStorage_upvr.Game.Vehicle.Heli.Spotlight))
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
local CrossHair_upvr = require(ReplicatedStorage_upvr.Game.CrossHair)
local UI_upvr = require(ReplicatedStorage_upvr.Module.UI)
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
return function(arg1) -- Line 564
    local em_upvr = arg1.em
    var188_upvw = arg1.Event
    Bomb_upvr.Init({
        Event = var188_upvw;
    })
    any_new_result1_upvr:Start()
    function module_upvr.VehicleEnter(arg1_5) -- Line 571
        if arg1_5.CarSitTrack ~= nil then
            arg1_5.CarSitTrack:Stop()
            arg1_5.CarSitTrack:Destroy()
            arg1_5.CarSitTrack = nil
        end
        if arg1_5.Seat:FindFirstChild("SitAnim") then
            local any_LoadAnimation_result1 = LocalPlayer_upvr.Character.Humanoid:LoadAnimation(ReplicatedStorage_upvr.Resource.CarSitAnimation)
            any_LoadAnimation_result1:AdjustSpeed(0)
            any_LoadAnimation_result1:Play()
            arg1_5.CarSitTrack = any_LoadAnimation_result1
        end
        if arg1_5.Passenger then
        else
            if arg1_5.IsBlade or arg1_5.IsLia or arg1_5.IsDrone or arg1_5.IsBionic then
                SetBladeEffectsVisible_upvr(arg1_5.Model, true)
            end
            arg1_5._enteredAt = os.clock()
            arg1_5._flagBrakelightsEnabled = false
            tbl_2_upvw = {0, 0, 0, 0, 0, 0}
            arg1_5.vForward = 0
            arg1_5.vUp = 0
            arg1_5.vHeading = 0
            local var204_upvr
            if arg1_5.IsHeli or arg1_5.IsBlackHawk or arg1_5.IsLittleBird then
                arg1_5.PropAlpha = 0
                local function decompInlinedCondition_22() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var204_upvr = arg1_5.OverrideSpinPropi + 1
                    return var204_upvr
                end
                if not arg1_5.OverrideSpinPropi or not decompInlinedCondition_22() then
                    var204_upvr = 0
                end
                arg1_5.OverrideSpinPropi = var204_upvr
                local var205_upvw = 0
                local var206_upvw
                local function Heartbeat(arg1_6) -- Line 79
                    var205_upvw += arg1_6 * 1 / 3
                    if 1 <= var205_upvw then
                        var205_upvw = 1
                    end
                    arg1_5.PropAlpha = var205_upvw
                    SpinProp_upvr(arg1_5, arg1_6)
                    if 1 <= var205_upvw then
                        arg1_5.OverrideSpinPropi = nil
                        var206_upvw:disconnect()
                    end
                    if arg1_5.OverrideSpinPropi ~= var204_upvr then
                        var206_upvw:disconnect()
                        return
                    end
                end
                var206_upvw = RunService_upvr.Heartbeat:connect(Heartbeat)
            end
            if arg1_5.IsUFO or arg1_5.IsDrone or arg1_5.IsCrewCapsule then
                arg1_5.OverrideSpringFadePropi = (arg1_5.OverrideSpringFadePropi or 0) + 1
                arg1_5.SpringSpinAlpha = Spring_upvr.new(0, 0, 1, 2)
                arg1_5.SpringSpinAlpha:SetTarget(1)
            end
            if InputUtils_upvr.isTouch() and arg1_5.Make == "BlackHawk" then
                arg1_5.CrossHair = CrossHair_upvr.Make()
                arg1_5.CrossHair.Gui.Parent = Players_upvr.LocalPlayer.PlayerGui
                arg1_5.seatMaid:GiveTask(function() -- Line 618
                    arg1_5.CrossHair:Destroy()
                    arg1_5.CrossHair = nil
                end)
            end
            if arg1_5.FellAt ~= nil and Time_upvr.GetNowSync() - arg1_5.FellAt < arg1_5.DisableDuration then
                module_upvr.FallOutOfSky(arg1_5)
                arg1_5.FellAt = arg1_5.FellAt
            end
        end
    end
    function module_upvr.VehicleLeave(arg1_7) -- Line 638
        if arg1_7.CarSitTrack ~= nil then
            arg1_7.CarSitTrack:Stop()
            arg1_7.CarSitTrack:Destroy()
            arg1_7.CarSitTrack = nil
        end
        if arg1_7.Passenger then
        else
            local var208_upvr
            if arg1_7.IsHeli or arg1_7.IsBlackHawk or arg1_7.IsLittleBird then
                local function decompInlinedCondition_23() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var208_upvr = arg1_7.OverrideSpinPropi + 1
                    return var208_upvr
                end
                if not arg1_7.OverrideSpinPropi or not decompInlinedCondition_23() then
                    var208_upvr = 0
                end
                arg1_7.OverrideSpinPropi = var208_upvr
                local var209_upvw = 0
                local var210_upvw
                local function Heartbeat(arg1_8) -- Line 102
                    var209_upvw += arg1_8 * 1 / 1
                    if 1 <= var209_upvw then
                        var209_upvw = 1
                    end
                    arg1_7.PropAlpha = 1 - var209_upvw
                    SpinProp_upvr(arg1_7, arg1_8)
                    if 1 <= var209_upvw then
                        arg1_7.OverrideSpinPropi = nil
                        var210_upvw:disconnect()
                    end
                    if arg1_7.OverrideSpinPropi ~= var208_upvr then
                        var210_upvw:disconnect()
                        return
                    end
                end
                var210_upvw = RunService_upvr.Heartbeat:connect(Heartbeat)
            end
            if arg1_7.IsUFO or arg1_7.IsDrone or arg1_7.IsCrewCapsule then
                arg1_7.OverrideSpringFadePropi = (arg1_7.OverrideSpringFadePropi or 0) + 1
                local var211_upvw = 0
                local var212_upvw
                local var213_upvr = (arg1_7.OverrideSpringFadePropi or 0) + 1
                var212_upvw = RunService_upvr.Heartbeat:connect(function(arg1_9) -- Line 126, Named "Heartbeat"
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    var211_upvw += arg1_9 * 1 / 1
                    if 1 <= var211_upvw then
                        var211_upvw = 1
                    end
                    local var214 = 1 - var211_upvw
                    if arg1_7.IsUFO then
                        module_upvr.SpinUFO(arg1_7, arg1_9, var214)
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    if arg1_7.IsDrone then
                        module_upvr.SpinDrone(arg1_7, arg1_9, var214)
                    elseif arg1_7.IsCrewCapsule then
                        module_upvr.SpinCrewCapsule(arg1_7, arg1_9, var214)
                    end
                    if 1 <= var211_upvw then
                        arg1_7.OverrideSpringFadePropi = nil
                        var212_upvw:disconnect()
                    end
                    if arg1_7.OverrideSpringFadePropi ~= var213_upvr then
                        var212_upvw:disconnect()
                    else
                        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    end
                end)
            end
            if arg1_7.IsBlade or arg1_7.IsLia or arg1_7.IsDrone or arg1_7.IsBionic then
                SetBladeEffectsVisible_upvr(arg1_7.Model, false)
            end
            if arg1_7.SpotlightMotor ~= nil then
                any_new_result1_upvr:Get(arg1_7.SpotlightMotor):UnhookLocal()
            end
            arg1_7.Rotate.AngularVelocity = Vector3.new(0, 0, 0)
            local RopePull_2 = arg1_7.Model.Preset:FindFirstChild("RopePull")
            if RopePull_2 then
                RopePull_2.VectorForce.Force = Vector3.new(0, 0, 0)
            end
            if arg1_7.RopePickupPacket ~= nil then
                arg1_7.RopePickupPacket.Maid:Destroy()
                arg1_7.RopePickupPacket = nil
            end
            VehicleUtils_upvr.setBrakelightsEnabled(arg1_7.Model, false)
        end
    end
    module_upvr.Roped = false
    function module_upvr.AttemptRopeDetach() -- Line 685
        assert(module_upvr.Roped)
        var188_upvw:FireServer('r'.."".."sammm":sub(3, 4):reverse().."".."fahk2")
    end
    local CharacterAnim_upvr = require(ReplicatedStorage_upvr.Game.CharacterAnim)
    function em_upvr.jjpe9crm(arg1_10) -- Line 689
        module_upvr.Roped = arg1_10
        for _, v_4 in ipairs(LocalPlayer_upvr.Character.Humanoid:GetPlayingAnimationTracks()) do
            v_4:Stop()
        end
        local any_getRopeGrabTrack_result1 = CharacterAnim_upvr.getRopeGrabTrack()
        if arg1_10 then
            any_getRopeGrabTrack_result1:Play()
        else
            any_getRopeGrabTrack_result1:Stop()
        end
    end
    local function AttemptDropRope_upvw() -- Line 702, Named "AttemptDropRope"
        var188_upvw:FireServer('w'.."bwmu9ck":sub(4, 6):reverse():reverse():reverse().."".."0jb6")
    end
    local CircleAction_upvr = UI_upvr.CircleAction
    local function Action_upvr(arg1_11, arg2) -- Line 706, Named "Action"
        if arg2 then
            var188_upvw:FireServer('j'.."h1h2fw3l":sub(4, 4):reverse():reverse():reverse().."".."".."qjukdu":sub(2, 2):reverse():reverse():reverse().."".."0buyi", arg1_11.Part)
            return true
        end
    end
    if not RunUtils_upvr.isTradeWorld() then
        for _, v_5 in next, CollectionService_upvr:GetTagged("RopePull") do
            CircleAction_upvr.Add({
                Part = v_5;
                Name = "Rope";
                Timed = true;
                Duration = 0.5;
                Dist = 15;
                Callback = Action_upvr;
            }, v_5)
        end
        CollectionService_upvr:GetInstanceAddedSignal("RopePull"):Connect(function(arg1_12) -- Line 712, Named "AddedFun"
            local tbl = {}
            tbl.Part = arg1_12
            tbl.Name = "Rope"
            tbl.Timed = true
            tbl.Duration = 0.5
            tbl.Dist = 15
            tbl.Callback = Action_upvr
            CircleAction_upvr.Add(tbl, arg1_12)
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("RopePull"):Connect(function(arg1_13) -- Line 727, Named "RemovedFun"
            CircleAction_upvr.Remove(arg1_13)
        end)
    end
    function em_upvr.l03xmnzk(arg1_14) -- Line 739
        if arg1_14.NonZero then
            em_upvr.ropj1fju({
                Title = "Store";
                Text = "Try again when you have 0 explosives!";
            })
        else
            if arg1_14.NotEnoughMoney then
                em_upvr.ropj1fju({
                    Title = "Store";
                    Text = "You don't have enough cash!";
                })
                em_upvr.lfty8cpc()
                return
            end
            assert(false, "No flag found")
        end
    end
    local function ClampUnitVectorCone_upvr(arg1_15, arg2, arg3) -- Line 752, Named "ClampUnitVectorCone"
        local any_VectorToObjectSpace_result1 = arg1_15:VectorToObjectSpace(arg2)
        local arctangent = math.atan2(any_VectorToObjectSpace_result1.Y, any_VectorToObjectSpace_result1.X)
        local clamped = math.clamp(math.acos(any_VectorToObjectSpace_result1.Z), math.pi - arg3, math.pi + arg3)
        return arg1_15:VectorToWorldSpace(Vector3.new(math.sin(clamped) * math.cos(arctangent), math.sin(clamped) * math.sin(arctangent), math.cos(clamped)))
    end
    local function AttemptFireMissile_upvr() -- Line 761, Named "AttemptFireMissile"
        if RunUtils_upvr.isTradeWorld() then
            return false
        end
        local any_GetVehiclePacket_result1_2 = arg1.GetVehiclePacket()
        if not any_GetVehiclePacket_result1_2.IsBlackHawk then
            return false
        end
        local Missiles_2 = any_GetVehiclePacket_result1_2.Missiles
        if not Missiles_2 then
            return false
        end
        if LocalPlayer_upvr:GetAttribute("MissileCount") <= 0 then
            VehicleUtils_upvr.promptMissileBuy()
            return false
        end
        local tick_result1_2 = tick()
        local var236 = tick_result1_2 - Missiles_2.LastFire
        if var236 < 2 and 0 < var236 then
            return false
        end
        Missiles_2.LastFire = tick_result1_2
        local var237_upvr = Missiles_2.Parts[Missiles_2.i]
        var237_upvr.Transparency = 1
        delay(2, function() -- Line 789
            var237_upvr.Transparency = 0
        end)
        local var239 = var237_upvr.CFrame * CFrame.Angles(0, math.pi, 0)
        local Velocity = var237_upvr.Velocity
        local var241
        if InputUtils_upvr.isTouch() then
            local ViewportSize_2 = CurrentCamera_upvr.ViewportSize
            var241 = Vector3.new(ViewportSize_2.X * 0.5, ViewportSize_2.Y * 0.375, 0)
        else
            var241 = UserInputService_upvr:GetMouseLocation()
        end
        local var243 = var241
        local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(var243.X, var243.Y)
        local _, any_RayIgnoreNonCollideWithIgnoreList_result2_2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction, 999, {any_GetVehiclePacket_result1_2.Model, LocalPlayer_upvr.Character})
        local _, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(var239.p, ClampUnitVectorCone_upvr(any_GetVehiclePacket_result1_2.Model.Engine.CFrame, (any_RayIgnoreNonCollideWithIgnoreList_result2_2 - var239.p).Unit, 1.0471975511965976), 999, {any_GetVehiclePacket_result1_2.Model, LocalPlayer_upvr.Character})
        local any_GetNowSync_result1_2 = Time_upvr.GetNowSync()
        var188_upvw:FireServer('j'.."".."hmsew":sub(4, 4):reverse():reverse():reverse():reverse():reverse().."".."".."sin9t2f2zq":sub(4, 6):reverse().."".."".."kqqlxn":sub(2, 2):reverse():reverse():reverse().."".."c3", var239, Velocity, any_RayIgnoreNonCollideWithIgnoreList_result2, any_GetNowSync_result1_2)
        Missile_upvr.LaunchMissile(var239, Velocity, any_RayIgnoreNonCollideWithIgnoreList_result2, any_GetNowSync_result1_2)
        Missiles_2.i = Missiles_2.i % #Missiles_2.Parts + 1
    end
    function em_upvr.je2t9qc3(arg1_16, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 817
        Missile_upvr.LaunchMissile(arg1_16, arg2, arg3, arg4, arg5, arg6, arg7)
    end
    local function AttemptDropBomb_upvr() -- Line 820, Named "AttemptDropBomb"
        if RunUtils_upvr.isTradeWorld() then
            return false
        end
        local any_GetVehiclePacket_result1 = arg1.GetVehiclePacket()
        local Missiles = any_GetVehiclePacket_result1.Missiles
        if not Missiles then
            return false
        end
        if LocalPlayer_upvr:GetAttribute("MissileCount") <= 0 then
            VehicleUtils_upvr.promptMissileBuy()
            return false
        end
        if tick() - Missiles.LastFire < 1 then
            return false
        end
        Missiles.LastFire = tick()
        local BoundingBox = any_GetVehiclePacket_result1.Model.BoundingBox
        local var255 = BoundingBox.CFrame * CFrame.new(0, -BoundingBox.Size.Y * 0.5 + 4, -BoundingBox.Size.Z * 0.5 + 10)
        local Velocity_2 = BoundingBox.Velocity
        local any_GetNowSync_result1 = Time_upvr.GetNowSync()
        Bomb_upvr.DropBomb(var255, Velocity_2, any_GetNowSync_result1, LocalPlayer_upvr)
        var188_upvw:FireServer('d'.."dmeaea":sub(4, 5):reverse():reverse():reverse().."".."".."iykbig":sub(5, 5):reverse().."".."tnow", var255, Velocity_2, any_GetNowSync_result1)
    end
    function em_upvr.deaitnow(arg1_17, arg2, arg3, arg4) -- Line 850
        Bomb_upvr.DropBomb(arg1_17, arg2, arg3, arg4)
    end
    function module_upvr.attemptDropRope() -- Line 853
        AttemptDropRope_upvw()
    end
    function module_upvr.attemptFireMissile() -- Line 856
        AttemptFireMissile_upvr()
    end
    function module_upvr.attemptDropBomb() -- Line 859
        AttemptDropBomb_upvr()
    end
    function module_upvr.toggleHeadlights(arg1_18) -- Line 862
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local SpotlightMotor = arg1_18.SpotlightMotor
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        SpotlightMotor:RequestToggle()
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var188_upvw:FireServer('q'.."".."ad3rrp6":sub(3, 3):reverse().."".."".."baablrtf":sub(3, 4):reverse():reverse():reverse().."".."".."o60or":sub(2, 3):reverse().."".."om", "Lights")
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    function module_upvr.setUp(arg1_19) -- Line 872
        local var259
        if arg1_19 then
            var259 = 1
        else
            var259 = 0
        end
        tbl_2_upvw[6] = var259
    end
    function module_upvr.setDown(arg1_20) -- Line 875
        local var260
        if arg1_20 then
            var260 = 1
        else
            var260 = 0
        end
        tbl_2_upvw[5] = var260
    end
    module_upvr.SpotlightBinder = any_new_result1_upvr
    return module_upvr
end