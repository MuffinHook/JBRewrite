local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Spring = require(ReplicatedStorage.Std.Spring)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local Boat = require(script.Parent.Boat)
local config = {
	SpeedForward = 1.5,
	MaximumTurnAngle = 0.03,
	FrictionFwd = 0.04,
	TurnCurveCoeff = 1
}
local Sloop = {
	__ClassName = "Sloop"
}
Sloop.__index = Sloop
setmetatable(Sloop, Boat)
function Sloop.new(boatConfig)
	local boat = Boat.new(config, boatConfig)
	setmetatable(boat, Sloop)
	boat:Setup()
	boat.PartSailBack = boat.Model.Physics.SailBack.Sail
	boat.PartSailBackSize = boat.PartSailBack.Size
	boat.MastMotor = boat.Model:FindFirstChild("MastMotor")
	boat.MotorSail = boat.Model:FindFirstChild("MotorSail")
	boat.MotorSteeringWheel = boat.Model:FindFirstChild("MotorSteeringWheel")
	boat.SoundCreak = Audio.ObjectLocal(boat.PartBase, 9058593096, {
		Volume = 0.5,
		EmitterSize = 20,
		Looped = true,
		DoNotPlay = true
	})
	boat.SoundWater = Audio.ObjectLocal(boat.PartBase, 9058608516, {
		Looped = true,
		EmitterSize = 20,
		DoNotPlay = true
	})
	boat.ParticleMist = boat.Model.Visual.MistEmitter.Particle
	boat.ParticleWake = boat.Model.Visual.WakeEmitter.Particle
	return boat
end
function Sloop.Setup(self)
	Boat.Setup(self)
	self.SpringSlowHeading = Spring.new(0, 0, 0.25, 4)
	self.LastHeadingSign = 0
end
function Sloop.UpdateInput(self)
	Boat.UpdateInput(self)
	self.SpringSlowHeadingValue = self.SpringSlowHeading:SetTarget(self.Heading)
end
function Sloop.UpdateThirdInput(self)
	self.Heading = math.clamp(self.PartBase.RotVelocity.Y * 2, -1, 1)
	self.Forward = math.clamp(-self.PartBase.CFrame:VectorToObjectSpace(self.PartBase.Velocity).Z / 60, -1, 1)
	self.SpringHeadingValue = self.SpringHeading:SetTarget(self.Heading)
	self.SpringForwardValue = self.SpringForward:SetTarget(self.Forward)
	self.SpringSlowHeadingValue = self.SpringSlowHeading:SetTarget(self.Heading)
end
function Sloop.MountPlayer(self, player, passenger)
	Boat.MountPlayer(self, player, passenger)
	if passenger.Driver then
		passenger.IKP = R15IKv2.BuildPacketArms(passenger.Character)
		if passenger.Local then
			local idleAnimation = passenger.Humanoid:LoadAnimation(ReplicatedStorage.Resource.IdleAnimation)
			idleAnimation:Play()
			passenger.Maid:GiveTask(function()
				idleAnimation:Stop()
				idleAnimation:Destroy()
			end)
		end
		passenger.Maid:GiveTask(RunService.Stepped:Connect(function()
			if self.Model ~= nil then
				self:SteppedDriver(passenger)
			end
		end))
		self.SoundCreak:Play()
		self.SoundWater:Play()
		passenger.Maid:GiveTask(function()
			self.SoundCreak:Stop()
		end)
		passenger.Maid:GiveTask(function()
			self.SoundWater:Stop()
		end)
		passenger.Maid:GiveTask(function()
			self.ParticleWake.Enabled = false
			self.ParticleMist.Enabled = false
		end)
	end
end
function Sloop.SteppedDriver(self, player)
	local IKP = player.IKP
	local Part0 = self.MotorSteeringWheel.Part0
	local springHeadingValue = self.SpringHeadingValue
	IKP.RightArm = Part0.CFrame * Vector3.new(0.15, 0, -1.5)
	IKP.LeftArm = Part0.CFrame * Vector3.new(0.15, -0.1, 1.5)
	IKP.RightWrist.Transform = CFrame.Angles(0, -math.pi / 2 * (1 - springHeadingValue), 0)
	IKP.LeftWrist.Transform = CFrame.Angles(0, -math.pi / 2 * (1 - springHeadingValue), 0)
	R15IKv2.Arms(IKP)
end
function Sloop.HeartbeatDriver(self, player)
	Boat.HeartbeatDriver(self, player)
	local headingValue, headingAngle, forwardMagnitude
	if player.Local then
		headingValue = self.SpringSlowHeadingValue + self.SwayY
		headingAngle = self.SpringHeadingValue
		local sailFactor = math.abs(self.SpringForwardValue)
		local sailSize = math.abs(self.SpringHeadingValue) * 0.5 + 0.5
		self.MotorSail.C1 = CFrame.new(0, 0, -sailSize * 0.5)
		self.PartSailBack.Size = self.PartSailBackSize + Vector3.new(0, 0, sailSize)
		forwardMagnitude = sailFactor
	else
		headingValue = self.SpringSlowHeadingValue
		headingAngle = self.SpringHeadingValue
		forwardMagnitude = math.abs(self.SpringForwardValue)
	end
	self.MastMotor.C1 = CFrame.Angles(0, -headingValue * math.pi * 0.05, 0)
	self.MotorSteeringWheel.C1 = self.MotorSteeringWheel.C0:Inverse() * CFrame.Angles(headingAngle * math.pi * 0.3, 0, 0) * self.MotorSteeringWheel.C0
	self.SoundCreak.Volume = 1 * (0.75 + 0.25 * forwardMagnitude)
	self.SoundWater.Volume = 1 * (0.25 + 0.75 * forwardMagnitude)
	if math.abs(self.Heading) > 0.5 then
		local headingSign = math.sign(self.Heading)
		if self.LastHeadingSign ~= headingSign then
			self.LastHeadingSign = headingSign
			Audio.ObjectLocal(self.PartSailBack, 4828088801, {
				Volume = 0.8
			})
		end
	end
	local velocityMagnitude = self.PartBase.Velocity.Magnitude
	local wakeEnabled = if self.SpringForwardValue > 0 then velocityMagnitude > 20 else false
	local mistEnabled = if self.SpringForwardValue > 0 then velocityMagnitude > 30 else false
	if self.ParticleWake.Enabled ~= wakeEnabled then
		self.ParticleWake.Enabled = wakeEnabled
	end
	if self.ParticleMist.Enabled ~= mistEnabled then
		self.ParticleMist.Enabled = mistEnabled
	end
end
return Sloop
