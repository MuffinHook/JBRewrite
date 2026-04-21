local CurrentCamera_upvr = workspace.CurrentCamera
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local RunService_upvr = game:GetService("RunService")
local UserInputService_upvr = game:GetService("UserInputService")
local var5_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local WheelWorld_upvr = require(ReplicatedStorage_upvr.Module.Wheel.WheelWorld)
local random_state_upvr = Random.new()
local function _(arg1) -- Line 46, Named "RandomVector"
    return Vector3.new(arg1 * (random_state_upvr:NextNumber() * 2 - 1), arg1 * (random_state_upvr:NextNumber() * 2 - 1), arg1 * (random_state_upvr:NextNumber() * 2 - 1))
end
local function SetHumanoidEnabled_upvr(arg1, arg2) -- Line 53, Named "SetHumanoidEnabled"
    for _, v in next, Enum.HumanoidStateType:GetEnumItems() do
        if v ~= Enum.HumanoidStateType.Dead and v ~= Enum.HumanoidStateType.None and v ~= Enum.HumanoidStateType.Jumping then
            arg1:SetStateEnabled(v, arg2)
        end
    end
end
local module_upvr = {
    __ClassName = "BaseUserControlledPlane";
}
module_upvr.__index = module_upvr
function module_upvr.Init() -- Line 68
    var5_upvw = require(LocalPlayer_upvr.PlayerScripts:WaitForChild("PlayerModule"))
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
function module_upvr.new(arg1, arg2) -- Line 71
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Id = arg1.Id
    assert(setmetatable_result1.Id)
    setmetatable_result1.Mass = arg1.Mass
    setmetatable_result1.Maid = Maid_upvr.new()
    setmetatable_result1.Model = arg1.Model
    local Wing = setmetatable_result1.Model.Skeleton.Wing
    local Thrust = setmetatable_result1.Model.Skeleton.Thrust
    setmetatable_result1.PartBoundingBox = setmetatable_result1.Model.BoundingBox
    setmetatable_result1.PartWing = Wing
    setmetatable_result1.WingVectorForce = Wing.VectorForce
    setmetatable_result1.WingAngularVelocity = Wing.AngularVelocity
    setmetatable_result1.PartThrust = Thrust
    setmetatable_result1.ThrustVectorForce = Thrust.VectorForce
    setmetatable_result1.AreaWing = Wing.Size.X * Wing.Size.Z
    setmetatable_result1.Seats = {}
    setmetatable_result1:SetupSeats()
    setmetatable_result1.CorrectingRoll = false
    setmetatable_result1.CorrectingRollFlag = false
    setmetatable_result1.OnTakeoff = nil
    setmetatable_result1.OnLanding = nil
    local tbl_10 = {
        GRAVITY = 196.20000000000002;
        ANGULAR_MAXTORQUE_FLYING = 100000000;
        ANGULAR_MAXTORQUE_LANDING = 1000;
        COEFFICIENT_DRAG = 0.8;
        ROLL_ADJUSTMENT_TIMER = 0.1;
        JOYSTICK_RECENTER_MULTIPLIER = 0.95;
        MAX_THRUST = 700;
        CAMERA_SHAKE_MIN_GS = 1.5;
        CAMERA_SHAKE_COEFF_GS = 1;
        CAMERA_OFFSET_CF = CFrame.new(0, 8, 25);
        SOUND_RUMBLE_COEFF_GS = 0.3333333333333333;
        SOUND_BREATHING_MIN_GS = 1;
        SOUND_BREATHING_TIMER = 2;
        SOUND_BREATHING_DURATION = 3;
        SUSPENSION_HEIGHT_FRONT = 5;
        SUSPENSION_HEIGHT_BACK = 4;
        WHEEL_VISUAL_RADIUS_FRONT = 0.83;
        WHEEL_VISUAL_RADIUS_BACK = 0.83;
        THROTTLE_WHEEL_TURN_MIN = 0.2;
        THROTTLE_TAKEOFF = 0.4;
        HEIGHT_MAX = 5000;
    }
    if arg2 then
        for i_2, v_2 in next, arg2 do
            assert(tbl_10[i_2], i_2)
            tbl_10[i_2] = v_2
        end
    end
    setmetatable_result1.CONST = tbl_10
    setmetatable_result1.Joystickx = 0
    setmetatable_result1.Joysticky = 0
    setmetatable_result1.InputYaw = 0
    setmetatable_result1.Throttle = 0
    setmetatable_result1._controlsEnabled = true
    return setmetatable_result1
end
function module_upvr.SetupSeats(arg1) -- Line 148
    table.insert(arg1.Seats, {
        Part = arg1.Model:FindFirstChild("Seat");
        Driver = true;
    })
end
function module_upvr.SetParticlesEnabled(arg1, arg2) -- Line 154
    if not arg1.Model then
    else
        local Particles = arg1.Model:FindFirstChild("Particles")
        if Particles then
            for _, v_3 in next, Particles:GetChildren() do
                v_3:FindFirstChildOfClass("ParticleEmitter").Enabled = arg2
            end
        end
    end
end
local CharacterAnim_upvr = require(ReplicatedStorage_upvr.Game.CharacterAnim)
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local DoorConsts_upvr = require(ReplicatedStorage_upvr.Door2.DoorConsts)
local InputUtils_upvr = require(ReplicatedStorage_upvr.Std.InputUtils)
local abs_upvr = math.abs
local Wheel_upvr = require(ReplicatedStorage_upvr.Module.Wheel.Wheel)
local ActionButtonService_upvr = require(ReplicatedStorage_upvr.ActionButton.ActionButtonService)
local DefaultActions_upvr = require(ReplicatedStorage_upvr.Game.DefaultActions)
local function MountLocalPlayer_upvr(arg1, arg2) -- Line 166, Named "MountLocalPlayer"
    local any_getCarSitTrack_result1_upvr_2 = CharacterAnim_upvr.getCarSitTrack()
    any_getCarSitTrack_result1_upvr_2:Play()
    arg2.Maid:GiveTask(function() -- Line 171
        any_getCarSitTrack_result1_upvr_2:Stop()
    end)
    any_getCarSitTrack_result1_upvr_2 = LocalPlayer_upvr
    any_getCarSitTrack_result1_upvr_2 = any_getCarSitTrack_result1_upvr_2.Character
    local var130 = any_getCarSitTrack_result1_upvr_2
    if var130 then
        local Humanoid_4 = var130:FindFirstChild("Humanoid")
        if Humanoid_4 then
            SetHumanoidEnabled_upvr(Humanoid_4, false)
            Humanoid_4:ChangeState(Enum.HumanoidStateType.Seated)
        end
    end
    if not arg2.Driver then
    else
        local any_new_result1_7_upvr = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.8, 30)
        local any_new_result1_13_upvr = Spring_upvr.new(0, 0, 0.6, 5)
        local any_new_result1_2_upvr = Spring_upvr.new(0, 0, 0.7, 5)
        local any_new_result1_16_upvr = Spring_upvr.new(0, 0, 0.95, 15)
        arg2.CameraSpring = any_new_result1_7_upvr
        local clone_upvw = ReplicatedStorage_upvr.Resource.Plane.PlaneGui:Clone()
        clone_upvw.Parent = LocalPlayer_upvr.PlayerGui
        arg1.PlaneGui = clone_upvw
        local any_ObjectLocal_result1_upvr_4 = Audio_upvr.ObjectLocal(clone_upvw, 3378049562, {
            Looped = true;
            Volume = 0;
            Pitch = 1;
        })
        arg1.SoundRumble = any_ObjectLocal_result1_upvr_4
        local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(clone_upvw, 3378078999, {
            Looped = true;
            Volume = 1.25;
        })
        arg1.SoundWind = any_ObjectLocal_result1_upvr
        local any_ObjectLocal_result1_upvr_2 = Audio_upvr.ObjectLocal(clone_upvw, 9058670257, {
            Looped = true;
            Volume = 0;
        })
        arg1.SoundBreathing = any_ObjectLocal_result1_upvr_2
        local var143_upvw = 0
        local tbl_9_upvr = {0, 0, 0, 0}
        local tick_result1_upvw_2 = tick()
        local var146_upvw = true
        local var147_upvw = 0
        local var148_upvw = 0
        if VehicleUtils_upvr.getTireHealth(arg1.Model) <= 0 then
            var143_upvw = 0
        end
        arg2.Maid:GiveTask(VehicleUtils_upvr.getTireHealthChangedSignal(arg1.Model):Connect(function() -- Line 223, Named "updatePlaneHealth"
            if VehicleUtils_upvr.getTireHealth(arg1.Model) <= 0 then
                var143_upvw = 0
            end
        end))
        arg1.IsFlying = false
        local function RunTakeoff_upvr() -- Line 235, Named "RunTakeoff"
            arg1.IsFlying = true
            arg1.Model:FindFirstChild("SetIsFlyingRemote"):FireServer(arg1.IsFlying)
            if arg1.OnTakeoff then
                arg1.OnTakeoff()
            end
            Audio_upvr.ObjectLocal(clone_upvw, 3382610090)
            for _, v_4 in next, arg1.WheelsConf do
                v_4.Wheel:Clear()
                v_4.Motor.C0 = CFrame.new()
            end
            any_new_result1_13_upvr:SetTarget(1)
            arg1.WingAngularVelocity.MaxTorque = arg1.CONST.ANGULAR_MAXTORQUE_FLYING
            clone_upvw.Controls.Mouse.Visible = true
            clone_upvw.Controls.Altitude.Visible = true
            arg1:SetParticlesEnabled(true)
        end
        local function RunLanding_upvr() -- Line 254, Named "RunLanding"
            if arg1.IsFlying then
                Audio_upvr.ObjectLocal(clone_upvw, 3382610090)
            end
            arg1.IsFlying = false
            arg1.Model:FindFirstChild("SetIsFlyingRemote"):FireServer(arg1.IsFlying)
            if arg1.OnLanding then
                arg1.OnLanding()
            end
            any_new_result1_13_upvr:SetTarget(0)
            arg1.WingAngularVelocity.MaxTorque = arg1.CONST.ANGULAR_MAXTORQUE_LANDING
            clone_upvw.Controls.Mouse.Visible = false
            clone_upvw.Controls.Altitude.Visible = false
            arg1:SetParticlesEnabled(false)
        end
        local zero_vector3_upvw = Vector3.new()
        local function HeartbeatWing_upvr(arg1_18) -- Line 271, Named "HeartbeatWing"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local PartWing = arg1.PartWing
            local CFrame = PartWing.CFrame
            local arcsine_2 = math.asin(CFrame.LookVector.Y)
            if arcsine_2 ~= arcsine_2 then
                arcsine_2 = 0
            end
            local arcsine = math.asin(CFrame.RightVector.Y)
            if arcsine ~= arcsine then
                arcsine = 0
            end
            arg1.ObservedPitch = arcsine_2
            arg1.ObservedRoll = arcsine
            if not arg1.IsFlying or not arg1.CONST.COEFFICIENT_DRAG then
            end
            local Velocity = PartWing.Velocity
            if not arg1.IsFlying or not (math.cos(arcsine_2) * 0.95) then
            end
            if 0.001 < Velocity:Dot(Velocity) then
            else
            end
            arg1.WingVectorForce.Force = Vector3.new(0, 0, 0)
            local any_Update_result1_3 = any_new_result1_16_upvr:Update()
            local var159 = 0
            if arg1.IsFlying then
                var159 = arg1.InputYaw * 0.5
            end
            arg1.WingAngularVelocity.AngularVelocity = Vector3.new(var148_upvw * 3 * (1 + -0.9 * any_Update_result1_3), var159, var147_upvw * 2.5 * (1 + 2 * any_Update_result1_3))
            arg1.ObservedAcceleration = ((Velocity - zero_vector3_upvw) / arg1_18).Magnitude
            zero_vector3_upvw = Velocity
        end
        local var160_upvw = 0
        local function HeartbeatThrust_upvr(arg1_19) -- Line 323, Named "HeartbeatThrust"
            local CFrame_2 = arg1.PartThrust.CFrame
            local var162
            local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var162 = var143_upvw / 3
                return var162
            end
            if var143_upvw >= 0.3333333333333333 or not decompInlinedCondition_4() then
                var162 = var143_upvw * var143_upvw
            end
            local tick_result1_6 = tick()
            if arg1.CONST.HEIGHT_MAX < CFrame_2.Y then
                var162 = 0
                var160_upvw = tick_result1_6
            end
            if tick_result1_6 - var160_upvw < 5 then
                var162 = 0
            end
            arg1.ThrustVectorForce.Force = (CFrame_2.LookVector * arg1.Mass) * (var162 * arg1.CONST.MAX_THRUST)
        end
        local var164_upvw = 0
        local var165_upvw = 0
        local function HeartbeatSounds_upvr(arg1_20) -- Line 341, Named "HeartbeatSounds"
            local var166 = arg1.ObservedAcceleration / arg1.CONST.GRAVITY
            if arg1.IsFlying == false then
                var166 = 0
            end
            local var167 = 1 - math.exp(-var166 * arg1.CONST.SOUND_RUMBLE_COEFF_GS)
            any_ObjectLocal_result1_upvr_4.Volume = var167 * 2
            any_ObjectLocal_result1_upvr.Volume = (1.25 - var167 * 0.2) * (0.2 + 0.8 * any_new_result1_13_upvr:Update())
            if arg1.CONST.SOUND_BREATHING_MIN_GS < var166 then
                var164_upvw += arg1_20
            else
                var164_upvw = 0
            end
            if arg1.CONST.SOUND_BREATHING_TIMER < var164_upvw then
                var165_upvw = arg1.CONST.SOUND_BREATHING_DURATION
            end
            var165_upvw -= arg1_20
            if 0 < var165_upvw then
                any_ObjectLocal_result1_upvr_2.Volume = (1 - math.exp(-var165_upvw)) * 0.4
            end
        end
        local function HeartbeatWheels(arg1_21) -- Line 383
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            if arg1.IsFlying ~= false then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [16.6]
            local var168
            if nil.Front then
                local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var168 = any_new_result1_2_upvr:Update() * math.pi * 0.2
                    return var168
                end
                if var143_upvw >= arg1.CONST.THROTTLE_WHEEL_TURN_MIN or not decompInlinedCondition_5() then
                end
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                local _, any_Update_result2_2 = nil.Wheel:Update(arg1_21, 0)
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if nil.DoorModel then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    if nil.DoorModel:GetAttribute(DoorConsts_upvr.OPEN_ATTR_NAME) == true then
                        any_Update_result2_2 = 0
                    end
                end
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                nil.Motor.C0 = CFrame.Angles(-any_Update_result2_2, -0, 0) * CFrame.new(0, -0, 0)
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                nil.MotorArm.C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0) * nil.ArmOffset
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        end
        local tick_result1_upvw = tick()
        local function HeartbeatControls_upvr(arg1_22) -- Line 404, Named "HeartbeatControls"
            local tick_result1_5 = tick()
            local var173 = tbl_9_upvr[1] - tbl_9_upvr[3]
            if VehicleUtils_upvr.getTireHealth(arg1.Model) <= 0 then
                var173 = 0
            end
            if InputUtils_upvr.isTouch() then
                local any_GetMoveVector_result1 = var5_upvw:GetControls():GetMoveVector()
                if 1 < any_GetMoveVector_result1.Magnitude then
                    any_GetMoveVector_result1 = any_GetMoveVector_result1.Unit
                end
                var147_upvw = -any_GetMoveVector_result1.X
                var148_upvw = -any_GetMoveVector_result1.Z
            else
            end
            if 0 < var173 then
                var143_upvw += arg1_22 * 0.2
                tick_result1_upvw = tick_result1_5
            elseif var173 < 0 then
                var143_upvw -= arg1_22 * 0.2
                tick_result1_upvw = tick_result1_5
            end
            if 1 < tick_result1_5 - tick_result1_upvw then
                if arg1.CONST.THROTTLE_TAKEOFF < var143_upvw then
                elseif 0.15 < var143_upvw then
                    var143_upvw -= arg1_22 * 0.1
                end
            end
            if var143_upvw < -0.06666666666666667 then
                var143_upvw = -0.06666666666666667
            end
            if 1 < var143_upvw then
                var143_upvw = 1
            end
            local var175
            if var143_upvw < arg1.CONST.THROTTLE_TAKEOFF and arg1.CONST.THROTTLE_TAKEOFF <= var143_upvw then
                RunTakeoff_upvr()
            elseif arg1.CONST.THROTTLE_TAKEOFF < var143_upvw and var143_upvw <= arg1.CONST.THROTTLE_TAKEOFF then
                RunLanding_upvr()
            end
            var143_upvw = var143_upvw
            local var176 = tick_result1_upvw_2
            local var177 = tick_result1_5 - var176
            if arg1.CONST.ROLL_ADJUSTMENT_TIMER >= var177 then
                var176 = false
            else
                var176 = true
            end
            if var176 then
                var147_upvw += -arg1.ObservedRoll * 0.1 * (1 - math.exp(-(var177 - arg1.CONST.ROLL_ADJUSTMENT_TIMER)))
            end
            if var146_upvw then
                var147_upvw *= arg1.CONST.JOYSTICK_RECENTER_MULTIPLIER
                var148_upvw *= arg1.CONST.JOYSTICK_RECENTER_MULTIPLIER
            end
            if var147_upvw < -1 then
                var147_upvw = -1
            end
            if 1 < var147_upvw then
                var147_upvw = 1
            end
            if var148_upvw < -1 then
                var148_upvw = -1
            end
            if 1 < var148_upvw then
                var148_upvw = 1
            end
            if var175 < -1 then
                var175 = -1
            end
            if 1 < var175 then
                var175 = 1
            end
            arg1.Joystickx = var147_upvw
            arg1.Joysticky = var148_upvw
            arg1.InputYaw = var175
            arg1.Throttle = var143_upvw
        end
        local function HeartbeatUI_upvr(arg1_23) -- Line 509, Named "HeartbeatUI"
            local var178 = var147_upvw
            local var179 = var148_upvw
            local var180 = (var178 * var178 + var179 * var179) ^ 0.5
            if 1 < var180 then
                var178 /= var180
                var179 /= var180
            end
            clone_upvw.Controls.Mouse.Dot.Position = UDim2.new(-(var178 * 0.9) * 0.5 + 0.5, 0, -(var179 * 0.9) * 0.5 + 0.5, 0)
            clone_upvw.Controls.Altitude.Text = string.format("%04d", arg1.PartWing.Position.Y)
            clone_upvw.Controls.Throttle.Value.Size = UDim2.new(1, 0, var143_upvw, 0)
            clone_upvw.Controls.Throttle.Value.Position = UDim2.new(0, 0, 1 - var143_upvw, 0)
        end
        local function Heartbeat(arg1_24) -- Line 523
            HeartbeatControls_upvr(arg1_24)
            HeartbeatWing_upvr(arg1_24)
            HeartbeatThrust_upvr(arg1_24)
            HeartbeatSounds_upvr(arg1_24)
            HeartbeatWheels(arg1_24)
            HeartbeatUI_upvr(arg1_24)
        end
        arg2.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(Heartbeat))
        local var181_upvw = false
        local var182_upvw
        local any_new_result1_15_upvr = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.8, 20)
        local var184_upvw = 70
        local function RenderSteppedCamera_upvr(arg1_25) -- Line 534, Named "RenderSteppedCamera"
            if arg1.IsFlying then
                if not var181_upvw then
                    var181_upvw = true
                    var182_upvw = arg1.PartWing.CFrame:toObjectSpace(CurrentCamera_upvr.CFrame)
                    CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            elseif var181_upvw and any_new_result1_13_upvr:Update() < 0.001 then
                var181_upvw = false
                CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
                CurrentCamera_upvr.CFrame = arg1.PartWing.CFrame * var182_upvw
            end
            local var185 = not arg1.IsFlying
            if not var185 then
                var185 = not arg1._controlsEnabled
            end
            UserInputService_upvr.MouseIconEnabled = var185
            if var185 then
                if UserInputService_upvr.MouseBehavior == Enum.MouseBehavior.LockCenter then
                    UserInputService_upvr.MouseBehavior = Enum.MouseBehavior.Default
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            elseif UserInputService_upvr.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                UserInputService_upvr.MouseBehavior = Enum.MouseBehavior.LockCenter
            end
            local var186 = 70
            if var181_upvw then
                var186 = math.clamp((arg1.PartWing.Velocity:Dot(arg1.PartWing.CFrame.LookVector) - 50) / 300, 0, 1) * 20 + 70
                local vector3 = Vector3.new(var147_upvw * -2, var148_upvw * 2, 0)
                local any_SetTarget_result1_2 = any_new_result1_15_upvr:SetTarget(vector3)
                if not arg1.Model:GetAttribute("IsCameraLocked") then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    CurrentCamera_upvr.CFrame = arg1.PartWing.CFrame * var182_upvw:Lerp(arg1.CONST.CAMERA_OFFSET_CF * CFrame.new(any_new_result1_7_upvr:SetTarget(vector3)) * CFrame.Angles(-any_SetTarget_result1_2.y * 0.02, any_SetTarget_result1_2.x * 0.02, 0), any_new_result1_13_upvr:Update())
                end
                local var189 = arg1.ObservedAcceleration / arg1.CONST.GRAVITY
                if arg1.CONST.CAMERA_SHAKE_MIN_GS < var189 then
                    local var190 = (1 - math.exp(-(var189 - arg1.CONST.CAMERA_SHAKE_MIN_GS) * arg1.CONST.CAMERA_SHAKE_COEFF_GS)) * 15
                    any_new_result1_7_upvr:Accelerate(Vector3.new(var190 * (random_state_upvr:NextNumber() * 2 - 1), var190 * (random_state_upvr:NextNumber() * 2 - 1), var190 * (random_state_upvr:NextNumber() * 2 - 1)))
                end
            end
            var184_upvw += (var186 - var184_upvw) * 0.7
            CurrentCamera_upvr.FieldOfView = var184_upvw
        end
        arg2.Maid:GiveTask(RunService_upvr.RenderStepped:Connect(function(arg1_26) -- Line 593, Named "RenderStepped"
            RenderSteppedCamera_upvr(arg1_26)
        end))
        local tbl_4_upvr = {
            [Enum.KeyCode.A] = 2;
            [Enum.KeyCode.D] = 4;
            [Enum.KeyCode.ButtonR2] = 1;
            [Enum.KeyCode.ButtonL2] = 3;
        }
        arg2.Maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_27, arg2_4) -- Line 608, Named "InputBegan"
            if arg2_4 then
                return false
            end
            if arg1_27.UserInputType == Enum.UserInputType.Keyboard then
                if arg1_27.KeyCode == Enum.KeyCode.Q then
                    any_new_result1_16_upvr:SetTarget(1)
                elseif arg1_27.KeyCode == Enum.KeyCode.LeftShift then
                    for _, v_8 in next, arg1.WheelsConf do
                        if not v_8.Front then
                            v_8.Wheel:SetForwardFriction(3)
                        end
                    end
                end
            end
            if tbl_4_upvr[arg1_27.KeyCode] then
                tbl_9_upvr[tbl_4_upvr[arg1_27.KeyCode]] = 1
                any_new_result1_2_upvr:SetTarget(tbl_9_upvr[2] - tbl_9_upvr[4])
            end
        end))
        arg2.Maid:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_28, arg2_5) -- Line 633, Named "InputEnded"
            if arg2_5 then
                return false
            end
            if arg1_28.UserInputType == Enum.UserInputType.Keyboard then
                if arg1_28.KeyCode == Enum.KeyCode.Q then
                    any_new_result1_16_upvr:SetTarget(0)
                elseif arg1_28.KeyCode == Enum.KeyCode.LeftShift then
                    for _, v_9 in next, arg1.WheelsConf do
                        v_9.Wheel:SetForwardFriction(0.02)
                    end
                end
            end
            if tbl_4_upvr[arg1_28.KeyCode] then
                tbl_9_upvr[tbl_4_upvr[arg1_28.KeyCode]] = 0
                any_new_result1_2_upvr:SetTarget(tbl_9_upvr[2] - tbl_9_upvr[4])
            end
        end))
        local any_new_result1_12_upvr = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.8, 20)
        arg2.Maid:GiveTask(UserInputService_upvr.InputChanged:Connect(function(arg1_29) -- Line 659, Named "InputChanged"
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            var147_upvw -= arg1_29.Delta.X * 0.015
            var148_upvw -= arg1_29.Delta.Y * 0.015
            tick_result1_upvw_2 = tick()
            var146_upvw = true
            do
                return
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end))
        local any_new_result1_6 = WheelWorld_upvr.new()
        any_new_result1_6:SetModel(arg1.Model)
        for _, v_5 in next, arg1.WheelsConf do
            local var198
            if 0 >= v_5.PartNode.CFrame:toObjectSpace(arg1.PartBoundingBox.CFrame).Z then
                var198 = false
            else
                var198 = true
            end
            local any_new_result1_14 = Wheel_upvr.new(v_5.PartNode)
            any_new_result1_14:SetSpringConstants(2, 3)
            if var198 then
                any_new_result1_14:SetVisualRadius(arg1.CONST.WHEEL_VISUAL_RADIUS_FRONT)
                any_new_result1_14:SetSuspensionHeight(arg1.CONST.SUSPENSION_HEIGHT_FRONT)
            else
                any_new_result1_14:SetVisualRadius(arg1.CONST.WHEEL_VISUAL_RADIUS_BACK)
                any_new_result1_14:SetSuspensionHeight(arg1.CONST.SUSPENSION_HEIGHT_BACK)
            end
            v_5.Front = var198
            v_5.Wheel = any_new_result1_14
            any_new_result1_6:AddWheel(any_new_result1_14)
        end
        arg2.Maid:GiveTask(any_new_result1_6)
        local function _() -- Line 740, Named "ThrottleUpPress"
            tbl_9_upvr[1] = 1
        end
        local function _() -- Line 743, Named "ThrottleUpRelease"
            tbl_9_upvr[1] = 0
        end
        local function _() -- Line 746, Named "ThrottleDownPress"
            tbl_9_upvr[3] = 1
        end
        local function _() -- Line 749, Named "ThrottleDownRelease"
            tbl_9_upvr[3] = 0
        end
        local tbl_3 = {
            primary = true;
            priority = 1000;
            saturateTo = 0;
            image = "rbxassetid://7858765663";
            keyCodes = {Enum.KeyCode.W, Enum.KeyCode.ButtonR2};
        }
        local function onPressed(arg1_30) -- Line 758
            if arg1_30 == Enum.UserInputType.Gamepad1 then
            else
                tbl_9_upvr[1] = 1
            end
        end
        tbl_3.onPressed = onPressed
        local function onReleased(arg1_31) -- Line 764
            if arg1_31 == Enum.UserInputType.Gamepad1 then
            else
                tbl_9_upvr[1] = 0
            end
        end
        tbl_3.onReleased = onReleased
        arg2.Maid:GiveTask(ActionButtonService_upvr.add(tbl_3))
        arg2.Maid:GiveTask(ActionButtonService_upvr.add({
            primary = true;
            priority = 700;
            saturateTo = 0;
            image = "rbxassetid://7858764373";
            keyCodes = {Enum.KeyCode.S, Enum.KeyCode.ButtonL2};
            onPressed = function(arg1_32) -- Line 777, Named "onPressed"
                if arg1_32 == Enum.UserInputType.Gamepad1 then
                else
                    tbl_9_upvr[3] = 1
                end
            end;
            onReleased = function(arg1_33) -- Line 783, Named "onReleased"
                if arg1_33 == Enum.UserInputType.Gamepad1 then
                else
                    tbl_9_upvr[3] = 0
                end
            end;
        }))
        ActionButtonService_upvr.setButtonPrimary(DefaultActions_upvr.jumpButton, false)
        arg2.Maid:GiveTask(function() -- Line 791
            ActionButtonService_upvr.setButtonPrimary(DefaultActions_upvr.jumpButton, true)
        end)
        arg2.Maid:GiveTask(clone_upvw)
        clone_upvw.Controls.Visible = true
        clone_upvw.Controls.Throttle.Line.Position = UDim2.new(0, -2, 1 - arg1.CONST.THROTTLE_TAKEOFF, 1)
        RunLanding_upvr()
    end
end
local WheelLQ_upvr = require(ReplicatedStorage_upvr.Module.Wheel.WheelLQ)
local function MountThirdPlayer_upvr(arg1, arg2, arg3) -- Line 802, Named "MountThirdPlayer"
    if not arg3.Driver then
    else
        local function HeartbeatWheels_upvr(arg1_34) -- Line 806, Named "HeartbeatWheels"
            for _, v_6 in next, arg1.WheelsConf do
                local any_Update_result1_2, any_Update_result2 = v_6.Wheel:Update(arg1_34)
                v_6.Motor.C0 = CFrame.Angles(-any_Update_result2, -0, 0) * CFrame.new(0, -any_Update_result1_2, 0)
                v_6.MotorArm.C1 = CFrame.new(0, any_Update_result1_2, 0) * CFrame.Angles(0, 0, 0) * v_6.ArmOffset
            end
        end
        arg3.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_35) -- Line 816, Named "Heartbeat"
            HeartbeatWheels_upvr(arg1_35)
        end))
        local any_new_result1 = WheelWorld_upvr.new()
        any_new_result1:SetModel(arg1.Model)
        for _, v_7 in next, arg1.WheelsConf do
            local var215
            if 0 >= v_7.PartNode.CFrame:toObjectSpace(arg1.PartWing.CFrame).Z then
                var215 = false
            else
                var215 = true
            end
            local any_new_result1_8 = WheelLQ_upvr.new(v_7.PartNode)
            if var215 then
                any_new_result1_8:SetVisualRadius(arg1.CONST.WHEEL_VISUAL_RADIUS_FRONT)
                any_new_result1_8:SetSuspensionHeight(arg1.CONST.SUSPENSION_HEIGHT_FRONT)
            else
                any_new_result1_8:SetVisualRadius(arg1.CONST.WHEEL_VISUAL_RADIUS_BACK)
                any_new_result1_8:SetSuspensionHeight(arg1.CONST.SUSPENSION_HEIGHT_BACK)
            end
            v_7.Front = var215
            v_7.Wheel = any_new_result1_8
            any_new_result1:AddWheel(any_new_result1_8)
        end
        arg3.Maid:GiveTask(any_new_result1)
    end
end
function module_upvr.MountPlayer(arg1, arg2, arg3) -- Line 840
    if arg2 == LocalPlayer_upvr then
        MountLocalPlayer_upvr(arg1, arg3)
    else
        MountThirdPlayer_upvr(arg1, arg2, arg3)
    end
    return true
end
local function UnmountLocalPlayer_upvr(arg1, arg2) -- Line 848, Named "UnmountLocalPlayer"
    local Character = LocalPlayer_upvr.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then
            SetHumanoidEnabled_upvr(Humanoid, true)
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    if not arg2.Driver then
    else
        arg1.ThrustVectorForce.Force = Vector3.new()
        arg1.WingVectorForce.Force = Vector3.new()
        arg1.WingAngularVelocity.AngularVelocity = Vector3.new()
        arg1.WingAngularVelocity.MaxTorque = 0
        arg1.SoundRumble:Destroy()
        arg1.SoundRumble = nil
        arg1.SoundWind:Destroy()
        arg1.SoundWind = nil
        arg1.SoundBreathing:Destroy()
        arg1.SoundBreathing = nil
        UserInputService_upvr.MouseIconEnabled = true
        UserInputService_upvr.MouseBehavior = Enum.MouseBehavior.Default
        arg1:SetParticlesEnabled(false)
        CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
        CurrentCamera_upvr.FieldOfView = 70
    end
end
local function _(arg1, arg2, arg3) -- Line 882, Named "UmmountThirdPlayer"
end
function module_upvr.UnmountSeat(arg1, arg2) -- Line 883
    assert(arg2)
    assert(arg2.Occupied)
    if arg2.Player ~= nil then
        if arg2.Player == LocalPlayer_upvr then
            UnmountLocalPlayer_upvr(arg1, arg2)
            return
        end
    end
end
function module_upvr.SetControlsEnabled(arg1, arg2) -- Line 894
    arg1._controlsEnabled = arg2
end
function module_upvr.Destroy(arg1) -- Line 897
    if arg1.Maid then
        arg1.Maid:Destroy()
        arg1.Maid = nil
    end
end
return module_upvr