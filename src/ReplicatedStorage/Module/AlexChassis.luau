-- Reviewed by Claude
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
local CFrameNew = CFrame.new
local Vector3New = Vector3.new
local Angles = CFrame.Angles
local zeroOriginCFrame = CFrameNew(0, 0, 0)
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
local vehicleModel = nil
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
local function f(p1, p2, p3)
	return math.exp(-(p1 - p2) ^ 2 / (2 * p3 * p3))
end
local function setVolume(p1, p2)
	if math.abs(p1.Volume - p2) > 0.001 then
		p1.Volume = p2
	end
end
local function setPlaybackSpeed(p1, p2)
	if math.abs(p1.PlaybackSpeed - p2) > 0.001 then
		p1.PlaybackSpeed = p2
	end
end
local function SetRPM3(p1, p2, p3, p4)
	local tbl = 0.2
	local cframe2 = 1
	local var3, var4, var5, var6, var7
	if p4 == EnumMake.Lamborghini or (p4 == EnumMake.Bugatti or (p4 == EnumMake.Chiron or (p4 == EnumMake.Surus or (p4 == EnumMake.Challenger or (p4 == EnumMake.Beignet or (p4 == EnumMake.Macaron or (p4 == EnumMake.Monster or (p4 == EnumMake.Goliath or (p4 == EnumMake.ShellMark5 or (p4 == EnumMake.Power1 or (p4 == EnumMake.Successor or (p4 == EnumMake.OGLaMatador or (p4 == EnumMake.Maverick or (p4 == EnumMake.Wedge or p4 == EnumMake.Revox)))))))))))))) then
		var3 = p2 / 12000 + 0.5 + 0.07 - 0.1
		var4 = 1 + p2 / 12000 - 0.5 + 0.07 - 0.1
		var5 = 1 + p2 / 12000 - 0.3 + 0.25 - 0.1
		var6 = p2 / 12000 + 0.6 + 0.1 - 0.1
		cframe2 = 0.5
		var7 = (p2 + 2000) / 5500 + 0.8
	elseif p4 == EnumMake.OrionM42 then
		var3 = p2 / 5500 + 0.2295
		var4 = 1 + p2 / 6000 - 0.991
		var5 = 1 + p2 / 6000 - 1.218
		var6 = p2 / 5500 + 0.2295
		tbl = tbl * 2.25
		var7 = (p2 + 6500) / 7500
	elseif p4 == EnumMake.Blackbeard or p4 == EnumMake.BlackWidow then
		var3 = p2 / 10500 + 0.085
		var4 = 1 + p2 / 12000 - 0.911
		var5 = 1 + p2 / 20500 - 0.818
		var6 = p2 / 10500 + 0.085
		tbl = tbl * 3.75
		var7 = (p2 + 2700) / 6500
	elseif p4 == EnumMake.Katana then
		var3 = p2 / 3500 + 0.09
		var4 = p2 / 6200 + 0.05
		var5 = p2 / 6700 - 0.012
		var6 = p2 / 3500 + 0.09
		tbl = 1
		var7 = (p2 + 9500) / 9500 - 0.1
	elseif p4 == EnumMake.WYNDR then
		var3 = p2 / 6500 + 0.4
		var4 = 1 + p2 / 6500 - 0.28
		var5 = 1 + p2 / 7500 - 0.45
		var6 = p2 / 6500 + 0.4
		var7 = (p2 + 1800) / 1800 + 0.3
	elseif p4 == EnumMake.Carbonara then
		var3 = p2 / 3600 + 0.04
		var4 = p2 / 4100 - 0.1
		var5 = p2 / 6200 + 0.022
		var6 = p2 / 3600 + 0.04
		var7 = (p2 + 4900) / 4900 - 0.05
	elseif p4 == EnumMake.Aperture then
		var3 = p2 / 8500 + 0.22
		var4 = p2 / 9300 + 0.33
		var5 = p2 / 16500 + 0.31
		var6 = p2 / 8500 + 0.22
		var7 = (p2 + 10800) / 10800 - 0.12
	elseif p4 == EnumMake.SWATVan or p4 == EnumMake.Sentinel then
		var3 = p2 / 10000 + 0.205
		var4 = p2 / 13000 + 0.175
		var5 = p2 / 11500 - 0.15
		var6 = p2 / 10000 + 0.205
		var7 = (p2 + 12500) / 12500 - 0.83
	elseif p4 == EnumMake.Polaire then
		var3 = p2 / 3500 + 0.235
		var4 = p2 / 6000 + 0.145
		var5 = p2 / 9500 + 0.315
		var6 = p2 / 3500 + 0.235
		var7 = (p2 + 4300) / 4300 - 0.02
	elseif p4 == EnumMake.Bluebird then
		var3 = p2 / 4500 + 0.165
		var4 = p2 / 7500 + 0.145
		var5 = p2 / 10500 + 0.155
		var6 = p2 / 4500 + 0.165
		var7 = (p2 + 7300) / 7300 - 0.2
	else
		var3 = p2 / 10000 + 0.2
		var4 = 1 + p2 / 10000 - 0.7
		var5 = 1 + p2 / 10000 - 1
		var6 = p2 / 10000 + 0.2
		cframe2 = 0.6
		var7 = (p2 + 1000) / 6000 + 0.8
	end
	local var8 = 0
	local var9 = 0
	if p4 == EnumMake.TheRattler or (p4 == EnumMake.ShellClassic or (p4 == EnumMake.Bandit or (p4 == EnumMake.Longhorn or (p4 == EnumMake.Laviolette or (p4 == EnumMake.Hammerhead or (p4 == EnumMake.Delorean or p4 == EnumMake.TowTruck)))))) then
		var9 = -0.3
		var8 = -0.3
	elseif p4 == EnumMake.MCL36 or p4 == EnumMake.MCL36FREE then
		var9 = 0.45
		var8 = 0.45
	elseif p4 == EnumMake.Power1 then
		var9 = -0.3
		var8 = -0.3
	elseif p4 == EnumMake.Blackbeard then
		var9 = 0
		var8 = -0.15
	end
	local Idle = p1.Idle
	local var10 = var7 + var9
	if math.abs(Idle.PlaybackSpeed - var10) > 0.001 then
		Idle.PlaybackSpeed = var10
	end
	local OnLow = p1.OnLow
	local var12 = var3 + var8
	if math.abs(OnLow.PlaybackSpeed - var12) > 0.001 then
		OnLow.PlaybackSpeed = var12
	end
	local OnMid = p1.OnMid
	local var14 = var4 + var8
	if math.abs(OnMid.PlaybackSpeed - var14) > 0.001 then
		OnMid.PlaybackSpeed = var14
	end
	local OnHigh = p1.OnHigh
	local var16 = var5 + var8
	if math.abs(OnHigh.PlaybackSpeed - var16) > 0.001 then
		OnHigh.PlaybackSpeed = var16
	end
	local OffLow = p1.OffLow
	local var18 = var6 + var8
	if math.abs(OffLow.PlaybackSpeed - var18) > 0.001 then
		OffLow.PlaybackSpeed = var18
	end
	local var20 = p2 / 8000
	local var21 = math.exp(-(-0.1 - var20) ^ 2 / 0.08000000000000002) * tbl * cframe2 * 1
	local var22 = math.exp(-(0.3 - var20) ^ 2 / 0.020000000000000004) * tbl * 1
	local var23 = math.exp(-(0.6 - var20) ^ 2 / 0.08000000000000002) * tbl * 1
	local var25 = (var20 < 0.9 and math.exp(-(0.9 - var20) ^ 2 / 0.045) or 1) * tbl * 1
	local Idle_2 = p1.Idle
	if math.abs(Idle_2.Volume - var21) > 0.001 then
		Idle_2.Volume = var21
	end
	if p3 > 0 then
		local OnLow_2 = p1.OnLow
		if math.abs(OnLow_2.Volume - var22) > 0.001 then
			OnLow_2.Volume = var22
		end
		local OnMid_2 = p1.OnMid
		if math.abs(OnMid_2.Volume - var23) > 0.001 then
			OnMid_2.Volume = var23
		end
		local OnHigh_2 = p1.OnHigh
		if math.abs(OnHigh_2.Volume - var25) > 0.001 then
			OnHigh_2.Volume = var25
		end
		local OffLow_2 = p1.OffLow
		if math.abs(OffLow_2.Volume - 0) > 0.001 then
			OffLow_2.Volume = 0
		end
	else
		local OnLow_2 = p1.OnLow
		local var31 = var22 * 0.5
		if math.abs(OnLow_2.Volume - var31) > 0.001 then
			OnLow_2.Volume = var31
		end
		local OnMid_2 = p1.OnMid
		local var33 = var23 * 1
		if math.abs(OnMid_2.Volume - var33) > 0.001 then
			OnMid_2.Volume = var33
		end
		local OnHigh_2 = p1.OnHigh
		local var35 = var25 * 1
		if math.abs(OnHigh_2.Volume - var35) > 0.001 then
			OnHigh_2.Volume = var35
		end
		local OffLow_2 = p1.OffLow
		local var37 = var22 * 0.5
		if math.abs(OffLow_2.Volume - var37) > 0.001 then
			OffLow_2.Volume = var37
		end
	end
end
local function SetRPM1(p1, p2, p3, p4)
	local tbl = nil
	local var3 = p2 / if p4 == EnumMake.Volt or p4 == EnumMake.Volt4x4 then 10000 elseif p4 == EnumMake.Roadster then 12000 else 6000
	local var4 = 1
	local var5 = 0
	if p4 == EnumMake.DesertCrawler then
		var4 = 1.4
		var5 = 0.1
	elseif p4 == EnumMake.BrickKar then
		var4 = 1.3
		var5 = 0.4
		tbl = 1.4
	elseif p4 == EnumMake.AdminNuke then
		var4 = 1.3
		var5 = -0.4
		tbl = 1.4
	end
	local Idle = p1.Idle
	local var6 = var5 + var4 * (p2 + 3000) / 8000
	if math.abs(Idle.PlaybackSpeed - var6) > 0.001 then
		Idle.PlaybackSpeed = var6
	end
	if not tbl then
		tbl = math.exp(-(1.1 - var3) ^ 2 / 0.5) * 0.2
	end
	local Idle_2 = p1.Idle
	if math.abs(Idle_2.Volume - tbl) > 0.001 then
		Idle_2.Volume = tbl
	end
end
local function SetRPMNew(p1, p2, p3, p4, p5, p6)
	local tbl = p5 / 6
	local cframe2 = p2 / 6300
	local var3 = 5 * cframe2
	local var4 = 0.2
	local var5 = 0.2
	if p4 == EnumMake.Venom or (p4 == EnumMake.Cobra or p4 == EnumMake.Polaire) then
		var4 = var4 * 2
		var5 = var5 * 2
	end
	local var6 = math.exp(-(var3 - 0) ^ 2 / 8) * var4
	local var7 = math.exp(-(var3 - 1.5) ^ 2 / 2) * var5
	local var8 = math.exp(-(var3 - 3.25) ^ 2 / 2) * var5
	local var10 = (var3 <= 5 and math.exp(-(var3 - 5) ^ 2 / 2) or 1) * var5
	local var11 = 0.1 + 1.15 * ((1 + tbl) * (cframe2 - 0.4 * tbl))
	local var12 = var11 * 2 ^ (-p6.low / 12)
	local var13 = var11 * 2 ^ (-p6.mid / 12)
	local var14 = var11 * 2 ^ (-p6.high / 12)
	local var15 = var11 * 0.75 + 1
	local Idle = p1.Idle
	if math.abs(Idle.Volume - var6) > 0.001 then
		Idle.Volume = var6
	end
	local OnLow = p1.OnLow
	if math.abs(OnLow.Volume - var7) > 0.001 then
		OnLow.Volume = var7
	end
	local OnMid = p1.OnMid
	if math.abs(OnMid.Volume - var8) > 0.001 then
		OnMid.Volume = var8
	end
	local OnHigh = p1.OnHigh
	if math.abs(OnHigh.Volume - var10) > 0.001 then
		OnHigh.Volume = var10
	end
	local Idle_2 = p1.Idle
	if math.abs(Idle_2.PlaybackSpeed - var15) > 0.001 then
		Idle_2.PlaybackSpeed = var15
	end
	local OnLow_2 = p1.OnLow
	if math.abs(OnLow_2.PlaybackSpeed - var12) > 0.001 then
		OnLow_2.PlaybackSpeed = var12
	end
	local OnMid_2 = p1.OnMid
	if math.abs(OnMid_2.PlaybackSpeed - var13) > 0.001 then
		OnMid_2.PlaybackSpeed = var13
	end
	local OnHigh_2 = p1.OnHigh
	if math.abs(OnHigh_2.PlaybackSpeed - var14) > 0.001 then
		OnHigh_2.PlaybackSpeed = var14
	end
end
local function SetRPM(p1, p2, p3, p4, p5, p6, p7)
	if p1 == "Electric" or (p1 == "BrickKar" or p1 == "AdminNuke") then
		SetRPM1(p3, p4, p5, p2)
	elseif p7 then
		SetRPMNew(p3, p4, p5, p2, p6, p7)
	else
		SetRPM3(p3, p4, p5, p2)
	end
end
local function UpdateGearsAndRPM(p1, p2, p3, p4, p5)
	local Gear = p1.Gear
	local LastGear = p1.LastGear
	local t3 = p1.t3
	local LastRPM = p1.LastRPM
	if p1.ManualGear then
		if p1._shiftUp then
			p1.Gear = p1.Gear + 1
			p1._shiftUp = nil
		end
		if p1._shiftDown then
			p1.Gear = p1.Gear - 1
			p1._shiftDown = nil
		end
		p1.Gear = math.clamp(p1.Gear, 1, #p2 - 2)
		Gear = p1.Gear
	end
	local tbl = p3 / (p1.Wheels[1].Model.PrimaryPart.Size.Y / 2.9) * 1000 / 3600 / 0.34
	local cframe2
	if LastGear == Gear then
		cframe2 = p2[2 + Gear]
	else
		cframe2 = p2[2 + LastGear] * (1 - t3 * t3) + p2[2 + Gear] * t3 * t3
		local var3 = t3 + p5 * 1 / 0.26
		p1.t3 = var3
		if var3 >= 1 then
			p1.LastGear = Gear
			p1.t3 = 0
		end
	end
	local var4 = tbl * p2[1] * cframe2 * 60 / 6.283185307179586
	local var5 = tbl * p2[1] * p2[2 + Gear] * 60 / 6.283185307179586
	local var6 = var5 - LastRPM
	if not (p1.NoGears or p1.ManualGear) then
		if p4 > 0 and (var6 > 0 and (var5 > 6000 and Gear < #p2 - 2)) then
			p1.Gear = Gear + 1
			if p1.onGearShift then
				p1:onGearShift(p1.Gear, Gear)
			end
		elseif var6 < 0 and (var5 < 3400 and Gear > 1) then
			p1.Gear = Gear - 1
			if p1.onGearShift then
				p1:onGearShift(p1.Gear, Gear)
			end
		end
	end
	SetRPM(p1.SoundType, p1.EnumMakeId, p1.Sounds, var4, p4, Gear, p1.engineSoundConfig)
	p1.rpmVisual = var4
	p1.rpmVisualMax = 7000
	p1.LastRPM = var5
	if p1.ManualGear then
		local var7 = p1._rpmLimit or 6000
		p1._rpmLimitMult = if var5 <= var7 then 1 else math.clamp(var7 / var5, 0, 1)
	end
	if p1.turboIntakeSound then
		local var10 = math.clamp(p1.rpmVisual / p1.rpmVisualMax, 0, 1) ^ 3
		if p4 <= 0 then
			var10 = 0
		end
		p1.turboIntakeSound.Volume = p1.turboIntakeSound.Volume + (var10 * p1.maxTurboIntakeSoundVolume - p1.turboIntakeSound.Volume) * 0.1
		if Gear < p1.Gear and p1.turboBlowOff then
			p1.turboBlowOff.PlaybackSpeed = 1 + (math.random() * 0.15 - 0.075)
			p1.turboBlowOff:Play()
		end
	end
	return Gear, cframe2
end
local function updateFOV(p1)
	local tbl = (p1.LastFakeGear or 1) ^ 0.5 * (p1.Model.Engine.AssemblyLinearVelocity.Magnitude / 120)
	if tbl ~= tbl then
		tbl = 0
	end
	local cframe2 = math.clamp(tbl, 0, 3)
	local var3, var4
	if cframe2 < 0.825155 then
		var3 = cframe2 * cframe2 * cframe2
		if not var3 then
			var4 = cframe2
			var3 = 1 - math.exp(-cframe2)
		end
	else
		var4 = cframe2
		var3 = 1 - math.exp(-cframe2)
	end
	local FieldOfView = CurrentCamera.FieldOfView
	CurrentCamera.FieldOfView = FieldOfView + (var3 * 30 + 70 - FieldOfView) * 0.7
end
local chassisInputTable = {}
local inputMovementState = { 0, 0, 0, 0, 0, 0 }
local handbrakeEnabled = false
local sirenEnabled = false
local headlightsEnabled = false
local policeMode = false
local function GetMass(p1)
	local sum = 0
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			sum = sum + v:GetMass()
		end
	end
	return sum
end
function chassisInputTable.setForward(p1)
	inputMovementState[1] = if p1 then 1 else 0
end
function chassisInputTable.setBackward(p1)
	inputMovementState[3] = if p1 then 1 else 0
end
function chassisInputTable.onGearShift(p1, p2, p3)
	if p1.EnumMakeId == EnumMake.Venom or p1.EnumMakeId == EnumMake.Polaire then
		Audio.ObjectLocal(p1.Model.PrimaryPart, 18128231812, {
			Volume = 0.5,
			Pitch = 1
		})
		for modelIndex, metalPart in p1.Model.Model.Metal:GetChildren() do
			if metalPart:IsA("Attachment") then
				local particleEmitter = metalPart:FindFirstChildWhichIsA("ParticleEmitter")
				if particleEmitter then
					particleEmitter:Emit(3)
				end
			end
		end
	end
	local GearShiftRemote = p1.Model:FindFirstChild("GearShiftRemote")
	if GearShiftRemote then
		GearShiftRemote:FireServer(p2, p3)
	end
end
function chassisInputTable.toggleSirens()
	policeMode = not policeMode
	remoteEventServer:FireServer("s" .. ("fgis"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("lcj23s"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("alabh"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("anygmt"):sub(5, 5):reverse() .. "d", "PoliceLights", policeMode)
end
function chassisInputTable.toggleHeadlights()
	remoteEventServer:FireServer("s" .. ("eeygz2ah"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("l9co90"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("l235bk"):sub(5, 5):reverse() .. "" .. "" .. ("o00laueo"):sub(4, 5):reverse():reverse():reverse() .. "md", "Lights")
end
function chassisInputTable.setHandbrakeEnabled(p1)
	handbrakeEnabled = p1
	ChassisShared.HandBrake = p1
end
function chassisInputTable.DriveToPosition(p1, p2, p3)
local driveOptions = p3 or {}
p1.DriveToPosition = p2
p1.DriveToPositionArrivalRadius = driveOptions.arrivalRadius or 4
p1.DriveToPositionOnReached = driveOptions.onReached
end
function chassisInputTable.StopDriveToPosition(p1)
p1.DriveToPosition = nil
p1.DriveToPositionOnReached = nil
end
function chassisInputTable.runAction(p1)
	if p1 then
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		if vehiclePacket.Make == "Firetruck" then
			remoteEventServer:FireServer("sgcbalmd", "FiretruckWater", true)
		elseif vehiclePacket.Make == "TheAgent" then
			chassisInputTable.AttemptFireMissile(vehiclePacket)
		elseif p1 == "Jump" then
			if not vehiclePacket.AreTiresPopped then
				local Engine = vehiclePacket.Model.Engine
				local currentSpeed = SpeedometerUtils.sToH(SpeedometerUtils.studsToMi((math.abs((Engine.Velocity:Dot(Engine.CFrame.LookVector))))))
				local maxJumpForce = vehiclePacket.jumpMaxAmount or 75
				Engine:ApplyImpulse(Vector3.new(0, maxJumpForce - (maxJumpForce - (vehiclePacket.jumpBaseAmount or 40)) * math.clamp(currentSpeed / (vehiclePacket.jumpMaxMph or 500), 0, 1), 0) * Engine.AssemblyMass)
				VehicleUtils.vehicleEffect("Jump", vehiclePacket.Model)
				remoteEventServer:FireServer("s" .. ("ifqfbcgt4bu"):sub(5, 7):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("y1hlaqa"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("zy4jmdk"):sub(5, 5):reverse() .. "d", "Jump")
				vehiclePacket._lastJumpAt = os.clock()
				return true
			end
		else
			remoteEventServer:FireServer("s" .. ("xvgpr"):sub(3, 3):reverse() .. "" .. "" .. ("r15labcwt"):sub(4, 7):reverse():reverse():reverse() .. "" .. "" .. ("chfmmejj"):sub(4, 4):reverse():reverse():reverse() .. "d", "Action")
		end
	elseif ChassisShared.VehicleMake == "Firetruck" then
		remoteEventServer:FireServer("s" .. "" .. ("vwabcgiu91"):sub(3, 6):reverse():reverse():reverse() .. "lmd", "FiretruckWater", false)
	end
end
local function getTransparencyPredicateForHumanoid(p1)
	assert(p1, "missing humanoid")
	return function(p12)
		if p12.Parent == p1.Parent then
			local tbl = p1:GetLimb(p12)
			if tbl == Enum.Limb.LeftArm or tbl == Enum.Limb.RightArm then
				return false
			else
				return true
			end
		else
			return true
		end
	end
end
function t4.toggleInsideCamera(p1)
	local tbl = p1 or VehicleUtils.GetLocalVehiclePacket()
	if tbl and not tbl.Passenger then
		local IsCameraLocked = tbl.IsCameraLocked
		if IsCameraLocked then
			t4.UnlockCamera(tbl)
		else
			t4.LockCamera(tbl)
		end
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			assert(Humanoid, "missing humanoid")
			local function f2(p1)
				if p1.Parent == Humanoid.Parent then
					local tbl = Humanoid:GetLimb(p1)
					if tbl == Enum.Limb.LeftArm or tbl == Enum.Limb.RightArm then
						return false
					else
						return true
					end
				else
					return true
				end
			end
			if IsCameraLocked then
				CharacterUtils.popInvisible(LocalPlayer.Character, f2)
				return
			end
			CharacterUtils.setInvisible(LocalPlayer.Character, f2)
		end
	end
end
function t4.init(p1)
	var10 = p1.ScreenGui
end
function t4.SetGravity(p1, p2)
	local tbl = p1.Model:FindFirstChild("Engine").AssemblyMass * 9.81 * 20
	local cframe2 = 1 - p2 / 196.20000000000002
	if tbl ~= tbl then
		tbl = 0
	end
	if cframe2 ~= cframe2 then
		cframe2 = 0
	end
	p1.gravityOffset = tbl * cframe2
end
function t4.VehicleEnter(p1)
	local Passenger = p1.Passenger
	local Character = LocalPlayer.Character
	local Humanoid = Character.Humanoid
	local seatMaid = p1.seatMaid
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
		updateFOV(p1)
	end))
	p1.EnumMakeId = EnumMake[p1.Make]
	local tbl = true
	if p1.EnumMakeId == EnumMake.ATV or p1.EnumMakeId == EnumMake.Volt then
		p1.NoLook = true
	elseif p1.Seat:FindFirstChild("Turret") then
		task.delay(0.1, function()
			for i, v in ipairs(Humanoid:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			local tbl = CharacterAnim.getIdleTrack()
			tbl:Play()
			seatMaid:GiveTask(function()
				tbl:Stop()
			end)
		end)
		tbl = false
	end
	if tbl then
		local cframe2 = CharacterAnim.getCarSitTrack()
		cframe2:Play()
		seatMaid:GiveTask(function()
			cframe2:Stop()
		end)
	end
	local Steer = p1.Model:FindFirstChild("Steer")
	if Steer then
		local Offset = Steer:FindFirstChild("Offset")
		if Offset then
			p1.SteerOffset = Offset.Value
		end
	end
	local Model = p1.Model
	if not p1.Seat:FindFirstChild("Visible") then
		local Head = Character:FindFirstChild("Head")
		if Head then
			local Decal = Head:FindFirstChildOfClass("Decal")
			if Decal then
				Decal.Transparency = 1
			end
		end
	end
	ChassisShared.VehicleMake = p1.Make
	if not Passenger then
		t5 = { 0, 0, 0, 0, 0, 0 }
		var12 = false
		var13 = false
		ChassisShared.HandBrake = false
		var14 = false
		var15 = p1.PoliceLights
		t4.SetGravity(p1, 100)
		local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
		BodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
		BodyAngularVelocity.MaxTorque = var4(p1.Mass, (1 / 0), p1.Mass)
		BodyAngularVelocity.Parent = Model.Engine
		p1.Rotate = BodyAngularVelocity
		p1.Traction = 1
		p1.LastForward = 0
		p1.RotY = 0
		p1.LastDrift = 0
		p1.vHeading = 0
		p1.vGrass = 0
		p1.vAsphalt = 0
		p1.vSandstone = 0
		p1.Gear = 1
		p1.LastGear = 1
		p1.LastRPM = 0
		p1.t3 = 0
		p1.AreTiresPopped = false
		p1.PopTires = t4.PopTires
		p1._flagBrakelightsEnabled = false
		p1._flagHeadlightsEnabled = false
		if p1.Make ~= "Volt" then
			p1.IK = R15IKv2.BuildPacketArms(Character)
		end
		if p1.Make == "TheRattler" then
			p1.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			p1.SpringEngineFlaps = Spring.new(0, 0, 0.8, 15)
			p1.LastEngineRattle = os.clock()
			p1.RattleFire = {}
			p1.RattleSmoke = {}
			for i, v in ipairs(Model.Preset.RattlerEngine.EngineGold:GetChildren()) do
				if v:IsA("Attachment") then
					table.insert(p1.RattleFire, v.Fire)
					table.insert(p1.RattleSmoke, v.Smoke)
					v.Fire.Enabled = false
					v.Smoke.Enabled = false
				end
			end
		elseif p1.Make == "Blackbeard" then
			p1.LastEngineRattle = os.clock()
			p1.RattleMotors = {}
			p1.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			p1.RattleParticles = {}
			for var3, var42 in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = var42:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(p1.RattleMotors, {
						motor = Motor
					})
				end
			end
			for var5, var6 in Model.Preset.RattlerEngine.SecondBody:GetChildren() do
				if var6:IsA("Attachment") then
					local var72 = var6:FindFirstChildWhichIsA("ParticleEmitter")
					if var72 then
						table.insert(p1.RattleParticles, var72)
						var72.Enabled = false
					end
				end
			end
		elseif p1.Make == "Shogun" then
			p1.LastEngineRattle = os.clock()
			p1.RattleMotors = {}
			p1.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			for var8, var9 in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = var9:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(p1.RattleMotors, {
						motor = Motor
					})
				end
			end
			p1.RattleParticles = {}
			for var10, var11 in Model.Model:FindFirstChild("SecondBody"):GetDescendants() do
				if var11:IsA("ParticleEmitter") then
					table.insert(p1.RattleParticles, var11)
					var11.Enabled = false
				end
			end
			p1.BrakeTrails = {}
			for var122, var132 in Model.Model:FindFirstChild("BrakelightGlass"):GetChildren() do
				if var132:IsA("Trail") then
					table.insert(p1.BrakeTrails, var132)
					var132.Enabled = false
				end
			end
		elseif p1.Make == "BlackWidow" then
			p1.LastEngineRattle = os.clock()
			p1.RattleMotors = {}
			p1.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			for v142, v152 in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = v152:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(p1.RattleMotors, {
						motor = Motor
					})
				end
			end
			p1.RattleParticles = {}
			for var16, color17 in Model.Preset.RattlerEngine.Metal:QueryDescendants("ParticleEmitter") do
				table.insert(p1.RattleParticles, color17)
				color17.Enabled = false
			end
		elseif p1.Make == "Bluebird" then
			p1.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			p1.SpringEngineFlaps = Spring.new(0, 0, 0.8, 15)
			p1.LastEngineRattle = os.clock()
			p1.RattleFire = {}
			for i, v in ipairs(Model.Preset.RattlerEngine.EngineMetal:GetChildren()) do
				if v:IsA("Attachment") then
					local Fire = v:FindFirstChild("Fire")
					if Fire then
						table.insert(p1.RattleFire, Fire)
						Fire.Enabled = false
					end
				end
			end
			p1.BluebirdSupercharger = Audio.ObjectLocal(Model.Engine, 78492749956905, {
				Volume = 0,
				Looped = true,
				RollOffMaxDistance = 352
			})
			seatMaid:GiveTask(function()
				if p1.BluebirdSupercharger then
					p1.BluebirdSupercharger:Destroy()
				end
			end)
		elseif p1.Make == "JBX0031" then
			p1.ThrusterFlames = true
			t4.UpdateThrusterFlames(Model, 0, 0, 0, {
				vehicleEnter = true
			})
		elseif p1.Make == "Wedge" or (p1.Make == "Manta" or (p1.Make == "Katana" or (p1.Make == "WYNDR" or p1.Make == "Polaire"))) then
			local var18 = Audio.ObjectLocal(Model.Engine, 132884974895700, {
				Volume = 0,
				Looped = true,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 512,
				RollOffMode = Enum.RollOffMode.InverseTapered
			})
			p1.maxTurboIntakeSoundVolume = 0.2
			if p1.Make == "Manta" or p1.Make == "Polaire" then
				p1.maxTurboIntakeSoundVolume = 0.1
			end
			local var19 = Audio.ObjectLocal(Model.Engine, 118282536530342, {
				Volume = 0.2,
				DoNotPlay = true,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 512,
				RollOffMode = Enum.RollOffMode.InverseTapered
			})
			p1.turboIntakeSound = var18
			p1.turboBlowOff = var19
			seatMaid:GiveTask(function()
				var18:Destroy()
				var19:Destroy()
			end)
		end
		p1.Sounds.DriftSqueal.Volume = 0
		for k, v in pairs(p1.Sounds) do
			if not v.IsPlaying then
				v:Play()
			end
		end
		p1.setForward = t4.setForward
		p1.setBackward = t4.setBackward
		p1.onGearShift = t4.onGearShift
		var7.IgnoreWater = if p1.EnumMakeId == EnumMake.Delorean then false else p1.EnumMakeId ~= EnumMake.Blackbeard
	end
end
function t4.VehicleLeave(p1)
	CurrentCamera.FieldOfView = 70
	if p1.Sounds then
		local Outside = t3.Outside
		for tbl, cframe2 in next, t2 do
			for var3, var4 in next, cframe2 do
				t[tbl][var4] = Outside[tbl][var4]
			end
		end
		for k, v in pairs(p1.Sounds) do
			v.Volume = 0
		end
		p1.Sounds.DriftSqueal:Stop()
	end
	if p1.IsCameraLocked then
		t4.UnlockCamera(p1)
	end
	if not p1.Passenger then
		p1.Rotate:Destroy()
		p1.Lift.Force = Vector3.new(0, 0, 0)
		for var6, var7 in p1.EngineThrusters do
			var7.Drive.Force = Vector3.new(0, 0, 0)
			var7.Friction.Force = Vector3.new(0, 0, 0)
		end
		p1.IK = nil
		for var8, var9 in p1.Wheels do
			var9.Thruster.Force = Vector3.new(0, 0, 0)
		end
		if p1.RattleSmoke then
			for var10, var11 in p1.RattleSmoke do
				var11.Enabled = false
			end
		end
		if p1.RattleFire then
			for var12, var13 in p1.RattleFire do
				var13.Enabled = false
			end
		end
		if p1.RattleParticles then
			for var14, var15 in p1.RattleParticles do
				var15.Enabled = false
			end
		end
		if p1.ThrusterFlames then
			t4.UpdateThrusterFlames(p1.Model, 0, 0, 0, {
				vehicleLeave = true
			})
		end
		if p1.BrakeTrails then
			for var16, color17 in p1.BrakeTrails do
				color17.Enabled = false
			end
		end
		VehicleUtils.setBrakelightsEnabled(p1.Model, false)
		local var18 = p1.Model.Parent and p1.Model.Preset:FindFirstChild("Rudder")
		if var18 then
			DoorUtils.setPctOpen(var18, 0.5)
		end
		if p1._haptic then
			p1._haptic:Destroy()
			p1._haptic = nil
		end
	end
end
local var16 = Color3.fromRGB(204, 142, 105)
local color17 = Color3.fromRGB(68, 54, 43)
local t6 = {}
local function getThrusterLightsState(p1)
	local tbl = t6[p1]
	if not tbl then
		local t = {
			part = nil,
			activeTween = nil,
			isOn = false,
			hotUntil = 0
		}
		t6[p1] = t
		tbl = t
	end
	if tbl.part == nil or tbl.part.Parent == nil then
		local ThrusterLights = p1.Model:FindFirstChild("ThrusterLights")
		if ThrusterLights and ThrusterLights:IsA("BasePart") then
			tbl.part = ThrusterLights
			return tbl
		end
		tbl.part = nil
	end
	return tbl
end
local function setThrusterLightsEnabled(p1, p2)
	local tbl = getThrusterLightsState(p1)
	local part = tbl.part
	if part then
		if tbl.isOn ~= p2 then
			if tbl.activeTween then
				tbl.activeTween:Cancel()
				tbl.activeTween = nil
			end
			tbl.isOn = p2
			local var3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local t = {}
			t.Color = p2 and var16 or color17
			tbl.activeTween = TweenService:Create(part, var3, t)
			tbl.activeTween:Play()
		end
	end
end
local t7 = {}
function t4.UpdateThrusterFlames(p1, p2, p3, p4, p5)
	local tbl = p5 or {}
	local cframe2 = t7[p1]
	if not cframe2 then
		local Thrusters = p1.Model:FindFirstChild("Thrusters")
		if Thrusters then
			local CenterAttachment = Thrusters:FindFirstChild("CenterAttachment")
			local RightAttachment = Thrusters:FindFirstChild("RightAttachment")
			local LeftAttachment = Thrusters:FindFirstChild("LeftAttachment")
			if CenterAttachment and (RightAttachment and LeftAttachment) then
				local Flame = CenterAttachment:FindFirstChild("Flame")
				local Flame_2 = RightAttachment:FindFirstChild("Flame")
				local Flame_3 = LeftAttachment:FindFirstChild("Flame")
				if Flame and (Flame_2 and Flame_3) then
					local t = {
						thrusters = Thrusters,
						centerFlame = Flame,
						rightFlame = Flame_2,
						leftFlame = Flame_3,
						thrusterSound = Thrusters:FindFirstChild("ThrusterSound")
					}
					t7[p1] = t
					cframe2 = t
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
	local thrusters = cframe2.thrusters
	local rightFlame = cframe2.rightFlame
	local leftFlame = cframe2.leftFlame
	local count = 0
	local var3 = nil
	local var4 = nil
	local var5, var6
	if p3 > 0 or tbl.client and t5[2] > 0 then
		var5 = tbl
		var6 = true
		count = count + 1
	else
		var6 = nil
		var5 = tbl
	end
	if p3 < 0 or var5.client and t5[4] > 0 then
		count = count + 1
		var4 = true
	end
	if p2 > 0 then
		var3 = true
		count = count + 1
	elseif p4 < 1 and p4 > -1 then
		var4 = nil
		var6 = nil
		count = 0
	end
	cframe2.centerFlame.Enabled = var3 == true
	if p2 > 0 or p4 < 0 then
		rightFlame.Enabled = var4 == true
		leftFlame.Enabled = var6 == true
	else
		rightFlame.Enabled = var6 == true
		leftFlame.Enabled = var4 == true
	end
	local thrusterSound = cframe2.thrusterSound
	if thrusterSound then
		local var12 = if count > 0 then 0.175 else 0
		if math.abs(thrusterSound.Volume - var12) > 0.001 then
			thrusterSound.Volume = var12
		end
		local var14 = (count - 1) * 0.1 + 0.7
		if math.abs(thrusterSound.PlaybackSpeed - var14) > 0.001 then
			thrusterSound.PlaybackSpeed = var14
		end
	end
	local var16 = getThrusterLightsState(p1)
	if var5.vehicleLeave then
		t7[p1] = nil
		var16.hotUntil = 0
		setThrusterLightsEnabled(p1, false)
		task.delay(0.25, function()
			if t6[p1] == var16 and not var16.isOn then
				t6[p1] = nil
			end
		end)
	elseif var5.vehicleEnter then
		var16.hotUntil = os.clock() + 2.5
		setThrusterLightsEnabled(p1, true)
	else
		local color17 = os.clock()
		if count > 0 then
			var16.hotUntil = color17 + 2.5
		end
		setThrusterLightsEnabled(p1, if count > 0 then true else color17 < var16.hotUntil)
	end
	return count
end
function t4.UpdateWheelLowQuality(p1, p2, p3, p4)
	local Engine = p3.Engine
	local Part = p3.Part
	local cframe2 = Part.CFrame
	local cframe32 = Engine.CFrame:ToObjectSpace(cframe2)
	local var6 = if cframe32.X > 0 then 1 else -1
	local var7 = CFrame.new((p3.lateralRotateOffset or 0) * var6, 0, 0)
	local cframe82 = cframe2 * CFrame.new((p3.lateralOffset or 0) * var6, 0, 0) * var7
	local p = cframe82.p
	local Motor = Part.Motor
	local var9 = workspace:Raycast(p, cframe82:VectorToWorldSpace(Vector3.new(0, -1, 0)) * p2, var8)
	local var10 = if var9 then var9.Position else nil
	local var12 = -min(if var10 then (var10 - p).magnitude else p2, p2) + Motor.Part0.Size.Y * 0.5
	local var13 = var3(0, var12, 0)
	if cframe32.Z < 0 then
		var13 = var13 * Angles(0, Engine.AssemblyAngularVelocity.Y * 0.5, 0)
	end
	Motor.C1 = var13 * var7 * Angles(p4, 0, 0)
	local BridgeMotor = Part:FindFirstChild("BridgeMotor")
	if BridgeMotor then
		local var16 = p3.bridgeLocalYOffset or 0
		local color17 = CFrame.new((p3.bridgeXOffset or 0) * var6, (p3.bridgeYOffset or 0) + var16, 0)
		BridgeMotor.C1 = color17 * CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(cframe32.X, var12 - var16, 0)))
	end
end
function t4.UpdateSoundLowQuality(p1, p2, p3)
	if p1.EnumMakeId == nil then
		p1.EnumMakeId = EnumMake[p1.Make]
	end
	UpdateGearsAndRPM(p1, p2, math.abs(p3.Z), -math.sign(p3.Z), 1 / 60)
end
local function IsNaN(p1)
	return p1 ~= p1
end
local function UpdateThruster(p1, p2, p3, p4)
	local Part = p2.Part
	local Engine = p2.Engine
	local cframe2 = Part.CFrame
	local cframe32 = Engine.CFrame:ToObjectSpace(cframe2)
	local var6 = if cframe32.X > 0 then 1 else -1
	local var72 = CFrame.new((p2.lateralRotateOffset or 0) * var6, 0, 0)
	local var8 = CFrame.new((p2.lateralOffset or 0) * var6, 0, 0)
	local var9 = cframe2 * var8 * var72
	local p = var9.p
	local Motor = Part.Motor
	local Thruster = p2.Thruster
	local var10 = Part.AssemblyMass * 9.81 * 20
	local var11 = var10 * p1.Suspension
	if var11 ~= var11 then
		var11 = 0
	end
	local var122 = var11 / p1.Bounce
	if var122 ~= var122 then
		var122 = 0
	end
	local var13 = var9:VectorToObjectSpace(Part.Velocity)
	local Height = p1.Height
	local var14 = p1.Model:GetAttribute("GarageSuspensionHeight")
	if var14 then
		Height = Height + var14
	end
	local var15 = p2._heightOffset or 0
	local var16 = var15 + ((Part:GetAttribute("ThrusterHeightOffset") or 0) - var15) * 0.1
	p2._heightOffset = var16
	local color17 = if p1.AreTiresPopped then p1.Height - 0.5 else Height + var16
	local var18 = workspace:Raycast(p, var9:VectorToObjectSpace(Vector3.new(0, -1, 0)) * color17, var7)
	local var19, var20
	if var18 then
		var19 = var18.Instance
		var20 = var18.Position
	else
		var20 = nil
		var19 = nil
	end
	local var21 = if var20 then (var20 - p).Magnitude else color17
	local var22 = p1.AreTiresPopped and Part.Parent:FindFirstChild("Rim") or Part.Parent:FindFirstChild("TireMesh")
	local var23 = if var22 then var22.Size.Y else 0
	local var24 = -min(var21, color17) + var23 * 0.5
	local Y = Motor.C1.Y
	local var25 = Y + (var24 - Y) * 0.5
	local var26 = var3(0, var25, 0) * var8
	local Drift = Part:FindFirstChild("Drift")
	if cframe32.Z < 0 then
		var26 = var26 * Angles(0, p1.RotY * 0.4 + Engine.RotVelocity.Y * 0.2, 0)
	elseif Drift and (var19 and (var12 or p1.Drift)) then
		p1._didAnyWheelDrift = true
		Drift.C0 = CFrame.new(0, -var25 + var23 * 0.5, 0)
		for v27, v28 in Drift.Part0:GetChildren() do
			if v28:IsA("ParticleEmitter") then
				local var29 = (v28:GetAttribute("DriftAccum") or 0) + v28.Rate * p4
				local var30 = math.floor(var29)
				if var30 > 0 then
					v28:Emit(var30)
				end
				v28:SetAttribute("DriftAccum", var29 - var30)
			end
		end
	end
	local var31 = var26 * var72 * Angles(p3.WheelRotation or 0, 0, 0)
	if var31.x ~= var31.x or (var31.y ~= var31.y or (var31.z ~= var31.z or abs(var31.x + var31.y + var31.z) > 100)) then
		var31 = var5
	end
	Motor.C1 = var31
	local var322 = 4 / p2.NumWheels
	if var19 then
		local var33 = var13 * var122
		local var34 = var10 * 0.5
		local var35 = -var10 * 0.5
		local sum = (color17 - min(var21, color17)) ^ 2 * (var11 / color17 ^ 2)
		if var13.magnitude > 0.01 then
			sum = sum - var33.Y
		end
		if sum ~= sum then
			sum = 0
		end
		local var37 = 1
		local var38 = PhysicsLagService.getEstimatedPhysicsStepsMult()
		if var38 >= 1 then
			var37 = var37 / var38
		end
		Thruster.Force = var4(0, if var34 < sum then var34 elseif sum < var35 then var35 else sum * math.clamp(var37, 0, 1) * var322, 0)
	else
		Thruster.Force = Vector3.new(0, 0, 0)
	end
	local BridgeMotor = Part:FindFirstChild("BridgeMotor")
	if BridgeMotor then
		local var41 = p2.bridgeLocalYOffset or 0
		local cframe422 = CFrame.new((p2.bridgeXOffset or 0) * var6, (p2.bridgeYOffset or 0) + var41, 0)
		BridgeMotor.C1 = cframe422 * CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(cframe32.X, var25 - var41, 0)))
	end
end
local function fpor2Autopilot(p1, p2, p3)
	local magnitude = p2.magnitude
	local unit = p2.unit
	local count, tbl, cframe2, var3 = 0, p1, 0, { p3 }
	while true do
		local var4, var5, var62
		count = count + 1
		local var8, var9, var10 = FindPartOnRayWithIgnoreList(workspace, var6(tbl, unit * (magnitude - cframe2)), var3, false, true)
		if var8 then
			var8 = var8.CanCollide
			if var8 then
				if var8.Material == Enum.Material.Asphalt then
					var8, var4 = true, var8
				else
					var8, var4 = false, var8
				end
			else
				var4 = var8
			end
		else
			var4 = var8
		end
		if not var8 then
			table.insert(var3, var4)
		end
		cframe2 = (p1 - var9).magnitude
		if var8 or (magnitude - cframe2 <= 0.001 or count > 4) then
			if var4 then
				var5 = var9
				var62 = var10
			else
				var5 = p1 + unit * magnitude
				var62 = Vector3.new(0, -1, 0)
			end
			return var4, var5, var62
		end
		tbl = var9
	end
end
local t8 = {
	[EnumMake.Proto8] = true,
	[EnumMake.Parisian] = true,
	[EnumMake.Semi] = true,
	[EnumMake.PrisonBus] = true,
	[EnumMake.Aperture] = true,
	[EnumMake.Fiasco] = true
}
local t9 = {
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
function t4.UpdateEngine(p1, p2, p3)
	local Model = p1.Model
	local CanDrive = p2.CanDrive
	local Engine = p2.Engine
	local var13 = Engine.CFrame
	local cframe2 = Engine.Size * 0.5
	local Rotate = p1.Rotate
	local Height = p1.Height
	local var3 = Engine.AssemblyMass * 9.81 * 20
	local TurnSpeed = p1.TurnSpeed
	local EnumMakeId = p1.EnumMakeId
	local var42 = var13:VectorToObjectSpace(Engine.AssemblyLinearVelocity)
	local Magnitude = var42.Magnitude
	local var5 = os.clock()
	local _spinOutAt = p1._spinOutAt
	if _spinOutAt then
		_spinOutAt = var5 - p1._spinOutAt < 3
	end
	local var6 = t5[1] - t5[3]
	local var72 = t5[2] - t5[4]
	if InputUtils.isTouch() then
		local X = GetMoveVector().X
		local var8 = math.clamp(X, -1, 1)
		var72 = -var8 * abs(var8)
	end
	if _spinOutAt then
		var6 = var6 * 0.5
		if p1.AreTiresPopped and p1._spinOutLeft ~= nil then
			TurnSpeed = p1._pitTurnSpeed or 2
			var72 = if p1._spinOutLeft then 1 else -1
		end
	end
	local var92 = Model:GetAttribute("ForceHardBraking") == true
	if var92 then
		var12 = true
	end
	if p1.LockMovement or Model:GetAttribute("LockMovement") then
		var6 = 0
		var72 = 0
	end
	if p1.DriveToPosition and (var6 == 0 and var72 == 0) then
		local DriveToPosition = p1.DriveToPosition
		local p = var13.p
		local var10 = var4(DriveToPosition.X - p.X, 0, DriveToPosition.Z - p.Z)
		if var10.Magnitude <= (p1.DriveToPositionArrivalRadius or 4) then
			local DriveToPositionOnReached = p1.DriveToPositionOnReached
			p1.DriveToPosition = nil
			p1.DriveToPositionOnReached = nil
			if DriveToPositionOnReached then
				DriveToPositionOnReached:Fire()
			end
			var6 = 0
			var72 = 0
		else
			local LookVector = var13.LookVector
			local Unit = var4(LookVector.X, 0, LookVector.Z).Unit
			local Unit_2 = var10.Unit
			local var112 = Unit:Dot(Unit_2)
			local var132 = math.clamp(-(Unit.X * Unit_2.Z - Unit.Z * Unit_2.X) * 2.5, -1, 1)
			if var112 > 0.3 then
				var6, var72 = math.min(1, 0.3 + 0.7 * var112), var132
			elseif var112 < -0.3 then
				var6, var72 = math.max(-1, -0.3 + 0.7 * var112), var132
			else
				var6 = 0
				var72 = var132
			end
		end
	elseif p1.Autopilot then
		local var16 = var13.lookVector:Cross(Vector3.new(0, 1, 0))
		local color17 = fpor2Autopilot(var13 * var4(0, 0, -cframe2.Z - abs(var42.Z) * 16 * p3), Vector3.new(0, -10, 0), Model)
		if color17 then
			local var22 = (color17.CFrame * var4(-color17.Size.X * 0.5 + math.floor((color17.CFrame:toObjectSpace(var13).X + color17.Size.X * 0.5) / 12) * 12 + 6, 0, -color17.Size.Z * 0.5 * if var13.lookVector:Dot(color17.CFrame.lookVector) > 0 then 1 else -1) - var13.p).unit:Dot(var16)
			local var23 = var22 * 4
			local var25 = var72 - if var23 < -1 then -1 elseif var23 > 1 then 1 else var23
			local var26 = var6 + (1 - abs(var22) ^ 0.16666666666666666) - abs(var22) ^ 4 * 0.3
			var6 = if var26 > 1 then 1 elseif var26 < -1 then -1 else var26
			var72 = if var25 > 1 then 1 elseif var25 < -1 then -1 else var25
		end
	end
	local vHeading = p1.vHeading
	local var31 = vHeading + var72 * p3 * 60 - vHeading * if var72 == 0 then 0.3 else 0.16 * p3 * 60
	p1.vHeading = var31
	local cframe32 = var31 * 0.16
	local Cd = p1.Cd
	local Crr = p1.Crr
	local Cb = p1.Cb
	local var33 = nil
	local TirePopProportion = p1.TirePopProportion
	local var34 = Model:GetAttribute("VehicleTiresLastPop") or 0
	local var36 = math.min((Time.GetNowSync() - var34) / p1.DisableDuration, 1)
	local var37 = if var36 < 0.999 then p1.Make ~= "AdminNuke" else false
	if var37 then
		local var38 = if var36 < TirePopProportion then 0 else (var36 - TirePopProportion) / (1 - TirePopProportion)
		var33 = var3 * ((Vector3.new(0, 0, 0) - var42) / ((1 - var38) * 200 + var38 * 500))
		var6 = 0
		if Magnitude > 30 then
			p1.LastDrift = tick()
		end
	end
	p1.AreTiresPopped = var37
	if var72 ~= 0 and (var72 / abs(var72) ~= var42.X / abs(var42.X) and abs(var42.X) > 8) then
		p1.LastDrift = tick()
	end
	local var39 = tick() - p1.LastDrift < 0.3
	if EnumMakeId == EnumMake.Volt then
		var12 = false
		var39 = false
	end
	p1.Drift = var39
	local var40 = if Magnitude > 50 then var12 or p1.Drift else false
	if var40 and p1._haptic == nil then
		p1._haptic = HapticEffect.basic(0.2, (1 / 0))
	elseif p1._haptic and not var40 then
		p1._haptic:Destroy()
		p1._haptic = nil
	end
	local Volume = p1.Sounds.DriftSqueal.Volume
	p1.Sounds.DriftSqueal.Volume = if Magnitude > 30 and (var39 or var12 and var72 ~= 0) or (_spinOutAt or p1.LaunchSpeedMult) then Volume + (0.3 - Volume) * 0.06 else Volume + (0 - Volume) * 0.1
	t4.UpdateForces(p1, p2, p3)
	local var43 = var42.Z * p3
	if var43 ~= var43 then
		var43 = 0
	end
	p2.WheelRotation = ((p2.WheelRotation or 0) + var43 / (p1.Wheels[1].Model.PrimaryPart.Size.Y * 0.5)) % 6.283185307179586
	local var44 = tanh(abs(var42.magnitude) * 0.03)
	local Traction = p1.Traction
	local var45 = (var12 or var39) and (1 - var44) ^ 2 or 1
	if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
		var45 = var45 * 0.4
	end
	if _spinOutAt then
		var45 = var45 * 0.6
	end
	local var46 = if var45 < 0.07 then 0.07 else var45
	local var48 = Traction + (var46 - Traction) * if var46 < Traction then 0.2 else 0.01 * p3 * 60
	if var48 < 0 then
		var48 = 0
	end
	p1.Traction = var48
	local Gears = p1.Gears
	local var49 = math.abs(var42.Z)
	local v50, v51 = UpdateGearsAndRPM(p1, Gears, var49, var6, p3)
	p1.LastFakeGear = v51
	local vector52 = workspace:Raycast(var13 * var4(0, 0, cframe2.Z - 1), var13:vectorToWorldSpace(Vector3.new(0, -1, 0)) * Height * 2, var7)
	local v53, v54
	if vector52 then
		v53 = vector52.Instance
		v54 = vector52.Material
	else
		v54 = nil
		v53 = nil
	end
	local var55 = p1.CanLaunchControl == true
	if var55 and (t5[1] == 1 and (t5[3] == 1 and (var49 < 10 and not (p1.LaunchSpeedMult or p1.AreTiresPopped)))) then
		if p1.LaunchHeldSince == nil then
			p1.LaunchHeldSince = os.clock()
		end
		if p1.LaunchHoldSound == nil then
			p1.LaunchHoldSound = Audio.ObjectLocal(Model.Engine, 115412433949268, {
				Volume = 0,
				Looped = true,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 512,
				RollOffMode = Enum.RollOffMode.InverseTapered
			})
		end
		p1.LaunchHoldSound.Volume = math.clamp(p1.LaunchHoldSound.Volume + p3 * 0.8, 0, 0.6)
		p1.LastDrift = tick()
	elseif var55 and (p1.LaunchHeldSince and (os.clock() - p1.LaunchHeldSince >= 2 and var6 == 1)) then
		print("LAUNCH!")
		p1.LaunchHeldSince = nil
		p1.LaunchStartedAt = os.clock()
		p1.LaunchSpeedMult = 4
		Audio.ObjectLocal(Model.Engine, 15684233147, {
			Volume = 1.5,
			RollOffMaxDistance = 128,
			RollOffMinDistance = 32
		})
	elseif var55 then
		p1.LaunchHeldSince = nil
		if p1.LaunchHoldSound then
			p1.LaunchHoldSound.Volume = 0
		end
		if p1.LaunchSpeedMult then
			p1.LaunchSpeedMult = p1.LaunchSpeedMult - p3 * 3
			if p1.LaunchSpeedMult < 1 then
				p1.LaunchSpeedMult = nil
			end
		end
	end
	if not p1.TractionMag then
		p1.TractionMag = t9[EnumMakeId] or 300
	end
	local var62 = -Cd * var42 * Magnitude * var4(0, 0, if var6 < 0 then 80 else 1)
	local vector63 = -Crr * var42 * Vector3.new(0, 0, 1)
	local var64 = -var4(math.clamp(var42.X, -150, 150), 0, 0) * p1.TractionMag * var48 * 150 / 588600 * var3
	if EnumMakeId == EnumMake.ATV and var3 * 0.05 < math.abs(vector63.X) then
		vector63 = Vector3.new(math.clamp(vector63.X, -var3 * 0.05, var3 * 0.05), 0, vector63.Z)
	end
	local var67 = var3 / 196.20000000000002
	local var68 = -(Cb * (1 + p1.GarageBrakes)) * var42.Z / abs(var42.Z)
	if var68 ~= var68 then
		var68 = 0
	end
	local vector69 = var68 / 18000 * var67 * Vector3.new(0, 0, 1)
	if var92 then
		vector69 = vector69 * 40
	end
	local vector70 = -Cb * 0.3 * var42 * Vector3.new(1, 0, 0)
	local Nitro = p1.Nitro
	local _lastJumpAt = p1._lastJumpAt
	if _lastJumpAt then
		_lastJumpAt = os.clock() - p1._lastJumpAt < 2
	end
	if Nitro and not (p1.Nitrof1 or _lastJumpAt) then
		p1.Nitrof1 = true
		t4.SetGravity(p1, 20)
	elseif (not Nitro or _lastJumpAt) and p1.Nitrof1 then
		p1.Nitrof1 = false
		t4.SetGravity(p1, 100)
	end
	local var74 = if p1.NoGears then var6 > 0 and Gears[1] or Gears[2] else var6 > 0 and Gears[2 + v50] or Gears[2]
	local var77 = 4.4
	if EnumMakeId == EnumMake.Lamborghini or (EnumMakeId == EnumMake.OGLaMatador or EnumMakeId == EnumMake.Hammerhead) then
		var77 = 5.5
	elseif EnumMakeId == EnumMake.Ambulance then
		var77 = 5
	elseif EnumMakeId == EnumMake.Bandit then
		var77 = 11.399999999999999 * var67 / 4300
	elseif EnumMakeId == EnumMake.FrostCrawler then
		var77 = 2.485 * var67 / 4600
	elseif EnumMakeId == EnumMake.Laviolette then
		var77 = 3 * var67 / 4300
	elseif EnumMakeId == EnumMake.Crown then
		var77 = 11.2 * var67 / 3304
	elseif EnumMakeId == EnumMake.DesertCrawler then
		var77 = 9 * var67 / 3894
	elseif EnumMakeId == EnumMake.ShellMark5 then
		var77 = 6.6 * var67 / 3089
	elseif EnumMakeId == EnumMake.Goliath then
		var77 = 2.6 * var67 / 12720 * 4
	elseif EnumMakeId == EnumMake.Bloxy then
		var77 = 6.6 * var67 / 3948
	elseif EnumMakeId == EnumMake.TinyToy then
		var77 = 1.02 * var67 / 720
	elseif EnumMakeId == EnumMake.ShellClassic then
		var77 = 5.5 * var67 / 2250
	elseif EnumMakeId == EnumMake.Snake then
		var77 = 13.3 * var67 / 5449 * 1.39
	elseif EnumMakeId == EnumMake.Scorpio then
		var77 = 25.27 * var67 / 12583
	elseif EnumMakeId == EnumMake.Successor then
		var77 = 9.545689999999999 * var67 / 3018
	elseif EnumMakeId == EnumMake.Macaron then
		var77 = 9.182440218957073 * var67 / 5543 * 1.6
	elseif EnumMakeId == EnumMake.JackRabbit then
		var77 = 3.331709741550696 * var67 / 3047
	elseif EnumMakeId == EnumMake.Poseidon then
		var77 = 5.43452380952381 * var67 / 3024
	elseif EnumMakeId == EnumMake.MCL36 or EnumMakeId == EnumMake.MCL36FREE then
		var77 = 132500 / var67
	elseif EnumMakeId == EnumMake.TowTruck then
		var77 = 6.6 * var67 / 4000 * 2
	elseif EnumMakeId == EnumMake.NASCAR1 then
		var77 = 11.407
	elseif EnumMakeId == EnumMake.NASCAR2 or EnumMakeId == EnumMake.NASCAR75th then
		var77 = 6.039
	elseif EnumMakeId == EnumMake.Trailblazer then
		var77 = 12.552631578947368
	elseif EnumMakeId == EnumMake.Concept then
		var77 = 9.636363636363637
	elseif EnumMakeId == EnumMake.Torero then
		var77 = 15.847
	elseif EnumMakeId == EnumMake.Beignet then
		var77 = 10.794242074927956
	elseif EnumMakeId == EnumMake.Ray9 then
		var77 = 5.4
	elseif EnumMakeId == EnumMake.TheRattler then
		var77 = 5.5
	elseif EnumMakeId == EnumMake.Ferrari then
		var77 = 6
	elseif EnumMakeId == EnumMake.BananaCar then
		var77 = 18
	elseif EnumMakeId == EnumMake.Challenger then
		var77 = 5.459999999999999
	elseif EnumMakeId == EnumMake.Surus then
		var77 = 6
	elseif EnumMakeId == EnumMake.MoltenM12 then
		var77 = 6.56
	elseif EnumMakeId == EnumMake.Bugatti then
		var77 = 8
	elseif EnumMakeId == EnumMake.Parisian then
		var77 = 24.8
	elseif EnumMakeId == EnumMake.Chiron then
		var77 = 8.8 * var67 / 3303
	elseif EnumMakeId == EnumMake.Model3 then
		var77 = 4.2
	elseif EnumMakeId == EnumMake.Roadster then
		var77 = 9
	elseif EnumMakeId == EnumMake.IceBreaker then
		var77 = 8.5
	elseif EnumMakeId == EnumMake.Proto8 then
		var77 = 6.73
	elseif EnumMakeId == EnumMake.Monster then
		var77 = 5.75
	elseif EnumMakeId == EnumMake.OGMonster then
		var77 = 5
	elseif EnumMakeId == EnumMake.Firetruck then
		var77 = 10 * var67 / 10418
	elseif EnumMakeId == EnumMake.ATV then
		var77 = 1.5
	elseif EnumMakeId == EnumMake.BankTruck then
		var77 = 16.8
	elseif EnumMakeId == EnumMake.BeamHybrid then
		var77 = 6.5
	elseif EnumMakeId == EnumMake.AirTail then
		var77 = 7.5
	elseif EnumMakeId == EnumMake.Volt4x4 then
		var77 = 20
	elseif EnumMakeId == EnumMake.TheAgent then
		var77 = 8.5
	elseif EnumMakeId == EnumMake.Interrogator then
		var77 = 6
	elseif EnumMakeId == EnumMake.Sentinel then
		var77 = 7
	elseif EnumMakeId == EnumMake.TheCamper then
		var77 = 18.974999999999998
	elseif EnumMakeId == EnumMake.R8 then
		var77 = 6.072
	elseif EnumMakeId == EnumMake.Semi then
		var77 = 4.928000000000001
	elseif EnumMakeId == EnumMake.Stormrider then
		var77 = 19.712000000000003
	elseif EnumMakeId == EnumMake.Shogun then
		var77 = 4.95 * var67 / 3010 * 1.8
	elseif EnumMakeId == EnumMake.PrisonBus then
		var77 = 5
	elseif EnumMakeId == EnumMake.Power1 then
		var77 = 7.700000000000001 * var67 / 2267 * 0.95
	elseif EnumMakeId == EnumMake.Aperture then
		var77 = 7.2 * var67 / 2242
	elseif EnumMakeId == EnumMake.Fiasco then
		var77 = 12.32
	elseif EnumMakeId == EnumMake.Longhorn then
		var77 = 10.26
	elseif EnumMakeId == EnumMake.Carbonara then
		var77 = 7.6 * var67 / 2601
	elseif EnumMakeId == EnumMake.XRK then
		var77 = var77 * 1.44256
	elseif EnumMakeId == EnumMake.Striker then
		var77 = var77 * 0.7
	elseif EnumMakeId == EnumMake.SWATVan then
		var77 = var77 * 1.32
	elseif EnumMakeId == EnumMake.Wedge then
		var77 = var77 * 1.3
	elseif EnumMakeId == EnumMake.Manta then
		var77 = var77 * 9.2
	elseif EnumMakeId == EnumMake.Iceborn then
		var77 = var77 * (var67 / 2250 * 1.0093333333333334 * 1.05)
	elseif EnumMakeId == EnumMake.Tanker then
		var77 = var77 * 3
	elseif EnumMakeId == EnumMake.Revox then
		var77 = var77 * 1.830907534246575
	elseif EnumMakeId == EnumMake.Deja then
		var77 = var77 * 2
	elseif EnumMakeId == EnumMake.McLaren then
		var77 = var77 * 1.3
	elseif EnumMakeId == EnumMake.Cobra then
		var77 = var77 * 1.7
	elseif EnumMakeId == EnumMake.Expeditioner then
		var77 = var77 * 1.6
	elseif EnumMakeId == EnumMake.Wraith then
		var77 = var77 * 1.3
	elseif EnumMakeId == EnumMake.Badger then
		var77 = var77 * 1.5
	elseif EnumMakeId == EnumMake.Mustang then
		var77 = var77 * 1.25
	elseif EnumMakeId == EnumMake.Blackbeard then
		var77 = var77 * 2.508
	elseif EnumMakeId == EnumMake.OrionM42 then
		var77 = var77 * 0.768
	elseif EnumMakeId == EnumMake.Maverick then
		var77 = var77 * 1.6
	elseif EnumMakeId == EnumMake.Katana then
		var77 = var77 * 2.3
	elseif EnumMakeId == EnumMake.WYNDR then
		var77 = var77 * 1.6
	elseif EnumMakeId == EnumMake.PizzaDelivery then
		var77 = var77 * 10
	elseif EnumMakeId == EnumMake.BrickKar then
		var77 = var77 * 6.8
	elseif EnumMakeId == EnumMake.Polaire then
		var77 = var77 * 5.7
	elseif EnumMakeId == EnumMake.BlackWidow then
		var77 = var77 * 1.55
	elseif EnumMakeId == EnumMake.AdminNuke then
		var77 = 60
	elseif EnumMakeId == EnumMake.Bluebird then
		var77 = 44.6
	end
	if p1.EngineSpeedMult then
		var77 = var77 * p1.EngineSpeedMult
	end
	if p1.LaunchSpeedMult then
		var77 = var77 * p1.LaunchSpeedMult
	end
	local sum = var77 + p1.GarageEngineSpeed
	if not t8[EnumMakeId] then
		sum = sum + 0.5
	end
	p1.TrueEngineSpeed = sum
	local vector78 = var6 * Vector3.new(0, 0, -1) * Gears[1] * 1 / 0.34 * 750 * var74 * sum
	if v54 and (v54 == Enum.Material.Water and var7.IgnoreWater) then
		vector78 = vector78 * 0.625
	end
	if p1.ManualGear and p1._rpmLimitMult then
		vector78 = vector78 * p1._rpmLimitMult
	end
	local sum_2 = var62 + vector63
	if var6 ~= 0 and var6 == var6 then
		p1.LastForward = var6 / abs(var6)
		sum_2 = sum_2 + vector78
	end
	if var6 == 0 and Magnitude <= 1 then
		Engine.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	elseif var6 == 0 then
		sum_2 = sum_2 + vector69
	end
	if var12 and (var72 == 0 and var6 == 0) then
		sum_2 = sum_2 + vector69 * 3 + vector70
	end
	local var79 = 0
	local var80 = 0
	local var81 = 0
	local RotY = p1.RotY
	p1.RotY = RotY + (var72 - RotY) * 0.1
	if p1.driveInAir then
		v54 = Enum.Material.SmoothPlastic
	end
	if v53 or p1.driveInAir then
		if v54 == Enum.Material.Grass then
			var79 = 0.4
		elseif v54 == Enum.Material.Concrete or (v54 == Enum.Material.Basalt or v54 == Enum.Material.Asphalt) then
			var80 = 0.94
		elseif v54 == Enum.Material.Sandstone or v54 == Enum.Material.Sand then
			var81 = 0.5
		end
		local var85 = math.exp(-max(var42.magnitude, 120) / 400) * if var12 then 1.5 else 1.2
		local var86 = -var42.Z / abs(var42.Z)
		if var86 ~= var86 then
			var86 = 0
		end
		if p1.LastForward ~= var86 and (abs(var42.Z) > 2 and not var12) then
			p1.LastForward = var86
		end
		if var72 == 0 then
			if var42.Z < 0 and not var12 then
				Rotate.MaxTorque = var4(0, var3 * 2, 0)
			end
		else
			Rotate.MaxTorque = var4(0, var3 * 30, 0)
		end
		Rotate.AngularVelocity = var4(0, cframe32 * TurnSpeed * p1.LastForward * var85 * var44, 0)
	else
		Rotate.MaxTorque = var4(var3 * 0.5, var3, var3 * 0.5)
		var64 = Vector3.new(0, 0, 0)
		sum_2 = Vector3.new(0, 0, 0)
	end
	local sum_3 = sum_2 + (Nitro and 0.17 * var3 or 0) * Vector3.new(0, -0.1, -1)
	if var33 ~= nil then
		sum_3 = sum_3 + var33
	end
	local Grass = p1.Sounds.Grass
	local Asphalt = p1.Sounds.Asphalt
	local Sandstone = p1.Sounds.Sandstone
	p1.vGrass = p1.vGrass + (var79 - p1.vGrass) * 0.03
	p1.vAsphalt = p1.vAsphalt + (var80 - p1.vAsphalt) * 0.03
	p1.vSandstone = p1.vSandstone + (var81 - p1.vSandstone) * 0.03
	local var88 = (Magnitude < 60 and Magnitude / 60 or 1) * 0.25
	Grass.Volume = p1.vGrass * var88
	Asphalt.Volume = p1.vAsphalt * var88
	Sandstone.Volume = p1.vSandstone * var88
	local var89 = Magnitude > 0 and (Magnitude / 120) ^ 0.5 or 0
	Grass.PlaybackSpeed = var89
	Asphalt.PlaybackSpeed = var89
	Sandstone.PlaybackSpeed = var89
	local var90 = var12
	if not var90 then
		var90 = var6 < 1e-6
	end
	if p1._flagBrakelightsEnabled ~= var90 then
		p1._flagBrakelightsEnabled = var90
		VehicleUtils.setBrakelightsEnabled(p1.Model, var90)
	end
	if CanDrive then
		p2.Drive.Force = sum_3
	end
	p2.Friction.Force = var13:VectorToWorldSpace(var64)
	local _, _2, _3, _4, _5, _6, _7, v91, _8, _9, _10, _11 = var13:GetComponents()
	if v91 < -0.25 then
		if p1.UpsideDownTime then
			if tick() - p1.UpsideDownTime > 2 then
				p1.UpsideDownTime = nil
				var9:FireServer("l" .. ("dx152bwlj"):sub(5, 8):reverse():reverse():reverse():reverse():reverse() .. "iv8")
			end
		else
			p1.UpsideDownTime = tick()
		end
	else
		p1.UpsideDownTime = nil
	end
	local var922 = nil
	if (not tbl or tbl and Settings.Test.RegionSounds) and Region.CastPoint(Settings.Prism.City, Engine.Position) then
		var922 = "City"
	end
	local vector93 = if workspace:Raycast(var13 * var4(0, 0, cframe2.Z - 1), var13:VectorToWorldSpace(Vector3.new(0, 1, 0)) * 20, var7) then "Tunnel" else var922 or "Outside"
	if p1.LastEnvironment ~= vector93 then
		p1.TransitionSpeed = 1 / if vector93 == "Tunnel" or p1.LastEnvironment == "Tunnel" then 0.5 else 4
		p1.EnvironmentTransition = true
		p1.LastEnvironment = vector93
		var11 = 0
		for k, v in pairs(t2) do
			p1[k] = {}
			for k2, var8 in pairs(v) do
				p1[k][var8] = t[k][var8]
			end
		end
	end
	if p1.EnvironmentTransition then
		local var95 = t3[vector93]
		var11 = var11 + p3 * p1.TransitionSpeed
		for k, v in pairs(t2) do
			for k2, var8 in pairs(v) do
				t[k][var8] = p1[k][var8] * (1 - var11) + var95[k][var8] * var11
			end
		end
		if var11 >= 1 then
			p1.EnvironmentTransition = false
		end
	end
	if EnumMakeId == EnumMake.Bluebird then
		local var98 = os.clock()
		local var99 = var6 > 0.01
		if if var99 then 0.1 else 0.2 < var98 - p1.LastEngineRattle then
			p1.LastEngineRattle = var98
			p1.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if var99 then 4 else 2)
		end
		local var107 = if var99 then p1.SpringEngineFlaps:SetTarget(1) else p1.SpringEngineFlaps:SetTarget(0)
		Model.Preset.RattlerEngine.EngineMetal["EngineMetal->Engine"].C1 = CFrame.new((p1.SpringEngineRattle:Update()))
		local var111 = Model.Preset.RattlerEngine.EngineFlaps["EngineFlaps->Engine"]
		var111.C1 = var111.C0:Inverse() * CFrame.Angles(var107 * -3.141592653589793 * 0.45, 0, 0) * var111.C0
		for i, v in ipairs(p1.RattleFire) do
			v.Enabled = var99
		end
		if p1.BluebirdSupercharger then
			local var112 = p1.rpmVisual or 0
			if var6 > 0 then
				p1.BluebirdSupercharger.Volume = math.clamp(var112 / 4000 * 0.15, 0, 0.15)
				p1.BluebirdSupercharger.PlaybackSpeed = math.clamp(var112 / 8000 * 0.8, 0, 0.8)
			elseif p1.BluebirdSupercharger.Volume > 0 then
				p1.BluebirdSupercharger.Volume = math.max(0, p1.BluebirdSupercharger.Volume - p3 * 0.3)
			end
		end
	elseif EnumMakeId == EnumMake.TheRattler then
		local var116 = os.clock()
		local var117 = math.abs(var6) > 0.01
		if if var117 then 0.1 else 0.2 < var116 - p1.LastEngineRattle then
			p1.LastEngineRattle = var116
			p1.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if var117 then 4 else 2)
		end
		local var125 = if var117 then p1.SpringEngineFlaps:SetTarget(1) else p1.SpringEngineFlaps:SetTarget(0)
		Model.Preset.RattlerEngine.EngineBody["EngineBody->Engine"].C1 = CFrame.new((p1.SpringEngineRattle:Update()))
		local var129 = Model.Preset.RattlerEngine.EngineFlaps["EngineFlaps->Engine"]
		var129.C1 = var129.C0:Inverse() * CFrame.Angles(var125 * -3.141592653589793 * 0.45, 0, 0) * var129.C0
		for i, v in ipairs(p1.RattleSmoke) do
			v.Enabled = not var117
		end
		for i, v in ipairs(p1.RattleFire) do
			v.Enabled = var117
		end
	end
	if EnumMakeId == EnumMake.Polaire then
		local TiltWing = Model.Preset:FindFirstChild("TiltWing")
		if TiltWing then
			DoorUtils.setPctOpen(TiltWing, if var72 < -0.5 then -1 elseif var72 > 0.5 then 1 else 0)
		end
	end
	local Rudder = p1.Model.Preset:FindFirstChild("Rudder")
	if Rudder then
		DoorUtils.setPctOpen(Rudder, if math.abs(var72) > 0.5 then if var72 > 0 then 0 else 1 else 0.5)
	end
	if p1.RattleMotors then
		local var132 = os.clock()
		local var133 = math.abs(var6) > 0.01
		if if var133 then 0.05 else 0.1 < var132 - p1.LastEngineRattle then
			p1.LastEngineRattle = var132
			p1.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if var133 then 3 else 2)
		end
		local var141 = p1.SpringEngineRattle:Update()
		for v142, v143 in p1.RattleMotors do
			v143.motor.C1 = CFrame.new(var141)
		end
	end
	if p1.RattleParticles then
		local var144 = math.abs(var6) > 0.01
		for v145, v146 in p1.RattleParticles do
			v146.Enabled = var144
		end
	end
	if p1.ThrusterFlames then
		t4.UpdateThrusterFlames(p1.Model, var6, var72, var42.Z, {
			client = true
		})
	end
	if p1.BrakeTrails then
		for v147, v148 in p1.BrakeTrails do
			v148.Enabled = p1._flagBrakelightsEnabled
		end
	end
	local gravityOffset = p1.gravityOffset
	if p1.Model:FindFirstChild("IsPickedUp") then
		gravityOffset = 0
	end
	p1.Lift.Force = var4(0, gravityOffset, 0)
end
function t4.Update(p1, p2)
	p1._didAnyWheelDrift = false
	local tbl = t5[1] - t5[3] > 0
	if not tbl and (p1.isAccelHeld ~= tbl and p1.Model.PrimaryPart.AssemblyLinearVelocity.Magnitude > 50) then
		local cframe2 = os.clock()
		if p1.turboBlowOff and cframe2 - (p1.lastTurboBlowOff or 0) > 1 then
			p1.lastTurboBlowOff = cframe2
			p1.turboBlowOff.PlaybackSpeed = 1 + (math.random() * 0.1 - 0.05)
			p1.turboBlowOff:Play()
		end
	end
	p1.isAccelHeld = tbl
	for var3, var4 in p1.EngineThrusters do
		t4.UpdateEngine(p1, var4, p2)
	end
	if p1.Model:GetAttribute("VehicleIsDrifting") ~= p1._didAnyWheelDrift then
		p1.Model:SetAttribute("VehicleIsDrifting", p1._didAnyWheelDrift)
		p1.Model:FindFirstChild("RelayDriftingRemote"):FireServer(p1._didAnyWheelDrift)
	end
end
function t4.UpdateStepped(p1)
	local Model = p1.Model
	if p1.IK then
		local tbl = 0.6 * p1.RotY
		p1.WeldSteer.C0 = Angles(0, tbl, 0)
		local cframe2 = Model.Steer.CFrame
		local var3 = Model.Steer.Size.X * 0.5 - 0.2
		local SteerOffset = p1.SteerOffset
		local IK = p1.IK
		local sum = var4(var3, 0.1, 0)
		if SteerOffset then
			sum = sum + SteerOffset
		end
		local sum_2 = var4(-var3, 0.1, 0)
		if SteerOffset then
			sum_2 = sum_2 + SteerOffset
		end
		IK.RightArm = cframe2 * sum
		IK.LeftArm = cframe2 * sum_2
		IK.RightAngle = -tbl - 0.6
		IK.LeftAngle = -tbl + 0.6
		R15IKv2.Arms(IK)
	end
end
function t4.UpdateForces(p1, p2, p3)
	for tbl, cframe2 in p1.Wheels do
		UpdateThruster(p1, cframe2, p2, p3)
	end
end
function t4.Halt(p1)
	for tbl, cframe2 in p1.EngineThrusters do
		cframe2.Drive.Force = Vector3.new(0, 0, 0)
		cframe2.Friction.Force = Vector3.new(0, 0, 0)
	end
	p1.Rotate.MaxTorque = Vector3.new(0, 0, 0)
end
function t4.SpinOut(p1, p2)
	p1._spinOutLeft = p2
	p1._spinOutAt = os.clock()
end
function t4.AttemptFireMissile(p1)
	local Missiles = p1.Missiles
	if not Missiles then
		return false
	end
	if LocalPlayer:GetAttribute("MissileCount") <= 0 then
		VehicleUtils.promptMissileBuy()
		return false
	end
	local tbl = tick()
	local cframe2 = tbl - Missiles.LastFire
	if cframe2 < 2 and cframe2 > 0 then
		return false
	end
	Missiles.LastFire = tbl
	local var3 = Missiles.Parts[Missiles.i]
	var3.Transparency = 1
	delay(2, function()
		var3.Transparency = 0
	end)
	local var4 = var3.CFrame
	local Velocity = var3.Velocity
	if Velocity.Magnitude < 0.01 then
		Velocity = Vector3.new(0, 0, 0)
	end
	local t = { p1.Model, LocalPlayer.Character }
	local _, var5 = RayCast.RayIgnoreNonCollideWithIgnoreList(var4.p, (p1.Model.Engine.CFrame.LookVector * 60 - Vector3.new(0, 2, 0)).Unit, 999, t)
	local var6 = Time.GetNowSync()
	var9:FireServer("e" .. ("t0wcl0avxyx"):sub(5, 9):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("gp4krij"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "q", var4, Velocity, var5, var6, "RocketPart2", 0)
	Missile.LaunchMissile(var4, Velocity, var5, var6, "RocketPart2", 0, t)
	Missiles.i = Missiles.i % #Missiles.Parts + 1
end
local t10 = {
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.Q] = 5,
	[Enum.KeyCode.E] = 6,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 3,
	[Enum.KeyCode.Left] = 2,
	[Enum.KeyCode.Right] = 4
}
function t4.LockCamera(p1)
	assert(not p1.IsCameraLocked)
	local Model = p1.Model
	local InsideCamera = Model:FindFirstChild("InsideCamera")
	if InsideCamera ~= nil then
		p1.IsCameraLocked = true
		Model:SetAttribute("IsCameraLocked", true)
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		p1.seatMaid.cameraLockRenderStepped = RunService.RenderStepped:Connect(function()
			CurrentCamera.CFrame = InsideCamera.CFrame
		end)
		function p1.seatMaid.cameraUnlock()
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end
	end
end
function t4.UnlockCamera(p1)
	assert(p1.IsCameraLocked)
	p1.IsCameraLocked = false
	p1.Model:SetAttribute("IsCameraLocked", false)
	CurrentCamera.CameraType = Enum.CameraType.Custom
	p1.seatMaid.cameraLockRenderStepped = nil
	p1.seatMaid.cameraUnlock = nil
end
function t4.InputBegan(p1)
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t10[KeyCode] then
			t5[t10[KeyCode]] = 1
		end
	end
end
function t4.InputEnded(p1)
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t10[KeyCode] then
			t5[t10[KeyCode]] = 0
		end
	elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			t5[t10[KeyCode]] = 0
		end
	end
end
function t4.InputChanged(p1)
	if p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = p1.Position
			local X = Position.X
			local Y = Position.Y
			t5[2] = X < -0.24 and (-X) ^ 2 or 0
			t5[4] = X > 0.24 and X ^ 2 or 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = p1.Position.Z
			t5[t10[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
		end
	end
end
function t4.SetEvent(p1)
	var9 = p1
end
local CircleAction = UI.CircleAction
local function Action(p1, p2)
	if p2 then
		var9:FireServer("e" .. "" .. ("ahui0"):sub(2, 3):reverse():reverse():reverse() .. "" .. "" .. ("b0lg8d"):sub(5, 5):reverse() .. "" .. "" .. ("k5bb9fhz8"):sub(5, 7):reverse():reverse():reverse() .. "2", p1.Part)
	end
	return true
end
local function AddedFun(p1)
	CircleAction.Add({
		Part = p1,
		Name = "Move Ladder",
		NoRay = true,
		Timed = true,
		Duration = 0.25,
		Dist = 10,
		Callback = Action
	}, p1)
end
local function RemovedFun(p1)
	CircleAction.Remove(p1)
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
return t4
