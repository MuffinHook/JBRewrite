local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local Boat = require(script.Parent.Boat)
local boatConfigs = {
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
local CruiserClass = {
	__ClassName = "Cruiser"
}
CruiserClass.__index = CruiserClass
setmetatable(CruiserClass, Boat)
function CruiserClass.new(boatModel)
	local cruiser = Boat.new(assert(boatConfigs[boatModel.Model.Name]), boatModel)
	setmetatable(cruiser, CruiserClass)
	cruiser:Setup()
	cruiser.MotorSteeringWheel = cruiser.Model:FindFirstChild("MotorSteeringWheel")
	if cruiser.Model:FindFirstChild("Physics"):FindFirstChild("Motor") then
		cruiser.MotorEngine = cruiser.Model:FindFirstChild("MotorEngine")
		cruiser.MotorBlade = cruiser.Model:FindFirstChild("MotorBlade")
	end
	cruiser.ParticleMist = cruiser.Model.Visual.MistEmitter.Particle
	cruiser.ParticleWake = cruiser.Model.Visual.WakeEmitter.Particle
	cruiser.BladeSpin = 0
	cruiser.IdleSound = Audio.ObjectLocal(cruiser.PartBase, 657590761, {
		Volume = 0,
		Looped = true,
		DoNotPlay = true
	})
	cruiser.LowSound = Audio.ObjectLocal(cruiser.PartBase, 657591400, {
		Volume = 0,
		Looped = true,
		DoNotPlay = true
	})
	return cruiser
end
function CruiserClass.Setup(cruiser)
	Boat.Setup(cruiser)
end
function CruiserClass.SetupSeats(cruiser)
	Boat.SetupSeats(cruiser)
	local seatData = {}
	seatData.Part = assert(cruiser.Model.Passenger)
	table.insert(cruiser.Seats, seatData)
end
function CruiserClass.UpdateThirdInput(cruiser)
	cruiser.Heading = math.clamp(cruiser.PartBase.RotVelocity.Y * 2, -1, 1)
	cruiser.Forward = math.clamp(-cruiser.PartBase.CFrame:VectorToObjectSpace(cruiser.PartBase.Velocity).Z / 80, -1, 1)
	cruiser.SpringForwardp = cruiser.SpringForward:SetTarget(cruiser.Forward)
	cruiser.SpringHeadingp = cruiser.SpringHeading:SetTarget(cruiser.Heading)
end
function CruiserClass.HeartbeatDriver(cruiser, driver)
	Boat.HeartbeatDriver(cruiser, driver)
	if cruiser.MotorSteeringWheel then
		cruiser.MotorSteeringWheel.C1 = cruiser.MotorSteeringWheel.C0:Inverse() * CFrame.Angles(0, 0, cruiser.SpringHeadingp * math.pi * 0.3) * cruiser.MotorSteeringWheel.C0
	end
	if cruiser.MotorEngine then
		local inverseC0 = cruiser.MotorEngine.C0:Inverse()
		local Angles = CFrame.Angles
		cruiser.MotorEngine.C1 = inverseC0 * Angles((1 - math.abs(cruiser.SpringForwardp)) * math.pi * 0.1, 0, 0) * CFrame.Angles(0, -cruiser.SpringHeadingp * math.pi * 0.1, 0) * cruiser.MotorEngine.C0
	end
	if cruiser.MotorBlade then
		cruiser.BladeSpin = cruiser.BladeSpin + cruiser.SpringForwardp
		cruiser.MotorBlade.C1 = cruiser.MotorBlade.C0:Inverse() * CFrame.Angles(cruiser.BladeSpin * 0.75, 0, 0) * cruiser.MotorBlade.C0
	end
	driver.SpringNeckRotation:SetTarget((Vector3.new(0.23561944901923448 * math.abs(cruiser.Forward) + 0.15707963267948966 - 0.07853981633974483, cruiser.Heading * math.pi * 0.2, 0)))
	driver.SpringWaistRotation:SetTarget((Vector3.new(-0.23561944901923448 * math.abs(cruiser.Forward) - 0.15707963267948966, 0, cruiser.SpringHeadingp * math.pi * 0.05)))
	local Magnitude = cruiser.PartBase.Velocity.Magnitude
	cruiser.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
	cruiser.LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
	cruiser.LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
	local shouldEnableWake = if cruiser.SpringForwardp > 0 then Magnitude > 20 else false
	local shouldEnableMist = if cruiser.SpringForwardp > 0 then Magnitude > 30 else false
	if cruiser.ParticleWake.Enabled ~= shouldEnableWake then
		cruiser.ParticleWake.Enabled = shouldEnableWake
	end
	if cruiser.ParticleMist.Enabled ~= shouldEnableMist then
		cruiser.ParticleMist.Enabled = shouldEnableMist
	end
end
function CruiserClass.SteppedDriver(cruiser, driver)
	local IKP = driver.IKP
	local Part0 = cruiser.MotorSteeringWheel.Part0
	IKP.RightArm = Part0.CFrame * Vector3.new(0.6, 0, 0.5)
	IKP.LeftArm = Part0.CFrame * Vector3.new(-0.6, 0, 0.5)
	R15IKv2.Arms(IKP)
end
function CruiserClass.MountPlayer(cruiser, driver, playerData)
	Boat.MountPlayer(cruiser, driver, playerData)
	if playerData.Driver then
		playerData.IKP = R15IKv2.BuildPacketArms(playerData.Character)
		playerData.Maid:GiveTask(RunService.Stepped:Connect(function()
			if cruiser.Model ~= nil then
				cruiser:SteppedDriver(playerData)
			end
		end))
		cruiser.IdleSound:Play()
		cruiser.LowSound:Play()
		playerData.Maid:GiveTask(function()
			cruiser.IdleSound:Stop()
		end)
		playerData.Maid:GiveTask(function()
			cruiser.LowSound:Stop()
		end)
		playerData.Maid:GiveTask(function()
			cruiser.ParticleWake.Enabled = false
			cruiser.ParticleMist.Enabled = false
		end)
		playerData.SpringNeckRotation.Freq = 10
		playerData.SpringWaistRotation:SetTarget(Vector3.new(-0.31415927, 0, 0))
		playerData.SpringWaistRotation.Freq = 10
	end
	if playerData.Local then
		local sitAnimation = playerData.Humanoid:LoadAnimation(ReplicatedStorage.Resource.SitAnimation)
		sitAnimation:Play()
		playerData.Maid:GiveTask(function()
			sitAnimation:Stop()
			sitAnimation:Destroy()
		end)
	end
end
return CruiserClass
