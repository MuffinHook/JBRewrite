local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    __ClassName = "Stunt";
}
module_upvr.__index = module_upvr
local BaseUserControlledPlane_upvr = require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane)
function module_upvr.new(arg1) -- Line 16
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Meta = arg1
    setmetatable_result1.Model = arg1.Model
    setmetatable_result1.Plane = BaseUserControlledPlane_upvr.new(arg1, {
        SUSPENSION_HEIGHT_FRONT = 4;
        SUSPENSION_HEIGHT_BACK = 4;
        COEFFICIENT_DRAG = 0.8;
        MAX_THRUST = 790;
        THROTTLE_WHEEL_TURN_MIN = 0.5;
        THROTTLE_TAKEOFF = 0.5;
        CAMERA_OFFSET_CF = CFrame.new(0, 10, 30);
        HEIGHT_MAX = 1100;
        WHEEL_VISUAL_RADIUS_FRONT = 1.3095;
        WHEEL_VISUAL_RADIUS_BACK = 0.7075;
    })
    setmetatable_result1.Maid = setmetatable_result1.Plane.Maid
    setmetatable_result1.Seats = setmetatable_result1.Plane.Seats
    setmetatable_result1.BoundingBox = setmetatable_result1.Model.BoundingBox
    setmetatable_result1.MotorAileronWingRight = arg1.MotorAileronWingRight
    setmetatable_result1.MotorAileronWingLeft = arg1.MotorAileronWingLeft
    setmetatable_result1.MotorAileronTailRight = arg1.MotorAileronTailRight
    setmetatable_result1.MotorAileronTailLeft = arg1.MotorAileronTailLeft
    setmetatable_result1.MotorAileronTail = arg1.MotorAileronTail
    setmetatable_result1.MotorPropeller = arg1.MotorPropeller
    setmetatable_result1.Plane.WheelsConf = arg1.WheelsConf
    return setmetatable_result1
end
local function MountLocalPlayer_upvr(arg1, arg2, arg3) -- Line 48, Named "MountLocalPlayer"
    local MotorAileronWingRight_upvr = arg1.MotorAileronWingRight
    local MotorAileronWingLeft_upvr = arg1.MotorAileronWingLeft
    local MotorAileronTailRight_upvr = arg1.MotorAileronTailRight
    local MotorAileronTailLeft_upvr = arg1.MotorAileronTailLeft
    local MotorAileronTail_upvr = arg1.MotorAileronTail
    local var13_upvw = 0
    local MotorPropeller_upvr = arg1.MotorPropeller
    local var15_upvw = 0
    local function HeartbeatAilerons_upvr(arg1_2) -- Line 60, Named "HeartbeatAilerons"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local Joystickx = arg1.Plane.Joystickx
        local Joysticky = arg1.Plane.Joysticky
        local var18 = (Joystickx * Joystickx + Joysticky * Joysticky) ^ 0.5
        local var19
        if var19 >= var18 or not (Joystickx / var18) then
            local var20 = Joystickx
        end
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var19 = Joysticky / var18
            return var19
        end
        if 1 >= var18 or not decompInlinedCondition() then
            var19 = Joysticky
        end
        MotorAileronWingRight_upvr.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.3 * (-var19 - var20), 0, 0)
        MotorAileronWingLeft_upvr.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.3 * (-var19 + var20), 0, 0)
        MotorAileronTailRight_upvr.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.2 * (-var19 - var20), 0, 0)
        MotorAileronTailLeft_upvr.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.2 * (-var19 + var20), 0, 0)
        MotorAileronTail_upvr.C0 = CFrame.new(0, 0, 1) * CFrame.Angles(-0.5235987755982988, 0, 0) * CFrame.Angles(0, 0.1 * var20 - 0.07 * arg1.Plane.InputYaw, 0) * CFrame.Angles(0.5235987755982988, 0, 0)
        var13_upvw += (10 + 10 * arg1.Plane.Throttle) * arg1_2
        if (-math.pi*2) < var13_upvw then
            var13_upvw -= (-math.pi*2)
        end
        MotorPropeller_upvr.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, var13_upvw)
        local var21 = math.floor(((1 - math.clamp(arg1.Plane.Throttle, 0, 1) ^ 2) * 0.4 + 0.6) * 20) / 20
        if var21 ~= var15_upvw then
            var15_upvw = var21
            arg1.Meta.PropellerDisc.Transparency = var21
        end
    end
    local function _(arg1_3) -- Line 94, Named "HeartbeatSounds"
        local Throttle = arg1.Plane.Throttle
        arg1.SoundPropeller.Volume = Throttle * Throttle
    end
    local function Heartbeat(arg1_4) -- Line 98
        HeartbeatAilerons_upvr(arg1_4)
        local Throttle_2 = arg1.Plane.Throttle
        arg1.SoundPropeller.Volume = Throttle_2 * Throttle_2
    end
    arg3.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(Heartbeat))
    arg3.Maid:GiveTask(function() -- Line 103
        arg1.Meta.PropellerDisc.Transparency = 1
    end)
end
local function MountThirdPlayer_upvr(arg1, arg2, arg3) -- Line 108, Named "MountThirdPlayer"
    local var25_upvw = 0
    local MotorPropeller_upvr_2 = arg1.MotorPropeller
    arg3.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_5) -- Line 112, Named "Heartbeat"
        var25_upvw += 10 * arg1_5
        if (-math.pi*2) < var25_upvw then
            var25_upvw -= (-math.pi*2)
        end
        MotorPropeller_upvr_2.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, var25_upvw)
        arg1.SoundPropeller.Volume = 1 - math.exp(-arg1.BoundingBox.Velocity.Magnitude / 50)
    end))
    arg1.Plane:SetParticlesEnabled(true)
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr.MountPlayer(arg1, arg2, arg3) -- Line 129
    arg1.Plane:MountPlayer(arg2, arg3)
    local any_ObjectLocal_result1 = Audio_upvr.ObjectLocal(arg1.Model.BoundingBox, 9058676938, {
        Looped = true;
        Volume = 0;
        Pitch = 1;
    })
    any_ObjectLocal_result1.MaxDistance = 3000
    any_ObjectLocal_result1.EmitterSize = 20
    arg1.SoundPropeller = any_ObjectLocal_result1
    if arg2 == LocalPlayer_upvr then
        MountLocalPlayer_upvr(arg1, arg2, arg3)
    else
        MountThirdPlayer_upvr(arg1, arg2, arg3)
    end
end
local function _(arg1, arg2) -- Line 144, Named "UnmountLocalPlayer"
end
local function _(arg1, arg2, arg3) -- Line 145, Named "UnmountThirdPlayer"
    arg1.Plane:SetParticlesEnabled(false)
end
function module_upvr.UnmountSeat(arg1, arg2) -- Line 148
    assert(arg2)
    assert(arg2.Occupied)
    arg1.SoundPropeller:Destroy()
    arg1.SoundPropeller = nil
    if arg2.Player == LocalPlayer_upvr then
    else
        arg1.Plane:SetParticlesEnabled(false)
    end
    return arg1.Plane:UnmountSeat(arg2)
end
function module_upvr.Destroy(arg1) -- Line 161
    arg1.Plane:Destroy()
end
return module_upvr