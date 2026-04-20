local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local R15IKv2_upvr = require(ReplicatedStorage_upvr.Module.R15IKv2)
local Boat_upvr = require(script.Parent.Boat)
local tbl_upvr = {
    Cruiser = {
        SpeedForward = 11;
        MaximumTurnAngle = 0.1;
        FrictionFwd = 0.04;
        TurnCurveCoeff = 1;
    };
    SpeedYacht = {
        SpeedForward = 11;
        MaximumTurnAngle = 0.06;
        FrictionFwd = 0;
        TurnCurveCoeff = 1;
    };
}
local module_upvr = {
    __ClassName = "Cruiser";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Boat_upvr)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function module_upvr.new(arg1) -- Line 28
    local any_new_result1 = Boat_upvr.new(assert(tbl_upvr[arg1.Model.Name]), arg1)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup()
    any_new_result1.MotorSteeringWheel = any_new_result1.Model:FindFirstChild("MotorSteeringWheel")
    if any_new_result1.Model:FindFirstChild("Physics"):FindFirstChild("Motor") then
        any_new_result1.MotorEngine = any_new_result1.Model:FindFirstChild("MotorEngine")
        any_new_result1.MotorBlade = any_new_result1.Model:FindFirstChild("MotorBlade")
    end
    any_new_result1.ParticleMist = any_new_result1.Model.Visual.MistEmitter.Particle
    any_new_result1.ParticleWake = any_new_result1.Model.Visual.WakeEmitter.Particle
    any_new_result1.BladeSpin = 0
    any_new_result1.IdleSound = Audio_upvr.ObjectLocal(any_new_result1.PartBase, 657590761, {
        Volume = 0;
        Looped = true;
        DoNotPlay = true;
    })
    any_new_result1.LowSound = Audio_upvr.ObjectLocal(any_new_result1.PartBase, 657591400, {
        Volume = 0;
        Looped = true;
        DoNotPlay = true;
    })
    return any_new_result1
end
function module_upvr.Setup(arg1) -- Line 49
    Boat_upvr.Setup(arg1)
end
function module_upvr.SetupSeats(arg1) -- Line 52
    Boat_upvr.SetupSeats(arg1)
    table.insert(arg1.Seats, {
        Part = assert(arg1.Model.Passenger);
    })
end
function module_upvr.UpdateThirdInput(arg1) -- Line 58
    arg1.Heading = math.clamp(arg1.PartBase.RotVelocity.Y * 2, -1, 1)
    arg1.Forward = math.clamp(-arg1.PartBase.CFrame:VectorToObjectSpace(arg1.PartBase.Velocity).Z / 80, -1, 1)
    arg1.SpringForwardp = arg1.SpringForward:SetTarget(arg1.Forward)
    arg1.SpringHeadingp = arg1.SpringHeading:SetTarget(arg1.Heading)
end
function module_upvr.HeartbeatDriver(arg1, arg2) -- Line 69
    Boat_upvr.HeartbeatDriver(arg1, arg2)
    if arg1.MotorSteeringWheel then
        arg1.MotorSteeringWheel.C1 = arg1.MotorSteeringWheel.C0:Inverse() * CFrame.Angles(0, 0, arg1.SpringHeadingp * math.pi * 0.3) * arg1.MotorSteeringWheel.C0
    end
    if arg1.MotorEngine then
        arg1.MotorEngine.C1 = arg1.MotorEngine.C0:Inverse() * CFrame.Angles((1 - math.abs(arg1.SpringForwardp)) * math.pi * 0.1, 0, 0) * CFrame.Angles(0, -arg1.SpringHeadingp * math.pi * 0.1, 0) * arg1.MotorEngine.C0
    end
    if arg1.MotorBlade then
        arg1.BladeSpin += arg1.SpringForwardp
        arg1.MotorBlade.C1 = arg1.MotorBlade.C0:Inverse() * CFrame.Angles(arg1.BladeSpin * 0.75, 0, 0) * arg1.MotorBlade.C0
    end
    arg2.SpringNeckRotation:SetTarget(Vector3.new(0.23561944901923448 * math.abs(arg1.Forward) + 0.15707963267948966 - 0.07853981633974483, arg1.Heading * math.pi * 0.2, 0))
    arg2.SpringWaistRotation:SetTarget(Vector3.new(-0.23561944901923448 * math.abs(arg1.Forward) - 0.15707963267948966, 0, arg1.SpringHeadingp * math.pi * 0.05))
    local Magnitude = arg1.PartBase.Velocity.Magnitude
    arg1.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
    arg1.LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
    arg1.LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
    local var14 = false
    if 0 < arg1.SpringForwardp then
        if 20 >= Magnitude then
            var14 = false
        else
            var14 = true
        end
    end
    local var15 = false
    if 0 < arg1.SpringForwardp then
        if 30 >= Magnitude then
            var15 = false
        else
            var15 = true
        end
    end
    if arg1.ParticleWake.Enabled ~= var14 then
        arg1.ParticleWake.Enabled = var14
    end
    if arg1.ParticleMist.Enabled ~= var15 then
        arg1.ParticleMist.Enabled = var15
    end
end
function module_upvr.SteppedDriver(arg1, arg2) -- Line 116
    local IKP = arg2.IKP
    local Part0 = arg1.MotorSteeringWheel.Part0
    IKP.RightArm = Part0.CFrame * Vector3.new(0.60000, 0, 0.5)
    IKP.LeftArm = Part0.CFrame * Vector3.new(-0.6000, 0, 0.5)
    R15IKv2_upvr.Arms(IKP)
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.MountPlayer(arg1, arg2, arg3) -- Line 126
    Boat_upvr.MountPlayer(arg1, arg2, arg3)
    if arg3.Driver then
        arg3.IKP = R15IKv2_upvr.BuildPacketArms(arg3.Character)
        arg3.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 132
            if arg1.Model ~= nil then
                arg1:SteppedDriver(arg3)
            end
        end))
        arg1.IdleSound:Play()
        arg1.LowSound:Play()
        arg3.Maid:GiveTask(function() -- Line 140
            arg1.IdleSound:Stop()
        end)
        arg3.Maid:GiveTask(function() -- Line 143
            arg1.LowSound:Stop()
        end)
        arg3.Maid:GiveTask(function() -- Line 147
            arg1.ParticleWake.Enabled = false
            arg1.ParticleMist.Enabled = false
        end)
        arg3.SpringNeckRotation.Freq = 10
        arg3.SpringWaistRotation:SetTarget(Vector3.new(-0.3141, 0, 0))
        arg3.SpringWaistRotation.Freq = 10
    end
    if arg3.Local then
        local any_LoadAnimation_result1_upvr = arg3.Humanoid:LoadAnimation(ReplicatedStorage_upvr.Resource.SitAnimation)
        any_LoadAnimation_result1_upvr:Play()
        arg3.Maid:GiveTask(function() -- Line 159
            any_LoadAnimation_result1_upvr:Stop()
            any_LoadAnimation_result1_upvr:Destroy()
        end)
    end
end
return module_upvr