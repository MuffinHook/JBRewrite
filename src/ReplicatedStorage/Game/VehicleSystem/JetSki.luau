local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local R15IKv2_upvr = require(ReplicatedStorage.Module.R15IKv2)
local ConstraintUtils_upvr = require(ReplicatedStorage.Std.ConstraintUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local function GetMoveVector_upvw() -- Line 21, Named "GetMoveVector"
    return Vector3.new()
end
local ControlModule = LocalPlayer_upvr.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
    local var6_2_upvw = require(ControlModule)
    function GetMoveVector_upvw() -- Line 28, Named "GetMoveVector"
        return var6_2_upvw:GetMoveVector()
    end
end
local function SetHumanoidEnabled_upvr(arg1, arg2) -- Line 34, Named "SetHumanoidEnabled"
    for _, v in next, Enum.HumanoidStateType:GetEnumItems() do
        if v ~= Enum.HumanoidStateType.Dead and v ~= Enum.HumanoidStateType.None and v ~= Enum.HumanoidStateType.Jumping then
            arg1:SetStateEnabled(v, arg2)
        end
    end
end
local function _(arg1) -- Line 45, Named "MakeSound"
    local Sound_2 = Instance.new("Sound")
    Sound_2.Volume = 0
    Sound_2.SoundId = "rbxassetid://"..arg1
    Sound_2.Looped = true
    Sound_2.EmitterSize = 10
    Sound_2.MaxDistance = 160
    return Sound_2
end
local module_upvr = {
    __ClassName = "JetSki";
}
module_upvr.__index = module_upvr
local Maid_2_upvr = require(ReplicatedStorage.Std.Maid)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.FromPacket(arg1) -- Line 59
    setmetatable(arg1, module_upvr)
    assert(arg1.Id)
    assert(arg1.Model)
    assert(arg1.Seats)
    local Engine = arg1.Model.Physics.Engine
    arg1.BodyGyro = Engine.BodyGyro
    arg1.VectorForce = Engine.VectorForce
    arg1.EnginePart = Engine
    arg1.BoundingBox = arg1.Model.BoundingBox
    arg1.Maid = Maid_2_upvr.new()
    arg1.maid = arg1.Maid
    local var18_upvw = false
    arg1.maid:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 76
        local any_GetAreTiresPopped_result1 = arg1:GetAreTiresPopped()
        if any_GetAreTiresPopped_result1 ~= var18_upvw then
            arg1.Model:FindFirstChild("Model"):FindFirstChild("Body"):FindFirstChild("Smoke").Enabled = any_GetAreTiresPopped_result1
        end
        var18_upvw = any_GetAreTiresPopped_result1
    end))
    return arg1
end
local BoatConsts_upvr = require(ReplicatedStorage.Game.Boat.BoatConsts)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
function module_upvr.GetAreTiresPopped(arg1) -- Line 87
    local var22 = "JetSki"
    if workspace:GetServerTimeNow() >= (arg1.Model:GetAttribute(BoatConsts_upvr.TIRES_POPPED_AT_ATTR_NAME) or 0) + VehicleUtils_upvr.getVehicleCombatConfig(var22).DisableDuration then
        var22 = false
    else
        var22 = true
    end
    return var22
end
function module_upvr.GetSeatFromPlayer(arg1, arg2) -- Line 93
    assert(arg2)
    for i_2 = 1, #arg1.Seats do
        local var24 = arg1.Seats[i_2]
        if var24.Occupied and var24.Player == arg2 then
            return var24
        end
    end
    return false
end
local function UpdateArms_upvr(arg1, arg2) -- Line 105, Named "UpdateArms"
    local IKP = arg2.IKP
    if arg1.Model:IsDescendantOf(workspace) then
        local Steering = arg1.Model.Model.Steering
        IKP.RightArm = Steering.CFrame * Vector3.new(1.20000, 0.60000, 1.10000)
        IKP.LeftArm = Steering.CFrame * Vector3.new(-1.2000, 0.60000, 1.10000)
        ConstraintUtils_upvr.setJointC1(IKP.RightWrist, CFrame.Angles(0, (-math.pi/2), 0))
        ConstraintUtils_upvr.setJointC1(IKP.LeftWrist, CFrame.Angles(0, (math.pi/2), 0))
        R15IKv2_upvr.Arms(IKP)
    end
end
local function UpdateForces_upvr(arg1, arg2, arg3) -- Line 116, Named "UpdateForces"
    local EnginePart = arg1.EnginePart
    local CFrame_3 = EnginePart.CFrame
    local var30
    if not arg1.BuoyancySensor then
        local BuoyancySensor = Instance.new("BuoyancySensor")
        BuoyancySensor.Parent = arg1.BoundingBox
        arg1.BuoyancySensor = BuoyancySensor
        arg1.maid.sensor = BuoyancySensor
    end
    local TouchingSurface = BuoyancySensor.TouchingSurface
    local Magnitude_2 = EnginePart.Velocity.Magnitude
    var30 = arg1.Model:IsDescendantOf(workspace)
    local var34
    if var30 then
        var30 = arg1.Model
        var30 = var30.Skeleton
        var34 = TouchingSurface
        if var34 then
            if 20 >= Magnitude_2 then
                var34 = false
            else
                var34 = true
            end
        end
        var30.JetEmitter.Particle.Enabled = var34
        if TouchingSurface then
            if 50 >= Magnitude_2 then
            else
            end
        end
        var30.MistEmitter.Particle.Enabled = true
        if TouchingSurface then
            if 100 >= Magnitude_2 then
            else
            end
        end
        var30.WakeEmitter.Particle.Enabled = true
    end
    var30 = 0
    if 0 < arg2 then
        var30 = -6000 * arg2
    elseif arg2 < 0 then
        var30 = -1000 * arg2
    end
    if TouchingSurface == false then
        var30 *= 0.3
    end
    if arg1:GetAreTiresPopped() then
        var30 *= 0.05
    end
    arg1.VectorForce.Force = Vector3.new(0, 0, var30)
    local var35 = 0
    arg1.BodyGyro.CFrame = CFrame.new(Vector3.new(), CFrame_3.LookVector) * CFrame.Angles(var35, 0, arg3 * math.pi * 0.2) + CFrame_3.p
    local any_VectorToObjectSpace_result1 = CFrame_3:VectorToObjectSpace(EnginePart.RotVelocity)
    if TouchingSurface then
        var35 = 1
    else
        var35 = 0.8
    end
    local vector3 = Vector3.new(any_VectorToObjectSpace_result1.X * var35, any_VectorToObjectSpace_result1.Y * 0.9 + arg3 * 0.3, any_VectorToObjectSpace_result1.Z)
    EnginePart.RotVelocity = CFrame_3:VectorToWorldSpace(vector3)
    return vector3
end
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local UserInputService_upvr = game:GetService("UserInputService")
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
local function MountLocalPlayer_upvr(arg1, arg2, arg3) -- Line 164, Named "MountLocalPlayer"
    assert(arg2)
    assert(arg3)
    local Character_2 = arg2.Character
    assert(Character_2)
    local Humanoid_2 = Character_2:FindFirstChild("Humanoid")
    assert(Humanoid_2)
    SetHumanoidEnabled_upvr(Humanoid_2, false)
    Humanoid_2:ChangeState(Enum.HumanoidStateType.PlatformStanding)
    local Neck_upvr = Character_2.Head.Neck
    local cframe_upvr = CFrame.new(Neck_upvr.C1.p)
    local Waist_upvr = Character_2.UpperTorso.Waist
    local cframe_upvr_2 = CFrame.new(Waist_upvr.C1.p)
    local Maid = arg3.Maid
    local function Stepped() -- Line 184
        UpdateArms_upvr(arg1, arg3)
    end
    Maid:GiveTask(RunService_upvr.Stepped:Connect(Stepped))
    local tbl_upvr = {0, 0, 0, 0}
    local tbl_upvr_2 = {
        [Enum.KeyCode.A] = 2;
        [Enum.KeyCode.D] = 4;
        [Enum.KeyCode.ButtonR2] = 1;
        [Enum.KeyCode.ButtonL2] = 3;
    }
    local any_new_result1_upvr = Spring_upvr.new(0, 0, 0.9, 30)
    local any_new_result1_upvr_2 = Spring_upvr.new(0, 0, 0.6, 10)
    Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 198, Named "Heartbeat"
        local var53 = tbl_upvr[1] - tbl_upvr[3]
        local var54 = tbl_upvr[2] - tbl_upvr[4]
        if InputUtils_upvr.isTouch() then
            local clamped = math.clamp(GetMoveVector_upvw().X, -1, 1)
            var54 = -clamped * math.abs(clamped)
        end
        local any_SetTarget_result1 = any_new_result1_upvr:SetTarget(UpdateForces_upvr(arg1, var53, var54).Y * 0.3)
        local any_SetTarget_result1_2 = any_new_result1_upvr_2:SetTarget(var53)
        ConstraintUtils_upvr.setJointC1(Waist_upvr, cframe_upvr_2 * CFrame.Angles(-any_SetTarget_result1_2 * 0.15 + math.abs(any_SetTarget_result1) * 0.2, -any_SetTarget_result1 * 0.5, 0))
        ConstraintUtils_upvr.setJointC1(Neck_upvr, cframe_upvr * CFrame.Angles(-0.6283185307179586 + any_SetTarget_result1_2 * 0.3 - math.abs(any_SetTarget_result1) * 0.3, 0, 0) * CFrame.Angles(0, -any_SetTarget_result1 * 0.1, 0))
        local SteeringMotor = arg3.SteeringMotor
        SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, any_SetTarget_result1 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
        if arg3.Driver then
            local LowSound = arg1.LowSound
            local Magnitude = arg1.EnginePart.Velocity.Magnitude
            arg1.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
            LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
            LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
        end
    end))
    Maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2_2) -- Line 237, Named "InputBegan"
        if arg2_2 then
            return true
        end
        if arg1_2.UserInputType == Enum.UserInputType.Keyboard and tbl_upvr_2[arg1_2.KeyCode] then
            tbl_upvr[tbl_upvr_2[arg1_2.KeyCode]] = 1
        end
    end))
    Maid:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_3, arg2_3) -- Line 248, Named "InputEnded"
        if arg2_3 then
            return true
        end
        if arg1_3.UserInputType == Enum.UserInputType.Keyboard and tbl_upvr_2[arg1_3.KeyCode] then
            tbl_upvr[tbl_upvr_2[arg1_3.KeyCode]] = 0
        end
    end))
    Maid:GiveTask(UserInputService_upvr.InputChanged:Connect(function(arg1_4) -- Line 259, Named "InputChanged"
        if arg1_4.UserInputType == Enum.UserInputType.Gamepad1 then
            local KeyCode = arg1_4.KeyCode
            local var62
            if KeyCode == Enum.KeyCode.Thumbstick1 then
                local X = arg1_4.Position.X
                local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var62 = (-X) ^ 2
                    return var62
                end
                if X >= -0.24 or not decompInlinedCondition() then
                    var62 = 0
                end
                tbl_upvr[2] = var62
                local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var62 = X ^ 2
                    return var62
                end
                if 0.24 >= X or not decompInlinedCondition_2() then
                    var62 = 0
                end
                tbl_upvr[4] = var62
                return
            end
            if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
                local Z = arg1_4.Position.Z
                var62 = tbl_upvr_2
                local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var62 = Z ^ 0.5
                    return var62
                end
                if 0.05 >= Z or not decompInlinedCondition_3() then
                    var62 = 0
                end
                tbl_upvr[var62[KeyCode]] = var62
            end
        end
    end))
    local tbl = {
        primary = true;
        priority = 1000;
        saturateTo = 0;
        image = "rbxassetid://7858765663";
        keyCodes = {Enum.KeyCode.W};
    }
    local function onPressed() -- Line 284
        tbl_upvr[1] = 1
    end
    tbl.onPressed = onPressed
    local function onReleased() -- Line 287
        tbl_upvr[1] = 0
    end
    tbl.onReleased = onReleased
    arg3.Maid:GiveTask(ActionButtonService_upvr.add(tbl))
    arg3.Maid:GiveTask(ActionButtonService_upvr.add({
        primary = true;
        priority = 700;
        saturateTo = 0;
        image = "rbxassetid://7858764373";
        keyCodes = {Enum.KeyCode.S};
        onPressed = function() -- Line 297, Named "onPressed"
            tbl_upvr[3] = 1
        end;
        onReleased = function() -- Line 300, Named "onReleased"
            tbl_upvr[3] = 0
        end;
    }))
    arg1.NeckC1 = cframe_upvr
    arg1.WaistC1 = cframe_upvr_2
end
local function _(arg1, arg2, arg3) -- Line 308, Named "MountThirdPlayer"
    assert(arg2)
    assert(arg3)
    local EnginePart_upvr = arg1.EnginePart
    local function Stepped() -- Line 314
        UpdateArms_upvr(arg1, arg3)
        local SteeringMotor_5 = arg3.SteeringMotor
        SteeringMotor_5.C1 = SteeringMotor_5.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, EnginePart_upvr.CFrame:VectorToObjectSpace(EnginePart_upvr.RotVelocity).Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor_5.C0
        if arg3.Driver then
            local LowSound_2 = arg1.LowSound
            local Magnitude_4 = arg1.EnginePart.Velocity.Magnitude
            arg1.IdleSound.Volume = math.exp(-Magnitude_4 / 50) * 0.5
            LowSound_2.Volume = (1 - math.exp(-Magnitude_4 / 50)) * 0.5
            LowSound_2.PlaybackSpeed = 1 - math.exp(-Magnitude_4 / 50)
        end
    end
    arg3.Maid:GiveTask(RunService_upvr.Stepped:Connect(Stepped))
end
function module_upvr.MountPlayer(arg1, arg2, arg3) -- Line 339
    assert(arg2)
    assert(arg3)
    if arg3.Driver then
        local Character_4 = arg2.Character
        assert(Character_4)
        local any_BuildPacketArms_result1 = R15IKv2_upvr.BuildPacketArms(Character_4)
        arg3.IKP = any_BuildPacketArms_result1
        arg3.RightWristC1 = any_BuildPacketArms_result1.RightWrist.C1
        arg3.LeftWristC1 = any_BuildPacketArms_result1.LeftWrist.C1
        local Sound = Instance.new("Sound")
        Sound.Volume = 0
        Sound.SoundId = "rbxassetid://"..657590761
        Sound.Looped = true
        Sound.EmitterSize = 10
        Sound.MaxDistance = 160
        local var77 = Sound
        local Sound_3 = Instance.new("Sound")
        Sound_3.Volume = 0
        Sound_3.SoundId = "rbxassetid://"..657591400
        Sound_3.Looped = true
        Sound_3.EmitterSize = 10
        Sound_3.MaxDistance = 160
        local var79 = Sound_3
        var77.Parent = arg1.EnginePart
        var79.Parent = arg1.EnginePart
        arg1.IdleSound = var77
        arg1.LowSound = var79
        arg1.IdleSound:Play()
        arg1.LowSound:Play()
    end
    if arg2 == LocalPlayer_upvr then
        MountLocalPlayer_upvr(arg1, arg2, arg3)
    else
        assert(arg2)
        assert(arg3)
        local EnginePart_2_upvr = arg1.EnginePart
        arg3.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 314, Named "Stepped"
            UpdateArms_upvr(arg1, arg3)
            local SteeringMotor_3 = arg3.SteeringMotor
            SteeringMotor_3.C1 = SteeringMotor_3.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, EnginePart_2_upvr.CFrame:VectorToObjectSpace(EnginePart_2_upvr.RotVelocity).Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor_3.C0
            if arg3.Driver then
                local LowSound_3 = arg1.LowSound
                local Magnitude_3 = arg1.EnginePart.Velocity.Magnitude
                arg1.IdleSound.Volume = math.exp(-Magnitude_3 / 50) * 0.5
                LowSound_3.Volume = (1 - math.exp(-Magnitude_3 / 50)) * 0.5
                LowSound_3.PlaybackSpeed = 1 - math.exp(-Magnitude_3 / 50)
            end
        end))
    end
end
local function UnmountLocalPlayer_upvr(arg1, arg2, arg3) -- Line 369, Named "UnmountLocalPlayer"
    assert(arg2)
    assert(arg3)
    local Character_3 = arg2.Character
    if Character_3 then
        if Character_3:IsDescendantOf(workspace) then
            local Humanoid = Character_3:FindFirstChild("Humanoid")
            if Humanoid then
                SetHumanoidEnabled_upvr(Humanoid, true)
                Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                local Head = Character_3:FindFirstChild("Head")
                if Head then
                    local Neck_2 = Head:FindFirstChild("Neck")
                    if Neck_2 then
                        ConstraintUtils_upvr.setJointC1(Neck_2, arg1.NeckC1)
                    end
                end
                local UpperTorso = Character_3:FindFirstChild("UpperTorso")
                if UpperTorso then
                    local Waist_2 = UpperTorso:FindFirstChild("Waist")
                    if Waist_2 then
                        ConstraintUtils_upvr.setJointC1(Waist_2, arg1.WaistC1)
                    end
                end
            end
        end
    end
    if arg3.Driver then
        local IKP_2 = arg3.IKP
        if IKP_2 then
            ConstraintUtils_upvr.setJointC1(IKP_2.RightWrist, arg3.RightWristC1)
            ConstraintUtils_upvr.setJointC1(IKP_2.LeftWrist, arg3.LeftWristC1)
        end
    end
    arg1.WaistC1 = nil
    arg1.NeckC1 = nil
    local CFrame = arg1.EnginePart.CFrame
    arg1.VectorForce.Force = Vector3.new(0, 0, 0)
    arg1.BodyGyro.CFrame = CFrame.new(Vector3.new(), CFrame.LookVector) + CFrame.p
    local SteeringMotor_4 = arg3.SteeringMotor
    SteeringMotor_4.C1 = SteeringMotor_4.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.new(0, 0, 0.6) * SteeringMotor_4.C0
    if arg1.Model:IsDescendantOf(workspace) then
        local Skeleton_2 = arg1.Model.Skeleton
        Skeleton_2.JetEmitter.Particle.Enabled = false
        Skeleton_2.MistEmitter.Particle.Enabled = false
        Skeleton_2.WakeEmitter.Particle.Enabled = false
    end
end
function module_upvr.UnmountPlayer(arg1, arg2, arg3) -- Line 429
    assert(arg2)
    local var103
    if var103 == nil then
        var103 = arg1:GetSeatFromPlayer(arg2)
    end
    local var104 = var103
    assert(var104)
    if var103.Occupied ~= true then
        var104 = false
    else
        var104 = true
    end
    assert(var104)
    if var103.Driver then
        if arg1.IdleSound then
            arg1.IdleSound:Destroy()
            arg1.IdleSound = nil
        end
        if arg1.LowSound then
            arg1.LowSound:Destroy()
            arg1.LowSound = nil
        end
    end
    if arg2 == LocalPlayer_upvr then
        UnmountLocalPlayer_upvr(arg1, arg2, var103)
    end
end
function module_upvr.UnmountSeat(arg1, arg2) -- Line 451
    local var105 = arg2
    assert(var105)
    if arg2.Occupied ~= true then
        var105 = false
    else
        var105 = true
    end
    assert(var105)
    return arg1:UnmountPlayer(arg2.Player, arg2)
end
function module_upvr.Destroy(arg1) -- Line 477
    for i_3 = 1, #arg1.Seats do
        local var107 = arg1.Seats[i_3]
        if var107.Occupied then
            arg1:UnmountSeat(var107)
        end
    end
    arg1.Maid:Destroy()
end
return module_upvr