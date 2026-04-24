-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Spring = require(ReplicatedStorage.Std.Spring)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local Boat = require(script.Parent.Boat)
local t = {
	SpeedForward = 1.5,
	MaximumTurnAngle = 0.03,
	FrictionFwd = 0.04,
	TurnCurveCoeff = 1
}
local t2 = {
	__ClassName = "Sloop"
}
t2.__index = t2
setmetatable(t2, Boat)
function t2.new(p1)
	local v1 = Boat.new(t, p1)
	setmetatable(v1, t2)
	v1:Setup()
	v1.PartSailBack = v1.Model.Physics.SailBack.Sail
	v1.PartSailBackSize = v1.PartSailBack.Size
	v1.MastMotor = v1.Model:FindFirstChild("MastMotor")
	v1.MotorSail = v1.Model:FindFirstChild("MotorSail")
	v1.MotorSteeringWheel = v1.Model:FindFirstChild("MotorSteeringWheel")
	v1.SoundCreak = Audio.ObjectLocal(v1.PartBase, 9058593096, {
		Volume = 0.5,
		EmitterSize = 20,
		Looped = true,
		DoNotPlay = true
	})
	v1.SoundWater = Audio.ObjectLocal(v1.PartBase, 9058608516, {
		Looped = true,
		EmitterSize = 20,
		DoNotPlay = true
	})
	v1.ParticleMist = v1.Model.Visual.MistEmitter.Particle
	v1.ParticleWake = v1.Model.Visual.WakeEmitter.Particle
	return v1
end
function t2.Setup(p1)
	Boat.Setup(p1)
	p1.SpringSlowHeading = Spring.new(0, 0, 0.25, 4)
	p1.LastHeadingSign = 0
end
function t2.UpdateInput(p1)
	Boat.UpdateInput(p1)
	p1.SpringSlowHeadingp = p1.SpringSlowHeading:SetTarget(p1.Heading)
end
function t2.UpdateThirdInput(p1)
	p1.Heading = math.clamp(p1.PartBase.RotVelocity.Y * 2, -1, 1)
	p1.Forward = math.clamp(-p1.PartBase.CFrame:VectorToObjectSpace(p1.PartBase.Velocity).Z / 60, -1, 1)
	p1.SpringHeadingp = p1.SpringHeading:SetTarget(p1.Heading)
	p1.SpringForwardp = p1.SpringForward:SetTarget(p1.Forward)
	p1.SpringSlowHeadingp = p1.SpringSlowHeading:SetTarget(p1.Heading)
end
function t2.MountPlayer(p1, p2, p3)
	Boat.MountPlayer(p1, p2, p3)
	if p3.Driver then
		p3.IKP = R15IKv2.BuildPacketArms(p3.Character)
		if p3.Local then
			local v1 = p3.Humanoid:LoadAnimation(ReplicatedStorage.Resource.IdleAnimation)
			v1:Play()
			p3.Maid:GiveTask(function()
				v1:Stop()
				v1:Destroy()
			end)
		end
		p3.Maid:GiveTask(RunService.Stepped:Connect(function()
			if p1.Model ~= nil then
				p1:SteppedDriver(p3)
			end
		end))
		p1.SoundCreak:Play()
		p1.SoundWater:Play()
		p3.Maid:GiveTask(function()
			p1.SoundCreak:Stop()
		end)
		p3.Maid:GiveTask(function()
			p1.SoundWater:Stop()
		end)
		p3.Maid:GiveTask(function()
			p1.ParticleWake.Enabled = false
			p1.ParticleMist.Enabled = false
		end)
	end
end
function t2.SteppedDriver(p1, p2)
	local IKP = p2.IKP
	local Part0 = p1.MotorSteeringWheel.Part0
	local SpringHeadingp = p1.SpringHeadingp
	IKP.RightArm = Part0.CFrame * Vector3.new(0.15, 0, -1.5)
	IKP.LeftArm = Part0.CFrame * Vector3.new(0.15, -0.1, 1.5)
	IKP.RightWrist.Transform = CFrame.Angles(0, -1.5707963267948966 * (1 - SpringHeadingp), 0)
	IKP.LeftWrist.Transform = CFrame.Angles(0, -1.5707963267948966 * (1 - SpringHeadingp), 0)
	R15IKv2.Arms(IKP)
end
function t2.HeartbeatDriver(p1, p2)
	Boat.HeartbeatDriver(p1, p2)
	local v1, v2, v3
	if p2.Local then
		v1 = p1.SpringSlowHeadingp + p1.SwayY
		v2 = p1.SpringHeadingp
		local v4 = math.abs(p1.SpringForwardp)
		local v5 = math.abs(p1.SpringHeadingp) * 0.5 + 0.5
		p1.MotorSail.C1 = CFrame.new(0, 0, -v5 * 0.5)
		p1.PartSailBack.Size = p1.PartSailBackSize + Vector3.new(0, 0, v5)
		v3 = v4
	else
		v1 = p1.SpringSlowHeadingp
		v2 = p1.SpringHeadingp
		v3 = math.abs(p1.SpringForwardp)
	end
	p1.MastMotor.C1 = CFrame.Angles(0, -v1 * math.pi * 0.05, 0)
	p1.MotorSteeringWheel.C1 = p1.MotorSteeringWheel.C0:Inverse() * CFrame.Angles(v2 * math.pi * 0.3, 0, 0) * p1.MotorSteeringWheel.C0
	p1.SoundCreak.Volume = 1 * (0.75 + 0.25 * v3)
	p1.SoundWater.Volume = 1 * (0.25 + 0.75 * v3)
	if math.abs(p1.Heading) > 0.5 then
		local v7 = math.sign(p1.Heading)
		if p1.LastHeadingSign ~= v7 then
			p1.LastHeadingSign = v7
			Audio.ObjectLocal(p1.PartSailBack, 4828088801, {
				Volume = 0.8
			})
		end
	end
	local Magnitude = p1.PartBase.Velocity.Magnitude
	local v8 = if p1.SpringForwardp > 0 then Magnitude > 20 else false
	local v9 = if p1.SpringForwardp > 0 then Magnitude > 30 else false
	if p1.ParticleWake.Enabled ~= v8 then
		p1.ParticleWake.Enabled = v8
	end
	if p1.ParticleMist.Enabled ~= v9 then
		p1.ParticleMist.Enabled = v9
	end
end
return t2
