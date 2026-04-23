local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local Boat = require(script.Parent.Boat)
local t = {
	Cruiser = {
		SpeedForward = 11,
		MaximumTurnAngle = 0.1,
		FrictionFwd = 0.04,
		TurnCurveCoeff = 1
	},
	SpeedYacht = {
		SpeedForward = 11,
		MaximumTurnAngle = 0.06,
		FrictionFwd = 0,
		TurnCurveCoeff = 1
	}
}
local t2 = {
	__ClassName = "Cruiser"
}
t2.__index = t2
setmetatable(t2, Boat)
function t2.new(p1) --[[ Line: 28 | Upvalues: t (copy), Boat (copy), t2 (copy), Audio (copy) ]]
	local v3 = Boat.new(assert(t[p1.Model.Name]), p1)
	setmetatable(v3, t2)
	v3:Setup()
	v3.MotorSteeringWheel = v3.Model:FindFirstChild("MotorSteeringWheel")
	if v3.Model:FindFirstChild("Physics"):FindFirstChild("Motor") then
		v3.MotorEngine = v3.Model:FindFirstChild("MotorEngine")
		v3.MotorBlade = v3.Model:FindFirstChild("MotorBlade")
	end
	v3.ParticleMist = v3.Model.Visual.MistEmitter.Particle
	v3.ParticleWake = v3.Model.Visual.WakeEmitter.Particle
	v3.BladeSpin = 0
	v3.IdleSound = Audio.ObjectLocal(v3.PartBase, 657590761, {
		Volume = 0,
		Looped = true,
		DoNotPlay = true
	})
	v3.LowSound = Audio.ObjectLocal(v3.PartBase, 657591400, {
		Volume = 0,
		Looped = true,
		DoNotPlay = true
	})
	return v3
end
function t2.Setup(p1) --[[ Line: 49 | Upvalues: Boat (copy) ]]
	Boat.Setup(p1)
end
function t2.SetupSeats(p1) --[[ Line: 52 | Upvalues: Boat (copy) ]]
	Boat.SetupSeats(p1)
	local t = {}
	t.Part = assert(p1.Model.Passenger)
	table.insert(p1.Seats, t)
end
function t2.UpdateThirdInput(p1) --[[ Line: 58 ]]
	p1.Heading = math.clamp(p1.PartBase.RotVelocity.Y * 2, -1, 1)
	p1.Forward = math.clamp(-p1.PartBase.CFrame:VectorToObjectSpace(p1.PartBase.Velocity).Z / 80, -1, 1)
	p1.SpringForwardp = p1.SpringForward:SetTarget(p1.Forward)
	p1.SpringHeadingp = p1.SpringHeading:SetTarget(p1.Heading)
end
function t2.HeartbeatDriver(p1, p2) --[[ Line: 69 | Upvalues: Boat (copy) ]]
	Boat.HeartbeatDriver(p1, p2)
	if p1.MotorSteeringWheel then
		p1.MotorSteeringWheel.C1 = p1.MotorSteeringWheel.C0:Inverse() * CFrame.Angles(0, 0, p1.SpringHeadingp * math.pi * 0.3) * p1.MotorSteeringWheel.C0
	end
	if p1.MotorEngine then
		local v1 = p1.MotorEngine.C0:Inverse()
		local Angles = CFrame.Angles
		p1.MotorEngine.C1 = v1 * Angles((1 - math.abs(p1.SpringForwardp)) * math.pi * 0.1, 0, 0) * CFrame.Angles(0, -p1.SpringHeadingp * math.pi * 0.1, 0) * p1.MotorEngine.C0
	end
	if p1.MotorBlade then
		p1.BladeSpin = p1.BladeSpin + p1.SpringForwardp
		p1.MotorBlade.C1 = p1.MotorBlade.C0:Inverse() * CFrame.Angles(p1.BladeSpin * 0.75, 0, 0) * p1.MotorBlade.C0
	end
	p2.SpringNeckRotation:SetTarget((Vector3.new(0.23561944901923448 * math.abs(p1.Forward) + 0.15707963267948966 - 0.07853981633974483, p1.Heading * math.pi * 0.2, 0)))
	p2.SpringWaistRotation:SetTarget((Vector3.new(-0.23561944901923448 * math.abs(p1.Forward) - 0.15707963267948966, 0, p1.SpringHeadingp * math.pi * 0.05)))
	local Magnitude = p1.PartBase.Velocity.Magnitude
	p1.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
	p1.LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
	p1.LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
	local v6 = if p1.SpringForwardp > 0 then Magnitude > 20 else false
	local v7 = if p1.SpringForwardp > 0 then Magnitude > 30 else false
	if p1.ParticleWake.Enabled ~= v6 then
		p1.ParticleWake.Enabled = v6
	end
	if p1.ParticleMist.Enabled ~= v7 then
		p1.ParticleMist.Enabled = v7
	end
end
function t2.SteppedDriver(p1, p2) --[[ Line: 116 | Upvalues: R15IKv2 (copy) ]]
	local IKP = p2.IKP
	local Part0 = p1.MotorSteeringWheel.Part0
	IKP.RightArm = Part0.CFrame * Vector3.new(0.6, 0, 0.5)
	IKP.LeftArm = Part0.CFrame * Vector3.new(-0.6, 0, 0.5)
	R15IKv2.Arms(IKP)
end
function t2.MountPlayer(p1, p2, p3) --[[ Line: 126 | Upvalues: Boat (copy), R15IKv2 (copy), RunService (copy), ReplicatedStorage (copy) ]]
	Boat.MountPlayer(p1, p2, p3)
	if p3.Driver then
		p3.IKP = R15IKv2.BuildPacketArms(p3.Character)
		p3.Maid:GiveTask(RunService.Stepped:Connect(function() --[[ Line: 132 | Upvalues: p1 (copy), p3 (copy) ]]
			if p1.Model ~= nil then
				p1:SteppedDriver(p3)
			end
		end))
		p1.IdleSound:Play()
		p1.LowSound:Play()
		p3.Maid:GiveTask(function() --[[ Line: 140 | Upvalues: p1 (copy) ]]
			p1.IdleSound:Stop()
		end)
		p3.Maid:GiveTask(function() --[[ Line: 143 | Upvalues: p1 (copy) ]]
			p1.LowSound:Stop()
		end)
		p3.Maid:GiveTask(function() --[[ Line: 147 | Upvalues: p1 (copy) ]]
			p1.ParticleWake.Enabled = false
			p1.ParticleMist.Enabled = false
		end)
		p3.SpringNeckRotation.Freq = 10
		p3.SpringWaistRotation:SetTarget(Vector3.new(-0.31415927, 0, 0))
		p3.SpringWaistRotation.Freq = 10
	end
	if p3.Local then
		local v1 = p3.Humanoid:LoadAnimation(ReplicatedStorage.Resource.SitAnimation)
		v1:Play()
		p3.Maid:GiveTask(function() --[[ Line: 159 | Upvalues: v1 (copy) ]]
			v1:Stop()
			v1:Destroy()
		end)
	end
end
return t2