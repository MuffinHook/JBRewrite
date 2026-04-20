-- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local RunService_upvr = game:GetService("RunService")
local CurrentCamera_upvr = workspace.CurrentCamera
local R15IKv2_upvr = require(ReplicatedStorage.Module.R15IKv2)
local ChassisShared_upvr = require(ReplicatedStorage.Module.ChassisShared)
local Time_upvr = require(ReplicatedStorage.Module.Time)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local EnumMake_upvr = require(ReplicatedStorage.Game.Garage.EnumMake)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Vehicles = workspace:WaitForChild("Vehicles")
local function GetMoveVector_upvw() -- Line 43, Named "GetMoveVector"
    return Vector3.new()
end
local ControlModule = LocalPlayer_upvr.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
    local var23_2_upvw = require(ControlModule)
    function GetMoveVector_upvw() -- Line 50, Named "GetMoveVector"
        return var23_2_upvw:GetMoveVector()
    end
end
local new_upvr_2 = CFrame.new
local new_upvr = Vector3.new
local Angles_upvr = CFrame.Angles
local min_upvr = math.min
local abs_upvr = math.abs
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.RespectCanCollide = true
RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams_new_result1_upvr.FilterDescendantsInstances = {Vehicles}
local RaycastParams_new_result1_upvr_2 = RaycastParams.new()
RaycastParams_new_result1_upvr_2.RespectCanCollide = true
RaycastParams_new_result1_upvr_2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams_new_result1_upvr_2.FilterDescendantsInstances = {Vehicles}
local var34_upvw
local tbl_9_upvr = {
    Echo = SoundService.Chassis.EchoSoundEffect;
    Equalizer = SoundService.Chassis.EqualizerSoundEffect;
    Reverb = SoundService.Chassis.ReverbSoundEffect;
}
local tbl_8_upvr = {
    Echo = {"Delay", "DryLevel", "Feedback", "WetLevel"};
    Equalizer = {"HighGain", "LowGain", "MidGain"};
    Reverb = {"DecayTime", "Density", "Diffusion", "DryLevel", "WetLevel"};
}
local tbl_21_upvr = {
    Tunnel = {
        Echo = {
            Delay = 0.35;
            DryLevel = 0;
            Feedback = 0;
            WetLevel = -27;
        };
        Equalizer = {
            HighGain = 0;
            LowGain = -2.5;
            MidGain = -2.5;
        };
        Reverb = {
            DecayTime = 3.5;
            Density = 1;
            Diffusion = 0.6;
            DryLevel = 4;
            WetLevel = 0;
        };
    };
    Outside = {
        Echo = {
            Delay = 1.5;
            DryLevel = 0;
            Feedback = 0;
            WetLevel = -42.2;
        };
        Equalizer = {
            HighGain = 0;
            LowGain = 0;
            MidGain = 0;
        };
        Reverb = {
            DecayTime = 10;
            Density = 1;
            Diffusion = 1;
            DryLevel = 0;
            WetLevel = -35;
        };
    };
    City = {
        Echo = {
            Delay = 0.198;
            DryLevel = 0;
            Feedback = 0;
            WetLevel = -9.8;
        };
        Equalizer = {
            HighGain = 0;
            LowGain = -8;
            MidGain = 0;
        };
        Reverb = {
            DecayTime = 4.6;
            Density = 1;
            Diffusion = 0.6;
            DryLevel = 0;
            WetLevel = -28;
        };
    };
}
local function _(arg1, arg2, arg3) -- Line 150, Named "f"
    return math.exp((-(arg1 - arg2) ^ 2) / (2 * arg3 * arg3))
end
local function _(arg1, arg2) -- Line 153, Named "setVolume"
    if 0.001 < math.abs(arg1.Volume - arg2) then
        arg1.Volume = arg2
    end
end
local function _(arg1, arg2) -- Line 158, Named "setPlaybackSpeed"
    if 0.001 < math.abs(arg1.PlaybackSpeed - arg2) then
        arg1.PlaybackSpeed = arg2
    end
end
local function SetRPM3_upvr(arg1, arg2, arg3, arg4) -- Line 163, Named "SetRPM3"
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
end
local function SetRPM1_upvr(arg1, arg2, arg3, arg4) -- Line 408, Named "SetRPM1"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var53
    if arg4 == EnumMake_upvr.Volt or arg4 == EnumMake_upvr.Volt4x4 then
        var53 = 10000
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg4 == EnumMake_upvr.Roadster then
        var53 = 12000
    else
        var53 = 6000
    end
    var53 = 1
    if arg4 == EnumMake_upvr.DesertCrawler then
        var53 = 1.4
    elseif arg4 == EnumMake_upvr.BrickKar then
        var53 = 1.3
    elseif arg4 == EnumMake_upvr.AdminNuke then
        var53 = 1.3
    end
    local Idle_2 = arg1.Idle
    local var55 = -0.4 + var53 * (arg2 + 3000) / 8000
    if 0.001 < math.abs(Idle_2.PlaybackSpeed - var55) then
        Idle_2.PlaybackSpeed = var55
    end
    if not 1.4 then
    end
    local Idle_3 = arg1.Idle
    local var57 = math.exp(-(1.1 - arg2 / var53) ^ 2 / 0.5) * 0.2
    if 0.001 < math.abs(Idle_3.Volume - var57) then
        Idle_3.Volume = var57
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function SetRPMNew_upvw(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 439, Named "SetRPMNew"
    local var58 = arg5 / 6
    local var59 = arg2 / 6300
    local var60 = 5 * var59
    local var61 = 0.2
    local var62 = 0.2
    local var63
    if arg4 == EnumMake_upvr.Venom or arg4 == EnumMake_upvr.Cobra or arg4 == EnumMake_upvr.Polaire then
        var61 *= 2
        var62 *= 2
    end
    var63 = (var60 - 0) ^ 2
    local var64 = math.exp(-var63 / 8) * var61
    var63 = -(var60 - 1.5) ^ 2
    local var65 = math.exp(var63 / 2) * var62
    var63 = -(var60 - 3.25) ^ 2 / 2
    local var66 = math.exp(var63) * var62
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var63 = math.exp(-(var60 - 5) ^ 2 / 2)
        return var63
    end
    if var60 > 5 or not decompInlinedCondition() then
        var63 = 1
    end
    local var67 = var63 * var62
    var63 = arg6.low
    local var68 = 0.1 + (1.15) * ((1 + var58) * (var59 - 0.4 * var58))
    local var69 = var68 * 2 ^ (-var63 / 12)
    local var70 = var68 * 2 ^ (-arg6.mid / 12)
    local var71 = var68 * 2 ^ (-arg6.high / 12)
    local var72 = var68 * 0.75 + 1
    local Idle_4 = arg1.Idle
    if 0.001 < math.abs(Idle_4.Volume - var64) then
        Idle_4.Volume = var64
    end
    local OnLow_2 = arg1.OnLow
    if 0.001 < math.abs(OnLow_2.Volume - var65) then
        OnLow_2.Volume = var65
    end
    local OnMid_2 = arg1.OnMid
    if 0.001 < math.abs(OnMid_2.Volume - var66) then
        OnMid_2.Volume = var66
    end
    local OnHigh = arg1.OnHigh
    if 0.001 < math.abs(OnHigh.Volume - var67) then
        OnHigh.Volume = var67
    end
    local Idle = arg1.Idle
    if 0.001 < math.abs(Idle.PlaybackSpeed - var72) then
        Idle.PlaybackSpeed = var72
    end
    local OnLow = arg1.OnLow
    if 0.001 < math.abs(OnLow.PlaybackSpeed - var69) then
        OnLow.PlaybackSpeed = var69
    end
    local OnMid = arg1.OnMid
    if 0.001 < math.abs(OnMid.PlaybackSpeed - var70) then
        OnMid.PlaybackSpeed = var70
    end
    local OnHigh_2 = arg1.OnHigh
    if 0.001 < math.abs(OnHigh_2.PlaybackSpeed - var71) then
        OnHigh_2.PlaybackSpeed = var71
    end
end
local function SetRPM_upvw(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 492, Named "SetRPM"
    if arg1 == "Electric" or arg1 == "BrickKar" or arg1 == "AdminNuke" then
        SetRPM1_upvr(arg3, arg4, arg5, arg2)
    else
        if arg7 then
            SetRPMNew_upvw(arg3, arg4, arg5, arg2, arg6, arg7)
            return
        end
        SetRPM3_upvr(arg3, arg4, arg5, arg2)
    end
end
local function UpdateGearsAndRPM_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 503, Named "UpdateGearsAndRPM"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Gear_2 = arg1.Gear
    local LastGear = arg1.LastGear
    local t3 = arg1.t3
    if arg1.ManualGear then
        if arg1._shiftUp then
            arg1.Gear += 1
            arg1._shiftUp = nil
        end
        if arg1._shiftDown then
            arg1.Gear -= 1
            arg1._shiftDown = nil
        end
        arg1.Gear = math.clamp(arg1.Gear, 1, #arg2 - 2)
        Gear_2 = arg1.Gear
    end
    local var96 = (arg3) / (arg1.Wheels[1].Model.PrimaryPart.Size.Y / 2.9) * 1000 / 3600 / 0.34
    if LastGear ~= Gear_2 then
        local _ = arg2[2 + LastGear] * (1 - t3 * t3) + arg2[2 + Gear_2] * t3 * t3
        local var98 = t3 + arg5 * 1 / 0.26
        arg1.t3 = var98
        if 1 <= var98 then
            arg1.LastGear = Gear_2
            arg1.t3 = 0
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    else
    end
    local var99 = var96 * arg2[1] * arg2[2 + Gear_2] * 60 / (-math.pi*2)
    local var100 = var96 * arg2[1] * arg2[2 + Gear_2] * 60 / (-math.pi*2)
    local var101 = var100 - arg1.LastRPM
    if not arg1.NoGears and not arg1.ManualGear then
        if 0 < arg4 and 0 < var101 and 6000 < var100 and Gear_2 < #arg2 - 2 then
            arg1.Gear = Gear_2 + 1
            if arg1.onGearShift then
                arg1:onGearShift(arg1.Gear, Gear_2)
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        elseif var101 < 0 and var100 < 3400 and 1 < Gear_2 then
            arg1.Gear = Gear_2 - 1
            if arg1.onGearShift then
                arg1:onGearShift(arg1.Gear, Gear_2)
            end
        end
    end
    SetRPM_upvw(arg1.SoundType, arg1.EnumMakeId, arg1.Sounds, var99, arg4, Gear_2, arg1.engineSoundConfig)
    arg1.rpmVisual = var99
    arg1.rpmVisualMax = 7000
    arg1.LastRPM = var100
    if arg1.ManualGear then
        local _rpmLimit = arg1._rpmLimit
        local var103 = _rpmLimit or 6000
        if var100 <= var103 then
            _rpmLimit = 1
        else
            _rpmLimit = math.clamp(var103 / var100, 0, 1)
        end
        arg1._rpmLimitMult = _rpmLimit
    end
    var103 = arg1.turboIntakeSound
    local var104
    if var104 then
        var104 = math.clamp(arg1.rpmVisual / arg1.rpmVisualMax, 0, 1)
        var104 ^= 3
        if arg4 <= 0 then
            var104 = 0
        end
        arg1.turboIntakeSound.Volume = arg1.turboIntakeSound.Volume + (var104 * arg1.maxTurboIntakeSoundVolume - arg1.turboIntakeSound.Volume) * 0.1
        if Gear_2 < arg1.Gear and arg1.turboBlowOff then
            arg1.turboBlowOff.PlaybackSpeed = (1) + (math.random() * 0.15 - 0.075)
            arg1.turboBlowOff:Play()
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return Gear_2, arg2[2 + Gear_2]
end
local function updateFOV_upvr(arg1) -- Line 578, Named "updateFOV"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var105 = ((arg1.LastFakeGear or 1) ^ 0.5) * (arg1.Model.Engine.AssemblyLinearVelocity.Magnitude / 120)
    if var105 ~= var105 then
        var105 = 0
    end
    local clamped = math.clamp(var105, 0, 3)
    if clamped >= 0.825155 or not (clamped * clamped * clamped) then
    end
    local FieldOfView = CurrentCamera_upvr.FieldOfView
    CurrentCamera_upvr.FieldOfView = FieldOfView + ((1 - math.exp(-clamped)) * 30 + 70 - FieldOfView) * 0.7
end
local module_upvr = {}
SetRPM3_upvr = {}
local var109_upvw = SetRPM3_upvr
SetRPM1_upvr = 0
SetRPMNew_upvw = 0
var109_upvw[1] = SetRPM1_upvr
var109_upvw[2] = SetRPMNew_upvw
var109_upvw[3] = 0
var109_upvw[4] = 0
var109_upvw[5] = 0
var109_upvw[6] = 0
SetRPM1_upvr = false
local var110_upvw = SetRPM1_upvr
SetRPMNew_upvw = false
local var111_upvw = false
local function _(arg1) -- Line 600, Named "GetMass"
    local var119
    for _, v in ipairs(arg1:GetDescendants()) do
        if v:IsA("BasePart") then
            var119 += v:GetMass()
        end
    end
    return var119
end
function module_upvr.setForward(arg1) -- Line 609
    local var120
    if arg1 then
        var120 = 1
    else
        var120 = 0
    end
    var109_upvw[1] = var120
end
function module_upvr.setBackward(arg1) -- Line 612
    local var121
    if arg1 then
        var121 = 1
    else
        var121 = 0
    end
    var109_upvw[3] = var121
end
function module_upvr.onGearShift(arg1, arg2, arg3) -- Line 615
    if arg1.EnumMakeId == EnumMake_upvr.Venom or arg1.EnumMakeId == EnumMake_upvr.Polaire then
        Audio_upvr.ObjectLocal(arg1.Model.PrimaryPart, 18128231812, {
            Volume = 0.5;
            Pitch = 1;
        })
        for _, v_2 in arg1.Model.Model.Metal:GetChildren() do
            if v_2:IsA("Attachment") then
                local class_ParticleEmitter = v_2:FindFirstChildWhichIsA("ParticleEmitter")
                if class_ParticleEmitter then
                    class_ParticleEmitter:Emit(3)
                end
            end
        end
    end
    local GearShiftRemote = arg1.Model:FindFirstChild("GearShiftRemote")
    if GearShiftRemote then
        GearShiftRemote:FireServer(arg2, arg3)
    end
end
function module_upvr.toggleSirens() -- Line 649
    var111_upvw = not var111_upvw
    var34_upvw:FireServer('q'.."q3vtx":sub(2, 2):reverse():reverse():reverse():reverse():reverse().."".."ba06om", "PoliceLights", var111_upvw)
end
function module_upvr.toggleHeadlights() -- Line 653
    var34_upvw:FireServer('q'.."ya53v":sub(4, 4):reverse().."".."".."x60abuu5":sub(2, 5):reverse():reverse():reverse().."".."om", "Lights")
end
function module_upvr.setHandbrakeEnabled(arg1) -- Line 656
    var110_upvw = arg1
    ChassisShared_upvr.HandBrake = arg1
end
function module_upvr.DriveToPosition(arg1, arg2, arg3) -- Line 668
    local var138 = arg3
    if not var138 then
        var138 = {}
    end
    local var139 = var138
    arg1.DriveToPosition = arg2
    arg1.DriveToPositionArrivalRadius = var139.arrivalRadius or 4
    arg1.DriveToPositionOnReached = var139.onReached
end
function module_upvr.StopDriveToPosition(arg1) -- Line 676
    arg1.DriveToPosition = nil
    arg1.DriveToPositionOnReached = nil
end
local SpeedometerUtils_upvr = require(ReplicatedStorage.Speedometer.SpeedometerUtils)
function module_upvr.runAction(arg1) -- Line 680
    if arg1 then
        local any_GetLocalVehiclePacket_result1 = VehicleUtils_upvr.GetLocalVehiclePacket()
        if any_GetLocalVehiclePacket_result1.Make == "Firetruck" then
            var34_upvw:FireServer('q'.."".."vp3r6k2":sub(3, 3):reverse().."".."".."xlfr0abzu2":sub(5, 7):reverse():reverse():reverse().."".."".."xg6w26v":sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."om", "FiretruckWater", true)
        else
            if any_GetLocalVehiclePacket_result1.Make == "TheAgent" then
                module_upvr.AttemptFireMissile(any_GetLocalVehiclePacket_result1)
                return
            end
            if arg1 == "Jump" then
                if any_GetLocalVehiclePacket_result1.AreTiresPopped then return end
                local Engine = any_GetLocalVehiclePacket_result1.Model.Engine
                local var143 = any_GetLocalVehiclePacket_result1.jumpMaxAmount or 75
                Engine:ApplyImpulse(Vector3.new(0, var143 - (var143 - (any_GetLocalVehiclePacket_result1.jumpBaseAmount or 40)) * math.clamp(SpeedometerUtils_upvr.sToH(SpeedometerUtils_upvr.studsToMi(math.abs(Engine.Velocity:Dot(Engine.CFrame.LookVector)))) / (any_GetLocalVehiclePacket_result1.jumpMaxMph or 500), 0, 1), 0) * Engine.AssemblyMass)
                VehicleUtils_upvr.vehicleEffect("Jump", any_GetLocalVehiclePacket_result1.Model)
                var34_upvw:FireServer('q'.."cab3ckw":sub(2, 4):reverse():reverse():reverse().."".."06om", "Jump")
                any_GetLocalVehiclePacket_result1._lastJumpAt = os.clock()
                return true
            end
            var34_upvw:FireServer('q'.."cb3kb9f":sub(2, 3):reverse():reverse():reverse().."".."a06om", "Action")
        end
    end
    if ChassisShared_upvr.VehicleMake == "Firetruck" then
        var34_upvw:FireServer('q'.."".."mm60ab3z95":sub(3, 7):reverse():reverse():reverse().."".."om", "FiretruckWater", false)
    end
end
local function _(arg1) -- Line 720, Named "getTransparencyPredicateForHumanoid"
    assert(arg1, "missing humanoid")
    return function(arg1_2) -- Line 723
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            local any_GetLimb_result1 = arg1:GetLimb(arg1_2)
            return any_GetLimb_result1 == Enum.Limb.LeftArm
        end
        if arg1_2.Parent == arg1.Parent and (decompInlinedCondition_2() or any_GetLimb_result1 == Enum.Limb.RightArm) then
            return false
        end
        return true
    end
end
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
function module_upvr.toggleInsideCamera(arg1) -- Line 733
    local var153 = arg1
    if not var153 then
        var153 = VehicleUtils_upvr
        var153 = var153.GetLocalVehiclePacket()
    end
    local var154 = var153
    if var154 then
        if not var154.Passenger then
            local IsCameraLocked = var154.IsCameraLocked
            if IsCameraLocked then
                module_upvr.UnlockCamera(var154)
            else
                module_upvr.LockCamera(var154)
            end
            local Character = LocalPlayer_upvr.Character
            if Character then
                local Humanoid_upvr_2 = Character:FindFirstChild("Humanoid")
                assert(Humanoid_upvr_2, "missing humanoid")
                local function var158(arg1_4) -- Line 723
                    local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        local any_GetLimb_result1_2 = Humanoid_upvr_2:GetLimb(arg1_4)
                        return any_GetLimb_result1_2 == Enum.Limb.LeftArm
                    end
                    if arg1_4.Parent == Humanoid_upvr_2.Parent and (decompInlinedCondition_4() or any_GetLimb_result1_2 == Enum.Limb.RightArm) then
                        return false
                    end
                    return true
                end
                if IsCameraLocked then
                    CharacterUtils_upvr.popInvisible(LocalPlayer_upvr.Character, var158)
                    return
                end
                CharacterUtils_upvr.setInvisible(LocalPlayer_upvr.Character, var158)
            end
        end
    end
end
local var160_upvw
function module_upvr.init(arg1) -- Line 754
    var160_upvw = arg1.ScreenGui
end
function module_upvr.SetGravity(arg1, arg2) -- Line 757
    local var161 = arg1.Model:FindFirstChild("Engine").AssemblyMass * 9.81 * 20
    local var162
    if var161 ~= var161 then
        var161 = 0
    end
    if var162 ~= var162 then
        var162 = 0
    end
    arg1.gravityOffset = var161 * var162
end
local CharacterAnim_upvr = require(ReplicatedStorage.Game.CharacterAnim)
local var164_upvw = false
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr.VehicleEnter(arg1) -- Line 773
    local Character_2_upvr = LocalPlayer_upvr.Character
    local seatMaid_upvr = arg1.seatMaid
    seatMaid_upvr:GiveTask(function() -- Line 779
        if not Character_2_upvr then
        else
            local Head_2 = Character_2_upvr:FindFirstChild("Head")
            if Head_2 then
                local class_Decal_3 = Head_2:FindFirstChildOfClass("Decal")
                if class_Decal_3 then
                    class_Decal_3.Transparency = 0
                end
            end
        end
    end)
    seatMaid_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 792
        updateFOV_upvr(arg1)
    end))
    arg1.EnumMakeId = EnumMake_upvr[arg1.Make]
    local var364 = true
    local var365
    if arg1.EnumMakeId == EnumMake_upvr.ATV or arg1.EnumMakeId == EnumMake_upvr.Volt then
        arg1.NoLook = true
    elseif arg1.Seat:FindFirstChild("Turret") then
        var364 = false
        local Humanoid_upvr = Character_2_upvr.Humanoid
        task.delay(0.1, function() -- Line 803
            for _, v_10 in ipairs(Humanoid_upvr:GetPlayingAnimationTracks()) do
                v_10:Stop()
            end
            local any_getIdleTrack_result1_upvr_2 = CharacterAnim_upvr.getIdleTrack()
            any_getIdleTrack_result1_upvr_2:Play()
            seatMaid_upvr:GiveTask(function() -- Line 809
                any_getIdleTrack_result1_upvr_2:Stop()
            end)
        end)
    end
    if var364 then
        local any_getCarSitTrack_result1_upvr = CharacterAnim_upvr.getCarSitTrack()
        any_getCarSitTrack_result1_upvr:Play()
        seatMaid_upvr:GiveTask(function() -- Line 817
            any_getCarSitTrack_result1_upvr:Stop()
        end)
    end
    any_getCarSitTrack_result1_upvr = arg1.Model:FindFirstChild("Steer")
    local var377 = any_getCarSitTrack_result1_upvr
    if var377 then
        local Offset_2 = var377:FindFirstChild("Offset")
        if Offset_2 then
            arg1.SteerOffset = Offset_2.Value
        end
    end
    local Model = arg1.Model
    if not arg1.Seat:FindFirstChild("Visible") then
        local Head_3 = Character_2_upvr:FindFirstChild("Head")
        if Head_3 then
            var365 = "Decal"
            local instance = Head_3:FindFirstChildOfClass(var365)
            if instance then
                instance.Transparency = 1
            end
        end
    end
    ChassisShared_upvr.VehicleMake = arg1.Make
    if arg1.Passenger then
    else
        local tbl = {}
        var365 = 0
        tbl[1] = 0
        tbl[2] = 0
        tbl[3] = var365
        tbl[4] = 0
        tbl[5] = 0
        tbl[6] = 0
        var109_upvw = tbl
        var110_upvw = false
        SetRPMNew_upvw = false
        ChassisShared_upvr.HandBrake = false
        var164_upvw = false
        var111_upvw = arg1.PoliceLights
        var365 = 100
        module_upvr.SetGravity(arg1, var365)
        local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
        BodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        var365 = arg1.Mass
        BodyAngularVelocity.MaxTorque = new_upvr(var365, math.huge, arg1.Mass)
        BodyAngularVelocity.Parent = Model.Engine
        arg1.Rotate = BodyAngularVelocity
        arg1.Traction = 1
        arg1.LastForward = 0
        arg1.RotY = 0
        arg1.LastDrift = 0
        arg1.vHeading = 0
        arg1.vGrass = 0
        arg1.vAsphalt = 0
        arg1.vSandstone = 0
        arg1.Gear = 1
        arg1.LastGear = 1
        arg1.LastRPM = 0
        arg1.t3 = 0
        arg1.AreTiresPopped = false
        arg1.PopTires = module_upvr.PopTires
        arg1._flagBrakelightsEnabled = false
        arg1._flagHeadlightsEnabled = false
        if arg1.Make ~= "Volt" then
            var365 = Character_2_upvr
            arg1.IK = R15IKv2_upvr.BuildPacketArms(var365)
        end
        if arg1.Make == "TheRattler" then
            var365 = Vector3.new()
            arg1.SpringEngineRattle = Spring_upvr.new(var365, Vector3.new(), 0.6, 30)
            var365 = 0
            arg1.SpringEngineFlaps = Spring_upvr.new(var365, 0, 0.8, 15)
            arg1.LastEngineRattle = os.clock()
            arg1.RattleFire = {}
            arg1.RattleSmoke = {}
            var365 = Model.Preset
            var365 = var365.RattlerEngine
            var365 = var365.EngineGold:GetChildren()
            local ipairs_result1_2, ipairs_result2_5, ipairs_result3_4 = ipairs(var365)
            for _, v_11 in ipairs_result1_2, ipairs_result2_5, ipairs_result3_4 do
                if v_11:IsA("Attachment") then
                    table.insert(arg1.RattleFire, v_11.Fire)
                    table.insert(arg1.RattleSmoke, v_11.Smoke)
                    v_11.Fire.Enabled = false
                    v_11.Smoke.Enabled = false
                end
            end
        elseif arg1.Make == "Blackbeard" then
            arg1.LastEngineRattle = os.clock()
            arg1.RattleMotors = {}
            ipairs_result2_5 = Vector3.new()
            arg1.SpringEngineRattle = Spring_upvr.new(ipairs_result2_5, Vector3.new(), 0.6, 30)
            arg1.RattleParticles = {}
            for _, v_20 in Model.Preset.RattlerEngine:GetChildren() do
                local class_Motor_3 = v_20:FindFirstChildOfClass("Motor")
                if class_Motor_3 and class_Motor_3.Name:match("Engine$") then
                    table.insert(arg1.RattleMotors, {
                        motor = class_Motor_3;
                    })
                end
            end
            local children_4, NONE_21, NONE_20 = Model.Preset.RattlerEngine.SecondBody:GetChildren()
            for _, v_21 in children_4, NONE_21, NONE_20 do
                if v_21:IsA("Attachment") then
                    local class_ParticleEmitter_3 = v_21:FindFirstChildWhichIsA("ParticleEmitter")
                    if class_ParticleEmitter_3 then
                        table.insert(arg1.RattleParticles, class_ParticleEmitter_3)
                        class_ParticleEmitter_3.Enabled = false
                    end
                end
            end
        elseif arg1.Make == "Shogun" then
            arg1.LastEngineRattle = os.clock()
            arg1.RattleMotors = {}
            NONE_21 = Vector3.new()
            arg1.SpringEngineRattle = Spring_upvr.new(NONE_21, Vector3.new(), 0.6, 30)
            for _, v_22 in Model.Preset.RattlerEngine:GetChildren() do
                local class_Motor_4 = v_22:FindFirstChildOfClass("Motor")
                if class_Motor_4 and class_Motor_4.Name:match("Engine$") then
                    table.insert(arg1.RattleMotors, {
                        motor = class_Motor_4;
                    })
                end
            end
            arg1.RattleParticles = {}
            for _, v_23 in Model.Model:FindFirstChild("SecondBody"):GetDescendants() do
                if v_23:IsA("ParticleEmitter") then
                    table.insert(arg1.RattleParticles, v_23)
                    v_23.Enabled = false
                end
            end
            arg1.BrakeTrails = {}
            local children_6, NONE_8, NONE_13 = Model.Model:FindFirstChild("BrakelightGlass"):GetChildren()
            for i_24, v_24 in children_6, NONE_8, NONE_13 do
                if v_24:IsA("Trail") then
                    table.insert(arg1.BrakeTrails, v_24)
                    v_24.Enabled = false
                end
            end
        elseif arg1.Make == "BlackWidow" then
            arg1.LastEngineRattle = os.clock()
            arg1.RattleMotors = {}
            NONE_8 = Vector3.new()
            i_24 = 0.6
            v_24 = 30
            arg1.SpringEngineRattle = Spring_upvr.new(NONE_8, Vector3.new(), i_24, v_24)
            for _, v_25 in Model.Preset.RattlerEngine:GetChildren() do
                local class_Motor = v_25:FindFirstChildOfClass("Motor")
                if class_Motor and class_Motor.Name:match("Engine$") then
                    table.insert(arg1.RattleMotors, {
                        motor = class_Motor;
                    })
                end
            end
            arg1.RattleParticles = {}
            local any_QueryDescendants_result1_2, any_QueryDescendants_result2, any_QueryDescendants_result3 = Model.Preset.RattlerEngine.Metal:QueryDescendants("ParticleEmitter")
            for i_26, v_26 in any_QueryDescendants_result1_2, any_QueryDescendants_result2, any_QueryDescendants_result3 do
                table.insert(arg1.RattleParticles, v_26)
                v_26.Enabled = false
            end
        elseif arg1.Make == "Bluebird" then
            any_QueryDescendants_result2 = Vector3.new()
            i_26 = 0.6
            v_26 = 30
            arg1.SpringEngineRattle = Spring_upvr.new(any_QueryDescendants_result2, Vector3.new(), i_26, v_26)
            any_QueryDescendants_result2 = 0
            i_26 = 0.8
            v_26 = 15
            arg1.SpringEngineFlaps = Spring_upvr.new(any_QueryDescendants_result2, 0, i_26, v_26)
            arg1.LastEngineRattle = os.clock()
            arg1.RattleFire = {}
            any_QueryDescendants_result2 = Model.Preset
            any_QueryDescendants_result2 = any_QueryDescendants_result2.RattlerEngine
            any_QueryDescendants_result2 = any_QueryDescendants_result2.EngineMetal:GetChildren()
            local ipairs_result1, ipairs_result2_upvr, ipairs_result3_3 = ipairs(any_QueryDescendants_result2)
            for _, v_27 in ipairs_result1, ipairs_result2_upvr, ipairs_result3_3 do
                if v_27:IsA("Attachment") then
                    local Fire_2 = v_27:FindFirstChild("Fire")
                    if Fire_2 then
                        table.insert(arg1.RattleFire, Fire_2)
                        Fire_2.Enabled = false
                    end
                end
            end
            ipairs_result2_upvr = Model.Engine
            arg1.BluebirdSupercharger = Audio_upvr.ObjectLocal(ipairs_result2_upvr, 78492749956905, {
                Volume = 0;
                Looped = true;
                RollOffMaxDistance = 352;
            })
            seatMaid_upvr:GiveTask(function() -- Line 984
                if arg1.BluebirdSupercharger then
                    arg1.BluebirdSupercharger:Destroy()
                end
            end)
        elseif arg1.Make == "JBX0031" then
            arg1.ThrusterFlames = true
            ipairs_result2_upvr = Model
            module_upvr.UpdateThrusterFlames(ipairs_result2_upvr, 0, 0, 0, {
                vehicleEnter = true;
            })
        elseif arg1.Make == "Wedge" or arg1.Make == "Manta" or arg1.Make == "Katana" or arg1.Make == "WYNDR" or arg1.Make == "Polaire" then
            ipairs_result2_upvr = Model.Engine
            local any_ObjectLocal_result1_upvr_3 = Audio_upvr.ObjectLocal(ipairs_result2_upvr, 132884974895700, {
                Volume = 0;
                Looped = true;
                RollOffMinDistance = 16;
                RollOffMaxDistance = 512;
                RollOffMode = Enum.RollOffMode.InverseTapered;
            })
            ipairs_result2_upvr = 0.2
            arg1.maxTurboIntakeSoundVolume = ipairs_result2_upvr
            ipairs_result2_upvr = arg1.Make
            if ipairs_result2_upvr == "Manta" then
                ipairs_result2_upvr = 0.1
                arg1.maxTurboIntakeSoundVolume = ipairs_result2_upvr
            else
                ipairs_result2_upvr = arg1.Make
                if ipairs_result2_upvr == "Polaire" then
                    ipairs_result2_upvr = 0.1
                    arg1.maxTurboIntakeSoundVolume = ipairs_result2_upvr
                end
            end
            ipairs_result2_upvr = Audio_upvr
            ipairs_result2_upvr = ipairs_result2_upvr.ObjectLocal
            ipairs_result2_upvr = ipairs_result2_upvr(Model.Engine, 118282536530342, {
                Volume = 0.2;
                DoNotPlay = true;
                RollOffMinDistance = 16;
                RollOffMaxDistance = 512;
                RollOffMode = Enum.RollOffMode.InverseTapered;
            })
            arg1.turboIntakeSound = any_ObjectLocal_result1_upvr_3
            arg1.turboBlowOff = ipairs_result2_upvr
            seatMaid_upvr:GiveTask(function() -- Line 1015
                any_ObjectLocal_result1_upvr_3:Destroy()
                ipairs_result2_upvr:Destroy()
            end)
        end
        ipairs_result2_upvr = arg1.Sounds
        any_ObjectLocal_result1_upvr_3 = ipairs_result2_upvr.DriftSqueal
        ipairs_result2_upvr = 0
        any_ObjectLocal_result1_upvr_3.Volume = ipairs_result2_upvr
        any_ObjectLocal_result1_upvr_3 = pairs
        ipairs_result2_upvr = arg1.Sounds
        any_ObjectLocal_result1_upvr_3 = any_ObjectLocal_result1_upvr_3(ipairs_result2_upvr)
        local any_ObjectLocal_result1_upvr_3_result1, var423_result2, any_ObjectLocal_result1_upvr_3_result3 = any_ObjectLocal_result1_upvr_3(ipairs_result2_upvr)
        for _, v_12 in any_ObjectLocal_result1_upvr_3_result1, var423_result2, any_ObjectLocal_result1_upvr_3_result3 do
            if not v_12.IsPlaying then
                v_12:Play()
            end
        end
        any_ObjectLocal_result1_upvr_3_result1 = module_upvr
        any_ObjectLocal_result1_upvr_3_result1 = any_ObjectLocal_result1_upvr_3_result1.setForward
        arg1.setForward = any_ObjectLocal_result1_upvr_3_result1
        any_ObjectLocal_result1_upvr_3_result1 = module_upvr
        any_ObjectLocal_result1_upvr_3_result1 = any_ObjectLocal_result1_upvr_3_result1.setBackward
        arg1.setBackward = any_ObjectLocal_result1_upvr_3_result1
        any_ObjectLocal_result1_upvr_3_result1 = module_upvr
        any_ObjectLocal_result1_upvr_3_result1 = any_ObjectLocal_result1_upvr_3_result1.onGearShift
        arg1.onGearShift = any_ObjectLocal_result1_upvr_3_result1
        any_ObjectLocal_result1_upvr_3_result1 = RaycastParams_new_result1_upvr
        var423_result2 = false
        if arg1.EnumMakeId ~= EnumMake_upvr.Delorean then
            if arg1.EnumMakeId == EnumMake_upvr.Blackbeard then
                var423_result2 = false
            else
                var423_result2 = true
            end
        end
        any_ObjectLocal_result1_upvr_3_result1.IgnoreWater = var423_result2
    end
end
function module_upvr.VehicleLeave(arg1) -- Line 1079
    CurrentCamera_upvr.FieldOfView = 70
    local var465
    if var465 then
        var465 = tbl_21_upvr.Outside
        for i_3, v_3 in next, tbl_8_upvr do
            for _, v_4 in next, v_3 do
                tbl_9_upvr[i_3][v_4] = var465[i_3][v_4]
            end
        end
        for _, v_5 in pairs(arg1.Sounds) do
            v_5.Volume = 0
        end
        arg1.Sounds.DriftSqueal:Stop()
    end
    if arg1.IsCameraLocked then
        module_upvr.UnlockCamera(arg1)
    end
    if arg1.Passenger then
    else
        arg1.Rotate:Destroy()
        arg1.Lift.Force = Vector3.new(0, 0, 0)
        for _, v_13 in arg1.EngineThrusters do
            v_13.Drive.Force = Vector3.new(0, 0, 0)
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            v_13.Friction.Force = Vector3.new(0, 0, 0)
        end
        arg1.IK = nil
        for _, v_14 in arg1.Wheels do
            v_14.Thruster.Force = Vector3.new(0, 0, 0)
        end
        if arg1.RattleSmoke then
            for _, v_15 in arg1.RattleSmoke do
                v_15.Enabled = false
            end
        end
        if arg1.RattleFire then
            for _, v_16 in arg1.RattleFire do
                v_16.Enabled = false
            end
        end
        if arg1.RattleParticles then
            for _, v_17 in arg1.RattleParticles do
                v_17.Enabled = false
            end
        end
        if arg1.ThrusterFlames then
            module_upvr.UpdateThrusterFlames(arg1.Model, 0, 0, 0, {
                vehicleLeave = true;
            })
        end
        if arg1.BrakeTrails then
            for _, v_18 in arg1.BrakeTrails do
                v_18.Enabled = false
            end
        end
        VehicleUtils_upvr.setBrakelightsEnabled(arg1.Model, false)
        if arg1.Model.Parent then
        end
        if arg1.Model.Preset:FindFirstChild("Rudder") then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            DoorUtils_upvr.setPctOpen(arg1.Model.Preset:FindFirstChild("Rudder"), 0.5)
        end
        if arg1._haptic then
            arg1._haptic:Destroy()
            arg1._haptic = nil
        end
    end
end
local tbl_2_upvr = {}
local function getThrusterLightsState_upvr(arg1) -- Line 1152, Named "getThrusterLightsState"
    local var471 = tbl_2_upvr[arg1]
    if not var471 then
        var471 = {
            part = nil;
            activeTween = nil;
            isOn = false;
            hotUntil = 0;
        }
        tbl_2_upvr[arg1] = var471
    end
    if var471.part == nil or var471.part.Parent == nil then
        local ThrusterLights = arg1.Model:FindFirstChild("ThrusterLights")
        if ThrusterLights and ThrusterLights:IsA("BasePart") then
            var471.part = ThrusterLights
            return var471
        end
        var471.part = nil
    end
    return var471
end
local TweenService_upvr = game:GetService("TweenService")
local Color3_fromRGB_result1_upvr_2 = Color3.fromRGB(204, 142, 105)
local Color3_fromRGB_result1_upvr = Color3.fromRGB(68, 54, 43)
local function setThrusterLightsEnabled_upvr(arg1, arg2) -- Line 1174, Named "setThrusterLightsEnabled"
    local getThrusterLightsState_result1 = getThrusterLightsState_upvr(arg1)
    local part = getThrusterLightsState_result1.part
    local var479
    if not part then
    else
        if getThrusterLightsState_result1.isOn == arg2 then return end
        if getThrusterLightsState_result1.activeTween then
            getThrusterLightsState_result1.activeTween:Cancel()
            getThrusterLightsState_result1.activeTween = nil
        end
        getThrusterLightsState_result1.isOn = arg2
        var479 = Enum.EasingStyle.Quad
        local tbl_3 = {}
        local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var479 = Color3_fromRGB_result1_upvr_2
            return var479
        end
        if not arg2 or not decompInlinedCondition_5() then
            var479 = Color3_fromRGB_result1_upvr
        end
        tbl_3.Color = var479
        getThrusterLightsState_result1.activeTween = TweenService_upvr:Create(part, TweenInfo.new(0.2, var479, Enum.EasingDirection.Out), tbl_3)
        getThrusterLightsState_result1.activeTween:Play()
    end
end
local tbl_4_upvr = {}
function module_upvr.UpdateThrusterFlames(arg1, arg2, arg3, arg4, arg5) -- Line 1201
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.UpdateWheelLowQuality(arg1, arg2, arg3, arg4) -- Line 1303
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Engine_3 = arg3.Engine
    local Part_2 = arg3.Part
    local CFrame_2 = Part_2.CFrame
    local any_ToObjectSpace_result1 = Engine_3.CFrame:ToObjectSpace(CFrame_2)
    local lateralOffset = arg3.lateralOffset
    local var487
    if 0 < any_ToObjectSpace_result1.X then
        lateralOffset = 1
    else
        lateralOffset = -1
    end
    local cframe_3 = CFrame.new((arg3.lateralRotateOffset or 0) * lateralOffset, 0, 0)
    var487 = 0
    local var489 = CFrame_2 * CFrame.new((lateralOffset or 0) * lateralOffset, 0, var487) * cframe_3
    local Motor_2 = Part_2.Motor
    var487 = nil
    local workspace_Raycast_result1_2 = workspace:Raycast(var489.p, var489:VectorToWorldSpace(Vector3.new(0, -1, 0)) * arg2, RaycastParams_new_result1_upvr_2)
    if workspace_Raycast_result1_2 then
        var487 = workspace_Raycast_result1_2.Position
    end
    if var487 then
    else
    end
    local var493 = -min_upvr(arg2, arg2) + Motor_2.Part0.Size.Y * 0.5
    local new_upvr_2_result1 = new_upvr_2(0, var493, 0)
    if any_ToObjectSpace_result1.Z < 0 then
        new_upvr_2_result1 *= Angles_upvr(0, Engine_3.AssemblyAngularVelocity.Y * 0.5, 0)
    end
    Motor_2.C1 = new_upvr_2_result1 * cframe_3 * Angles_upvr(arg4, 0, 0)
    local BridgeMotor = Part_2:FindFirstChild("BridgeMotor")
    if BridgeMotor then
        local var496 = arg3.bridgeLocalYOffset or 0
        BridgeMotor.C1 = CFrame.new((arg3.bridgeXOffset or 0) * lateralOffset, (arg3.bridgeYOffset or 0) + var496, 0) * CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(any_ToObjectSpace_result1.X, var493 - var496, 0))
    end
end
function module_upvr.UpdateSoundLowQuality(arg1, arg2, arg3) -- Line 1345
    if arg1.EnumMakeId == nil then
        arg1.EnumMakeId = EnumMake_upvr[arg1.Make]
    end
    UpdateGearsAndRPM_upvr(arg1, arg2, math.abs(arg3.Z), -math.sign(arg3.Z), (1/60))
end
local function _(arg1) -- Line 1351, Named "IsNaN"
    if arg1 == arg1 then
    else
    end
    return true
end
local new_upvr_2_result1_upvr = new_upvr_2(0, 0, 0)
local PhysicsLagService_upvr = require(ReplicatedStorage.App.PhysicsLagService)
local function UpdateThruster_upvr(arg1, arg2, arg3, arg4) -- Line 1355, Named "UpdateThruster"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Part = arg2.Part
    local Engine_2 = arg2.Engine
    local CFrame_4 = Part.CFrame
    local any_ToObjectSpace_result1_2 = Engine_2.CFrame:ToObjectSpace(CFrame_4)
    local lateralOffset_2 = arg2.lateralOffset
    local var512
    if 0 < any_ToObjectSpace_result1_2.X then
        lateralOffset_2 = 1
    else
        lateralOffset_2 = -1
    end
    local cframe_2 = CFrame.new((arg2.lateralRotateOffset or 0) * lateralOffset_2, 0, 0)
    local cframe = CFrame.new((lateralOffset_2 or 0) * lateralOffset_2, 0, 0)
    local var515 = CFrame_4 * cframe * cframe_2
    local p = var515.p
    local Motor = Part.Motor
    local var518 = Part.AssemblyMass * 9.81 * 20
    var512 = var518 * arg1.Suspension
    if var512 ~= var512 then
        var512 = 0
    end
    local var519 = var512 / arg1.Bounce
    if var519 ~= var519 then
    end
    local any_VectorToObjectSpace_result1 = var515:VectorToObjectSpace(Part.Velocity)
    local Height = arg1.Height
    local GarageSuspensionHeight = arg1.Model:GetAttribute("GarageSuspensionHeight")
    if GarageSuspensionHeight then
        Height += GarageSuspensionHeight
    end
    local var523 = arg2._heightOffset or 0
    local var524 = var523 + ((Part:GetAttribute("ThrusterHeightOffset") or 0) - var523) * 0.1
    arg2._heightOffset = var524
    Height += var524
    if arg1.AreTiresPopped then
        Height = arg1.Height - 0.5
    end
    local var525
    local var526
    local workspace_Raycast_result1 = workspace:Raycast(p, var515:VectorToObjectSpace(Vector3.new(0, -1, 0)) * Height, RaycastParams_new_result1_upvr)
    if workspace_Raycast_result1 then
        var525 = workspace_Raycast_result1.Instance
        var526 = workspace_Raycast_result1.Position
    end
    if var526 then
        local _ = (var526 - p).Magnitude
    else
    end
    if not arg1.AreTiresPopped or not Part.Parent:FindFirstChild("Rim") then
        local TireMesh = Part.Parent:FindFirstChild("TireMesh")
    end
    local var530 = 0
    if TireMesh then
        var530 = TireMesh.Size.Y
    end
    local Y = Motor.C1.Y
    local var532 = Y + (-min_upvr(Height, Height) + var530 * 0.5 - Y) * 0.5
    local var533 = new_upvr_2(0, var532, 0) * cframe
    local Drift = Part:FindFirstChild("Drift")
    if any_ToObjectSpace_result1_2.Z < 0 then
        var533 *= Angles_upvr(0, arg1.RotY * 0.4 + Engine_2.RotVelocity.Y * 0.2, 0)
    elseif Drift and var525 and (var110_upvw or arg1.Drift) then
        arg1._didAnyWheelDrift = true
        Drift.C0 = CFrame.new(0, -var532 + var530 * 0.5, 0)
        for i_19, v_19 in Drift.Part0:GetChildren() do
            if v_19:IsA("ParticleEmitter") then
                local var538 = (v_19:GetAttribute("DriftAccum") or 0) + v_19.Rate * arg4
                local floored = math.floor(var538)
                if 0 < floored then
                    v_19:Emit(floored)
                end
                v_19:SetAttribute("DriftAccum", var538 - floored)
            end
        end
    end
    local var540
    i_19 = 0
    v_19 = 0
    local var541 = var533 * cframe_2 * Angles_upvr(arg3.WheelRotation or 0, i_19, v_19)
    local function decompInlinedCondition_6() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        v_19 = var541.z
        i_19 = v_19 + var541.y
        v_19 = var541.x
        return 100 < abs_upvr(i_19 + v_19)
    end
    if var541.x ~= var541.x or var541.y ~= var541.y or var541.z ~= var541.z or decompInlinedCondition_6() then
    end
    Motor.C1 = new_upvr_2_result1_upvr
    if var525 then
        i_19 = var518 * 0.5
        local var542 = i_19
        v_19 = -var518 * 0.5
        local var543 = v_19
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        local var544 = ((Height - min_upvr(Height, Height)) ^ 2) * (var512 / Height ^ 2)
        if 0.01 < any_VectorToObjectSpace_result1.magnitude then
            var544 -= (any_VectorToObjectSpace_result1 * 0).Y
        end
        if var544 ~= var544 then
        end
        local function decompInlinedCondition_7() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            return 0 >= var543
        end
        if var542 >= 0 or not var542 or decompInlinedCondition_7() or not var543 then
        end
        local var545 = 1
        local any_getEstimatedPhysicsStepsMult_result1 = PhysicsLagService_upvr.getEstimatedPhysicsStepsMult()
        if 1 <= any_getEstimatedPhysicsStepsMult_result1 then
            var545 /= any_getEstimatedPhysicsStepsMult_result1
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg2.Thruster.Force = new_upvr(0, (0 * math.clamp(var545, 0, 1)) * (4 / arg2.NumWheels), 0)
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg2.Thruster.Force = Vector3.new(0, 0, 0)
    end
    var543 = "BridgeMotor"
    local SOME = Part:FindFirstChild(var543)
    if SOME then
        var543 = arg2.bridgeXOffset
        var542 = var543 or 0
        var543 = arg2.bridgeYOffset or 0
        local var548 = arg2.bridgeLocalYOffset or 0
        SOME.C1 = CFrame.new(var542 * lateralOffset_2, var543 + var548, 0) * CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(any_ToObjectSpace_result1_2.X, var532 - var548, 0))
    end
end
local new_upvr_3 = Ray.new
local FindPartOnRayWithIgnoreList_upvr = workspace.FindPartOnRayWithIgnoreList
local function fpor2Autopilot_upvr(arg1, arg2, arg3) -- Line 1489, Named "fpor2Autopilot"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local magnitude = arg2.magnitude
    local unit = arg2.unit
    local tbl_14 = {}
    tbl_14[1] = arg3
    local var564
    repeat
        local var550_result1, var550_result2_2, _ = FindPartOnRayWithIgnoreList_upvr(workspace, new_upvr_3(arg1, unit * (magnitude - 0)), tbl_14, false, true)
        var564 = var550_result1
        var550_result1 = var564
        local var569 = var550_result1
        if var569 then
            var569 = var564.CanCollide
            if var569 then
                if var564.Material ~= Enum.Material.Asphalt then
                    var569 = false
                else
                    var569 = true
                end
            end
        end
        local var570 = var569
        if not var570 then
            table.insert(tbl_14, var564)
        end
    until var570 and magnitude - (arg1 - var550_result2_2).magnitude <= 0.001 and 4 < 0 + 1
    if not var564 then
    end
    return var564, arg1 + unit * magnitude, Vector3.new(0, -1, 0)
end
local tbl_11_upvr = {
    [EnumMake_upvr.Proto8] = true;
    [EnumMake_upvr.Parisian] = true;
    [EnumMake_upvr.Semi] = true;
    [EnumMake_upvr.PrisonBus] = true;
    [EnumMake_upvr.Aperture] = true;
    [EnumMake_upvr.Fiasco] = true;
}
local tbl_12_upvr = {
    [EnumMake_upvr.Firetruck] = 450;
    [EnumMake_upvr.Surus] = 450;
    [EnumMake_upvr.BankTruck] = 450;
    [EnumMake_upvr.Volt4x4] = 450;
    [EnumMake_upvr.Interrogator] = 450;
    [EnumMake_upvr.Sentinel] = 450;
    [EnumMake_upvr.TheCamper] = 450;
    [EnumMake_upvr.Roadster] = 450;
    [EnumMake_upvr.Boxer] = 450;
    [EnumMake_upvr.Ray9] = 450;
    [EnumMake_upvr.JackRabbit] = 450;
    [EnumMake_upvr.ShellClassic] = 450;
    [EnumMake_upvr.Bandit] = 450;
    [EnumMake_upvr.Parisian] = 450;
    [EnumMake_upvr.Carbonara] = 450;
    [EnumMake_upvr.Laviolette] = 450;
    [EnumMake_upvr.Venom] = 450;
    [EnumMake_upvr.Beignet] = 450;
    [EnumMake_upvr.Snake] = 450;
    [EnumMake_upvr.MoltenM12] = 450;
    [EnumMake_upvr.Scorpio] = 450;
    [EnumMake_upvr.Iceborn] = 300;
    [EnumMake_upvr.OrionM42] = 450;
    [EnumMake_upvr.Polaire] = 175;
    [EnumMake_upvr.Challenger] = 175;
    [EnumMake_upvr.Deja] = 175;
    [EnumMake_upvr.Shogun] = 148.75;
    [EnumMake_upvr.Bugatti] = 175;
    [EnumMake_upvr.Stormrider] = 175;
    [EnumMake_upvr.Revox] = 175;
    [EnumMake_upvr.Badger] = 175;
    [EnumMake_upvr.Mustang] = 175;
    [EnumMake_upvr.TheAgent] = 175;
    [EnumMake_upvr.Blackbeard] = 175;
    [EnumMake_upvr.WYNDR] = 175;
    [EnumMake_upvr.MCL36] = 550;
    [EnumMake_upvr.MCL36FREE] = 550;
    [EnumMake_upvr.Manta] = 550;
    [EnumMake_upvr.Striker] = 175;
    [EnumMake_upvr.XRK] = 450;
    [EnumMake_upvr.Maverick] = 175;
    [EnumMake_upvr.BananaCar] = 100;
    [EnumMake_upvr.Power1] = 450;
    [EnumMake_upvr.Successor] = 450;
    [EnumMake_upvr.Bluebird] = 175;
    [EnumMake_upvr.JBX0031] = 175;
    [EnumMake_upvr.Proto8] = 450;
    [EnumMake_upvr.Goliath] = 550;
    [EnumMake_upvr.PizzaDelivery] = 100;
    [EnumMake_upvr.BrickKar] = 450;
    [EnumMake_upvr.TheCamper] = 300;
    [EnumMake_upvr.AdminNuke] = 900;
}
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local HapticEffect_upvr = require(ReplicatedStorage.App.HapticEffect)
local tanh_upvr = math.tanh
local EnvironmentUtils_upvr = require(ReplicatedStorage.Environment.EnvironmentUtils)
local EnvironmentConsts_upvr = require(ReplicatedStorage.Environment.EnvironmentConsts)
local max_upvr = math.max
local any_isStudio_result1_upvr = require(ReplicatedStorage.App.RunUtils).isStudio()
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local Region_upvr = require(ReplicatedStorage.Module.Region)
local const_number_upvw = 0
function module_upvr.UpdateEngine(arg1, arg2, arg3) -- Line 1588
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _ = arg2.Engine
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if os.clock() - arg1._spinOutAt >= 3 then
    else
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.Update(arg1, arg2) -- Line 2434
    arg1._didAnyWheelDrift = false
    local var588
    if 0 >= var109_upvw[1] - var109_upvw[3] then
        var588 = false
    else
        var588 = true
    end
    if not var588 and arg1.isAccelHeld ~= var588 and 50 < arg1.Model.PrimaryPart.AssemblyLinearVelocity.Magnitude and arg1.turboBlowOff and 1 < os.clock() - (arg1.lastTurboBlowOff or 0) then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1.lastTurboBlowOff = os.clock()
        arg1.turboBlowOff.PlaybackSpeed = (1) + (math.random() * 0.1 - 0.05)
        arg1.turboBlowOff:Play()
    end
    arg1.isAccelHeld = var588
    for i_6, v_6 in arg1.EngineThrusters do
        module_upvr.UpdateEngine(arg1, v_6, arg2)
    end
    if arg1._didAnyWheelDrift ~= arg1.Model:GetAttribute("VehicleIsDrifting") then
        i_6 = "VehicleIsDrifting"
        v_6 = arg1._didAnyWheelDrift
        arg1.Model:SetAttribute(i_6, v_6)
        i_6 = "RelayDriftingRemote"
        i_6 = arg1._didAnyWheelDrift
        arg1.Model:FindFirstChild(i_6):FireServer(i_6)
    end
end
function module_upvr.UpdateStepped(arg1) -- Line 2464
    local Model_3 = arg1.Model
    if arg1.IK then
        local var590 = 0.6 * arg1.RotY
        arg1.WeldSteer.C0 = Angles_upvr(0, var590, 0)
        local CFrame = Model_3.Steer.CFrame
        local var592 = Model_3.Steer.Size.X * 0.5 - 0.2
        local SteerOffset = arg1.SteerOffset
        local IK = arg1.IK
        local new_upvr_result1_2 = new_upvr(var592, 0.1, 0)
        if SteerOffset then
            new_upvr_result1_2 += SteerOffset
        end
        local new_upvr_result1 = new_upvr(-var592, 0.1, 0)
        if SteerOffset then
            new_upvr_result1 += SteerOffset
        end
        IK.RightArm = CFrame * new_upvr_result1_2
        IK.LeftArm = CFrame * new_upvr_result1
        IK.RightAngle = -var590 - 0.6
        IK.LeftAngle = -var590 + 0.6
        R15IKv2_upvr.Arms(IK)
    end
end
function module_upvr.UpdateForces(arg1, arg2, arg3) -- Line 2495
    for _, v_7 in arg1.Wheels do
        UpdateThruster_upvr(arg1, v_7, arg2, arg3)
    end
end
function module_upvr.Halt(arg1) -- Line 2501
    for _, v_8 in arg1.EngineThrusters do
        v_8.Drive.Force = Vector3.new(0, 0, 0)
        v_8.Friction.Force = Vector3.new(0, 0, 0)
    end
    arg1.Rotate.MaxTorque = Vector3.new(0, 0, 0)
end
function module_upvr.SpinOut(arg1, arg2) -- Line 2508
    arg1._spinOutLeft = arg2
    arg1._spinOutAt = os.clock()
end
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
local Missile_upvr = require(ReplicatedStorage.Game.Missile)
function module_upvr.AttemptFireMissile(arg1) -- Line 2513
    local Missiles = arg1.Missiles
    if not Missiles then
        return false
    end
    if LocalPlayer_upvr:GetAttribute("MissileCount") <= 0 then
        VehicleUtils_upvr.promptMissileBuy()
        return false
    end
    local tick_result1 = tick()
    local var605 = tick_result1 - Missiles.LastFire
    if var605 < 2 and 0 < var605 then
        return false
    end
    Missiles.LastFire = tick_result1
    local var606_upvr = Missiles.Parts[Missiles.i]
    var606_upvr.Transparency = 1
    delay(2, function() -- Line 2536
        var606_upvr.Transparency = 0
    end)
    local CFrame_3 = var606_upvr.CFrame
    local Velocity = var606_upvr.Velocity
    if Velocity.Magnitude < 0.01 then
        Velocity = Vector3.new(0, 0, 0)
    end
    local tbl_16 = {arg1.Model, LocalPlayer_upvr.Character}
    local _, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(CFrame_3.p, (arg1.Model.Engine.CFrame.LookVector * 60 - Vector3.new(0, 2, 0)).Unit, 999, tbl_16)
    local any_GetNowSync_result1 = Time_upvr.GetNowSync()
    var34_upvw:FireServer('j'.."zx9jetnh":sub(5, 5):reverse():reverse():reverse():reverse():reverse().."".."".."llt2ykuo":sub(3, 4):reverse():reverse():reverse():reverse():reverse().."".."".."lk8cq9ff8":sub(4, 6):reverse():reverse():reverse()..""..'3', CFrame_3, Velocity, any_RayIgnoreNonCollideWithIgnoreList_result2, any_GetNowSync_result1, "RocketPart2", 0)
    Missile_upvr.LaunchMissile(CFrame_3, Velocity, any_RayIgnoreNonCollideWithIgnoreList_result2, any_GetNowSync_result1, "RocketPart2", 0, tbl_16)
    Missiles.i = Missiles.i % #Missiles.Parts + 1
end
local tbl_18_upvr = {
    [Enum.KeyCode.A] = 2;
    [Enum.KeyCode.D] = 4;
    [Enum.KeyCode.Q] = 5;
    [Enum.KeyCode.E] = 6;
    [Enum.KeyCode.ButtonR2] = 1;
    [Enum.KeyCode.ButtonL2] = 3;
    [Enum.KeyCode.Left] = 2;
    [Enum.KeyCode.Right] = 4;
}
function module_upvr.LockCamera(arg1) -- Line 2569
    assert(not arg1.IsCameraLocked)
    local Model_2 = arg1.Model
    local InsideCamera_upvr = Model_2:FindFirstChild("InsideCamera")
    if InsideCamera_upvr == nil then
    else
        arg1.IsCameraLocked = true
        Model_2:SetAttribute("IsCameraLocked", true)
        CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
        arg1.seatMaid.cameraLockRenderStepped = RunService_upvr.RenderStepped:Connect(function() -- Line 2579
            CurrentCamera_upvr.CFrame = InsideCamera_upvr.CFrame
        end)
        arg1.seatMaid.cameraUnlock = function() -- Line 2582
            CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
        end
    end
end
function module_upvr.UnlockCamera(arg1) -- Line 2586
    assert(arg1.IsCameraLocked)
    arg1.IsCameraLocked = false
    arg1.Model:SetAttribute("IsCameraLocked", false)
    CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
    arg1.seatMaid.cameraLockRenderStepped = nil
    arg1.seatMaid.cameraUnlock = nil
end
function module_upvr.InputBegan(arg1) -- Line 2594
    if arg1.UserInputType == Enum.UserInputType.Keyboard then
        local KeyCode_3 = arg1.KeyCode
        if tbl_18_upvr[KeyCode_3] then
            var109_upvw[tbl_18_upvr[KeyCode_3]] = 1
        end
    end
end
function module_upvr.InputEnded(arg1) -- Line 2602
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local UserInputType = arg1.UserInputType
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var109_upvw[tbl_18_upvr[UserInputType]] = 0
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local function decompInlinedCondition_8() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        local KeyCode_2 = arg1.KeyCode
        return KeyCode_2 == Enum.KeyCode.ButtonR2
    end
    if arg1.UserInputType == Enum.UserInputType.Gamepad1 and (decompInlinedCondition_8() or KeyCode_2 == Enum.KeyCode.ButtonL2) then
        var109_upvw[tbl_18_upvr[KeyCode_2]] = 0
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.InputChanged(arg1) -- Line 2615
    if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
        local KeyCode = arg1.KeyCode
        local var624
        if KeyCode == Enum.KeyCode.Thumbstick1 then
            local X = arg1.Position.X
            local function decompInlinedCondition_9() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var624 = (-X) ^ 2
                return var624
            end
            if X >= -0.24 or not decompInlinedCondition_9() then
                var624 = 0
            end
            var109_upvw[2] = var624
            local function decompInlinedCondition_10() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var624 = X ^ 2
                return var624
            end
            if 0.24 >= X or not decompInlinedCondition_10() then
                var624 = 0
            end
            var109_upvw[4] = var624
            return
        end
        if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
            local Z = arg1.Position.Z
            var624 = tbl_18_upvr
            local function decompInlinedCondition_11() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var624 = Z ^ 0.5
                return var624
            end
            if 0.05 >= Z or not decompInlinedCondition_11() then
                var624 = 0
            end
            var109_upvw[var624[KeyCode]] = var624
        end
    end
end
function module_upvr.SetEvent(arg1) -- Line 2636
    var34_upvw = arg1
end
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local function Action_upvr(arg1, arg2) -- Line 2642, Named "Action"
    if arg2 then
        var34_upvw:FireServer('z'.."fo1v5iaw":sub(4, 5):reverse():reverse():reverse():reverse():reverse().."".."k4vr0", arg1.Part)
    end
    return true
end
for _, v_9 in ipairs(CollectionService:GetTagged("Firetruck_Ladder")) do
    CircleAction_upvr.Add({
        Part = v_9;
        Name = "Move Ladder";
        NoRay = true;
        Timed = true;
        Duration = 0.25;
        Dist = 10;
        Callback = Action_upvr;
    }, v_9)
    local _
end
CollectionService:GetInstanceAddedSignal("Firetruck_Ladder"):Connect(function(arg1) -- Line 2649, Named "AddedFun"
    local tbl_19 = {}
    tbl_19.Part = arg1
    tbl_19.Name = "Move Ladder"
    tbl_19.NoRay = true
    tbl_19.Timed = true
    tbl_19.Duration = 0.25
    tbl_19.Dist = 10
    tbl_19.Callback = Action_upvr
    CircleAction_upvr.Add(tbl_19, arg1)
end)
CollectionService:GetInstanceRemovedSignal("Firetruck_Ladder"):Connect(function(arg1) -- Line 2661, Named "RemovedFun"
    CircleAction_upvr.Remove(arg1)
end)
return module_upvr