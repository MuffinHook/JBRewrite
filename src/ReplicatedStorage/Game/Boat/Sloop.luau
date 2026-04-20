local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local R15IKv2_upvr = require(ReplicatedStorage_upvr.Module.R15IKv2)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Boat_upvr = require(script.Parent.Boat)
local tbl_upvr = {
    SpeedForward = 1.5;
    MaximumTurnAngle = 0.03;
    FrictionFwd = 0.04;
    TurnCurveCoeff = 1;
}
local module_upvr = {
    __ClassName = "Sloop";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Boat_upvr)
function module_upvr.new(arg1) -- Line 21
    local any_new_result1 = Boat_upvr.new(tbl_upvr, arg1)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup()
    any_new_result1.PartSailBack = any_new_result1.Model.Physics.SailBack.Sail
    any_new_result1.PartSailBackSize = any_new_result1.PartSailBack.Size
    any_new_result1.MastMotor = any_new_result1.Model:FindFirstChild("MastMotor")
    any_new_result1.MotorSail = any_new_result1.Model:FindFirstChild("MotorSail")
    any_new_result1.MotorSteeringWheel = any_new_result1.Model:FindFirstChild("MotorSteeringWheel")
    any_new_result1.SoundCreak = Audio_upvr.ObjectLocal(any_new_result1.PartBase, 9058593096, {
        Volume = 0.5;
        EmitterSize = 20;
        Looped = true;
        DoNotPlay = true;
    })
    any_new_result1.SoundWater = Audio_upvr.ObjectLocal(any_new_result1.PartBase, 9058608516, {
        Looped = true;
        EmitterSize = 20;
        DoNotPlay = true;
    })
    any_new_result1.ParticleMist = any_new_result1.Model.Visual.MistEmitter.Particle
    any_new_result1.ParticleWake = any_new_result1.Model.Visual.WakeEmitter.Particle
    return any_new_result1
end
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
function module_upvr.Setup(arg1) -- Line 43
    Boat_upvr.Setup(arg1)
    arg1.SpringSlowHeading = Spring_upvr.new(0, 0, 0.25, 4)
    arg1.LastHeadingSign = 0
end
function module_upvr.UpdateInput(arg1) -- Line 48
    Boat_upvr.UpdateInput(arg1)
    arg1.SpringSlowHeadingp = arg1.SpringSlowHeading:SetTarget(arg1.Heading)
end
function module_upvr.UpdateThirdInput(arg1) -- Line 52
    arg1.Heading = math.clamp(arg1.PartBase.RotVelocity.Y * 2, -1, 1)
    arg1.Forward = math.clamp(-arg1.PartBase.CFrame:VectorToObjectSpace(arg1.PartBase.Velocity).Z / 60, -1, 1)
    arg1.SpringHeadingp = arg1.SpringHeading:SetTarget(arg1.Heading)
    arg1.SpringForwardp = arg1.SpringForward:SetTarget(arg1.Forward)
    arg1.SpringSlowHeadingp = arg1.SpringSlowHeading:SetTarget(arg1.Heading)
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.MountPlayer(arg1, arg2, arg3) -- Line 64
    Boat_upvr.MountPlayer(arg1, arg2, arg3)
    if arg3.Driver then
        arg3.IKP = R15IKv2_upvr.BuildPacketArms(arg3.Character)
        if arg3.Local then
            local any_LoadAnimation_result1_upvr = arg3.Humanoid:LoadAnimation(ReplicatedStorage_upvr.Resource.IdleAnimation)
            any_LoadAnimation_result1_upvr:Play()
            arg3.Maid:GiveTask(function() -- Line 72
                any_LoadAnimation_result1_upvr:Stop()
                any_LoadAnimation_result1_upvr:Destroy()
            end)
        end
        any_LoadAnimation_result1_upvr = arg3.Maid
        any_LoadAnimation_result1_upvr = any_LoadAnimation_result1_upvr:GiveTask
        any_LoadAnimation_result1_upvr(RunService_upvr.Stepped:Connect(function() -- Line 78
            if arg1.Model ~= nil then
                arg1:SteppedDriver(arg3)
            end
        end))
        any_LoadAnimation_result1_upvr = arg1.SoundCreak:Play
        any_LoadAnimation_result1_upvr()
        any_LoadAnimation_result1_upvr = arg1.SoundWater:Play
        any_LoadAnimation_result1_upvr()
        any_LoadAnimation_result1_upvr = arg3.Maid
        any_LoadAnimation_result1_upvr = any_LoadAnimation_result1_upvr:GiveTask
        any_LoadAnimation_result1_upvr(function() -- Line 86
            arg1.SoundCreak:Stop()
        end)
        any_LoadAnimation_result1_upvr = arg3.Maid
        any_LoadAnimation_result1_upvr = any_LoadAnimation_result1_upvr:GiveTask
        any_LoadAnimation_result1_upvr(function() -- Line 89
            arg1.SoundWater:Stop()
        end)
        any_LoadAnimation_result1_upvr = arg3.Maid
        any_LoadAnimation_result1_upvr = any_LoadAnimation_result1_upvr:GiveTask
        any_LoadAnimation_result1_upvr(function() -- Line 93
            arg1.ParticleWake.Enabled = false
            arg1.ParticleMist.Enabled = false
        end)
    end
end
function module_upvr.SteppedDriver(arg1, arg2) -- Line 99
    local IKP = arg2.IKP
    local Part0 = arg1.MotorSteeringWheel.Part0
    local SpringHeadingp = arg1.SpringHeadingp
    IKP.RightArm = Part0.CFrame * Vector3.new(0.15000, 0, -1.5)
    IKP.LeftArm = Part0.CFrame * Vector3.new(0.15000, -0.1000, 1.5)
    IKP.RightWrist.Transform = CFrame.Angles(0, (-math.pi/2) * (1 - SpringHeadingp), 0)
    IKP.LeftWrist.Transform = CFrame.Angles(0, (-math.pi/2) * (1 - SpringHeadingp), 0)
    R15IKv2_upvr.Arms(IKP)
end
function module_upvr.HeartbeatDriver(arg1, arg2) -- Line 111
    Boat_upvr.HeartbeatDriver(arg1, arg2)
    local var30
    local var31
    local var32
    if arg2.Local then
        var30 = arg1.SpringSlowHeadingp + arg1.SwayY
        var31 = arg1.SpringHeadingp
        var32 = math.abs(arg1.SpringForwardp)
        local var33 = math.abs(arg1.SpringHeadingp) * 0.5 + 0.5
        arg1.MotorSail.C1 = CFrame.new(0, 0, -var33 * 0.5)
        arg1.PartSailBack.Size = arg1.PartSailBackSize + Vector3.new(0, 0, var33)
    else
        var30 = arg1.SpringSlowHeadingp
        var31 = arg1.SpringHeadingp
        var32 = math.abs(arg1.SpringForwardp)
    end
    arg1.MastMotor.C1 = CFrame.Angles(0, -var30 * math.pi * 0.05, 0)
    arg1.MotorSteeringWheel.C1 = arg1.MotorSteeringWheel.C0:Inverse() * CFrame.Angles(var31 * math.pi * 0.3, 0, 0) * arg1.MotorSteeringWheel.C0
    arg1.SoundCreak.Volume = 1 * (0.75 + 0.25 * var32)
    arg1.SoundWater.Volume = 1 * (0.25 + 0.75 * var32)
    if 0.5 < math.abs(arg1.Heading) then
        local sign = math.sign(arg1.Heading)
        if arg1.LastHeadingSign ~= sign then
            arg1.LastHeadingSign = sign
            Audio_upvr.ObjectLocal(arg1.PartSailBack, 4828088801, {
                Volume = 0.8;
            })
        end
    end
    local Magnitude_2 = arg1.PartBase.Velocity.Magnitude
    local var37 = false
    if 0 < arg1.SpringForwardp then
        if 20 >= Magnitude_2 then
            var37 = false
        else
            var37 = true
        end
    end
    local var38 = false
    if 0 < arg1.SpringForwardp then
        if 30 >= Magnitude_2 then
            var38 = false
        else
            var38 = true
        end
    end
    if arg1.ParticleWake.Enabled ~= var37 then
        arg1.ParticleWake.Enabled = var37
    end
    if arg1.ParticleMist.Enabled ~= var38 then
        arg1.ParticleMist.Enabled = var38
    end
end
return module_upvr