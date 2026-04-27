local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UI = require(ReplicatedStorage.Module.UI)
local RunService = game:GetService("RunService")
game:GetService("Lighting")
local isStudio = require(ReplicatedStorage.App.RunUtils).isStudio()
local CurrentCamera = workspace.CurrentCamera
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
require(ReplicatedStorage.Module.AlexWM)
local Region = require(ReplicatedStorage.Module.Region)
local Settings = require(ReplicatedStorage.Resource.Settings)
local ChassisShared = require(ReplicatedStorage.Module.ChassisShared)
local PhysicsLagService = require(ReplicatedStorage.App.PhysicsLagService)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Time = require(ReplicatedStorage.Module.Time)
local Spring = require(ReplicatedStorage.Std.Spring)
local Audio = require(ReplicatedStorage.Std.Audio)
local Missile = require(ReplicatedStorage.Game.Missile)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
require(ReplicatedStorage.Module.Wheel.WheelWorld)
require(ReplicatedStorage.Module.Wheel.Wheel)
local CharacterAnim = require(ReplicatedStorage.Game.CharacterAnim)
local EnumMake = require(ReplicatedStorage.Game.Garage.EnumMake)
local Players = game:GetService("Players")
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local LocalPlayer = Players.LocalPlayer
local EnvironmentUtils = require(ReplicatedStorage.Environment.EnvironmentUtils)
local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
local SpeedometerUtils = require(ReplicatedStorage.Speedometer.SpeedometerUtils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
require(ReplicatedStorage.Std.PartUtils)
local Vehicles = workspace:WaitForChild("Vehicles")
local function GetMoveVector()
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local controlModuleInstance = require(ControlModule)
	GetMoveVector = function()
		return controlModuleInstance:GetMoveVector()
	end
end
local Vector3New = Vector3.new
local Angles = CFrame.Angles
local RayNew = Ray.new
local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local min = math.min
local max = math.max
local abs = math.abs
local tanh = math.tanh
local exp = math.exp
local raycastParamsMobile = RaycastParams.new()
raycastParamsMobile.RespectCanCollide = true
raycastParamsMobile.FilterType = Enum.RaycastFilterType.Exclude
raycastParamsMobile.FilterDescendantsInstances = { Vehicles }
local raycastParamsDefault = RaycastParams.new()
raycastParamsDefault.RespectCanCollide = true
raycastParamsDefault.FilterType = Enum.RaycastFilterType.Exclude
raycastParamsDefault.FilterDescendantsInstances = { Vehicles }
local remoteEventServer = nil
local _screenGui = nil
local soundEffectLibrary = {
	Echo = SoundService.Chassis.EchoSoundEffect,
	Equalizer = SoundService.Chassis.EqualizerSoundEffect,
	Reverb = SoundService.Chassis.ReverbSoundEffect
}
local soundEffectProperties = {
	Echo = { "Delay", "DryLevel", "Feedback", "WetLevel" },
	Equalizer = { "HighGain", "LowGain", "MidGain" },
	Reverb = { "DecayTime", "Density", "Diffusion", "DryLevel", "WetLevel" }
}
local environmentSoundProfiles = {
	Tunnel = {
		Echo = {
			Delay = 0.35,
			DryLevel = 0,
			Feedback = 0,
			WetLevel = -27
		},
		Equalizer = {
			HighGain = 0,
			LowGain = -2.5,
			MidGain = -2.5
		},
		Reverb = {
			DecayTime = 3.5,
			Density = 1,
			Diffusion = 0.6,
			DryLevel = 4,
			WetLevel = 0
		}
	},
	Outside = {
		Echo = {
			Delay = 1.5,
			DryLevel = 0,
			Feedback = 0,
			WetLevel = -42.2
		},
		Equalizer = {
			HighGain = 0,
			LowGain = 0,
			MidGain = 0
		},
		Reverb = {
			DecayTime = 10,
			Density = 1,
			Diffusion = 1,
			DryLevel = 0,
			WetLevel = -35
		}
	},
	City = {
		Echo = {
			Delay = 0.198,
			DryLevel = 0,
			Feedback = 0,
			WetLevel = -9.8
		},
		Equalizer = {
			HighGain = 0,
			LowGain = -8,
			MidGain = 0
		},
		Reverb = {
			DecayTime = 4.6,
			Density = 1,
			Diffusion = 0.6,
			DryLevel = 0,
			WetLevel = -28
		}
	}
}
local engineSoundCounter = 0
local function gaussianDistribution(x, mean, sigma)
	return exp(-(x - mean) ^ 2 / (2 * sigma * sigma))
end
local function setVolume(sound, volume)
	if math.abs(sound.Volume - volume) > 0.001 then
		sound.Volume = volume
	end
end
local function setPlaybackSpeed(sound, speed)
	if math.abs(sound.PlaybackSpeed - speed) > 0.001 then
		sound.PlaybackSpeed = speed
	end
end
local function IsNaN(num)
	return num ~= num
end
local function SetRPM3(sounds, rpm, throttle, makeId)
	local baseVolume = 0.2
	local idleVolumeScale = 1
	local onLowSpeed, onMidSpeed, onHighSpeed, offLowSpeed, idleSpeed
	if makeId == EnumMake.Lamborghini or (makeId == EnumMake.Bugatti or (makeId == EnumMake.Chiron or (makeId == EnumMake.Surus or (makeId == EnumMake.Challenger or (makeId == EnumMake.Beignet or (makeId == EnumMake.Macaron or (makeId == EnumMake.Monster or (makeId == EnumMake.Goliath or (makeId == EnumMake.ShellMark5 or (makeId == EnumMake.Power1 or (makeId == EnumMake.Successor or (makeId == EnumMake.OGLaMatador or (makeId == EnumMake.Maverick or (makeId == EnumMake.Wedge or makeId == EnumMake.Revox)))))))))))))) then
		onLowSpeed = rpm / 12000 + 0.5 + 0.07 - 0.1
		onMidSpeed = 1 + rpm / 12000 - 0.5 + 0.07 - 0.1
		onHighSpeed = 1 + rpm / 12000 - 0.3 + 0.25 - 0.1
		offLowSpeed = rpm / 12000 + 0.6 + 0.1 - 0.1
		idleVolumeScale = 0.5
		idleSpeed = (rpm + 2000) / 5500 + 0.8
	elseif makeId == EnumMake.OrionM42 then
		onLowSpeed = rpm / 5500 + 0.2295
		onMidSpeed = 1 + rpm / 6000 - 0.991
		onHighSpeed = 1 + rpm / 6000 - 1.218
		offLowSpeed = rpm / 5500 + 0.2295
		baseVolume = baseVolume * 2.25
		idleSpeed = (rpm + 6500) / 7500
	elseif makeId == EnumMake.Blackbeard or makeId == EnumMake.BlackWidow then
		onLowSpeed = rpm / 10500 + 0.085
		onMidSpeed = 1 + rpm / 12000 - 0.911
		onHighSpeed = 1 + rpm / 20500 - 0.818
		offLowSpeed = rpm / 10500 + 0.085
		baseVolume = baseVolume * 3.75
		idleSpeed = (rpm + 2700) / 6500
	elseif makeId == EnumMake.Katana then
		onLowSpeed = rpm / 3500 + 0.09
		onMidSpeed = rpm / 6200 + 0.05
		onHighSpeed = rpm / 6700 - 0.012
		offLowSpeed = rpm / 3500 + 0.09
		baseVolume = 1
		idleSpeed = (rpm + 9500) / 9500 - 0.1
	elseif makeId == EnumMake.WYNDR then
		onLowSpeed = rpm / 6500 + 0.4
		onMidSpeed = 1 + rpm / 6500 - 0.28
		onHighSpeed = 1 + rpm / 7500 - 0.45
		offLowSpeed = rpm / 6500 + 0.4
		idleSpeed = (rpm + 1800) / 1800 + 0.3
	elseif makeId == EnumMake.Carbonara then
		onLowSpeed = rpm / 3600 + 0.04
		onMidSpeed = rpm / 4100 - 0.1
		onHighSpeed = rpm / 6200 + 0.022
		offLowSpeed = rpm / 3600 + 0.04
		idleSpeed = (rpm + 4900) / 4900 - 0.05
	elseif makeId == EnumMake.Aperture then
		onLowSpeed = rpm / 8500 + 0.22
		onMidSpeed = rpm / 9300 + 0.33
		onHighSpeed = rpm / 16500 + 0.31
		offLowSpeed = rpm / 8500 + 0.22
		idleSpeed = (rpm + 10800) / 10800 - 0.12
	elseif makeId == EnumMake.SWATVan or makeId == EnumMake.Sentinel then
		onLowSpeed = rpm / 10000 + 0.205
		onMidSpeed = rpm / 13000 + 0.175
		onHighSpeed = rpm / 11500 - 0.15
		offLowSpeed = rpm / 10000 + 0.205
		idleSpeed = (rpm + 12500) / 12500 - 0.83
	elseif makeId == EnumMake.Polaire then
		onLowSpeed = rpm / 3500 + 0.235
		onMidSpeed = rpm / 6000 + 0.145
		onHighSpeed = rpm / 9500 + 0.315
		offLowSpeed = rpm / 3500 + 0.235
		idleSpeed = (rpm + 4300) / 4300 - 0.02
	elseif makeId == EnumMake.Bluebird then
		onLowSpeed = rpm / 4500 + 0.165
		onMidSpeed = rpm / 7500 + 0.145
		onHighSpeed = rpm / 10500 + 0.155
		offLowSpeed = rpm / 4500 + 0.165
		idleSpeed = (rpm + 7300) / 7300 - 0.2
	else
		onLowSpeed = rpm / 10000 + 0.2
		onMidSpeed = 1 + rpm / 10000 - 0.7
		onHighSpeed = 1 + rpm / 10000 - 1
		offLowSpeed = rpm / 10000 + 0.2
		idleVolumeScale = 0.6
		idleSpeed = (rpm + 1000) / 6000 + 0.8
	end
	local drivePitchOffset = 0
	local idlePitchOffset = 0
	if makeId == EnumMake.TheRattler or (makeId == EnumMake.ShellClassic or (makeId == EnumMake.Bandit or (makeId == EnumMake.Longhorn or (makeId == EnumMake.Laviolette or (makeId == EnumMake.Hammerhead or (makeId == EnumMake.Delorean or makeId == EnumMake.TowTruck)))))) then
		idlePitchOffset = -0.3
		drivePitchOffset = -0.3
	elseif makeId == EnumMake.MCL36 or makeId == EnumMake.MCL36FREE then
		idlePitchOffset = 0.45
		drivePitchOffset = 0.45
	elseif makeId == EnumMake.Power1 then
		idlePitchOffset = -0.3
		drivePitchOffset = -0.3
	elseif makeId == EnumMake.Blackbeard then
		idlePitchOffset = 0
		drivePitchOffset = -0.15
	end
	local idleSound = sounds.Idle
	local idlePlaybackSpeed = idleSpeed + idlePitchOffset
	setPlaybackSpeed(idleSound, idlePlaybackSpeed)
	local onLowSound = sounds.OnLow
	local onLowPlaybackSpeed = onLowSpeed + drivePitchOffset
	setPlaybackSpeed(onLowSound, onLowPlaybackSpeed)
	local onMidSound = sounds.OnMid
	local onMidPlaybackSpeed = onMidSpeed + drivePitchOffset
	setPlaybackSpeed(onMidSound, onMidPlaybackSpeed)
	local onHighSound = sounds.OnHigh
	local onHighPlaybackSpeed = onHighSpeed + drivePitchOffset
	setPlaybackSpeed(onHighSound, onHighPlaybackSpeed)
	local offLowSound = sounds.OffLow
	local offLowPlaybackSpeed = offLowSpeed + drivePitchOffset
	setPlaybackSpeed(offLowSound, offLowPlaybackSpeed)
	local rpmNormalized = rpm / 8000
	local idleVolume = gaussianDistribution(rpmNormalized, -0.1, 0.2) * baseVolume * idleVolumeScale
	local onLowVolume = gaussianDistribution(rpmNormalized, 0.3, 0.1) * baseVolume
	local onMidVolume = gaussianDistribution(rpmNormalized, 0.6, 0.2) * baseVolume
	local onHighVolume = (rpmNormalized < 0.9 and gaussianDistribution(rpmNormalized, 0.9, 0.15) or 1) * baseVolume
	setVolume(idleSound, idleVolume)
	if throttle > 0 then
		setVolume(onLowSound, onLowVolume)
		setVolume(onMidSound, onMidVolume)
		setVolume(onHighSound, onHighVolume)
		setVolume(offLowSound, 0)
	else
		local onLowCoastVolume = onLowVolume * 0.5
		setVolume(onLowSound, onLowCoastVolume)
		setVolume(onMidSound, onMidVolume)
		setVolume(onHighSound, onHighVolume)
		local offLowCoastVolume = onLowVolume * 0.5
		setVolume(offLowSound, offLowCoastVolume)
	end
end
local function SetRPM1(sounds, rpm, throttle, makeId)
	local idleVolumeOverride = nil
	local rpmNormalized = rpm / if makeId == EnumMake.Volt or makeId == EnumMake.Volt4x4 then 10000 elseif makeId == EnumMake.Roadster then 12000 else 6000
	local playbackScale = 1
	local playbackOffset = 0
	if makeId == EnumMake.DesertCrawler then
		playbackScale = 1.4
		playbackOffset = 0.1
	elseif makeId == EnumMake.BrickKar then
		playbackScale = 1.3
		playbackOffset = 0.4
		idleVolumeOverride = 1.4
	elseif makeId == EnumMake.AdminNuke then
		playbackScale = 1.3
		playbackOffset = -0.4
		idleVolumeOverride = 1.4
	end
	local idleSound = sounds.Idle
	local idlePlaybackSpeed = playbackOffset + playbackScale * (rpm + 3000) / 8000
	setPlaybackSpeed(idleSound, idlePlaybackSpeed)
	if not idleVolumeOverride then
		idleVolumeOverride = gaussianDistribution(rpmNormalized, 1.1, 0.5) * 0.2
	end
	setVolume(idleSound, idleVolumeOverride)
end
local function SetRPMNew(sounds, rpm, throttle, makeId, gear, soundConfig)
	local gearNormalized = gear / 6
	local rpmNormalized = rpm / 6300
	local bandPosition = 5 * rpmNormalized
	local idleBandScale = 0.2
	local driveBandScale = 0.2
	if makeId == EnumMake.Venom or (makeId == EnumMake.Cobra or makeId == EnumMake.Polaire) then
		idleBandScale = idleBandScale * 2
		driveBandScale = driveBandScale * 2
	end
	local idleVolume = gaussianDistribution(bandPosition, 0, 2) * idleBandScale
	local onLowVolume = gaussianDistribution(bandPosition, 1.5, 1) * driveBandScale
	local onMidVolume = gaussianDistribution(bandPosition, 3.25, 1) * driveBandScale
	local onHighVolume = (bandPosition <= 5 and gaussianDistribution(bandPosition, 5, 1) or 1) * driveBandScale
	local basePlaybackSpeed = 0.1 + 1.15 * ((1 + gearNormalized) * (rpmNormalized - 0.4 * gearNormalized))
	local onLowPlaybackSpeed = basePlaybackSpeed * 2 ^ (-soundConfig.low / 12)
	local onMidPlaybackSpeed = basePlaybackSpeed * 2 ^ (-soundConfig.mid / 12)
	local onHighPlaybackSpeed = basePlaybackSpeed * 2 ^ (-soundConfig.high / 12)
	local idlePlaybackSpeed = basePlaybackSpeed * 0.75 + 1
	local idleSound = sounds.Idle
	setVolume(idleSound, idleVolume)
	local onLowSound = sounds.OnLow
	setVolume(onLowSound, onLowVolume)
	local onMidSound = sounds.OnMid
	setVolume(onMidSound, onMidVolume)
	local onHighSound = sounds.OnHigh
	setVolume(onHighSound, onHighVolume)
	setPlaybackSpeed(idleSound, idlePlaybackSpeed)
	setPlaybackSpeed(onLowSound, onLowPlaybackSpeed)
	setPlaybackSpeed(onMidSound, onMidPlaybackSpeed)
	setPlaybackSpeed(onHighSound, onHighPlaybackSpeed)
end
local function SetRPM(soundType, makeId, sounds, rpm, throttle, gear, soundConfig)
	if soundType == "Electric" or (soundType == "BrickKar" or soundType == "AdminNuke") then
		SetRPM1(sounds, rpm, throttle, makeId)
	elseif soundConfig then
		SetRPMNew(sounds, rpm, throttle, makeId, gear, soundConfig)
	else
		SetRPM3(sounds, rpm, throttle, makeId)
	end
end
local function UpdateGearsAndRPM(chassis, gears, speed, forwardInput, dt)
	local Gear = chassis.Gear
	local LastGear = chassis.LastGear
	local gearBlend = chassis.gearBlendProgress
	local LastRPM = chassis.LastRPM
	if chassis.ManualGear then
		if chassis._shiftUp then
			chassis.Gear = chassis.Gear + 1
			chassis._shiftUp = nil
		end
		if chassis._shiftDown then
			chassis.Gear = chassis.Gear - 1
			chassis._shiftDown = nil
		end
		chassis.Gear = math.clamp(chassis.Gear, 1, #gears - 2)
		Gear = chassis.Gear
	end
	local wheelAngularSpeed = speed / (chassis.Wheels[1].Model.PrimaryPart.Size.Y / 2.9) * 1000 / 3600 / 0.34
	local blendedGearRatio
	if LastGear == Gear then
		blendedGearRatio = gears[2 + Gear]
	else
		blendedGearRatio = gears[2 + LastGear] * (1 - gearBlend * gearBlend) + gears[2 + Gear] * gearBlend * gearBlend
		local nextGearBlend = gearBlend + dt / 0.26
		chassis.gearBlendProgress = nextGearBlend
		if nextGearBlend >= 1 then
			chassis.LastGear = Gear
			chassis.gearBlendProgress = 0
		end
	end
	local visualRpm = wheelAngularSpeed * gears[1] * blendedGearRatio * 60 / math.tau
	local targetRpm = wheelAngularSpeed * gears[1] * gears[2 + Gear] * 60 / math.tau
	local rpmDelta = targetRpm - LastRPM
	if not (chassis.NoGears or chassis.ManualGear) then
		if forwardInput > 0 and (rpmDelta > 0 and (targetRpm > 6000 and Gear < #gears - 2)) then
			chassis.Gear = Gear + 1
			if chassis.onGearShift then
				chassis:onGearShift(chassis.Gear, Gear)
			end
		elseif rpmDelta < 0 and (targetRpm < 3400 and Gear > 1) then
			chassis.Gear = Gear - 1
			if chassis.onGearShift then
				chassis:onGearShift(chassis.Gear, Gear)
			end
		end
	end
	SetRPM(chassis.SoundType, chassis.EnumMakeId, chassis.Sounds, visualRpm, forwardInput, Gear, chassis.engineSoundConfig)
	chassis.rpmVisual = visualRpm
	chassis.rpmVisualMax = 7000
	chassis.LastRPM = targetRpm
	if chassis.ManualGear then
		local rpmLimit = chassis._rpmLimit or 6000
		chassis._rpmLimitMult = if targetRpm <= rpmLimit then 1 else math.clamp(rpmLimit / targetRpm, 0, 1)
	end
	if chassis.turboIntakeSound then
		local turboIntakeVolume = math.clamp(chassis.rpmVisual / chassis.rpmVisualMax, 0, 1) ^ 3
		if forwardInput <= 0 then
			turboIntakeVolume = 0
		end
		chassis.turboIntakeSound.Volume = chassis.turboIntakeSound.Volume + (turboIntakeVolume * chassis.maxTurboIntakeSoundVolume - chassis.turboIntakeSound.Volume) * 0.1
		if Gear < chassis.Gear and chassis.turboBlowOff then
			chassis.turboBlowOff.PlaybackSpeed = 1 + (math.random() * 0.15 - 0.075)
			chassis.turboBlowOff:Play()
		end
	end
	return Gear, blendedGearRatio
end
local function updateFOV(chassis)
	local rawFovScale = (chassis.LastFakeGear or 1) ^ 0.5 * (chassis.Model.Engine.AssemblyLinearVelocity.Magnitude / 120)
	if IsNaN(rawFovScale) then
		rawFovScale = 0
	end
	local clampedFovScale = math.clamp(rawFovScale, 0, 3)
	local fovOffsetScale
	if clampedFovScale < 0.825155 then
		fovOffsetScale = clampedFovScale * clampedFovScale * clampedFovScale
	else
		fovOffsetScale = 1 - exp(-clampedFovScale)
	end
	local currentFieldOfView = CurrentCamera.FieldOfView
	CurrentCamera.FieldOfView = currentFieldOfView + (fovOffsetScale * 30 + 70 - currentFieldOfView) * 0.7
end
local chassisInputTable: { [string]: any } = {}
local chassisInput = chassisInputTable
local inputMovementState = { 0, 0, 0, 0, 0, 0 }
local handbrakeEnabled = false
local sirenEnabled = false
local headlightsEnabled = false
local policeMode = false
local function GetMass(model)
	local sum = 0
	for i, v in ipairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			sum = sum + v:GetMass()
		end
	end
	return sum
end
function chassisInputTable.setForward(isForward)
	inputMovementState[1] = if isForward then 1 else 0
end
function chassisInputTable.setBackward(isBackward)
	inputMovementState[3] = if isBackward then 1 else 0
end
function chassisInputTable.onGearShift(chassis, newGear, oldGear)
	if chassis.EnumMakeId == EnumMake.Venom or chassis.EnumMakeId == EnumMake.Polaire then
		Audio.ObjectLocal(chassis.Model.PrimaryPart, 18128231812, {
			Volume = 0.5,
			Pitch = 1
		})
		for modelIndex, metalPart in chassis.Model.Model.Metal:GetChildren() do
			if metalPart:IsA("Attachment") then
				local particleEmitter = metalPart:FindFirstChildWhichIsA("ParticleEmitter")
				if particleEmitter then
					particleEmitter:Emit(3)
				end
			end
		end
	end
	local GearShiftRemote = chassis.Model:FindFirstChild("GearShiftRemote")
	if GearShiftRemote then
		GearShiftRemote:FireServer(newGear, oldGear)
	end
end
function chassisInputTable.toggleSirens()
	policeMode = not policeMode
	remoteEventServer:FireServer("sgcbalmd", "PoliceLights", policeMode)
end
function chassisInputTable.toggleHeadlights()
	remoteEventServer:FireServer("sgcbalmd", "Lights")
end
function chassisInputTable.setHandbrakeEnabled(enabled)
	handbrakeEnabled = enabled
	ChassisShared.HandBrake = enabled
end
function chassisInputTable.DriveToPosition(chassis, targetPosition, options)
local driveOptions = options or {}
chassis.DriveToPosition = targetPosition
chassis.DriveToPositionArrivalRadius = driveOptions.arrivalRadius or 4
chassis.DriveToPositionOnReached = driveOptions.onReached
end
function chassisInputTable.StopDriveToPosition(chassis)
chassis.DriveToPosition = nil
chassis.DriveToPositionOnReached = nil
end
function chassisInputTable.runAction(action)
	if action then
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		if vehiclePacket.Make == "Firetruck" then
			remoteEventServer:FireServer("sgcbalmd", "FiretruckWater", true)
		elseif vehiclePacket.Make == "TheAgent" then
			chassisInputTable.AttemptFireMissile(vehiclePacket)
		elseif action == "Jump" then
			if not vehiclePacket.AreTiresPopped then
				local Engine = vehiclePacket.Model.Engine
				local currentSpeed = SpeedometerUtils.sToH(SpeedometerUtils.studsToMi((math.abs((Engine.Velocity:Dot(Engine.CFrame.LookVector))))))
				local maxJumpForce = vehiclePacket.jumpMaxAmount or 75
				Engine:ApplyImpulse(Vector3.new(0, maxJumpForce - (maxJumpForce - (vehiclePacket.jumpBaseAmount or 40)) * math.clamp(currentSpeed / (vehiclePacket.jumpMaxMph or 500), 0, 1), 0) * Engine.AssemblyMass)
				VehicleUtils.vehicleEffect("Jump", vehiclePacket.Model)
				remoteEventServer:FireServer("sgcbalmd", "Jump")
				vehiclePacket._lastJumpAt = os.clock()
				return true
			end
		else
			remoteEventServer:FireServer("sgcbalmd", "Action")
		end
	elseif ChassisShared.VehicleMake == "Firetruck" then
		remoteEventServer:FireServer("sgcbalmd", "FiretruckWater", false)
	end
	return
end
local function getTransparencyPredicateForHumanoid(humanoid)
	assert(humanoid, "missing humanoid")
	return function(part)
		if part.Parent == humanoid.Parent then
			local limb = humanoid:GetLimb(part)
			if limb == Enum.Limb.LeftArm or limb == Enum.Limb.RightArm then
				return false
			else
				return true
			end
		else
			return true
		end
	end
end
function chassisInput.toggleInsideCamera(chassisPacket)
	local vehiclePacket = chassisPacket or VehicleUtils.GetLocalVehiclePacket()
	if vehiclePacket and not vehiclePacket.Passenger then
		local wasCameraLocked = vehiclePacket.IsCameraLocked
		if wasCameraLocked then
			chassisInput.UnlockCamera(vehiclePacket)
		else
			chassisInput.LockCamera(vehiclePacket)
		end
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChild("Humanoid")
			assert(humanoid, "missing humanoid")
			local transparencyPredicate = getTransparencyPredicateForHumanoid(humanoid)
			if wasCameraLocked then
				CharacterUtils.popInvisible(LocalPlayer.Character, transparencyPredicate)
				return
			end
			CharacterUtils.setInvisible(LocalPlayer.Character, transparencyPredicate)
		end
	end
end
function chassisInput.init(uiConfig)
	_screenGui = uiConfig.ScreenGui
end
function chassisInput.SetGravity(chassis, gravityPct)
	local gravityForce = chassis.Model:FindFirstChild("Engine").AssemblyMass * 9.81 * 20
	local gravityScale = 1 - gravityPct / 196.20000000000002
	if IsNaN(gravityForce) then
		gravityForce = 0
	end
	if IsNaN(gravityScale) then
		gravityScale = 0
	end
	chassis.gravityOffset = gravityForce * gravityScale
end
function chassisInput.VehicleEnter(chassis)
	local Passenger = chassis.Passenger
	local Character = LocalPlayer.Character
	local Humanoid = Character.Humanoid
	local seatMaid = chassis.seatMaid
	seatMaid:GiveTask(function()
		if Character then
			local Head = Character:FindFirstChild("Head")
			if Head then
				local Decal = Head:FindFirstChildOfClass("Decal")
				if Decal then
					Decal.Transparency = 0
				end
			end
		end
	end)
	seatMaid:GiveTask(RunService.Heartbeat:Connect(function()
		updateFOV(chassis)
	end))
	chassis.EnumMakeId = EnumMake[chassis.Make]
	local shouldPlaySeatAnimation = true
	if chassis.EnumMakeId == EnumMake.ATV or chassis.EnumMakeId == EnumMake.Volt then
		chassis.NoLook = true
	elseif chassis.Seat:FindFirstChild("Turret") then
		task.delay(0.1, function()
			for i, v in ipairs(Humanoid:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			local idleTrack = CharacterAnim.getIdleTrack()
			idleTrack:Play()
			seatMaid:GiveTask(function()
				idleTrack:Stop()
			end)
		end)
		shouldPlaySeatAnimation = false
	end
	if shouldPlaySeatAnimation then
		local sitTrack = CharacterAnim.getCarSitTrack()
		sitTrack:Play()
		seatMaid:GiveTask(function()
			sitTrack:Stop()
		end)
	end
	local Steer = chassis.Model:FindFirstChild("Steer")
	if Steer then
		local Offset = Steer:FindFirstChild("Offset")
		if Offset then
			chassis.SteerOffset = Offset.Value
		end
	end
	local Model = chassis.Model
	if not chassis.Seat:FindFirstChild("Visible") then
		local Head = Character:FindFirstChild("Head")
		if Head then
			local Decal = Head:FindFirstChildOfClass("Decal")
			if Decal then
				Decal.Transparency = 1
			end
		end
	end
	ChassisShared.VehicleMake = chassis.Make
	if not Passenger then
		inputMovementState = { 0, 0, 0, 0, 0, 0 }
		handbrakeEnabled = false
		sirenEnabled = false
		ChassisShared.HandBrake = false
		headlightsEnabled = false
		policeMode = chassis.PoliceLights
		chassisInput.SetGravity(chassis, 100)
		local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
		BodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
		BodyAngularVelocity.MaxTorque = Vector3New(chassis.Mass, (1 / 0), chassis.Mass)
		BodyAngularVelocity.Parent = Model.Engine
		chassis.Rotate = BodyAngularVelocity
		chassis.Traction = 1
		chassis.LastForward = 0
		chassis.RotY = 0
		chassis.LastDrift = 0
		chassis.vHeading = 0
		chassis.vGrass = 0
		chassis.vAsphalt = 0
		chassis.vSandstone = 0
		chassis.Gear = 1
		chassis.LastGear = 1
		chassis.LastRPM = 0
		chassis.gearBlendProgress = 0
		chassis.AreTiresPopped = false
		chassis.PopTires = chassisInput.PopTires
		chassis._flagBrakelightsEnabled = false
		chassis._flagHeadlightsEnabled = false
		if chassis.Make ~= "Volt" then
			chassis.IK = R15IKv2.BuildPacketArms(Character)
		end
		if chassis.Make == "TheRattler" then
			chassis.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			chassis.SpringEngineFlaps = Spring.new(0, 0, 0.8, 15)
			chassis.LastEngineRattle = os.clock()
			chassis.RattleFire = {}
			chassis.RattleSmoke = {}
			for i, v in ipairs(Model.Preset.RattlerEngine.EngineGold:GetChildren()) do
				if v:IsA("Attachment") then
					table.insert(chassis.RattleFire, v.Fire)
					table.insert(chassis.RattleSmoke, v.Smoke)
					v.Fire.Enabled = false
					v.Smoke.Enabled = false
				end
			end
		elseif chassis.Make == "Blackbeard" then
			chassis.LastEngineRattle = os.clock()
			chassis.RattleMotors = {}
			chassis.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			chassis.RattleParticles = {}
			for index, enginePart in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = enginePart:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(chassis.RattleMotors, {
						motor = Motor
					})
				end
			end
			for currentTime, sideSign in Model.Preset.RattlerEngine.SecondBody:GetChildren() do
				if sideSign:IsA("Attachment") then
					local wheelRotationOffset = sideSign:FindFirstChildWhichIsA("ParticleEmitter")
					if wheelRotationOffset then
						table.insert(chassis.RattleParticles, wheelRotationOffset)
						wheelRotationOffset.Enabled = false
					end
				end
			end
		elseif chassis.Make == "Shogun" then
			chassis.LastEngineRattle = os.clock()
			chassis.RattleMotors = {}
			chassis.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			for lateralOffset, raycastCFrame in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = raycastCFrame:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(chassis.RattleMotors, {
						motor = Motor
					})
				end
			end
			chassis.RattleParticles = {}
			for thrustForce, suspensionForce in Model.Model:FindFirstChild("SecondBody"):GetDescendants() do
				if suspensionForce:IsA("ParticleEmitter") then
					table.insert(chassis.RattleParticles, suspensionForce)
					suspensionForce.Enabled = false
				end
			end
			chassis.BrakeTrails = {}
			for dampingCoefficient, steerDirection in Model.Model:FindFirstChild("BrakelightGlass"):GetChildren() do
				if steerDirection:IsA("Trail") then
					table.insert(chassis.BrakeTrails, steerDirection)
					steerDirection.Enabled = false
				end
			end
		elseif chassis.Make == "BlackWidow" then
			chassis.LastEngineRattle = os.clock()
			chassis.RattleMotors = {}
			chassis.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			for _, child in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = child:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(chassis.RattleMotors, {
						motor = Motor
					})
				end
			end
			chassis.RattleParticles = {}
			for interpolatedHeightOffset, rayDistance in Model.Preset.RattlerEngine.Metal:QueryDescendants("ParticleEmitter") do
				table.insert(chassis.RattleParticles, rayDistance)
				rayDistance.Enabled = false
			end
		elseif chassis.Make == "Bluebird" then
			chassis.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			chassis.SpringEngineFlaps = Spring.new(0, 0, 0.8, 15)
			chassis.LastEngineRattle = os.clock()
			chassis.RattleFire = {}
			for i, v in ipairs(Model.Preset.RattlerEngine.EngineMetal:GetChildren()) do
				if v:IsA("Attachment") then
					local Fire = v:FindFirstChild("Fire")
					if Fire then
						table.insert(chassis.RattleFire, Fire)
						Fire.Enabled = false
					end
				end
			end
			chassis.BluebirdSupercharger = Audio.ObjectLocal(Model.Engine, 78492749956905, {
				Volume = 0,
				Looped = true,
				RollOffMaxDistance = 352
			})
			seatMaid:GiveTask(function()
				if chassis.BluebirdSupercharger then
					chassis.BluebirdSupercharger:Destroy()
				end
			end)
		elseif chassis.Make == "JBX0031" then
			chassis.ThrusterFlames = true
			chassisInput.UpdateThrusterFlames(Model, 0, 0, 0, {
				vehicleEnter = true
			})
		elseif chassis.Make == "Wedge" or (chassis.Make == "Manta" or (chassis.Make == "Katana" or (chassis.Make == "WYNDR" or chassis.Make == "Polaire"))) then
			local raycastResult = Audio.ObjectLocal(Model.Engine, 132884974895700, {
				Volume = 0,
				Looped = true,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 512,
				RollOffMode = Enum.RollOffMode.InverseTapered
			})
			chassis.maxTurboIntakeSoundVolume = 0.2
			if chassis.Make == "Manta" or chassis.Make == "Polaire" then
				chassis.maxTurboIntakeSoundVolume = 0.1
			end
			local hitInstance = Audio.ObjectLocal(Model.Engine, 118282536530342, {
				Volume = 0.2,
				DoNotPlay = true,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 512,
				RollOffMode = Enum.RollOffMode.InverseTapered
			})
			chassis.turboIntakeSound = raycastResult
			chassis.turboBlowOff = hitInstance
			seatMaid:GiveTask(function()
				raycastResult:Destroy()
				hitInstance:Destroy()
			end)
		end
		chassis.Sounds.DriftSqueal.Volume = 0
		for k, v in pairs(chassis.Sounds) do
			if not v.IsPlaying then
				v:Play()
			end
		end
		chassis.setForward = chassisInput.setForward
		chassis.setBackward = chassisInput.setBackward
		chassis.onGearShift = chassisInput.onGearShift
		local ignoreWater = if chassis.EnumMakeId == EnumMake.Delorean then false else chassis.EnumMakeId ~= EnumMake.Blackbeard
		raycastParamsDefault.IgnoreWater = ignoreWater
		raycastParamsMobile.IgnoreWater = ignoreWater
	end
end
function chassisInput.VehicleLeave(chassis)
	CurrentCamera.FieldOfView = 70
	if chassis.Sounds then
		local outsideProfile = environmentSoundProfiles.Outside
		for effectName, properties in next, soundEffectProperties do
			for index, value in next, properties do
				soundEffectLibrary[effectName][value] = outsideProfile[effectName][value]
			end
		end
		for k, v in pairs(chassis.Sounds) do
			v.Volume = 0
		end
		chassis.Sounds.DriftSqueal:Stop()
	end
	if chassis.IsCameraLocked then
		chassisInput.UnlockCamera(chassis)
	end
	if not chassis.Passenger then
		chassis.Rotate:Destroy()
		chassis.Lift.Force = Vector3.new(0, 0, 0)
		for sideSign, thruster in chassis.EngineThrusters do
			thruster.Drive.Force = Vector3.new(0, 0, 0)
			thruster.Friction.Force = Vector3.new(0, 0, 0)
		end
		chassis.IK = nil
		for lateralOffset, raycastCFrame in chassis.Wheels do
			raycastCFrame.Thruster.Force = Vector3.new(0, 0, 0)
		end
		if chassis.RattleSmoke then
			for thrustForce, suspensionForce in chassis.RattleSmoke do
				suspensionForce.Enabled = false
			end
		end
		if chassis.RattleFire then
			for index, fireParticle in chassis.RattleFire do
				fireParticle.Enabled = false
			end
		end
		if chassis.RattleParticles then
			for suspensionHeightOffset, heightOffsetBase in chassis.RattleParticles do
				heightOffsetBase.Enabled = false
			end
		end
		if chassis.ThrusterFlames then
			chassisInput.UpdateThrusterFlames(chassis.Model, 0, 0, 0, {
				vehicleLeave = true
			})
		end
		if chassis.BrakeTrails then
			for interpolatedHeightOffset, rayDistance in chassis.BrakeTrails do
				rayDistance.Enabled = false
			end
		end
		VehicleUtils.setBrakelightsEnabled(chassis.Model, false)
		local rudder = chassis.Model.Parent and chassis.Model.Preset:FindFirstChild("Rudder")
		if rudder then
			DoorUtils.setPctOpen(rudder, 0.5)
		end
		if chassis._haptic then
			chassis._haptic:Destroy()
			chassis._haptic = nil
		end
	end
end
local thrusterLightsActiveColor = Color3.fromRGB(204, 142, 105)
local thrusterLightsInactiveColor = Color3.fromRGB(68, 54, 43)
local vehicleThrusterLightsStates = {}
local function getThrusterLightsState(vehicle)
	local thrusterLightsState = vehicleThrusterLightsStates[vehicle]
	if not thrusterLightsState then
		local newState = {
			part = nil,
			activeTween = nil,
			isOn = false,
			hotUntil = 0
		}
		vehicleThrusterLightsStates[vehicle] = newState
		thrusterLightsState = newState
	end
	if thrusterLightsState.part == nil or thrusterLightsState.part.Parent == nil then
		local thrusterLightsPart = vehicle.Model:FindFirstChild("ThrusterLights")
		if thrusterLightsPart and thrusterLightsPart:IsA("BasePart") then
			thrusterLightsState.part = thrusterLightsPart
			return thrusterLightsState
		end
		thrusterLightsState.part = nil
	end
	return thrusterLightsState
end
local function setThrusterLightsEnabled(vehicle, isEnabled)
	local thrusterLightsState = getThrusterLightsState(vehicle)
	local part = thrusterLightsState.part
	if part then
		if thrusterLightsState.isOn ~= isEnabled then
			if thrusterLightsState.activeTween then
				thrusterLightsState.activeTween:Cancel()
				thrusterLightsState.activeTween = nil
			end
			thrusterLightsState.isOn = isEnabled
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local tweenGoal = {
				Color = isEnabled and thrusterLightsActiveColor or thrusterLightsInactiveColor
			}
			thrusterLightsState.activeTween = TweenService:Create(part, tweenInfo, tweenGoal)
			thrusterLightsState.activeTween:Play()
		end
	end
end
local vehicleThrusterStates = {}
function chassisInput.UpdateThrusterFlames(model, forwardInput, strafeInput, zVelocity, options)
	local thrusterOptions = options or {}
	local thrusterState = vehicleThrusterStates[model]
	if not thrusterState then
		local thrustersFolder = model.Model:FindFirstChild("Thrusters")
		if thrustersFolder then
			local centerAttachment = thrustersFolder:FindFirstChild("CenterAttachment")
			local rightAttachment = thrustersFolder:FindFirstChild("RightAttachment")
			local leftAttachment = thrustersFolder:FindFirstChild("LeftAttachment")
			if centerAttachment and (rightAttachment and leftAttachment) then
				local centerFlame = centerAttachment:FindFirstChild("Flame")
				local rightFlame = rightAttachment:FindFirstChild("Flame")
				local leftFlame = leftAttachment:FindFirstChild("Flame")
				if centerFlame and (rightFlame and leftFlame) then
					local newThrusterState = {
						thrusters = thrustersFolder,
						centerFlame = centerFlame,
						rightFlame = rightFlame,
						leftFlame = leftFlame,
						thrusterSound = thrustersFolder:FindFirstChild("ThrusterSound")
					}
					vehicleThrusterStates[model] = newThrusterState
					thrusterState = newThrusterState
				else
					return 0
				end
			else
				return 0
			end
		else
			return 0
		end
	end
	local rightFlame = thrusterState.rightFlame
	local leftFlame = thrusterState.leftFlame
	local count = 0
	local centerFlameEnabled = nil
	local rightFlameEnabled = nil
	local optionsTable, leftFlameEnabled
	if strafeInput > 0 or thrusterOptions.client and inputMovementState[2] > 0 then
		optionsTable = thrusterOptions
		leftFlameEnabled = true
		count = count + 1
	else
		leftFlameEnabled = nil
		optionsTable = thrusterOptions
	end
	if strafeInput < 0 or optionsTable.client and inputMovementState[4] > 0 then
		count = count + 1
		rightFlameEnabled = true
	end
	if forwardInput > 0 then
		centerFlameEnabled = true
		count = count + 1
	elseif zVelocity < 1 and zVelocity > -1 then
		rightFlameEnabled = nil
		leftFlameEnabled = nil
		count = 0
	end
	thrusterState.centerFlame.Enabled = centerFlameEnabled == true
	if forwardInput > 0 or zVelocity < 0 then
		rightFlame.Enabled = rightFlameEnabled == true
		leftFlame.Enabled = leftFlameEnabled == true
	else
		rightFlame.Enabled = leftFlameEnabled == true
		leftFlame.Enabled = rightFlameEnabled == true
	end
	local thrusterSound = thrusterState.thrusterSound
	if thrusterSound then
		local targetVolume = if count > 0 then 0.175 else 0
		setVolume(thrusterSound, targetVolume)
		local targetPlaybackSpeed = (count - 1) * 0.1 + 0.7
		setPlaybackSpeed(thrusterSound, targetPlaybackSpeed)
	end
	local thrusterLightsState = getThrusterLightsState(model)
	if optionsTable.vehicleLeave then
		vehicleThrusterStates[model] = nil
		thrusterLightsState.hotUntil = 0
		setThrusterLightsEnabled(model, false)
		task.delay(0.25, function()
			if vehicleThrusterLightsStates[model] == thrusterLightsState and not thrusterLightsState.isOn then
				vehicleThrusterLightsStates[model] = nil
			end
		end)
	elseif optionsTable.vehicleEnter then
		thrusterLightsState.hotUntil = os.clock() + 2.5
		setThrusterLightsEnabled(model, true)
	else
		local now = os.clock()
		if count > 0 then
			thrusterLightsState.hotUntil = now + 2.5
		end
		setThrusterLightsEnabled(model, if count > 0 then true else now < thrusterLightsState.hotUntil)
	end
	return count
end
function chassisInput.UpdateWheelLowQuality(raycastParams, rayDistance, wheelData, wheelRotation)
	local Engine = wheelData.Engine
	local Part = wheelData.Part
	local wheelCFrame = Part.CFrame
	local engineLocalWheelCFrame = Engine.CFrame:ToObjectSpace(wheelCFrame)
	local sideSign = if engineLocalWheelCFrame.X > 0 then 1 else -1
	local wheelRotationOffset = CFrame.new((wheelData.lateralRotateOffset or 0) * sideSign, 0, 0)
	local raycastWheelCFrame = wheelCFrame * CFrame.new((wheelData.lateralOffset or 0) * sideSign, 0, 0) * wheelRotationOffset
	local rayOrigin = raycastWheelCFrame.p
	local Motor = Part.Motor
	local raycastResult = workspace:Raycast(rayOrigin, raycastWheelCFrame:VectorToWorldSpace(Vector3.new(0, -1, 0)) * rayDistance, raycastParams or raycastParamsMobile)
	local hitPosition = if raycastResult then raycastResult.Position else nil
	local suspensionOffsetY = -min(if hitPosition then (hitPosition - rayOrigin).magnitude else rayDistance, rayDistance) + Motor.Part0.Size.Y * 0.5
	local motorOffset = CFrame.new(0, suspensionOffsetY, 0)
	if engineLocalWheelCFrame.Z < 0 then
		motorOffset = motorOffset * Angles(0, Engine.AssemblyAngularVelocity.Y * 0.5, 0)
	end
	Motor.C1 = motorOffset * wheelRotationOffset * Angles(wheelRotation, 0, 0)
	local BridgeMotor = Part:FindFirstChild("BridgeMotor")
	if BridgeMotor then
		local bridgeLocalYOffset = wheelData.bridgeLocalYOffset or 0
		local bridgeOffset = CFrame.new((wheelData.bridgeXOffset or 0) * sideSign, (wheelData.bridgeYOffset or 0) + bridgeLocalYOffset, 0)
		BridgeMotor.C1 = bridgeOffset * CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(engineLocalWheelCFrame.X, suspensionOffsetY - bridgeLocalYOffset, 0)))
	end
end
function chassisInput.UpdateSoundLowQuality(chassis, gears, velocity)
	if chassis.EnumMakeId == nil then
		chassis.EnumMakeId = EnumMake[chassis.Make]
	end
	UpdateGearsAndRPM(chassis, gears, math.abs(velocity.Z), -math.sign(velocity.Z), 1 / 60)
end
local function UpdateThruster(chassis, wheelData, engineThruster, dt)
	local Part = wheelData.Part
	local Engine = wheelData.Engine
	local wheelCFrame = Part.CFrame
	local engineLocalWheelCFrame = Engine.CFrame:ToObjectSpace(wheelCFrame)
	local sideSign = if engineLocalWheelCFrame.X > 0 then 1 else -1
	local wheelRotationOffset = CFrame.new((wheelData.lateralRotateOffset or 0) * sideSign, 0, 0)
	local lateralOffset = CFrame.new((wheelData.lateralOffset or 0) * sideSign, 0, 0)
	local raycastCFrame = wheelCFrame * lateralOffset * wheelRotationOffset
	local rayOrigin = raycastCFrame.p
	local Motor = Part.Motor
	local Thruster = wheelData.Thruster
	local thrustForce = Part.AssemblyMass * 9.81 * 20
	local suspensionForce = thrustForce * chassis.Suspension
	if IsNaN(suspensionForce) then
		suspensionForce = 0
	end
	local dampingCoefficient = suspensionForce / chassis.Bounce
	if IsNaN(dampingCoefficient) then
		dampingCoefficient = 0
	end
	local localWheelVelocity = raycastCFrame:VectorToObjectSpace(Part.Velocity)
	local Height = chassis.Height
	local suspensionHeightOffset = chassis.Model:GetAttribute("GarageSuspensionHeight")
	if suspensionHeightOffset then
		Height = Height + suspensionHeightOffset
	end
	local heightOffsetBase = wheelData._heightOffset or 0
	local interpolatedHeightOffset = heightOffsetBase + ((Part:GetAttribute("ThrusterHeightOffset") or 0) - heightOffsetBase) * 0.1
	wheelData._heightOffset = interpolatedHeightOffset
	local rayDistance = if chassis.AreTiresPopped then chassis.Height - 0.5 else Height + interpolatedHeightOffset
	local raycastResult = workspace:Raycast(p, raycastCFrame:VectorToWorldSpace(Vector3.new(0, -1, 0)) * rayDistance, raycastParamsDefault)
	local hitInstance, hitPosition
	if raycastResult then
		hitInstance = raycastResult.Instance
		hitPosition = raycastResult.Position
	else
		hitPosition = nil
		hitInstance = nil
	end
	local distanceToHit = if hitPosition then (hitPosition - rayOrigin).Magnitude else rayDistance
	local tirePart = chassis.AreTiresPopped and Part.Parent:FindFirstChild("Rim") or Part.Parent:FindFirstChild("TireMesh")
	local tireHeight = if tirePart then tirePart.Size.Y else 0
	local motorYOffset = -min(distanceToHit, rayDistance) + tireHeight * 0.5
	local Y = Motor.C1.Y
	local interpolatedMotorY = Y + (motorYOffset - Y) * 0.5
	local motorCFrame = CFrame.new(0, interpolatedMotorY, 0) * lateralOffset
	local previousMotorC1 = Motor.C1
	local Drift = Part:FindFirstChild("Drift")
	if engineLocalWheelCFrame.Z < 0 then
		motorCFrame = motorCFrame * Angles(0, chassis.RotY * 0.4 + Engine.RotVelocity.Y * 0.2, 0)
	elseif Drift and (hitInstance and (handbrakeEnabled or chassis.Drift)) then
		chassis._didAnyWheelDrift = true
		Drift.C0 = CFrame.new(0, -interpolatedMotorY + tireHeight * 0.5, 0)
		for _, driftChild in Drift.Part0:GetChildren() do
			if driftChild:IsA("ParticleEmitter") then
				local driftAccumulation = (driftChild:GetAttribute("DriftAccum") or 0) + driftChild.Rate * dt
				local driftEmitCount = math.floor(driftAccumulation)
				if driftEmitCount > 0 then
					driftChild:Emit(driftEmitCount)
				end
				driftChild:SetAttribute("DriftAccum", driftAccumulation - driftEmitCount)
			end
		end
	end
	local finalMotorCFrame = motorCFrame * wheelRotationOffset * Angles(engineThruster.WheelRotation or 0, 0, 0)
	if finalMotorCFrame.x ~= finalMotorCFrame.x or (finalMotorCFrame.y ~= finalMotorCFrame.y or (finalMotorCFrame.z ~= finalMotorCFrame.z or abs(finalMotorCFrame.x + finalMotorCFrame.y + finalMotorCFrame.z) > 100)) then
		finalMotorCFrame = previousMotorC1
	end
	Motor.C1 = finalMotorCFrame
	local forceDivisor = 4 / wheelData.NumWheels
	if hitInstance then
		local dampingForce = localWheelVelocity * dampingCoefficient
		local maxThrustForce = thrustForce * 0.5
		local minThrustForce = -thrustForce * 0.5
		local sum = (rayDistance - min(distanceToHit, rayDistance)) ^ 2 * (suspensionForce / rayDistance ^ 2)
		if localWheelVelocity.magnitude > 0.01 then
			sum = sum - dampingForce.Y
		end
		if IsNaN(sum) then
			sum = 0
		end
		local physicsMultiplier = 1
		local physicsStepsMult = PhysicsLagService.getEstimatedPhysicsStepsMult()
		if physicsStepsMult >= 1 then
			physicsMultiplier = physicsMultiplier / physicsStepsMult
		end
		Thruster.Force = Vector3New(0, if maxThrustForce < sum then maxThrustForce elseif sum < minThrustForce then minThrustForce else sum * math.clamp(physicsMultiplier, 0, 1) * forceDivisor, 0)
	else
		Thruster.Force = Vector3.new(0, 0, 0)
	end
	local BridgeMotor = Part:FindFirstChild("BridgeMotor")
	if BridgeMotor then
		local bridgeLocalYOffset = wheelData.bridgeLocalYOffset or 0
		local bridgeCFrame = CFrame.new((wheelData.bridgeXOffset or 0) * sideSign, (wheelData.bridgeYOffset or 0) + bridgeLocalYOffset, 0)
		BridgeMotor.C1 = bridgeCFrame * CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(engineLocalWheelCFrame.X, interpolatedMotorY - bridgeLocalYOffset, 0)))
	end
end
local function fpor2Autopilot(origin, rayVec, ignoreModel)
	local magnitude = rayVec.magnitude
	local unit = rayVec.unit
	local hitCount = 0
	local currentOrigin = origin
	local traveledDistance = 0
	local ignoreList = { ignoreModel }
	while true do
		local hitPart, hitPosition, hitNormal
		hitCount = hitCount + 1
		local candidatePart, candidatePosition, candidateNormal = FindPartOnRayWithIgnoreList(workspace, RayNew(currentOrigin, unit * (magnitude - traveledDistance)), ignoreList, false, true)
		if candidatePart then
			if candidatePart.CanCollide then
				if candidatePart.Material == Enum.Material.Asphalt then
					hitPart = candidatePart
				else
					hitPart = nil
				end
			end
		end
		if not hitPart then
			table.insert(ignoreList, candidatePart)
		end
		traveledDistance = (origin - candidatePosition).magnitude
		if hitPart or (magnitude - traveledDistance <= 0.001 or hitCount > 4) then
			if hitPart then
				hitPosition = candidatePosition
				hitNormal = candidateNormal
			else
				hitPosition = origin + unit * magnitude
				hitNormal = Vector3.new(0, -1, 0)
			end
			return hitPart, hitPosition, hitNormal
		end
		currentOrigin = candidatePosition
	end
end
local largeVehicleWhitelist = {
	[EnumMake.Proto8] = true,
	[EnumMake.Parisian] = true,
	[EnumMake.Semi] = true,
	[EnumMake.PrisonBus] = true,
	[EnumMake.Aperture] = true,
	[EnumMake.Fiasco] = true
}
local vehicleMaxHornPitch = {
	[EnumMake.Firetruck] = 450,
	[EnumMake.Surus] = 450,
	[EnumMake.BankTruck] = 450,
	[EnumMake.Volt4x4] = 450,
	[EnumMake.Interrogator] = 450,
	[EnumMake.Sentinel] = 450,
	[EnumMake.TheCamper] = 450,
	[EnumMake.Roadster] = 450,
	[EnumMake.Boxer] = 450,
	[EnumMake.Ray9] = 450,
	[EnumMake.JackRabbit] = 450,
	[EnumMake.ShellClassic] = 450,
	[EnumMake.Bandit] = 450,
	[EnumMake.Parisian] = 450,
	[EnumMake.Carbonara] = 450,
	[EnumMake.Laviolette] = 450,
	[EnumMake.Venom] = 450,
	[EnumMake.Beignet] = 450,
	[EnumMake.Snake] = 450,
	[EnumMake.MoltenM12] = 450,
	[EnumMake.Scorpio] = 450,
	[EnumMake.Iceborn] = 300,
	[EnumMake.OrionM42] = 450,
	[EnumMake.Polaire] = 175,
	[EnumMake.Challenger] = 175,
	[EnumMake.Deja] = 175,
	[EnumMake.Shogun] = 148.75,
	[EnumMake.Bugatti] = 175,
	[EnumMake.Stormrider] = 175,
	[EnumMake.Revox] = 175,
	[EnumMake.Badger] = 175,
	[EnumMake.Mustang] = 175,
	[EnumMake.TheAgent] = 175,
	[EnumMake.Blackbeard] = 175,
	[EnumMake.WYNDR] = 175,
	[EnumMake.MCL36] = 550,
	[EnumMake.MCL36FREE] = 550,
	[EnumMake.Manta] = 550,
	[EnumMake.Striker] = 175,
	[EnumMake.XRK] = 450,
	[EnumMake.Maverick] = 175,
	[EnumMake.BananaCar] = 100,
	[EnumMake.Power1] = 450,
	[EnumMake.Successor] = 450,
	[EnumMake.Bluebird] = 175,
	[EnumMake.JBX0031] = 175,
	[EnumMake.Proto8] = 450,
	[EnumMake.Goliath] = 550,
	[EnumMake.PizzaDelivery] = 100,
	[EnumMake.BrickKar] = 450,
	[EnumMake.TheCamper] = 300,
	[EnumMake.AdminNuke] = 900
}
function chassisInput.UpdateEngine(chassis, engineThruster, dt)
	local Model = chassis.Model
	local CanDrive = engineThruster.CanDrive
	local Engine = engineThruster.Engine
	local engineCFrame = Engine.CFrame
	local engineHalfSize = Engine.Size * 0.5
	local Rotate = chassis.Rotate
	local Height = chassis.Height
	local gravityForce = Engine.AssemblyMass * 9.81 * 20
	local TurnSpeed = chassis.TurnSpeed
	local EnumMakeId = chassis.EnumMakeId
	local localVelocity = engineCFrame:VectorToObjectSpace(Engine.AssemblyLinearVelocity)
	local Magnitude = localVelocity.Magnitude
	local currentTime = os.clock()
	local _spinOutAt = chassis._spinOutAt
	if _spinOutAt then
		_spinOutAt = currentTime - chassis._spinOutAt < 3
	end
	local forwardInput = inputMovementState[1] - inputMovementState[3]
	local steerInput = inputMovementState[2] - inputMovementState[4]
	if InputUtils.isTouch() then
		local X = GetMoveVector().X
		local lateralOffset = math.clamp(X, -1, 1)
		steerInput = -lateralOffset * abs(lateralOffset)
	end
	if _spinOutAt then
		forwardInput = forwardInput * 0.5
		if chassis.AreTiresPopped and chassis._spinOutLeft ~= nil then
			TurnSpeed = chassis._pitTurnSpeed or 2
			steerInput = if chassis._spinOutLeft then 1 else -1
		end
	end
	local forceHardBraking = Model:GetAttribute("ForceHardBraking") == true
	if forceHardBraking then
		handbrakeEnabled = true
	end
	if chassis.LockMovement or Model:GetAttribute("LockMovement") then
		forwardInput = 0
		steerInput = 0
	end
	if chassis.DriveToPosition and (forwardInput == 0 and steerInput == 0) then
		local DriveToPosition = chassis.DriveToPosition
		local enginePosition = engineCFrame.p
		local driveDirection = Vector3New(DriveToPosition.X - enginePosition.X, 0, DriveToPosition.Z - enginePosition.Z)
		if driveDirection.Magnitude <= (chassis.DriveToPositionArrivalRadius or 4) then
			local DriveToPositionOnReached = chassis.DriveToPositionOnReached
			chassis.DriveToPosition = nil
			chassis.DriveToPositionOnReached = nil
			if DriveToPositionOnReached then
				DriveToPositionOnReached:Fire()
			end
			forwardInput = 0
			steerInput = 0
		else
			local LookVector = engineCFrame.LookVector
			local Unit = Vector3New(LookVector.X, 0, LookVector.Z).Unit
			local Unit_2 = driveDirection.Unit
			local directionAlignment = Unit:Dot(Unit_2)
			local steerDirection = math.clamp(-(Unit.X * Unit_2.Z - Unit.Z * Unit_2.X) * 2.5, -1, 1)
			if directionAlignment > 0.3 then
				forwardInput, steerInput = math.min(1, 0.3 + 0.7 * directionAlignment), steerDirection
			elseif directionAlignment < -0.3 then
				forwardInput, steerInput = math.max(-1, -0.3 + 0.7 * directionAlignment), steerDirection
			else
				forwardInput = 0
				steerInput = steerDirection
			end
		end
	elseif chassis.Autopilot then
		local headingDirection = engineCFrame.lookVector:Cross(Vector3.new(0, 1, 0))
		local laneDetectionResult = fpor2Autopilot(engineCFrame * Vector3New(0, 0, -engineHalfSize.Z - abs(localVelocity.Z) * 16 * dt), Vector3.new(0, -10, 0), Model)
		if laneDetectionResult then
			local laneAlignment = (laneDetectionResult.CFrame * Vector3New(-laneDetectionResult.Size.X * 0.5 + math.floor((laneDetectionResult.CFrame:toObjectSpace(engineCFrame).X + laneDetectionResult.Size.X * 0.5) / 12) * 12 + 6, 0, -laneDetectionResult.Size.Z * 0.5 * if engineCFrame.lookVector:Dot(laneDetectionResult.CFrame.lookVector) > 0 then 1 else -1) - engineCFrame.p).unit:Dot(headingDirection)
			local alignmentStrength = laneAlignment * 4
			local steerAdjustment = steerInput - if alignmentStrength < -1 then -1 elseif alignmentStrength > 1 then 1 else alignmentStrength
			local forwardAdjustment = forwardInput + (1 - abs(laneAlignment) ^ 1/6) - abs(laneAlignment) ^ 4 * 0.3
			forwardInput = if forwardAdjustment > 1 then 1 elseif forwardAdjustment < -1 then -1 else forwardAdjustment
			steerInput = if steerAdjustment > 1 then 1 elseif steerAdjustment < -1 then -1 else steerAdjustment
		end
	end
	local vHeading = chassis.vHeading
	local calculatedHeading = vHeading + steerInput * dt * 60 - vHeading * if steerInput == 0 then 0.3 else 0.16 * dt * 60
	chassis.vHeading = calculatedHeading
	local engineLocalWheelCFrame = calculatedHeading * 0.16
	local Cd = chassis.Cd
	local Crr = chassis.Crr
	local Cb = chassis.Cb
	local dampingForce = nil
	local TirePopProportion = chassis.TirePopProportion
	local maxThrustForce = Model:GetAttribute("VehicleTiresLastPop") or 0
	local popRecoveryProgress = math.min((Time.GetNowSync() - maxThrustForce) / chassis.DisableDuration, 1)
	local physicsMultiplier = if popRecoveryProgress < 0.999 then chassis.Make ~= "AdminNuke" else false
	if physicsMultiplier then
		local physicsStepsMult = if popRecoveryProgress < TirePopProportion then 0 else (popRecoveryProgress - TirePopProportion) / (1 - TirePopProportion)
		dampingForce = gravityForce * ((Vector3.new(0, 0, 0) - localVelocity) / ((1 - physicsStepsMult) * 200 + physicsStepsMult * 500))
		forwardInput = 0
		if Magnitude > 30 then
			chassis.LastDrift = tick()
		end
	end
	chassis.AreTiresPopped = physicsMultiplier
	if steerInput ~= 0 and (steerInput / abs(steerInput) ~= localVelocity.X / abs(localVelocity.X) and abs(localVelocity.X) > 8) then
		chassis.LastDrift = tick()
	end
	local isRecentDrift = tick() - chassis.LastDrift < 0.3
	if EnumMakeId == EnumMake.Volt then
		handbrakeEnabled = false
		isRecentDrift = false
	end
	chassis.Drift = isRecentDrift
	local isDriftActive = if Magnitude > 50 then handbrakeEnabled or chassis.Drift else false
	if isDriftActive and chassis._haptic == nil then
		chassis._haptic = HapticEffect.basic(0.2, (1 / 0))
	elseif chassis._haptic and not isDriftActive then
		chassis._haptic:Destroy()
		chassis._haptic = nil
	end
	local Volume = chassis.Sounds.DriftSqueal.Volume
	chassis.Sounds.DriftSqueal.Volume = if Magnitude > 30 and (isRecentDrift or handbrakeEnabled and steerInput ~= 0) or (_spinOutAt or chassis.LaunchSpeedMult) then Volume + (0.3 - Volume) * 0.06 else Volume + (0 - Volume) * 0.1
	chassisInput.UpdateForces(chassis, engineThruster, dt)
	local forwardVelocityFrame = localVelocity.Z * dt
	if IsNaN(forwardVelocityFrame) then
		forwardVelocityFrame = 0
	end
	engineThruster.WheelRotation = ((engineThruster.WheelRotation or 0) + forwardVelocityFrame / (chassis.Wheels[1].Model.PrimaryPart.Size.Y * 0.5)) % math.tau
	local velocityDampingFactor = tanh(abs(localVelocity.magnitude) * 0.03)
	local Traction = chassis.Traction
	local tractionScale = (handbrakeEnabled or isRecentDrift) and (1 - velocityDampingFactor) ^ 2 or 1
	if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
		tractionScale = tractionScale * 0.4
	end
	if _spinOutAt then
		tractionScale = tractionScale * 0.6
	end
	local smoothedTraction = if tractionScale < 0.07 then 0.07 else tractionScale
	local currentTraction = Traction + (smoothedTraction - Traction) * if smoothedTraction < Traction then 0.2 else 0.01 * dt * 60
	if currentTraction < 0 then
		currentTraction = 0
	end
	chassis.Traction = currentTraction
	local Gears = chassis.Gears
	local forwardSpeed = math.abs(localVelocity.Z)
	local currentGear, gearRatioMult = UpdateGearsAndRPM(chassis, Gears, forwardSpeed, forwardInput, dt)
	chassis.LastFakeGear = gearRatioMult
	local vector52 = workspace:Raycast(engineCFrame * Vector3New(0, 0, engineHalfSize.Z - 1), engineCFrame:vectorToWorldSpace(Vector3.new(0, -1, 0)) * Height * 2, raycastParamsDefault)
	local groundHit, groundMaterial
	if vector52 then
		groundHit = vector52.Instance
		groundMaterial = vector52.Material
	else
		groundMaterial = nil
		groundHit = nil
	end
	local hasLaunchControl = chassis.CanLaunchControl == true
	if hasLaunchControl and (inputMovementState[1] == 1 and (inputMovementState[3] == 1 and (forwardSpeed < 10 and not (chassis.LaunchSpeedMult or chassis.AreTiresPopped)))) then
		if chassis.LaunchHeldSince == nil then
			chassis.LaunchHeldSince = os.clock()
		end
		if chassis.LaunchHoldSound == nil then
			chassis.LaunchHoldSound = Audio.ObjectLocal(Model.Engine, 115412433949268, {
				Volume = 0,
				Looped = true,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 512,
				RollOffMode = Enum.RollOffMode.InverseTapered
			})
		end
		chassis.LaunchHoldSound.Volume = math.clamp(chassis.LaunchHoldSound.Volume + dt * 0.8, 0, 0.6)
		chassis.LastDrift = tick()
	elseif hasLaunchControl and (chassis.LaunchHeldSince and (os.clock() - chassis.LaunchHeldSince >= 2 and forwardInput == 1)) then
		print("LAUNCH!")
		chassis.LaunchHeldSince = nil
		chassis.LaunchStartedAt = os.clock()
		chassis.LaunchSpeedMult = 4
		Audio.ObjectLocal(Model.Engine, 15684233147, {
			Volume = 1.5,
			RollOffMaxDistance = 128,
			RollOffMinDistance = 32
		})
	elseif hasLaunchControl then
		chassis.LaunchHeldSince = nil
		if chassis.LaunchHoldSound then
			chassis.LaunchHoldSound.Volume = 0
		end
		if chassis.LaunchSpeedMult then
			chassis.LaunchSpeedMult = chassis.LaunchSpeedMult - dt * 3
			if chassis.LaunchSpeedMult < 1 then
				chassis.LaunchSpeedMult = nil
			end
		end
	end
	if not chassis.TractionMag then
		chassis.TractionMag = vehicleMaxHornPitch[EnumMakeId] or 300
	end
	local dragForce = -Cd * localVelocity * Magnitude * Vector3New(0, 0, if forwardInput < 0 then 80 else 1)
	local vector63 = -Crr * localVelocity * Vector3.new(0, 0, 1)
	local lateralFrictionForce = -Vector3New(math.clamp(localVelocity.X, -150, 150), 0, 0) * chassis.TractionMag * currentTraction * 150 / 588600 * gravityForce
	if EnumMakeId == EnumMake.ATV and gravityForce * 0.05 < math.abs(vector63.X) then
		vector63 = Vector3.new(math.clamp(vector63.X, -gravityForce * 0.05, gravityForce * 0.05), 0, vector63.Z)
	end
	local gravityNormalized = gravityForce / 196.20000000000002
	local brakingForce = -(Cb * (1 + chassis.GarageBrakes)) * localVelocity.Z / abs(localVelocity.Z)
	if IsNaN(brakingForce) then
		brakingForce = 0
	end
	local vector69 = brakingForce / 18000 * gravityNormalized * Vector3.new(0, 0, 1)
	if forceHardBraking then
		vector69 = vector69 * 40
	end
	local vector70 = -Cb * 0.3 * localVelocity * Vector3.new(1, 0, 0)
	local Nitro = chassis.Nitro
	local _lastJumpAt = chassis._lastJumpAt
	if _lastJumpAt then
		_lastJumpAt = os.clock() - chassis._lastJumpAt < 2
	end
	if Nitro and not (chassis.Nitrof1 or _lastJumpAt) then
		chassis.Nitrof1 = true
		chassisInput.SetGravity(chassis, 20)
	elseif (not Nitro or _lastJumpAt) and chassis.Nitrof1 then
		chassis.Nitrof1 = false
		chassisInput.SetGravity(chassis, 100)
	end
	local finalGearRatio = if chassis.NoGears then forwardInput > 0 and Gears[1] or Gears[2] else forwardInput > 0 and Gears[2 + currentGear] or Gears[2]
	local rotationFactor = 4.4
	if EnumMakeId == EnumMake.Lamborghini or (EnumMakeId == EnumMake.OGLaMatador or EnumMakeId == EnumMake.Hammerhead) then
		rotationFactor = 5.5
	elseif EnumMakeId == EnumMake.Ambulance then
		rotationFactor = 5
	elseif EnumMakeId == EnumMake.Bandit then
		rotationFactor = 57/5 * gravityNormalized / 4300
	elseif EnumMakeId == EnumMake.FrostCrawler then
		rotationFactor = 2.485 * gravityNormalized / 4600
	elseif EnumMakeId == EnumMake.Laviolette then
		rotationFactor = 3 * gravityNormalized / 4300
	elseif EnumMakeId == EnumMake.Crown then
		rotationFactor = 11.2 * gravityNormalized / 3304
	elseif EnumMakeId == EnumMake.DesertCrawler then
		rotationFactor = 9 * gravityNormalized / 3894
	elseif EnumMakeId == EnumMake.ShellMark5 then
		rotationFactor = 6.6 * gravityNormalized / 3089
	elseif EnumMakeId == EnumMake.Goliath then
		rotationFactor = 2.6 * gravityNormalized / 12720 * 4
	elseif EnumMakeId == EnumMake.Bloxy then
		rotationFactor = 6.6 * gravityNormalized / 3948
	elseif EnumMakeId == EnumMake.TinyToy then
		rotationFactor = 1.02 * gravityNormalized / 720
	elseif EnumMakeId == EnumMake.ShellClassic then
		rotationFactor = 5.5 * gravityNormalized / 2250
	elseif EnumMakeId == EnumMake.Snake then
		rotationFactor = 13.3 * gravityNormalized / 5449 * 1.39
	elseif EnumMakeId == EnumMake.Scorpio then
		rotationFactor = 25.27 * gravityNormalized / 12583
	elseif EnumMakeId == EnumMake.Successor then
		rotationFactor = 9.545689999999999 * gravityNormalized / 3018
	elseif EnumMakeId == EnumMake.Macaron then
		rotationFactor = 9.182440218957073 * gravityNormalized / 5543 * 1.6
	elseif EnumMakeId == EnumMake.JackRabbit then
		rotationFactor = 3.331709741550696 * gravityNormalized / 3047
	elseif EnumMakeId == EnumMake.Poseidon then
		rotationFactor = 5.43452380952381 * gravityNormalized / 3024
	elseif EnumMakeId == EnumMake.MCL36 or EnumMakeId == EnumMake.MCL36FREE then
		rotationFactor = 132500 / gravityNormalized
	elseif EnumMakeId == EnumMake.TowTruck then
		rotationFactor = 6.6 * gravityNormalized / 4000 * 2
	elseif EnumMakeId == EnumMake.NASCAR1 then
		rotationFactor = 11.407
	elseif EnumMakeId == EnumMake.NASCAR2 or EnumMakeId == EnumMake.NASCAR75th then
		rotationFactor = 6.039
	elseif EnumMakeId == EnumMake.Trailblazer then
		rotationFactor = 12.552631578947368
	elseif EnumMakeId == EnumMake.Concept then
		rotationFactor = 106/11
	elseif EnumMakeId == EnumMake.Torero then
		rotationFactor = 15.847
	elseif EnumMakeId == EnumMake.Beignet then
		rotationFactor = 10.794242074927956
	elseif EnumMakeId == EnumMake.Ray9 then
		rotationFactor = 5.4
	elseif EnumMakeId == EnumMake.TheRattler then
		rotationFactor = 5.5
	elseif EnumMakeId == EnumMake.Ferrari then
		rotationFactor = 6
	elseif EnumMakeId == EnumMake.BananaCar then
		rotationFactor = 18
	elseif EnumMakeId == EnumMake.Challenger then
		rotationFactor = 273/50
	elseif EnumMakeId == EnumMake.Surus then
		rotationFactor = 6
	elseif EnumMakeId == EnumMake.MoltenM12 then
		rotationFactor = 6.56
	elseif EnumMakeId == EnumMake.Bugatti then
		rotationFactor = 8
	elseif EnumMakeId == EnumMake.Parisian then
		rotationFactor = 24.8
	elseif EnumMakeId == EnumMake.Chiron then
		rotationFactor = 8.8 * gravityNormalized / 3303
	elseif EnumMakeId == EnumMake.Model3 then
		rotationFactor = 4.2
	elseif EnumMakeId == EnumMake.Roadster then
		rotationFactor = 9
	elseif EnumMakeId == EnumMake.IceBreaker then
		rotationFactor = 8.5
	elseif EnumMakeId == EnumMake.Proto8 then
		rotationFactor = 6.73
	elseif EnumMakeId == EnumMake.Monster then
		rotationFactor = 5.75
	elseif EnumMakeId == EnumMake.OGMonster then
		rotationFactor = 5
	elseif EnumMakeId == EnumMake.Firetruck then
		rotationFactor = 10 * gravityNormalized / 10418
	elseif EnumMakeId == EnumMake.ATV then
		rotationFactor = 1.5
	elseif EnumMakeId == EnumMake.BankTruck then
		rotationFactor = 16.8
	elseif EnumMakeId == EnumMake.BeamHybrid then
		rotationFactor = 6.5
	elseif EnumMakeId == EnumMake.AirTail then
		rotationFactor = 7.5
	elseif EnumMakeId == EnumMake.Volt4x4 then
		rotationFactor = 20
	elseif EnumMakeId == EnumMake.TheAgent then
		rotationFactor = 8.5
	elseif EnumMakeId == EnumMake.Interrogator then
		rotationFactor = 6
	elseif EnumMakeId == EnumMake.Sentinel then
		rotationFactor = 7
	elseif EnumMakeId == EnumMake.TheCamper then
		rotationFactor = 759/40
	elseif EnumMakeId == EnumMake.R8 then
		rotationFactor = 6.072
	elseif EnumMakeId == EnumMake.Semi then
		rotationFactor = 4.928000000000001
	elseif EnumMakeId == EnumMake.Stormrider then
		rotationFactor = 19.712000000000003
	elseif EnumMakeId == EnumMake.Shogun then
		rotationFactor = 4.95 * gravityNormalized / 3010 * 1.8
	elseif EnumMakeId == EnumMake.PrisonBus then
		rotationFactor = 5
	elseif EnumMakeId == EnumMake.Power1 then
		rotationFactor = 7.700000000000001 * gravityNormalized / 2267 * 0.95
	elseif EnumMakeId == EnumMake.Aperture then
		rotationFactor = 7.2 * gravityNormalized / 2242
	elseif EnumMakeId == EnumMake.Fiasco then
		rotationFactor = 12.32
	elseif EnumMakeId == EnumMake.Longhorn then
		rotationFactor = 10.26
	elseif EnumMakeId == EnumMake.Carbonara then
		rotationFactor = 7.6 * gravityNormalized / 2601
	elseif EnumMakeId == EnumMake.XRK then
		rotationFactor = rotationFactor * 1.44256
	elseif EnumMakeId == EnumMake.Striker then
		rotationFactor = rotationFactor * 0.7
	elseif EnumMakeId == EnumMake.SWATVan then
		rotationFactor = rotationFactor * 1.32
	elseif EnumMakeId == EnumMake.Wedge then
		rotationFactor = rotationFactor * 1.3
	elseif EnumMakeId == EnumMake.Manta then
		rotationFactor = rotationFactor * 9.2
	elseif EnumMakeId == EnumMake.Iceborn then
		rotationFactor = rotationFactor * (gravityNormalized / 2250 * 1.00933 * 1.05)
	elseif EnumMakeId == EnumMake.Tanker then
		rotationFactor = rotationFactor * 3
	elseif EnumMakeId == EnumMake.Revox then
		rotationFactor = rotationFactor * 1.830907534246575
	elseif EnumMakeId == EnumMake.Deja then
		rotationFactor = rotationFactor * 2
	elseif EnumMakeId == EnumMake.McLaren then
		rotationFactor = rotationFactor * 1.3
	elseif EnumMakeId == EnumMake.Cobra then
		rotationFactor = rotationFactor * 1.7
	elseif EnumMakeId == EnumMake.Expeditioner then
		rotationFactor = rotationFactor * 1.6
	elseif EnumMakeId == EnumMake.Wraith then
		rotationFactor = rotationFactor * 1.3
	elseif EnumMakeId == EnumMake.Badger then
		rotationFactor = rotationFactor * 1.5
	elseif EnumMakeId == EnumMake.Mustang then
		rotationFactor = rotationFactor * 1.25
	elseif EnumMakeId == EnumMake.Blackbeard then
		rotationFactor = rotationFactor * 2.508
	elseif EnumMakeId == EnumMake.OrionM42 then
		rotationFactor = rotationFactor * 0.768
	elseif EnumMakeId == EnumMake.Maverick then
		rotationFactor = rotationFactor * 1.6
	elseif EnumMakeId == EnumMake.Katana then
		rotationFactor = rotationFactor * 2.3
	elseif EnumMakeId == EnumMake.WYNDR then
		rotationFactor = rotationFactor * 1.6
	elseif EnumMakeId == EnumMake.PizzaDelivery then
		rotationFactor = rotationFactor * 10
	elseif EnumMakeId == EnumMake.BrickKar then
		rotationFactor = rotationFactor * 6.8
	elseif EnumMakeId == EnumMake.Polaire then
		rotationFactor = rotationFactor * 5.7
	elseif EnumMakeId == EnumMake.BlackWidow then
		rotationFactor = rotationFactor * 1.55
	elseif EnumMakeId == EnumMake.AdminNuke then
		rotationFactor = 60
	elseif EnumMakeId == EnumMake.Bluebird then
		rotationFactor = 44.6
	end
	if chassis.EngineSpeedMult then
		rotationFactor = rotationFactor * chassis.EngineSpeedMult
	end
	if chassis.LaunchSpeedMult then
		rotationFactor = rotationFactor * chassis.LaunchSpeedMult
	end
	local sum = rotationFactor + chassis.GarageEngineSpeed
	if not largeVehicleWhitelist[EnumMakeId] then
		sum = sum + 0.5
	end
	chassis.TrueEngineSpeed = sum
	local vector78 = forwardInput * Vector3.new(0, 0, -1) * Gears[1] * 1 / 0.34 * 750 * finalGearRatio * sum
	if groundMaterial and (groundMaterial == Enum.Material.Water and raycastParamsDefault.IgnoreWater) then
		vector78 = vector78 * 0.625
	end
	if chassis.ManualGear and chassis._rpmLimitMult then
		vector78 = vector78 * chassis._rpmLimitMult
	end
	local sum_2 = dragForce + vector63
	if forwardInput ~= 0 and forwardInput == forwardInput then
		chassis.LastForward = forwardInput / abs(forwardInput)
		sum_2 = sum_2 + vector78
	end
	if forwardInput == 0 and Magnitude <= 1 then
		Engine.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	elseif forwardInput == 0 then
		sum_2 = sum_2 + vector69
	end
	if handbrakeEnabled and (steerInput == 0 and forwardInput == 0) then
		sum_2 = sum_2 + vector69 * 3 + vector70
	end
	local torqueRoll = 0
	local torquePitch = 0
	local torqueYaw = 0
	local RotY = chassis.RotY
	chassis.RotY = RotY + (steerInput - RotY) * 0.1
	if chassis.driveInAir then
		groundMaterial = Enum.Material.SmoothPlastic
	end
	if groundHit or chassis.driveInAir then
		if groundMaterial == Enum.Material.Grass then
			torqueRoll = 0.4
		elseif groundMaterial == Enum.Material.Concrete or (groundMaterial == Enum.Material.Basalt or groundMaterial == Enum.Material.Asphalt) then
			torquePitch = 0.94
		elseif groundMaterial == Enum.Material.Sandstone or groundMaterial == Enum.Material.Sand then
			torqueYaw = 0.5
		end
		local driftDamping = exp(-max(localVelocity.magnitude, 120) / 400) * if handbrakeEnabled then 1.5 else 1.2
		local driftDirection = -localVelocity.Z / abs(localVelocity.Z)
		if IsNaN(driftDirection) then
			driftDirection = 0
		end
		if chassis.LastForward ~= driftDirection and (abs(localVelocity.Z) > 2 and not handbrakeEnabled) then
			chassis.LastForward = driftDirection
		end
		if steerInput == 0 then
			if localVelocity.Z < 0 and not handbrakeEnabled then
				Rotate.MaxTorque = Vector3New(0, gravityForce * 2, 0)
			end
		else
			Rotate.MaxTorque = Vector3New(0, gravityForce * 30, 0)
		end
		Rotate.AngularVelocity = Vector3New(0, engineLocalWheelCFrame * TurnSpeed * chassis.LastForward * driftDamping * velocityDampingFactor, 0)
	else
		Rotate.MaxTorque = Vector3New(gravityForce * 0.5, gravityForce, gravityForce * 0.5)
		lateralFrictionForce = Vector3.new(0, 0, 0)
		sum_2 = Vector3.new(0, 0, 0)
	end
	local sum_3 = sum_2 + (Nitro and 0.17 * gravityForce or 0) * Vector3.new(0, -0.1, -1)
	if dampingForce ~= nil then
		sum_3 = sum_3 + dampingForce
	end
	local Grass = chassis.Sounds.Grass
	local Asphalt = chassis.Sounds.Asphalt
	local Sandstone = chassis.Sounds.Sandstone
	chassis.vGrass = chassis.vGrass + (torqueRoll - chassis.vGrass) * 0.03
	chassis.vAsphalt = chassis.vAsphalt + (torquePitch - chassis.vAsphalt) * 0.03
	chassis.vSandstone = chassis.vSandstone + (torqueYaw - chassis.vSandstone) * 0.03
	local downforceScale = (Magnitude < 60 and Magnitude / 60 or 1) * 0.25
	Grass.Volume = chassis.vGrass * downforceScale
	Asphalt.Volume = chassis.vAsphalt * downforceScale
	Sandstone.Volume = chassis.vSandstone * downforceScale
	local speedNormalized = Magnitude > 0 and (Magnitude / 120) ^ 0.5 or 0
	Grass.PlaybackSpeed = speedNormalized
	Asphalt.PlaybackSpeed = speedNormalized
	Sandstone.PlaybackSpeed = speedNormalized
	local brakeActive = handbrakeEnabled
	if not brakeActive then
		brakeActive = forwardInput < 1e-6
	end
	if chassis._flagBrakelightsEnabled ~= brakeActive then
		chassis._flagBrakelightsEnabled = brakeActive
		VehicleUtils.setBrakelightsEnabled(chassis.Model, brakeActive)
	end
	if CanDrive then
		engineThruster.Drive.Force = sum_3
	end
	engineThruster.Friction.Force = engineCFrame:VectorToWorldSpace(lateralFrictionForce)
	local _, _2, _3, _4, _5, _6, _7, upY, _8, _9, _10, _11 = engineCFrame:GetComponents()
	if upY < -0.25 then
		if chassis.UpsideDownTime then
			if tick() - chassis.UpsideDownTime > 2 then
				chassis.UpsideDownTime = nil
				remoteEventServer:FireServer("llwb2iv8")
			end
		else
			chassis.UpsideDownTime = tick()
		end
	else
		chassis.UpsideDownTime = nil
	end
	local engineSoundProfile = nil
	if (not isStudio or isStudio and Settings.Test.RegionSounds) and Region.CastPoint(Settings.Prism.City, Engine.Position) then
		engineSoundProfile = "City"
	end
	local vector93 = if workspace:Raycast(engineCFrame * Vector3New(0, 0, engineHalfSize.Z - 1), engineCFrame:VectorToWorldSpace(Vector3.new(0, 1, 0)) * 20, raycastParamsDefault) then "Tunnel" else engineSoundProfile or "Outside"
	if chassis.LastEnvironment ~= vector93 then
		chassis.TransitionSpeed = 1 / if vector93 == "Tunnel" or chassis.LastEnvironment == "Tunnel" then 0.5 else 4
		chassis.EnvironmentTransition = true
		chassis.LastEnvironment = vector93
		chassis.EnvironmentTransitionAlpha = 0
		for k, v in pairs(soundEffectProperties) do
			chassis[k] = {}
			for k2, lateralOffset in pairs(v) do
				chassis[k][lateralOffset] = soundEffectLibrary[k][lateralOffset]
			end
		end
	end
	if chassis.EnvironmentTransition then
		local soundProfile = environmentSoundProfiles[vector93]
		local transitionAlpha = (chassis.EnvironmentTransitionAlpha or 0) + dt * chassis.TransitionSpeed
		chassis.EnvironmentTransitionAlpha = transitionAlpha
		for k, v in pairs(soundEffectProperties) do
			for k2, lateralOffset in pairs(v) do
				soundEffectLibrary[k][lateralOffset] = chassis[k][lateralOffset] * (1 - transitionAlpha) + soundProfile[k][lateralOffset] * transitionAlpha
			end
		end
		if transitionAlpha >= 1 then
			chassis.EnvironmentTransition = false
		end
	end
	if EnumMakeId == EnumMake.Bluebird then
		local currentTime = os.clock()
		local isMovingForward = forwardInput > 0.01
		if if isMovingForward then 0.1 else 0.2 < currentTime - chassis.LastEngineRattle then
			chassis.LastEngineRattle = currentTime
			chassis.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if isMovingForward then 4 else 2)
		end
		local engineFlapTarget = if isMovingForward then chassis.SpringEngineFlaps:SetTarget(1) else chassis.SpringEngineFlaps:SetTarget(0)
		Model.Preset.RattlerEngine.EngineMetal["EngineMetal->Engine"].C1 = CFrame.new((chassis.SpringEngineRattle:Update()))
		local engineFlapMotor = Model.Preset.RattlerEngine.EngineFlaps["EngineFlaps->Engine"]
		engineFlapMotor.C1 = engineFlapMotor.C0:Inverse() * CFrame.Angles(engineFlapTarget * -math.pi * 0.45, 0, 0) * engineFlapMotor.C0
		for i, v in ipairs(chassis.RattleFire) do
			v.Enabled = isMovingForward
		end
		if chassis.BluebirdSupercharger then
			local directionAlignment = chassis.rpmVisual or 0
			if forwardInput > 0 then
				chassis.BluebirdSupercharger.Volume = math.clamp(directionAlignment / 4000 * 0.15, 0, 0.15)
				chassis.BluebirdSupercharger.PlaybackSpeed = math.clamp(directionAlignment / 8000 * 0.8, 0, 0.8)
			elseif chassis.BluebirdSupercharger.Volume > 0 then
				chassis.BluebirdSupercharger.Volume = math.max(0, chassis.BluebirdSupercharger.Volume - dt * 0.3)
			end
		end
	elseif EnumMakeId == EnumMake.TheRattler then
		local rattleTime = os.clock()
		local hasInput = math.abs(forwardInput) > 0.01
		if if hasInput then 0.1 else 0.2 < rattleTime - chassis.LastEngineRattle then
			chassis.LastEngineRattle = rattleTime
			chassis.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if hasInput then 4 else 2)
		end
		local flapAngle = if hasInput then chassis.SpringEngineFlaps:SetTarget(1) else chassis.SpringEngineFlaps:SetTarget(0)
		Model.Preset.RattlerEngine.EngineBody["EngineBody->Engine"].C1 = CFrame.new((chassis.SpringEngineRattle:Update()))
		local flapMotor = Model.Preset.RattlerEngine.EngineFlaps["EngineFlaps->Engine"]
		flapMotor.C1 = flapMotor.C0:Inverse() * CFrame.Angles(flapAngle * -math.pi * 0.45, 0, 0) * flapMotor.C0
		for i, v in ipairs(chassis.RattleSmoke) do
			v.Enabled = not hasInput
		end
		for i, v in ipairs(chassis.RattleFire) do
			v.Enabled = hasInput
		end
	end
	if EnumMakeId == EnumMake.Polaire then
		local TiltWing = Model.Preset:FindFirstChild("TiltWing")
		if TiltWing then
			DoorUtils.setPctOpen(TiltWing, if steerInput < -0.5 then -1 elseif steerInput > 0.5 then 1 else 0)
		end
	end
	local Rudder = chassis.Model.Preset:FindFirstChild("Rudder")
	if Rudder then
		DoorUtils.setPctOpen(Rudder, if math.abs(steerInput) > 0.5 then if steerInput > 0 then 0 else 1 else 0.5)
	end
	if chassis.RattleMotors then
		local steerDirection = os.clock()
		local isInputActive = math.abs(forwardInput) > 0.01
		if if isInputActive then 0.05 else 0.1 < steerDirection - chassis.LastEngineRattle then
			chassis.LastEngineRattle = steerDirection
			chassis.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if isInputActive then 3 else 2)
		end
		local rattleOffset = chassis.SpringEngineRattle:Update()
		for _, rattleMotor in chassis.RattleMotors do
			rattleMotor.motor.C1 = CFrame.new(rattleOffset)
		end
	end
	if chassis.RattleParticles then
		local shouldEmit = math.abs(forwardInput) > 0.01
		for _, particleEmitter in chassis.RattleParticles do
			particleEmitter.Enabled = shouldEmit
		end
	end
	if chassis.ThrusterFlames then
		chassisInput.UpdateThrusterFlames(chassis.Model, forwardInput, steerInput, localVelocity.Z, {
			client = true
		})
	end
	if chassis.BrakeTrails then
		for _, brakeTrail in chassis.BrakeTrails do
			brakeTrail.Enabled = chassis._flagBrakelightsEnabled
		end
	end
	local gravityOffset = chassis.gravityOffset
	if chassis.Model:FindFirstChild("IsPickedUp") then
		gravityOffset = 0
	end
	chassis.Lift.Force = Vector3New(0, gravityOffset, 0)
end
function chassisInput.Update(chassis, dt)
	chassis._didAnyWheelDrift = false
	local isAccelHeld = inputMovementState[1] - inputMovementState[3] > 0
	if not isAccelHeld and (chassis.isAccelHeld ~= isAccelHeld and chassis.Model.PrimaryPart.AssemblyLinearVelocity.Magnitude > 50) then
		local now = os.clock()
		if chassis.turboBlowOff and now - (chassis.lastTurboBlowOff or 0) > 1 then
			chassis.lastTurboBlowOff = now
			chassis.turboBlowOff.PlaybackSpeed = 1 + (math.random() * 0.1 - 0.05)
			chassis.turboBlowOff:Play()
		end
	end
	chassis.isAccelHeld = isAccelHeld
	for index, value in chassis.EngineThrusters do
		chassisInput.UpdateEngine(chassis, value, dt)
	end
	if chassis.Model:GetAttribute("VehicleIsDrifting") ~= chassis._didAnyWheelDrift then
		chassis.Model:SetAttribute("VehicleIsDrifting", chassis._didAnyWheelDrift)
		chassis.Model:FindFirstChild("RelayDriftingRemote"):FireServer(chassis._didAnyWheelDrift)
	end
end
function chassisInput.UpdateStepped(chassis)
	local Model = chassis.Model
	if chassis.IK then
		local steerAngle = 0.6 * chassis.RotY
		chassis.WeldSteer.C0 = Angles(0, steerAngle, 0)
		local steerCFrame = Model.Steer.CFrame
		local handOffsetX = Model.Steer.Size.X * 0.5 - 0.2
		local SteerOffset = chassis.SteerOffset
		local IK = chassis.IK
		local rightHandOffset = Vector3New(handOffsetX, 0.1, 0)
		if SteerOffset then
			rightHandOffset = rightHandOffset + SteerOffset
		end
		local leftHandOffset = Vector3New(-handOffsetX, 0.1, 0)
		if SteerOffset then
			leftHandOffset = leftHandOffset + SteerOffset
		end
		IK.RightArm = steerCFrame * rightHandOffset
		IK.LeftArm = steerCFrame * leftHandOffset
		IK.RightAngle = -steerAngle - 0.6
		IK.LeftAngle = -steerAngle + 0.6
		R15IKv2.Arms(IK)
	end
end
function chassisInput.UpdateForces(chassis, engineThruster, dt)
	for _, wheelData in chassis.Wheels do
		UpdateThruster(chassis, wheelData, engineThruster, dt)
	end
end
function chassisInput.Halt(chassis)
	for _, engineForce in chassis.EngineThrusters do
		engineForce.Drive.Force = Vector3.new(0, 0, 0)
		engineForce.Friction.Force = Vector3.new(0, 0, 0)
	end
	chassis.Rotate.MaxTorque = Vector3.new(0, 0, 0)
end
function chassisInput.SpinOut(chassis, spinLeft)
	chassis._spinOutLeft = spinLeft
	chassis._spinOutAt = os.clock()
end
function chassisInput.AttemptFireMissile(vehiclePacket)
	local Missiles = vehiclePacket.Missiles
	if not Missiles then
		return false
	end
	if LocalPlayer:GetAttribute("MissileCount") <= 0 then
		VehicleUtils.promptMissileBuy()
		return false
	end
	local fireTime = tick()
	local timeSinceLastFire = fireTime - Missiles.LastFire
	if timeSinceLastFire < 2 and timeSinceLastFire > 0 then
		return false
	end
	Missiles.LastFire = fireTime
	local missilePart = Missiles.Parts[Missiles.i]
	missilePart.Transparency = 1
	task.delay(2, function()
		missilePart.Transparency = 0
	end)
	local missileCFrame = missilePart.CFrame
	local missileVelocity = missilePart.Velocity
	if missileVelocity.Magnitude < 0.01 then
		missileVelocity = Vector3.new(0, 0, 0)
	end
	local ignoreList = { vehiclePacket.Model, LocalPlayer.Character }
	local _, targetPosition = RayCast.RayIgnoreNonCollideWithIgnoreList(missileCFrame.p, (vehiclePacket.Model.Engine.CFrame.LookVector * 60 - Vector3.new(0, 2, 0)).Unit, 999, ignoreList)
	local launchTime = Time.GetNowSync()
	remoteEventServer:FireServer("exva0l4q", missileCFrame, missileVelocity, targetPosition, launchTime, "RocketPart2", 0)
	Missile.LaunchMissile(missileCFrame, missileVelocity, targetPosition, launchTime, "RocketPart2", 0, ignoreList)
	Missiles.i = Missiles.i % #Missiles.Parts + 1
	return true
end
local keyCodeToInputIndexMap = {
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.Q] = 5,
	[Enum.KeyCode.E] = 6,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 3,
	[Enum.KeyCode.Left] = 2,
	[Enum.KeyCode.Right] = 4
}
function chassisInput.LockCamera(chassis)
	assert(not chassis.IsCameraLocked)
	local Model = chassis.Model
	local InsideCamera = Model:FindFirstChild("InsideCamera")
	if InsideCamera ~= nil then
		chassis.IsCameraLocked = true
		Model:SetAttribute("IsCameraLocked", true)
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		chassis.seatMaid.cameraLockRenderStepped = RunService.RenderStepped:Connect(function()
			CurrentCamera.CFrame = InsideCamera.CFrame
		end)
		function chassis.seatMaid.cameraUnlock()
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end
	end
end
function chassisInput.UnlockCamera(chassis)
	assert(chassis.IsCameraLocked)
	chassis.IsCameraLocked = false
	chassis.Model:SetAttribute("IsCameraLocked", false)
	CurrentCamera.CameraType = Enum.CameraType.Custom
	chassis.seatMaid.cameraLockRenderStepped = nil
	chassis.seatMaid.cameraUnlock = nil
end
function chassisInput.InputBegan(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = inputObject.KeyCode
		if keyCodeToInputIndexMap[KeyCode] then
			inputMovementState[keyCodeToInputIndexMap[KeyCode]] = 1
		end
	end
end
function chassisInput.InputEnded(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = inputObject.KeyCode
		if keyCodeToInputIndexMap[KeyCode] then
			inputMovementState[keyCodeToInputIndexMap[KeyCode]] = 0
		end
	elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = inputObject.KeyCode
		if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			inputMovementState[keyCodeToInputIndexMap[KeyCode]] = 0
		end
	end
end
function chassisInput.InputChanged(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = inputObject.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = inputObject.Position
			local X = Position.X
			--local Y = Position.Y
			inputMovementState[2] = X < -0.24 and (-X) ^ 2 or 0
			inputMovementState[4] = X > 0.24 and X ^ 2 or 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = inputObject.Position.Z
			inputMovementState[keyCodeToInputIndexMap[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
		end
	end
end
function chassisInput.SetEvent(remoteEvent)
	remoteEventServer = remoteEvent
end
local CircleAction = UI.CircleAction
local function Action(action, activated)
	if activated then
		remoteEventServer:FireServer("euh8hf92", action.Part)
	end
	return true
end
local function AddedFun(part)
	CircleAction.Add({
		Part = part,
		Name = "Move Ladder",
		NoRay = true,
		Timed = true,
		Duration = 0.25,
		Dist = 10,
		Callback = Action
	}, part)
end
local function RemovedFun(part)
	CircleAction.Remove(part)
end
for i, v in ipairs(CollectionService:GetTagged("Firetruck_Ladder")) do
	CircleAction.Add({
		Part = v,
		Name = "Move Ladder",
		NoRay = true,
		Timed = true,
		Duration = 0.25,
		Dist = 10,
		Callback = Action
	}, v)
end
CollectionService:GetInstanceAddedSignal("Firetruck_Ladder"):Connect(AddedFun)
CollectionService:GetInstanceRemovedSignal("Firetruck_Ladder"):Connect(RemovedFun)
return chassisInput







