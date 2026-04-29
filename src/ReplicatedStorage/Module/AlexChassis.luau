-- Reviewed by Claude
-- variables reassigned
-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UI = require(ReplicatedStorage.Module.UI)
local RunService = game:GetService("RunService")
game:GetService("Lighting")
local v1 = require(ReplicatedStorage.App.RunUtils).isStudio()
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
local function GetMoveVector() --[[ GetMoveVector | Line: 43 ]]
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local v2 = require(ControlModule)
	GetMoveVector = function() --[[ GetMoveVector | Line: 50 | Upvalues: v2 (ref) ]]
		return v2:GetMoveVector()
	end
end
local v3 = CFrame.new
local v4 = Vector3.new
local Angles = CFrame.Angles
local v5 = v3(0, 0, 0)
local v6 = Ray.new
local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local min = math.min
local max = math.max
local abs = math.abs
local tanh = math.tanh
local _exp = math.exp
local v7 = RaycastParams.new()
v7.RespectCanCollide = true
v7.FilterType = Enum.RaycastFilterType.Exclude
v7.FilterDescendantsInstances = { Vehicles }
local v8 = RaycastParams.new()
v8.RespectCanCollide = true
v8.FilterType = Enum.RaycastFilterType.Exclude
v8.FilterDescendantsInstances = { Vehicles }
local vehicleEvent = nil
local _screenGui = nil
local soundEffects = {
	Echo = SoundService.Chassis.EchoSoundEffect,
	Equalizer = SoundService.Chassis.EqualizerSoundEffect,
	Reverb = SoundService.Chassis.ReverbSoundEffect
}
local effectProperties = {
	Echo = { "Delay", "DryLevel", "Feedback", "WetLevel" },
	Equalizer = { "HighGain", "LowGain", "MidGain" },
	Reverb = { "DecayTime", "Density", "Diffusion", "DryLevel", "WetLevel" }
}
local environmentPresets = {
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
local envTransitionT = 0
local function f(p1, p2, p3) --[[ f | Line: 150 ]]
	return math.exp(-(p1 - p2) ^ 2 / (2 * p3 * p3))
end
local function setVolume(p1, p2) --[[ setVolume | Line: 153 ]]
	if math.abs(p1.Volume - p2) > 0.001 then
		p1.Volume = p2
	end
end
local function setPlaybackSpeed(p1, p2) --[[ setPlaybackSpeed | Line: 158 ]]
	if math.abs(p1.PlaybackSpeed - p2) > 0.001 then
		p1.PlaybackSpeed = p2
	end
end
local function IsNaN(p1) --[[ IsNaN | Line: 1351 ]]
	return p1 ~= p1
end
local function SetRPM3(p1, p2, p3, p4) --[[ SetRPM3 | Line: 163 | Upvalues: EnumMake (copy) ]]
	local v1 = 0.2
	local v2 = 1
	local v3, v4, v5, v6, v7
	if p4 == EnumMake.Lamborghini or (p4 == EnumMake.Bugatti or (p4 == EnumMake.Chiron or (p4 == EnumMake.Surus or (p4 == EnumMake.Challenger or (p4 == EnumMake.Beignet or (p4 == EnumMake.Macaron or (p4 == EnumMake.Monster or (p4 == EnumMake.Goliath or (p4 == EnumMake.ShellMark5 or (p4 == EnumMake.Power1 or (p4 == EnumMake.Successor or (p4 == EnumMake.OGLaMatador or (p4 == EnumMake.Maverick or (p4 == EnumMake.Wedge or p4 == EnumMake.Revox)))))))))))))) then
		v3 = p2 / 12000 + 0.5 + 0.07 - 0.1
		v4 = 1 + p2 / 12000 - 0.5 + 0.07 - 0.1
		v5 = 1 + p2 / 12000 - 0.3 + 0.25 - 0.1
		v6 = p2 / 12000 + 0.6 + 0.1 - 0.1
		v2 = 0.5
		v7 = (p2 + 2000) / 5500 + 0.8
	elseif p4 == EnumMake.OrionM42 then
		v3 = p2 / 5500 + 0.2295
		v4 = 1 + p2 / 6000 - 0.991
		v5 = 1 + p2 / 6000 - 1.218
		v6 = p2 / 5500 + 0.2295
		v1 = v1 * 2.25
		v7 = (p2 + 6500) / 7500
	elseif p4 == EnumMake.Blackbeard or p4 == EnumMake.BlackWidow then
		v3 = p2 / 10500 + 0.085
		v4 = 1 + p2 / 12000 - 0.911
		v5 = 1 + p2 / 20500 - 0.818
		v6 = p2 / 10500 + 0.085
		v1 = v1 * 3.75
		v7 = (p2 + 2700) / 6500
	elseif p4 == EnumMake.Katana then
		v3 = p2 / 3500 + 0.09
		v4 = p2 / 6200 + 0.05
		v5 = p2 / 6700 - 0.012
		v6 = p2 / 3500 + 0.09
		v1 = 1
		v7 = (p2 + 9500) / 9500 - 0.1
	elseif p4 == EnumMake.WYNDR then
		v3 = p2 / 6500 + 0.4
		v4 = 1 + p2 / 6500 - 0.28
		v5 = 1 + p2 / 7500 - 0.45
		v6 = p2 / 6500 + 0.4
		v7 = (p2 + 1800) / 1800 + 0.3
	elseif p4 == EnumMake.Carbonara then
		v3 = p2 / 3600 + 0.04
		v4 = p2 / 4100 - 0.1
		v5 = p2 / 6200 + 0.022
		v6 = p2 / 3600 + 0.04
		v7 = (p2 + 4900) / 4900 - 0.05
	elseif p4 == EnumMake.Aperture then
		v3 = p2 / 8500 + 0.22
		v4 = p2 / 9300 + 0.33
		v5 = p2 / 16500 + 0.31
		v6 = p2 / 8500 + 0.22
		v7 = (p2 + 10800) / 10800 - 0.12
	elseif p4 == EnumMake.SWATVan or p4 == EnumMake.Sentinel then
		v3 = p2 / 10000 + 0.205
		v4 = p2 / 13000 + 0.175
		v5 = p2 / 11500 - 0.15
		v6 = p2 / 10000 + 0.205
		v7 = (p2 + 12500) / 12500 - 0.83
	elseif p4 == EnumMake.Polaire then
		v3 = p2 / 3500 + 0.235
		v4 = p2 / 6000 + 0.145
		v5 = p2 / 9500 + 0.315
		v6 = p2 / 3500 + 0.235
		v7 = (p2 + 4300) / 4300 - 0.02
	elseif p4 == EnumMake.Bluebird then
		v3 = p2 / 4500 + 0.165
		v4 = p2 / 7500 + 0.145
		v5 = p2 / 10500 + 0.155
		v6 = p2 / 4500 + 0.165
		v7 = (p2 + 7300) / 7300 - 0.2
	else
		v3 = p2 / 10000 + 0.2
		v4 = 1 + p2 / 10000 - 0.7
		v5 = 1 + p2 / 10000 - 1
		v6 = p2 / 10000 + 0.2
		v2 = 0.6
		v7 = (p2 + 1000) / 6000 + 0.8
	end
	local v8 = 0
	local v9 = 0
	if p4 == EnumMake.TheRattler or (p4 == EnumMake.ShellClassic or (p4 == EnumMake.Bandit or (p4 == EnumMake.Longhorn or (p4 == EnumMake.Laviolette or (p4 == EnumMake.Hammerhead or (p4 == EnumMake.Delorean or p4 == EnumMake.TowTruck)))))) then
		v9 = -0.3
		v8 = -0.3
	elseif p4 == EnumMake.MCL36 or p4 == EnumMake.MCL36FREE then
		v9 = 0.45
		v8 = 0.45
	elseif p4 == EnumMake.Power1 then
		v9 = -0.3
		v8 = -0.3
	elseif p4 == EnumMake.Blackbeard then
		v9 = 0
		v8 = -0.15
	end
	local Idle = p1.Idle
	local v10 = v7 + v9
	setPlaybackSpeed(Idle, v10)
	local OnLow = p1.OnLow
	local v12 = v3 + v8
	setPlaybackSpeed(OnLow, v12)
	local OnMid = p1.OnMid
	local v14 = v4 + v8
	setPlaybackSpeed(OnMid, v14)
	local OnHigh = p1.OnHigh
	local v16 = v5 + v8
	setPlaybackSpeed(OnHigh, v16)
	local OffLow = p1.OffLow
	local v18 = v6 + v8
	setPlaybackSpeed(OffLow, v18)
	local v20 = p2 / 8000
	local v21 = f(v20, -0.1, 0.2) * v1 * v2 * 1
	local v22 = f(v20, 0.3, 0.1) * v1 * 1
	local v23 = f(v20, 0.6, 0.2) * v1 * 1
	local v25 = (v20 < 0.9 and f(v20, 0.9, 0.15) or 1) * v1 * 1
	local Idle_2 = p1.Idle
	setVolume(Idle_2, v21)
	if p3 > 0 then
		local OnLow_2 = p1.OnLow
		setVolume(OnLow_2, v22)
		local OnMid_2 = p1.OnMid
		setVolume(OnMid_2, v23)
		local OnHigh_2 = p1.OnHigh
		setVolume(OnHigh_2, v25)
		local OffLow_2 = p1.OffLow
		setVolume(OffLow_2, 0)
	else
		local OnLow_2 = p1.OnLow
		local v31 = v22 * 0.5
		setVolume(OnLow_2, v31)
		local OnMid_2 = p1.OnMid
		local v33 = v23 * 1
		setVolume(OnMid_2, v33)
		local OnHigh_2 = p1.OnHigh
		local v35 = v25 * 1
		setVolume(OnHigh_2, v35)
		local OffLow_2 = p1.OffLow
		local v37 = v22 * 0.5
		setVolume(OffLow_2, v37)
	end
end
local function SetRPM1(p1, p2, p3, p4) --[[ SetRPM1 | Line: 408 | Upvalues: EnumMake (copy) ]]
	local v1 = nil
	local v3 = p2 / if p4 == EnumMake.Volt or p4 == EnumMake.Volt4x4 then 10000 elseif p4 == EnumMake.Roadster then 12000 else 6000
	local v4 = 1
	local v5 = 0
	if p4 == EnumMake.DesertCrawler then
		v4 = 1.4
		v5 = 0.1
	elseif p4 == EnumMake.BrickKar then
		v4 = 1.3
		v5 = 0.4
		v1 = 1.4
	elseif p4 == EnumMake.AdminNuke then
		v4 = 1.3
		v5 = -0.4
		v1 = 1.4
	end
	local Idle = p1.Idle
	local v6 = v5 + v4 * (p2 + 3000) / 8000
	setPlaybackSpeed(Idle, v6)
	if not v1 then
		v1 = f(v3, 1.1, 0.5) * 0.2
	end
	local Idle_2 = p1.Idle
	setVolume(Idle_2, v1)
end
local function SetRPMNew(p1, p2, p3, p4, p5, p6) --[[ SetRPMNew | Line: 439 | Upvalues: EnumMake (copy) ]]
	local v1 = p5 / 6
	local v2 = p2 / 6300
	local v3 = 5 * v2
	local v4 = 0.2
	local v5 = 0.2
	if p4 == EnumMake.Venom or (p4 == EnumMake.Cobra or p4 == EnumMake.Polaire) then
		v4 = v4 * 2
		v5 = v5 * 2
	end
	local v6 = f(v3, 0, 2) * v4
	local v7 = f(v3, 1.5, 1) * v5
	local v8 = f(v3, 3.25, 1) * v5
	local v10 = (v3 <= 5 and f(v3, 5, 1) or 1) * v5
	local v11 = 0.1 + 1.15 * ((1 + v1) * (v2 - 0.4 * v1))
	local v12 = v11 * 2 ^ (-p6.low / 12)
	local v13 = v11 * 2 ^ (-p6.mid / 12)
	local v14 = v11 * 2 ^ (-p6.high / 12)
	local v15 = v11 * 0.75 + 1
	local Idle = p1.Idle
	setVolume(Idle, v6)
	local OnLow = p1.OnLow
	setVolume(OnLow, v7)
	local OnMid = p1.OnMid
	setVolume(OnMid, v8)
	local OnHigh = p1.OnHigh
	setVolume(OnHigh, v10)
	local Idle_2 = p1.Idle
	setPlaybackSpeed(Idle_2, v15)
	local OnLow_2 = p1.OnLow
	setPlaybackSpeed(OnLow_2, v12)
	local OnMid_2 = p1.OnMid
	setPlaybackSpeed(OnMid_2, v13)
	local OnHigh_2 = p1.OnHigh
	setPlaybackSpeed(OnHigh_2, v14)
end
local function SetRPM(p1, p2, p3, p4, p5, p6, p7) --[[ SetRPM | Line: 492 | Upvalues: SetRPM1 (copy), SetRPMNew (copy), SetRPM3 (copy) ]]
	if p1 == "Electric" or (p1 == "BrickKar" or p1 == "AdminNuke") then
		SetRPM1(p3, p4, p5, p2)
	elseif p7 then
		SetRPMNew(p3, p4, p5, p2, p6, p7)
	else
		SetRPM3(p3, p4, p5, p2)
	end
end
local function UpdateGearsAndRPM(p1, p2, p3, p4, p5) --[[ UpdateGearsAndRPM | Line: 503 | Upvalues: SetRPM (ref) ]]
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
	local v1 = p3 / (p1.Wheels[1].Model.PrimaryPart.Size.Y / 2.9) * 1000 / 3600 / 0.34
	local v2
	if LastGear == Gear then
		v2 = p2[2 + Gear]
	else
		v2 = p2[2 + LastGear] * (1 - t3 * t3) + p2[2 + Gear] * t3 * t3
		local v3 = t3 + p5 * 1 / 0.26
		p1.t3 = v3
		if v3 >= 1 then
			p1.LastGear = Gear
			p1.t3 = 0
		end
	end
	local v4 = v1 * p2[1] * v2 * 60 / math.tau
	local v5 = v1 * p2[1] * p2[2 + Gear] * 60 / math.tau
	local v6 = v5 - LastRPM
	if not (p1.NoGears or p1.ManualGear) then
		if p4 > 0 and (v6 > 0 and (v5 > 6000 and Gear < #p2 - 2)) then
			p1.Gear = Gear + 1
			if p1.onGearShift then
				p1:onGearShift(p1.Gear, Gear)
			end
		elseif v6 < 0 and (v5 < 3400 and Gear > 1) then
			p1.Gear = Gear - 1
			if p1.onGearShift then
				p1:onGearShift(p1.Gear, Gear)
			end
		end
	end
	SetRPM(p1.SoundType, p1.EnumMakeId, p1.Sounds, v4, p4, Gear, p1.engineSoundConfig)
	p1.rpmVisual = v4
	p1.rpmVisualMax = 7000
	p1.LastRPM = v5
	if p1.ManualGear then
		local v7 = p1._rpmLimit or 6000
		p1._rpmLimitMult = if v5 <= v7 then 1 else math.clamp(v7 / v5, 0, 1)
	end
	if p1.turboIntakeSound then
		local v10 = math.clamp(p1.rpmVisual / p1.rpmVisualMax, 0, 1) ^ 3
		if p4 <= 0 then
			v10 = 0
		end
		p1.turboIntakeSound.Volume = p1.turboIntakeSound.Volume + (v10 * p1.maxTurboIntakeSoundVolume - p1.turboIntakeSound.Volume) * 0.1
		if Gear < p1.Gear and p1.turboBlowOff then
			p1.turboBlowOff.PlaybackSpeed = 1 + (math.random() * 0.15 - 0.075)
			p1.turboBlowOff:Play()
		end
	end
	return Gear, v2
end
local function updateFOV(p1) --[[ updateFOV | Line: 578 | Upvalues: CurrentCamera (copy) ]]
	local v1 = (p1.LastFakeGear or 1) ^ 0.5 * (p1.Model.Engine.AssemblyLinearVelocity.Magnitude / 120)
	if IsNaN(v1) then
		v1 = 0
	end
	local v2 = math.clamp(v1, 0, 3)
	local v3, _v4
	if v2 < 0.825155 then
		v3 = v2 * v2 * v2
		if not v3 then
			_v4 = v2
			v3 = 1 - math.exp(-v2)
		end
	else
		_v4 = v2
		v3 = 1 - math.exp(-v2)
	end
	local FieldOfView = CurrentCamera.FieldOfView
	CurrentCamera.FieldOfView = FieldOfView + (v3 * 30 + 70 - FieldOfView) * 0.7
end
local Chassis = {}
local inputAxes = { 0, 0, 0, 0, 0, 0 }
local isHandbrakeHeld = false
local _v13 = false
local _v14 = false
local isSirensOn = false
local function _GetMass(p1) --[[ GetMass | Line: 600 ]]
	local sum = 0
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			sum = sum + v:GetMass()
		end
	end
	return sum
end
function Chassis.setForward(p1) --[[ setForward | Line: 609 | Upvalues: inputAxes (ref) ]]
	inputAxes[1] = if p1 then 1 else 0
end
function Chassis.setBackward(p1) --[[ setBackward | Line: 612 | Upvalues: inputAxes (ref) ]]
	inputAxes[3] = if p1 then 1 else 0
end
function Chassis.onGearShift(p1, p2, p3) --[[ onGearShift | Line: 615 | Upvalues: EnumMake (copy), Audio (copy) ]]
	if p1.EnumMakeId == EnumMake.Venom or p1.EnumMakeId == EnumMake.Polaire then
		Audio.ObjectLocal(p1.Model.PrimaryPart, 18128231812, {
			Volume = 0.5,
			Pitch = 1
		})
		for v1, v2 in p1.Model.Model.Metal:GetChildren() do
			if v2:IsA("Attachment") then
				local v3 = v2:FindFirstChildWhichIsA("ParticleEmitter")
				if v3 then
					v3:Emit(3)
				end
			end
		end
	end
	local GearShiftRemote = p1.Model:FindFirstChild("GearShiftRemote")
	if GearShiftRemote then
		GearShiftRemote:FireServer(p2, p3)
	end
end
function Chassis.toggleSirens() --[[ toggleSirens | Line: 649 | Upvalues: v15 (ref), v9 (ref) ]]
	isSirensOn = not isSirensOn
	vehicleEvent:FireServer("xjgmjeb2", "PoliceLights", isSirensOn)
end
function Chassis.toggleHeadlights() --[[ toggleHeadlights | Line: 653 | Upvalues: v9 (ref) ]]
	vehicleEvent:FireServer("xjgmjeb2", "Lights")
end
function Chassis.setHandbrakeEnabled(p1) --[[ setHandbrakeEnabled | Line: 656 | Upvalues: v12 (ref), ChassisShared (copy) ]]
	isHandbrakeHeld = p1
	ChassisShared.HandBrake = p1
end
function Chassis.DriveToPosition(p1, p2, p3) --[[ DriveToPosition | Line: 668 ]]
	local v1 = p3 or {}
	p1.DriveToPosition = p2
	p1.DriveToPositionArrivalRadius = v1.arrivalRadius or 4
	p1.DriveToPositionOnReached = v1.onReached
end
function Chassis.StopDriveToPosition(p1) --[[ StopDriveToPosition | Line: 676 ]]
	p1.DriveToPosition = nil
	p1.DriveToPositionOnReached = nil
end
function Chassis.runAction(p1) --[[ runAction | Line: 680 | Upvalues: VehicleUtils (copy), v9 (ref), Chassis (copy), SpeedometerUtils (copy), ChassisShared (copy) ]]
	if p1 then
		local v1 = VehicleUtils.GetLocalVehiclePacket()
		if v1.Make == "Firetruck" then
			vehicleEvent:FireServer("xjgmjeb2", "FiretruckWater", true)
		elseif v1.Make == "TheAgent" then
			Chassis.AttemptFireMissile(v1)
		elseif p1 == "Jump" then
			if not v1.AreTiresPopped then
				local Engine = v1.Model.Engine
				local v4 = SpeedometerUtils.sToH(SpeedometerUtils.studsToMi((math.abs((Engine.Velocity:Dot(Engine.CFrame.LookVector))))))
				local v7 = v1.jumpMaxAmount or 75
				Engine:ApplyImpulse(Vector3.new(0, v7 - (v7 - (v1.jumpBaseAmount or 40)) * math.clamp(v4 / (v1.jumpMaxMph or 500), 0, 1), 0) * Engine.AssemblyMass)
				VehicleUtils.vehicleEffect("Jump", v1.Model)
				vehicleEvent:FireServer("xjgmjeb2", "Jump")
				v1._lastJumpAt = os.clock()
				return true
			end
		else
			vehicleEvent:FireServer("xjgmjeb2", "Action")
		end
	elseif ChassisShared.VehicleMake == "Firetruck" then
		vehicleEvent:FireServer("xjgmjeb2", "FiretruckWater", false)
	end
	return false
end
local function _getTransparencyPredicateForHumanoid(p1) --[[ getTransparencyPredicateForHumanoid | Line: 720 ]]
	assert(p1, "missing humanoid")
	return function(p12) --[[ Line: 723 | Upvalues: p1 (copy) ]]
		if p12.Parent == p1.Parent then
			local v1 = p1:GetLimb(p12)
			if v1 == Enum.Limb.LeftArm or v1 == Enum.Limb.RightArm then
				return false
			else
				return true
			end
		else
			return true
		end
	end
end
function Chassis.toggleInsideCamera(p1) --[[ toggleInsideCamera | Line: 733 | Upvalues: VehicleUtils (copy), Chassis (copy), LocalPlayer (copy), CharacterUtils (copy) ]]
	local v1 = p1 or VehicleUtils.GetLocalVehiclePacket()
	if v1 and not v1.Passenger then
		local IsCameraLocked = v1.IsCameraLocked
		if IsCameraLocked then
			Chassis.UnlockCamera(v1)
		else
			Chassis.LockCamera(v1)
		end
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			assert(Humanoid, "missing humanoid")
			local function f2(p1) --[[ Line: 723 | Upvalues: Humanoid (copy) ]]
				if p1.Parent == Humanoid.Parent then
					local v1 = Humanoid:GetLimb(p1)
					if v1 == Enum.Limb.LeftArm or v1 == Enum.Limb.RightArm then
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
function Chassis.init(p1) --[[ init | Line: 754 | Upvalues: v10 (ref) ]]
	_screenGui = p1.ScreenGui
end
function Chassis.SetGravity(p1, p2) --[[ SetGravity | Line: 757 ]]
	local v1 = p1.Model:FindFirstChild("Engine").AssemblyMass * 9.81 * 20
	local v2 = 1 - p2 / 196.20000000000002
	if IsNaN(v1) then
		v1 = 0
	end
	if IsNaN(v2) then
		v2 = 0
	end
	p1.gravityOffset = v1 * v2
end
function Chassis.VehicleEnter(p1) --[[ VehicleEnter | Line: 773 | Upvalues: LocalPlayer (copy), RunService (copy), updateFOV (copy), EnumMake (copy), CharacterAnim (copy), ChassisShared (copy), inputAxes (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), Chassis (copy), v4 (copy), R15IKv2 (copy), Spring (copy), Audio (copy), v7 (copy) ]]
	local Passenger = p1.Passenger
	local Character = LocalPlayer.Character
	local Humanoid = Character.Humanoid
	local seatMaid = p1.seatMaid
	seatMaid:GiveTask(function() --[[ Line: 779 | Upvalues: Character (copy) ]]
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
	seatMaid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 792 | Upvalues: updateFOV (ref), p1 (copy) ]]
		updateFOV(p1)
	end))
	p1.EnumMakeId = EnumMake[p1.Make]
	local v1 = true
	if p1.EnumMakeId == EnumMake.ATV or p1.EnumMakeId == EnumMake.Volt then
		p1.NoLook = true
	elseif p1.Seat:FindFirstChild("Turret") then
		task.delay(0.1, function() --[[ Line: 803 | Upvalues: Humanoid (copy), CharacterAnim (ref), seatMaid (copy) ]]
			for i, v in ipairs(Humanoid:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			local v1 = CharacterAnim.getIdleTrack()
			v1:Play()
			seatMaid:GiveTask(function() --[[ Line: 809 | Upvalues: v1 (copy) ]]
				v1:Stop()
			end)
		end)
		v1 = false
	end
	if v1 then
		local v2 = CharacterAnim.getCarSitTrack()
		v2:Play()
		seatMaid:GiveTask(function() --[[ Line: 817 | Upvalues: v2 (copy) ]]
			v2:Stop()
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
		inputAxes = { 0, 0, 0, 0, 0, 0 }
		isHandbrakeHeld = false
		_v13 = false
		ChassisShared.HandBrake = false
		_v14 = false
		isSirensOn = p1.PoliceLights
		Chassis.SetGravity(p1, 100)
		local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
		BodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
		BodyAngularVelocity.MaxTorque = v4(p1.Mass, (1 / 0), p1.Mass)
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
			for v3, v42 in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = v42:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(p1.RattleMotors, {
						motor = Motor
					})
				end
			end
			for v5, v6 in Model.Preset.RattlerEngine.SecondBody:GetChildren() do
				if v6:IsA("Attachment") then
					local v72 = v6:FindFirstChildWhichIsA("ParticleEmitter")
					if v72 then
						table.insert(p1.RattleParticles, v72)
						v72.Enabled = false
					end
				end
			end
		elseif p1.Make == "Shogun" then
			p1.LastEngineRattle = os.clock()
			p1.RattleMotors = {}
			p1.SpringEngineRattle = Spring.new(Vector3.new(), Vector3.new(), 0.6, 30)
			for v8, v9 in Model.Preset.RattlerEngine:GetChildren() do
				local Motor = v9:FindFirstChildOfClass("Motor")
				if Motor and Motor.Name:match("Engine$") then
					table.insert(p1.RattleMotors, {
						motor = Motor
					})
				end
			end
			p1.RattleParticles = {}
			for v10, v11 in Model.Model:FindFirstChild("SecondBody"):GetDescendants() do
				if v11:IsA("ParticleEmitter") then
					table.insert(p1.RattleParticles, v11)
					v11.Enabled = false
				end
			end
			p1.BrakeTrails = {}
			for v122, v132 in Model.Model:FindFirstChild("BrakelightGlass"):GetChildren() do
				if v132:IsA("Trail") then
					table.insert(p1.BrakeTrails, v132)
					v132.Enabled = false
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
			for v16, v17 in Model.Preset.RattlerEngine.Metal:QueryDescendants("ParticleEmitter") do
				table.insert(p1.RattleParticles, v17)
				v17.Enabled = false
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
			seatMaid:GiveTask(function() --[[ Line: 984 | Upvalues: p1 (copy) ]]
				if p1.BluebirdSupercharger then
					p1.BluebirdSupercharger:Destroy()
				end
			end)
		elseif p1.Make == "JBX0031" then
			p1.ThrusterFlames = true
			Chassis.UpdateThrusterFlames(Model, 0, 0, 0, {
				vehicleEnter = true
			})
		elseif p1.Make == "Wedge" or (p1.Make == "Manta" or (p1.Make == "Katana" or (p1.Make == "WYNDR" or p1.Make == "Polaire"))) then
			local v18 = Audio.ObjectLocal(Model.Engine, 132884974895700, {
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
			local v19 = Audio.ObjectLocal(Model.Engine, 118282536530342, {
				Volume = 0.2,
				DoNotPlay = true,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 512,
				RollOffMode = Enum.RollOffMode.InverseTapered
			})
			p1.turboIntakeSound = v18
			p1.turboBlowOff = v19
			seatMaid:GiveTask(function() --[[ Line: 1015 | Upvalues: v18 (copy), v19 (copy) ]]
				v18:Destroy()
				v19:Destroy()
			end)
		end
		p1.Sounds.DriftSqueal.Volume = 0
		for k, v in pairs(p1.Sounds) do
			if not v.IsPlaying then
				v:Play()
			end
		end
		p1.setForward = Chassis.setForward
		p1.setBackward = Chassis.setBackward
		p1.onGearShift = Chassis.onGearShift
		v7.IgnoreWater = if p1.EnumMakeId == EnumMake.Delorean then false else p1.EnumMakeId ~= EnumMake.Blackbeard
	end
end
function Chassis.VehicleLeave(p1) --[[ VehicleLeave | Line: 1079 | Upvalues: CurrentCamera (copy), t3 (copy), effectProperties (copy), t (copy), Chassis (copy), VehicleUtils (copy), DoorUtils (copy) ]]
	CurrentCamera.FieldOfView = 70
	if p1.Sounds then
		local Outside = environmentPresets.Outside
		for v1, v2 in next, effectProperties do
			for v3, v4 in next, v2 do
				soundEffects[v1][v4] = Outside[v1][v4]
			end
		end
		for k, v in pairs(p1.Sounds) do
			v.Volume = 0
		end
		p1.Sounds.DriftSqueal:Stop()
	end
	if p1.IsCameraLocked then
		Chassis.UnlockCamera(p1)
	end
	if not p1.Passenger then
		p1.Rotate:Destroy()
		p1.Lift.Force = Vector3.new(0, 0, 0)
		for v6, v7 in p1.EngineThrusters do
			v7.Drive.Force = Vector3.new(0, 0, 0)
			v7.Friction.Force = Vector3.new(0, 0, 0)
		end
		p1.IK = nil
		for v8, v9 in p1.Wheels do
			v9.Thruster.Force = Vector3.new(0, 0, 0)
		end
		if p1.RattleSmoke then
			for v10, v11 in p1.RattleSmoke do
				v11.Enabled = false
			end
		end
		if p1.RattleFire then
			for v12, v13 in p1.RattleFire do
				v13.Enabled = false
			end
		end
		if p1.RattleParticles then
			for v14, v15 in p1.RattleParticles do
				v15.Enabled = false
			end
		end
		if p1.ThrusterFlames then
			Chassis.UpdateThrusterFlames(p1.Model, 0, 0, 0, {
				vehicleLeave = true
			})
		end
		if p1.BrakeTrails then
			for v16, v17 in p1.BrakeTrails do
				v17.Enabled = false
			end
		end
		VehicleUtils.setBrakelightsEnabled(p1.Model, false)
		local v18 = p1.Model.Parent and p1.Model.Preset:FindFirstChild("Rudder")
		if v18 then
			DoorUtils.setPctOpen(v18, 0.5)
		end
		if p1._haptic then
			p1._haptic:Destroy()
			p1._haptic = nil
		end
	end
end
local thrusterLightOnColor = Color3.fromRGB(204, 142, 105)
local thrusterLightOffColor = Color3.fromRGB(68, 54, 43)
local thrusterLightsStates = {}
local function getThrusterLightsState(p1) --[[ getThrusterLightsState | Line: 1152 | Upvalues: thrusterLightsStates (copy) ]]
	local v1 = thrusterLightsStates[p1]
	if not v1 then
		local t = {
			part = nil,
			activeTween = nil,
			isOn = false,
			hotUntil = 0
		}
		thrusterLightsStates[p1] = t
		v1 = t
	end
	if v1.part == nil or v1.part.Parent == nil then
		local ThrusterLights = p1.Model:FindFirstChild("ThrusterLights")
		if ThrusterLights and ThrusterLights:IsA("BasePart") then
			v1.part = ThrusterLights
			return v1
		end
		v1.part = nil
	end
	return v1
end
local function setThrusterLightsEnabled(p1, p2) --[[ setThrusterLightsEnabled | Line: 1174 | Upvalues: getThrusterLightsState (copy), TweenService (copy), v16 (copy), v17 (copy) ]]
	local v1 = getThrusterLightsState(p1)
	local part = v1.part
	if part then
		if v1.isOn ~= p2 then
			if v1.activeTween then
				v1.activeTween:Cancel()
				v1.activeTween = nil
			end
			v1.isOn = p2
			local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local t = {}
			t.Color = p2 and thrusterLightOnColor or thrusterLightOffColor
			v1.activeTween = TweenService:Create(part, v3, t)
			v1.activeTween:Play()
		end
	end
end
local thrusterFlamesCache = {}
function Chassis.UpdateThrusterFlames(p1, p2, p3, p4, p5) --[[ UpdateThrusterFlames | Line: 1201 | Upvalues: thrusterFlamesCache (copy), inputAxes (ref), getThrusterLightsState (copy), setThrusterLightsEnabled (copy), thrusterLightsStates (copy) ]]
	local v1 = p5 or {}
	local v2 = thrusterFlamesCache[p1]
	if not v2 then
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
					thrusterFlamesCache[p1] = t
					v2 = t
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
	local _thrusters = v2.thrusters
	local rightFlame = v2.rightFlame
	local leftFlame = v2.leftFlame
	local count = 0
	local v3 = nil
	local v4 = nil
	local v5, v6
	if p3 > 0 or v1.client and inputAxes[2] > 0 then
		v5 = v1
		v6 = true
		count = count + 1
	else
		v6 = nil
		v5 = v1
	end
	if p3 < 0 or v5.client and inputAxes[4] > 0 then
		count = count + 1
		v4 = true
	end
	if p2 > 0 then
		v3 = true
		count = count + 1
	elseif p4 < 1 and p4 > -1 then
		v4 = nil
		v6 = nil
		count = 0
	end
	v2.centerFlame.Enabled = v3 == true
	if p2 > 0 or p4 < 0 then
		rightFlame.Enabled = v4 == true
		leftFlame.Enabled = v6 == true
	else
		rightFlame.Enabled = v6 == true
		leftFlame.Enabled = v4 == true
	end
	local thrusterSound = v2.thrusterSound
	if thrusterSound then
		local v12 = if count > 0 then 0.175 else 0
		setVolume(thrusterSound, v12)
		local v14 = (count - 1) * 0.1 + 0.7
		setPlaybackSpeed(thrusterSound, v14)
	end
	local v16 = getThrusterLightsState(p1)
	if v5.vehicleLeave then
		thrusterFlamesCache[p1] = nil
		v16.hotUntil = 0
		setThrusterLightsEnabled(p1, false)
		task.delay(0.25, function() --[[ Line: 1282 | Upvalues: thrusterLightsStates (ref), p1 (copy), v16 (copy) ]]
			if thrusterLightsStates[p1] == v16 and not v16.isOn then
				thrusterLightsStates[p1] = nil
			end
		end)
	elseif v5.vehicleEnter then
		v16.hotUntil = os.clock() + 2.5
		setThrusterLightsEnabled(p1, true)
	else
		local v17 = os.clock()
		if count > 0 then
			v16.hotUntil = v17 + 2.5
		end
		setThrusterLightsEnabled(p1, if count > 0 then true else v17 < v16.hotUntil)
	end
	return count
end
function Chassis.UpdateWheelLowQuality(p1, p2, p3, p4) --[[ UpdateWheelLowQuality | Line: 1303 | Upvalues: v8 (copy), min (copy), v3 (copy), Angles (copy) ]]
	local Engine = p3.Engine
	local Part = p3.Part
	local v2 = Part.CFrame
	local v32 = Engine.CFrame:ToObjectSpace(v2)
	local v6 = if v32.X > 0 then 1 else -1
	local v7 = CFrame.new((p3.lateralRotateOffset or 0) * v6, 0, 0)
	local v82 = v2 * CFrame.new((p3.lateralOffset or 0) * v6, 0, 0) * v7
	local p = v82.p
	local Motor = Part.Motor
	local v9 = workspace:Raycast(p, v82:VectorToWorldSpace(Vector3.new(0, -1, 0)) * p2, v8)
	local v10 = if v9 then v9.Position else nil
	local v12 = -min(if v10 then (v10 - p).magnitude else p2, p2) + Motor.Part0.Size.Y * 0.5
	local v13 = v3(0, v12, 0)
	if v32.Z < 0 then
		v13 = v13 * Angles(0, Engine.AssemblyAngularVelocity.Y * 0.5, 0)
	end
	Motor.C1 = v13 * v7 * Angles(p4, 0, 0)
	local BridgeMotor = Part:FindFirstChild("BridgeMotor")
	if BridgeMotor then
		local v16 = p3.bridgeLocalYOffset or 0
		local v17 = CFrame.new((p3.bridgeXOffset or 0) * v6, (p3.bridgeYOffset or 0) + v16, 0)
		BridgeMotor.C1 = v17 * CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(v32.X, v12 - v16, 0)))
	end
end
function Chassis.UpdateSoundLowQuality(p1, p2, p3) --[[ UpdateSoundLowQuality | Line: 1345 | Upvalues: EnumMake (copy), UpdateGearsAndRPM (copy) ]]
	if p1.EnumMakeId == nil then
		p1.EnumMakeId = EnumMake[p1.Make]
	end
	UpdateGearsAndRPM(p1, p2, math.abs(p3.Z), -math.sign(p3.Z), 1 / 60)
end
local function UpdateThruster(p1, p2, p3, p4) --[[ UpdateThruster | Line: 1355 | Upvalues: v7 (copy), min (copy), v3 (copy), Angles (copy), v12 (ref), abs (copy), v5 (copy), PhysicsLagService (copy), v4 (copy) ]]
	local Part = p2.Part
	local Engine = p2.Engine
	local v2 = Part.CFrame
	local v32 = Engine.CFrame:ToObjectSpace(v2)
	local v6 = if v32.X > 0 then 1 else -1
	local v72 = CFrame.new((p2.lateralRotateOffset or 0) * v6, 0, 0)
	local v8 = CFrame.new((p2.lateralOffset or 0) * v6, 0, 0)
	local v9 = v2 * v8 * v72
	local p = v9.p
	local Motor = Part.Motor
	local Thruster = p2.Thruster
	local v10 = Part.AssemblyMass * 9.81 * 20
	local v11 = v10 * p1.Suspension
	if IsNaN(v11) then
		v11 = 0
	end
	local v122 = v11 / p1.Bounce
	if IsNaN(v122) then
		v122 = 0
	end
	local v13 = v9:VectorToObjectSpace(Part.Velocity)
	local Height = p1.Height
	local v14 = p1.Model:GetAttribute("GarageSuspensionHeight")
	if v14 then
		Height = Height + v14
	end
	local v15 = p2._heightOffset or 0
	local v16 = v15 + ((Part:GetAttribute("ThrusterHeightOffset") or 0) - v15) * 0.1
	p2._heightOffset = v16
	local v17 = if p1.AreTiresPopped then p1.Height - 0.5 else Height + v16
	local v18 = workspace:Raycast(p, v9:VectorToObjectSpace(Vector3.new(0, -1, 0)) * v17, v7)
	local v19, v20
	if v18 then
		v19 = v18.Instance
		v20 = v18.Position
	else
		v20 = nil
		v19 = nil
	end
	local v21 = if v20 then (v20 - p).Magnitude else v17
	local v22 = p1.AreTiresPopped and Part.Parent:FindFirstChild("Rim") or Part.Parent:FindFirstChild("TireMesh")
	local v23 = if v22 then v22.Size.Y else 0
	local v24 = -min(v21, v17) + v23 * 0.5
	local Y = Motor.C1.Y
	local v25 = Y + (v24 - Y) * 0.5
	local v26 = v3(0, v25, 0) * v8
	local Drift = Part:FindFirstChild("Drift")
	if v32.Z < 0 then
		v26 = v26 * Angles(0, p1.RotY * 0.4 + Engine.RotVelocity.Y * 0.2, 0)
	elseif Drift and (v19 and (isHandbrakeHeld or p1.Drift)) then
		p1._didAnyWheelDrift = true
		Drift.C0 = CFrame.new(0, -v25 + v23 * 0.5, 0)
		for v27, v28 in Drift.Part0:GetChildren() do
			if v28:IsA("ParticleEmitter") then
				local v29 = (v28:GetAttribute("DriftAccum") or 0) + v28.Rate * p4
				local v30 = math.floor(v29)
				if v30 > 0 then
					v28:Emit(v30)
				end
				v28:SetAttribute("DriftAccum", v29 - v30)
			end
		end
	end
	local v31 = v26 * v72 * Angles(p3.WheelRotation or 0, 0, 0)
	if v31.x ~= v31.x or (v31.y ~= v31.y or (v31.z ~= v31.z or abs(v31.x + v31.y + v31.z) > 100)) then
		v31 = v5
	end
	Motor.C1 = v31
	local v322 = 4 / p2.NumWheels
	if v19 then
		local v33 = v13 * v122
		local v34 = v10 * 0.5
		local v35 = -v10 * 0.5
		local sum = (v17 - min(v21, v17)) ^ 2 * (v11 / v17 ^ 2)
		if v13.magnitude > 0.01 then
			sum = sum - v33.Y
		end
		if IsNaN(sum) then
			sum = 0
		end
		local v37 = 1
		local v38 = PhysicsLagService.getEstimatedPhysicsStepsMult()
		if v38 >= 1 then
			v37 = v37 / v38
		end
		Thruster.Force = v4(0, if v34 < sum then v34 elseif sum < v35 then v35 else sum * math.clamp(v37, 0, 1) * v322, 0)
	else
		Thruster.Force = Vector3.new(0, 0, 0)
	end
	local BridgeMotor = Part:FindFirstChild("BridgeMotor")
	if BridgeMotor then
		local v41 = p2.bridgeLocalYOffset or 0
		local v422 = CFrame.new((p2.bridgeXOffset or 0) * v6, (p2.bridgeYOffset or 0) + v41, 0)
		BridgeMotor.C1 = v422 * CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(v32.X, v25 - v41, 0)))
	end
end
local function fpor2Autopilot(p1, p2, p3) --[[ fpor2Autopilot | Line: 1489 | Upvalues: v6 (copy), FindPartOnRayWithIgnoreList (copy) ]]
	local magnitude = p2.magnitude
	local unit = p2.unit
	local count, v1, v2, v3 = 0, p1, 0, { p3 }
	while true do
		local v4, v5, v62, v7, v8, v9
		count = count + 1
		v4, v5, v62 = FindPartOnRayWithIgnoreList(workspace, v6(v1, unit * (magnitude - v2)), v3, false, true)
		if v4 then
			v4 = v4.CanCollide
			if v4 then
				if v4.Material == Enum.Material.Asphalt then
					v4, v7 = true, v4
				else
					v4, v7 = false, v4
				end
			else
				v7 = v4
			end
		else
			v7 = v4
		end
		if not v4 then
			table.insert(v3, v7)
		end
		v2 = (p1 - v5).magnitude
		if v4 or (magnitude - v2 <= 0.001 or count > 4) then
			if v7 then
				v8 = v5
				v9 = v62
			else
				v8 = p1 + unit * magnitude
				v9 = Vector3.new(0, -1, 0)
			end
			return v7, v8, v9
		end
		v1 = v5
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
local tractionMagnitudes = {
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
function Chassis.UpdateEngine(p1, p2, p3) --[[ UpdateEngine | Line: 1588 | Upvalues: inputAxes (ref), InputUtils (copy), GetMoveVector (ref), abs (copy), v12 (ref), v4 (copy), fpor2Autopilot (copy), Time (copy), EnumMake (copy), HapticEffect (copy), Chassis (copy), tanh (copy), EnvironmentUtils (copy), EnvironmentConsts (copy), UpdateGearsAndRPM (copy), v7 (copy), Audio (copy), tractionMagnitudes (copy), t8 (copy), max (copy), VehicleUtils (copy), v9 (ref), v1 (copy), Settings (copy), Region (copy), v11 (ref), effectProperties (copy), t (copy), t3 (copy), DoorUtils (copy) ]]
	local Model = p1.Model
	local CanDrive = p2.CanDrive
	local Engine = p2.Engine
	local v13 = Engine.CFrame
	local v2 = Engine.Size * 0.5
	local Rotate = p1.Rotate
	local Height = p1.Height
	local v3 = Engine.AssemblyMass * 9.81 * 20
	local TurnSpeed = p1.TurnSpeed
	local EnumMakeId = p1.EnumMakeId
	local v42 = v13:VectorToObjectSpace(Engine.AssemblyLinearVelocity)
	local Magnitude = v42.Magnitude
	local v5 = os.clock()
	local _spinOutAt = p1._spinOutAt
	if _spinOutAt then
		_spinOutAt = v5 - p1._spinOutAt < 3
	end
	local v6 = inputAxes[1] - inputAxes[3]
	local v72 = inputAxes[2] - inputAxes[4]
	if InputUtils.isTouch() then
		local X = GetMoveVector().X
		local v8 = math.clamp(X, -1, 1)
		v72 = -v8 * abs(v8)
	end
	if _spinOutAt then
		v6 = v6 * 0.5
		if p1.AreTiresPopped and p1._spinOutLeft ~= nil then
			TurnSpeed = p1._pitTurnSpeed or 2
			v72 = if p1._spinOutLeft then 1 else -1
		end
	end
	local v92 = Model:GetAttribute("ForceHardBraking") == true
	if v92 then
		isHandbrakeHeld = true
	end
	if p1.LockMovement or Model:GetAttribute("LockMovement") then
		v6 = 0
		v72 = 0
	end
	if p1.DriveToPosition and (v6 == 0 and v72 == 0) then
		local DriveToPosition = p1.DriveToPosition
		local p = v13.p
		local v10 = v4(DriveToPosition.X - p.X, 0, DriveToPosition.Z - p.Z)
		if v10.Magnitude <= (p1.DriveToPositionArrivalRadius or 4) then
			local DriveToPositionOnReached = p1.DriveToPositionOnReached
			p1.DriveToPosition = nil
			p1.DriveToPositionOnReached = nil
			if DriveToPositionOnReached then
				DriveToPositionOnReached:Fire()
			end
			v6 = 0
			v72 = 0
		else
			local LookVector = v13.LookVector
			local Unit = v4(LookVector.X, 0, LookVector.Z).Unit
			local Unit_2 = v10.Unit
			local v112 = Unit:Dot(Unit_2)
			local v132 = math.clamp(-(Unit.X * Unit_2.Z - Unit.Z * Unit_2.X) * 2.5, -1, 1)
			if v112 > 0.3 then
				v6, v72 = math.min(1, 0.3 + 0.7 * v112), v132
			elseif v112 < -0.3 then
				v6, v72 = math.max(-1, -0.3 + 0.7 * v112), v132
			else
				v6 = 0
				v72 = v132
			end
		end
	elseif p1.Autopilot then
		local v16 = v13.lookVector:Cross(Vector3.new(0, 1, 0))
		local v17 = fpor2Autopilot(v13 * v4(0, 0, -v2.Z - abs(v42.Z) * 16 * p3), Vector3.new(0, -10, 0), Model)
		if v17 then
			local v22 = (v17.CFrame * v4(-v17.Size.X * 0.5 + math.floor((v17.CFrame:toObjectSpace(v13).X + v17.Size.X * 0.5) / 12) * 12 + 6, 0, -v17.Size.Z * 0.5 * if v13.lookVector:Dot(v17.CFrame.lookVector) > 0 then 1 else -1) - v13.p).unit:Dot(v16)
			local v23 = v22 * 4
			local v25 = v72 - if v23 < -1 then -1 elseif v23 > 1 then 1 else v23
			local v26 = v6 + (1 - abs(v22) ^ 1/6) - abs(v22) ^ 4 * 0.3
			v6 = if v26 > 1 then 1 elseif v26 < -1 then -1 else v26
			v72 = if v25 > 1 then 1 elseif v25 < -1 then -1 else v25
		end
	end
	local vHeading = p1.vHeading
	local v31 = vHeading + v72 * p3 * 60 - vHeading * if v72 == 0 then 0.3 else 0.16 * p3 * 60
	p1.vHeading = v31
	local v32 = v31 * 0.16
	local Cd = p1.Cd
	local Crr = p1.Crr
	local Cb = p1.Cb
	local v33 = nil
	local TirePopProportion = p1.TirePopProportion
	local v34 = Model:GetAttribute("VehicleTiresLastPop") or 0
	local v36 = math.min((Time.GetNowSync() - v34) / p1.DisableDuration, 1)
	local v37 = if v36 < 0.999 then p1.Make ~= "AdminNuke" else false
	if v37 then
		local v38 = if v36 < TirePopProportion then 0 else (v36 - TirePopProportion) / (1 - TirePopProportion)
		v33 = v3 * ((Vector3.new(0, 0, 0) - v42) / ((1 - v38) * 200 + v38 * 500))
		v6 = 0
		if Magnitude > 30 then
			p1.LastDrift = tick()
		end
	end
	p1.AreTiresPopped = v37
	if v72 ~= 0 and (v72 / abs(v72) ~= v42.X / abs(v42.X) and abs(v42.X) > 8) then
		p1.LastDrift = tick()
	end
	local v39 = tick() - p1.LastDrift < 0.3
	if EnumMakeId == EnumMake.Volt then
		isHandbrakeHeld = false
		v39 = false
	end
	p1.Drift = v39
	local v40 = if Magnitude > 50 then isHandbrakeHeld or p1.Drift else false
	if v40 and p1._haptic == nil then
		p1._haptic = HapticEffect.basic(0.2, (1 / 0))
	elseif p1._haptic and not v40 then
		p1._haptic:Destroy()
		p1._haptic = nil
	end
	local Volume = p1.Sounds.DriftSqueal.Volume
	p1.Sounds.DriftSqueal.Volume = if Magnitude > 30 and (v39 or isHandbrakeHeld and v72 ~= 0) or (_spinOutAt or p1.LaunchSpeedMult) then Volume + (0.3 - Volume) * 0.06 else Volume + (0 - Volume) * 0.1
	Chassis.UpdateForces(p1, p2, p3)
	local v43 = v42.Z * p3
	if IsNaN(v43) then
		v43 = 0
	end
	p2.WheelRotation = ((p2.WheelRotation or 0) + v43 / (p1.Wheels[1].Model.PrimaryPart.Size.Y * 0.5)) % math.tau
	local v44 = tanh(abs(v42.magnitude) * 0.03)
	local Traction = p1.Traction
	local v45 = (isHandbrakeHeld or v39) and (1 - v44) ^ 2 or 1
	if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
		v45 = v45 * 0.4
	end
	if _spinOutAt then
		v45 = v45 * 0.6
	end
	local v46 = if v45 < 0.07 then 0.07 else v45
	local v48 = Traction + (v46 - Traction) * if v46 < Traction then 0.2 else 0.01 * p3 * 60
	if v48 < 0 then
		v48 = 0
	end
	p1.Traction = v48
	local Gears = p1.Gears
	local v49 = math.abs(v42.Z)
	local v50, v51 = UpdateGearsAndRPM(p1, Gears, v49, v6, p3)
	p1.LastFakeGear = v51
	local v52 = workspace:Raycast(v13 * v4(0, 0, v2.Z - 1), v13:vectorToWorldSpace(Vector3.new(0, -1, 0)) * Height * 2, v7)
	local v53, v54
	if v52 then
		v53 = v52.Instance
		v54 = v52.Material
	else
		v53 = nil
		v54 = nil
	end
	local v55 = p1.CanLaunchControl == true
	if v55 and (inputAxes[1] == 1 and (inputAxes[3] == 1 and (v49 < 10 and not (p1.LaunchSpeedMult or p1.AreTiresPopped)))) then
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
	elseif v55 and (p1.LaunchHeldSince and (os.clock() - p1.LaunchHeldSince >= 2 and v6 == 1)) then
		print("LAUNCH!")
		p1.LaunchHeldSince = nil
		p1.LaunchStartedAt = os.clock()
		p1.LaunchSpeedMult = 4
		Audio.ObjectLocal(Model.Engine, 15684233147, {
			Volume = 1.5,
			RollOffMaxDistance = 128,
			RollOffMinDistance = 32
		})
	elseif v55 then
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
		p1.TractionMag = tractionMagnitudes[EnumMakeId] or 300
	end
	local v62 = -Cd * v42 * Magnitude * v4(0, 0, if v6 < 0 then 80 else 1)
	local v63 = -Crr * v42 * Vector3.new(0, 0, 1)
	local v64 = -v4(math.clamp(v42.X, -150, 150), 0, 0) * p1.TractionMag * v48 * 150 / 588600 * v3
	if EnumMakeId == EnumMake.ATV and v3 * 0.05 < math.abs(v63.X) then
		v63 = Vector3.new(math.clamp(v63.X, -v3 * 0.05, v3 * 0.05), 0, v63.Z)
	end
	local v67 = v3 / 196.20000000000002
	local v68 = -(Cb * (1 + p1.GarageBrakes)) * v42.Z / abs(v42.Z)
	if IsNaN(v68) then
		v68 = 0
	end
	local v69 = v68 / 18000 * v67 * Vector3.new(0, 0, 1)
	if v92 then
		v69 = v69 * 40
	end
	local v70 = -Cb * 0.3 * v42 * Vector3.new(1, 0, 0)
	local Nitro = p1.Nitro
	local _lastJumpAt = p1._lastJumpAt
	if _lastJumpAt then
		_lastJumpAt = os.clock() - p1._lastJumpAt < 2
	end
	if Nitro and not (p1.Nitrof1 or _lastJumpAt) then
		p1.Nitrof1 = true
		Chassis.SetGravity(p1, 20)
	elseif (not Nitro or _lastJumpAt) and p1.Nitrof1 then
		p1.Nitrof1 = false
		Chassis.SetGravity(p1, 100)
	end
	local v74 = if p1.NoGears then v6 > 0 and Gears[1] or Gears[2] else v6 > 0 and Gears[2 + v50] or Gears[2]
	local v77 = 4.4
	if EnumMakeId == EnumMake.Lamborghini or (EnumMakeId == EnumMake.OGLaMatador or EnumMakeId == EnumMake.Hammerhead) then
		v77 = 5.5
	elseif EnumMakeId == EnumMake.Ambulance then
		v77 = 5
	elseif EnumMakeId == EnumMake.Bandit then
		v77 = 57/5 * v67 / 4300
	elseif EnumMakeId == EnumMake.FrostCrawler then
		v77 = 2.485 * v67 / 4600
	elseif EnumMakeId == EnumMake.Laviolette then
		v77 = 3 * v67 / 4300
	elseif EnumMakeId == EnumMake.Crown then
		v77 = 11.2 * v67 / 3304
	elseif EnumMakeId == EnumMake.DesertCrawler then
		v77 = 9 * v67 / 3894
	elseif EnumMakeId == EnumMake.ShellMark5 then
		v77 = 6.6 * v67 / 3089
	elseif EnumMakeId == EnumMake.Goliath then
		v77 = 2.6 * v67 / 12720 * 4
	elseif EnumMakeId == EnumMake.Bloxy then
		v77 = 6.6 * v67 / 3948
	elseif EnumMakeId == EnumMake.TinyToy then
		v77 = 1.02 * v67 / 720
	elseif EnumMakeId == EnumMake.ShellClassic then
		v77 = 5.5 * v67 / 2250
	elseif EnumMakeId == EnumMake.Snake then
		v77 = 13.3 * v67 / 5449 * 1.39
	elseif EnumMakeId == EnumMake.Scorpio then
		v77 = 25.27 * v67 / 12583
	elseif EnumMakeId == EnumMake.Successor then
		v77 = 9.545689999999999 * v67 / 3018
	elseif EnumMakeId == EnumMake.Macaron then
		v77 = 9.182440218957073 * v67 / 5543 * 1.6
	elseif EnumMakeId == EnumMake.JackRabbit then
		v77 = 3.331709741550696 * v67 / 3047
	elseif EnumMakeId == EnumMake.Poseidon then
		v77 = 5.43452380952381 * v67 / 3024
	elseif EnumMakeId == EnumMake.MCL36 or EnumMakeId == EnumMake.MCL36FREE then
		v77 = 132500 / v67
	elseif EnumMakeId == EnumMake.TowTruck then
		v77 = 6.6 * v67 / 4000 * 2
	elseif EnumMakeId == EnumMake.NASCAR1 then
		v77 = 11.407
	elseif EnumMakeId == EnumMake.NASCAR2 or EnumMakeId == EnumMake.NASCAR75th then
		v77 = 6.039
	elseif EnumMakeId == EnumMake.Trailblazer then
		v77 = 12.552631578947368
	elseif EnumMakeId == EnumMake.Concept then
		v77 = 106/11
	elseif EnumMakeId == EnumMake.Torero then
		v77 = 15.847
	elseif EnumMakeId == EnumMake.Beignet then
		v77 = 10.794242074927956
	elseif EnumMakeId == EnumMake.Ray9 then
		v77 = 5.4
	elseif EnumMakeId == EnumMake.TheRattler then
		v77 = 5.5
	elseif EnumMakeId == EnumMake.Ferrari then
		v77 = 6
	elseif EnumMakeId == EnumMake.BananaCar then
		v77 = 18
	elseif EnumMakeId == EnumMake.Challenger then
		v77 = 273/50
	elseif EnumMakeId == EnumMake.Surus then
		v77 = 6
	elseif EnumMakeId == EnumMake.MoltenM12 then
		v77 = 6.56
	elseif EnumMakeId == EnumMake.Bugatti then
		v77 = 8
	elseif EnumMakeId == EnumMake.Parisian then
		v77 = 24.8
	elseif EnumMakeId == EnumMake.Chiron then
		v77 = 8.8 * v67 / 3303
	elseif EnumMakeId == EnumMake.Model3 then
		v77 = 4.2
	elseif EnumMakeId == EnumMake.Roadster then
		v77 = 9
	elseif EnumMakeId == EnumMake.IceBreaker then
		v77 = 8.5
	elseif EnumMakeId == EnumMake.Proto8 then
		v77 = 6.73
	elseif EnumMakeId == EnumMake.Monster then
		v77 = 5.75
	elseif EnumMakeId == EnumMake.OGMonster then
		v77 = 5
	elseif EnumMakeId == EnumMake.Firetruck then
		v77 = 10 * v67 / 10418
	elseif EnumMakeId == EnumMake.ATV then
		v77 = 1.5
	elseif EnumMakeId == EnumMake.BankTruck then
		v77 = 16.8
	elseif EnumMakeId == EnumMake.BeamHybrid then
		v77 = 6.5
	elseif EnumMakeId == EnumMake.AirTail then
		v77 = 7.5
	elseif EnumMakeId == EnumMake.Volt4x4 then
		v77 = 20
	elseif EnumMakeId == EnumMake.TheAgent then
		v77 = 8.5
	elseif EnumMakeId == EnumMake.Interrogator then
		v77 = 6
	elseif EnumMakeId == EnumMake.Sentinel then
		v77 = 7
	elseif EnumMakeId == EnumMake.TheCamper then
		v77 = 759/40
	elseif EnumMakeId == EnumMake.R8 then
		v77 = 6.072
	elseif EnumMakeId == EnumMake.Semi then
		v77 = 4.928000000000001
	elseif EnumMakeId == EnumMake.Stormrider then
		v77 = 19.712000000000003
	elseif EnumMakeId == EnumMake.Shogun then
		v77 = 4.95 * v67 / 3010 * 1.8
	elseif EnumMakeId == EnumMake.PrisonBus then
		v77 = 5
	elseif EnumMakeId == EnumMake.Power1 then
		v77 = 7.700000000000001 * v67 / 2267 * 0.95
	elseif EnumMakeId == EnumMake.Aperture then
		v77 = 7.2 * v67 / 2242
	elseif EnumMakeId == EnumMake.Fiasco then
		v77 = 12.32
	elseif EnumMakeId == EnumMake.Longhorn then
		v77 = 10.26
	elseif EnumMakeId == EnumMake.Carbonara then
		v77 = 7.6 * v67 / 2601
	elseif EnumMakeId == EnumMake.XRK then
		v77 = v77 * 1.44256
	elseif EnumMakeId == EnumMake.Striker then
		v77 = v77 * 0.7
	elseif EnumMakeId == EnumMake.SWATVan then
		v77 = v77 * 1.32
	elseif EnumMakeId == EnumMake.Wedge then
		v77 = v77 * 1.3
	elseif EnumMakeId == EnumMake.Manta then
		v77 = v77 * 9.2
	elseif EnumMakeId == EnumMake.Iceborn then
		v77 = v77 * (v67 / 2250 * 1.00933 * 1.05)
	elseif EnumMakeId == EnumMake.Tanker then
		v77 = v77 * 3
	elseif EnumMakeId == EnumMake.Revox then
		v77 = v77 * 1.830907534246575
	elseif EnumMakeId == EnumMake.Deja then
		v77 = v77 * 2
	elseif EnumMakeId == EnumMake.McLaren then
		v77 = v77 * 1.3
	elseif EnumMakeId == EnumMake.Cobra then
		v77 = v77 * 1.7
	elseif EnumMakeId == EnumMake.Expeditioner then
		v77 = v77 * 1.6
	elseif EnumMakeId == EnumMake.Wraith then
		v77 = v77 * 1.3
	elseif EnumMakeId == EnumMake.Badger then
		v77 = v77 * 1.5
	elseif EnumMakeId == EnumMake.Mustang then
		v77 = v77 * 1.25
	elseif EnumMakeId == EnumMake.Blackbeard then
		v77 = v77 * 2.508
	elseif EnumMakeId == EnumMake.OrionM42 then
		v77 = v77 * 0.768
	elseif EnumMakeId == EnumMake.Maverick then
		v77 = v77 * 1.6
	elseif EnumMakeId == EnumMake.Katana then
		v77 = v77 * 2.3
	elseif EnumMakeId == EnumMake.WYNDR then
		v77 = v77 * 1.6
	elseif EnumMakeId == EnumMake.PizzaDelivery then
		v77 = v77 * 10
	elseif EnumMakeId == EnumMake.BrickKar then
		v77 = v77 * 6.8
	elseif EnumMakeId == EnumMake.Polaire then
		v77 = v77 * 5.7
	elseif EnumMakeId == EnumMake.BlackWidow then
		v77 = v77 * 1.55
	elseif EnumMakeId == EnumMake.AdminNuke then
		v77 = 60
	elseif EnumMakeId == EnumMake.Bluebird then
		v77 = 44.6
	end
	if p1.EngineSpeedMult then
		v77 = v77 * p1.EngineSpeedMult
	end
	if p1.LaunchSpeedMult then
		v77 = v77 * p1.LaunchSpeedMult
	end
	local sum = v77 + p1.GarageEngineSpeed
	if not t8[EnumMakeId] then
		sum = sum + 0.5
	end
	p1.TrueEngineSpeed = sum
	local v78 = v6 * Vector3.new(0, 0, -1) * Gears[1] * 1 / 0.34 * 750 * v74 * sum
	if v54 and (v54 == Enum.Material.Water and v7.IgnoreWater) then
		v78 = v78 * 0.625
	end
	if p1.ManualGear and p1._rpmLimitMult then
		v78 = v78 * p1._rpmLimitMult
	end
	local sum_2 = v62 + v63
	if v6 ~= 0 and v6 == v6 then
		p1.LastForward = v6 / abs(v6)
		sum_2 = sum_2 + v78
	end
	if v6 == 0 and Magnitude <= 1 then
		Engine.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	elseif v6 == 0 then
		sum_2 = sum_2 + v69
	end
	if isHandbrakeHeld and (v72 == 0 and v6 == 0) then
		sum_2 = sum_2 + v69 * 3 + v70
	end
	local v79 = 0
	local v80 = 0
	local v81 = 0
	local RotY = p1.RotY
	p1.RotY = RotY + (v72 - RotY) * 0.1
	if p1.driveInAir then
		v54 = Enum.Material.SmoothPlastic
	end
	if v53 or p1.driveInAir then
		if v54 == Enum.Material.Grass then
			v79 = 0.4
		elseif v54 == Enum.Material.Concrete or (v54 == Enum.Material.Basalt or v54 == Enum.Material.Asphalt) then
			v80 = 0.94
		elseif v54 == Enum.Material.Sandstone or v54 == Enum.Material.Sand then
			v81 = 0.5
		end
		local v85 = math.exp(-max(v42.magnitude, 120) / 400) * if isHandbrakeHeld then 1.5 else 1.2
		local v86 = -v42.Z / abs(v42.Z)
		if IsNaN(v86) then
			v86 = 0
		end
		if p1.LastForward ~= v86 and (abs(v42.Z) > 2 and not isHandbrakeHeld) then
			p1.LastForward = v86
		end
		if v72 == 0 then
			if v42.Z < 0 and not isHandbrakeHeld then
				Rotate.MaxTorque = v4(0, v3 * 2, 0)
			end
		else
			Rotate.MaxTorque = v4(0, v3 * 30, 0)
		end
		Rotate.AngularVelocity = v4(0, v32 * TurnSpeed * p1.LastForward * v85 * v44, 0)
	else
		Rotate.MaxTorque = v4(v3 * 0.5, v3, v3 * 0.5)
		sum_2 = Vector3.new(0, 0, 0)
		v64 = Vector3.new(0, 0, 0)
	end
	local sum_3 = sum_2 + (Nitro and 0.17 * v3 or 0) * Vector3.new(0, -0.1, -1)
	if v33 ~= nil then
		sum_3 = sum_3 + v33
	end
	local Grass = p1.Sounds.Grass
	local Asphalt = p1.Sounds.Asphalt
	local Sandstone = p1.Sounds.Sandstone
	p1.vGrass = p1.vGrass + (v79 - p1.vGrass) * 0.03
	p1.vAsphalt = p1.vAsphalt + (v80 - p1.vAsphalt) * 0.03
	p1.vSandstone = p1.vSandstone + (v81 - p1.vSandstone) * 0.03
	local v88 = (Magnitude < 60 and Magnitude / 60 or 1) * 0.25
	Grass.Volume = p1.vGrass * v88
	Asphalt.Volume = p1.vAsphalt * v88
	Sandstone.Volume = p1.vSandstone * v88
	local v89 = Magnitude > 0 and (Magnitude / 120) ^ 0.5 or 0
	Grass.PlaybackSpeed = v89
	Asphalt.PlaybackSpeed = v89
	Sandstone.PlaybackSpeed = v89
	local v90 = isHandbrakeHeld
	if not v90 then
		v90 = v6 < 1e-6
	end
	if p1._flagBrakelightsEnabled ~= v90 then
		p1._flagBrakelightsEnabled = v90
		VehicleUtils.setBrakelightsEnabled(p1.Model, v90)
	end
	if CanDrive then
		p2.Drive.Force = sum_3
	end
	p2.Friction.Force = v13:VectorToWorldSpace(v64)
	local _, _2, _3, _4, _5, _6, _7, v91, _8, _9, _10, _11 = v13:GetComponents()
	if v91 < -0.25 then
		if p1.UpsideDownTime then
			if tick() - p1.UpsideDownTime > 2 then
				p1.UpsideDownTime = nil
				vehicleEvent:FireServer("hrm1cr55")
			end
		else
			p1.UpsideDownTime = tick()
		end
	else
		p1.UpsideDownTime = nil
	end
	local v922 = nil
	if (not v1 or v1 and Settings.Test.RegionSounds) and Region.CastPoint(Settings.Prism.City, Engine.Position) then
		v922 = "City"
	end
	local v93 = if workspace:Raycast(v13 * v4(0, 0, v2.Z - 1), v13:VectorToWorldSpace(Vector3.new(0, 1, 0)) * 20, v7) then "Tunnel" else v922 or "Outside"
	if p1.LastEnvironment ~= v93 then
		p1.TransitionSpeed = 1 / if v93 == "Tunnel" or p1.LastEnvironment == "Tunnel" then 0.5 else 4
		p1.EnvironmentTransition = true
		p1.LastEnvironment = v93
		envTransitionT = 0
		for k, v in pairs(effectProperties) do
			p1[k] = {}
			for k2, v8 in pairs(v) do
				p1[k][v8] = soundEffects[k][v8]
			end
		end
	end
	if p1.EnvironmentTransition then
		local v95 = environmentPresets[v93]
		envTransitionT = envTransitionT + p3 * p1.TransitionSpeed
		for k, v in pairs(effectProperties) do
			for k2, v8 in pairs(v) do
				soundEffects[k][v8] = p1[k][v8] * (1 - envTransitionT) + v95[k][v8] * envTransitionT
			end
		end
		if envTransitionT >= 1 then
			p1.EnvironmentTransition = false
		end
	end
	if EnumMakeId == EnumMake.Bluebird then
		local v98 = os.clock()
		local v99 = v6 > 0.01
		if if v99 then 0.1 else 0.2 < v98 - p1.LastEngineRattle then
			p1.LastEngineRattle = v98
			p1.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if v99 then 4 else 2)
		end
		local v107 = if v99 then p1.SpringEngineFlaps:SetTarget(1) else p1.SpringEngineFlaps:SetTarget(0)
		Model.Preset.RattlerEngine.EngineMetal["EngineMetal->Engine"].C1 = CFrame.new((p1.SpringEngineRattle:Update()))
		local v111 = Model.Preset.RattlerEngine.EngineFlaps["EngineFlaps->Engine"]
		v111.C1 = v111.C0:Inverse() * CFrame.Angles(v107 * -math.pi * 0.45, 0, 0) * v111.C0
		for i, v in ipairs(p1.RattleFire) do
			v.Enabled = v99
		end
		if p1.BluebirdSupercharger then
			local v112 = p1.rpmVisual or 0
			if v6 > 0 then
				p1.BluebirdSupercharger.Volume = math.clamp(v112 / 4000 * 0.15, 0, 0.15)
				p1.BluebirdSupercharger.PlaybackSpeed = math.clamp(v112 / 8000 * 0.8, 0, 0.8)
			elseif p1.BluebirdSupercharger.Volume > 0 then
				p1.BluebirdSupercharger.Volume = math.max(0, p1.BluebirdSupercharger.Volume - p3 * 0.3)
			end
		end
	elseif EnumMakeId == EnumMake.TheRattler then
		local v116 = os.clock()
		local v117 = math.abs(v6) > 0.01
		if if v117 then 0.1 else 0.2 < v116 - p1.LastEngineRattle then
			p1.LastEngineRattle = v116
			p1.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if v117 then 4 else 2)
		end
		local v125 = if v117 then p1.SpringEngineFlaps:SetTarget(1) else p1.SpringEngineFlaps:SetTarget(0)
		Model.Preset.RattlerEngine.EngineBody["EngineBody->Engine"].C1 = CFrame.new((p1.SpringEngineRattle:Update()))
		local v129 = Model.Preset.RattlerEngine.EngineFlaps["EngineFlaps->Engine"]
		v129.C1 = v129.C0:Inverse() * CFrame.Angles(v125 * -math.pi * 0.45, 0, 0) * v129.C0
		for i, v in ipairs(p1.RattleSmoke) do
			v.Enabled = not v117
		end
		for i, v in ipairs(p1.RattleFire) do
			v.Enabled = v117
		end
	end
	if EnumMakeId == EnumMake.Polaire then
		local TiltWing = Model.Preset:FindFirstChild("TiltWing")
		if TiltWing then
			DoorUtils.setPctOpen(TiltWing, if v72 < -0.5 then -1 elseif v72 > 0.5 then 1 else 0)
		end
	end
	local Rudder = p1.Model.Preset:FindFirstChild("Rudder")
	if Rudder then
		DoorUtils.setPctOpen(Rudder, if math.abs(v72) > 0.5 then if v72 > 0 then 0 else 1 else 0.5)
	end
	if p1.RattleMotors then
		local v132 = os.clock()
		local v133 = math.abs(v6) > 0.01
		if if v133 then 0.05 else 0.1 < v132 - p1.LastEngineRattle then
			p1.LastEngineRattle = v132
			p1.SpringEngineRattle:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1) * if v133 then 3 else 2)
		end
		local v141 = p1.SpringEngineRattle:Update()
		for v142, v143 in p1.RattleMotors do
			v143.motor.C1 = CFrame.new(v141)
		end
	end
	if p1.RattleParticles then
		local v144 = math.abs(v6) > 0.01
		for v145, v146 in p1.RattleParticles do
			v146.Enabled = v144
		end
	end
	if p1.ThrusterFlames then
		Chassis.UpdateThrusterFlames(p1.Model, v6, v72, v42.Z, {
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
	p1.Lift.Force = v4(0, gravityOffset, 0)
end
function Chassis.Update(p1, p2) --[[ Update | Line: 2434 | Upvalues: inputAxes (ref), Chassis (copy) ]]
	p1._didAnyWheelDrift = false
	local v1 = inputAxes[1] - inputAxes[3] > 0
	if not v1 and (p1.isAccelHeld ~= v1 and p1.Model.PrimaryPart.AssemblyLinearVelocity.Magnitude > 50) then
		local v2 = os.clock()
		if p1.turboBlowOff and v2 - (p1.lastTurboBlowOff or 0) > 1 then
			p1.lastTurboBlowOff = v2
			p1.turboBlowOff.PlaybackSpeed = 1 + (math.random() * 0.1 - 0.05)
			p1.turboBlowOff:Play()
		end
	end
	p1.isAccelHeld = v1
	for v3, v4 in p1.EngineThrusters do
		Chassis.UpdateEngine(p1, v4, p2)
	end
	if p1.Model:GetAttribute("VehicleIsDrifting") ~= p1._didAnyWheelDrift then
		p1.Model:SetAttribute("VehicleIsDrifting", p1._didAnyWheelDrift)
		p1.Model:FindFirstChild("RelayDriftingRemote"):FireServer(p1._didAnyWheelDrift)
	end
end
function Chassis.UpdateStepped(p1) --[[ UpdateStepped | Line: 2464 | Upvalues: Angles (copy), v4 (copy), R15IKv2 (copy) ]]
	local Model = p1.Model
	if p1.IK then
		local v1 = 0.6 * p1.RotY
		p1.WeldSteer.C0 = Angles(0, v1, 0)
		local v2 = Model.Steer.CFrame
		local v3 = Model.Steer.Size.X * 0.5 - 0.2
		local SteerOffset = p1.SteerOffset
		local IK = p1.IK
		local sum = v4(v3, 0.1, 0)
		if SteerOffset then
			sum = sum + SteerOffset
		end
		local sum_2 = v4(-v3, 0.1, 0)
		if SteerOffset then
			sum_2 = sum_2 + SteerOffset
		end
		IK.RightArm = v2 * sum
		IK.LeftArm = v2 * sum_2
		IK.RightAngle = -v1 - 0.6
		IK.LeftAngle = -v1 + 0.6
		R15IKv2.Arms(IK)
	end
end
function Chassis.UpdateForces(p1, p2, p3) --[[ UpdateForces | Line: 2495 | Upvalues: UpdateThruster (copy) ]]
	for v1, v2 in p1.Wheels do
		UpdateThruster(p1, v2, p2, p3)
	end
end
function Chassis.Halt(p1) --[[ Halt | Line: 2501 ]]
	for v1, v2 in p1.EngineThrusters do
		v2.Drive.Force = Vector3.new(0, 0, 0)
		v2.Friction.Force = Vector3.new(0, 0, 0)
	end
	p1.Rotate.MaxTorque = Vector3.new(0, 0, 0)
end
function Chassis.SpinOut(p1, p2) --[[ SpinOut | Line: 2508 ]]
	p1._spinOutLeft = p2
	p1._spinOutAt = os.clock()
end
function Chassis.AttemptFireMissile(p1) --[[ AttemptFireMissile | Line: 2513 | Upvalues: LocalPlayer (copy), VehicleUtils (copy), RayCast (copy), Time (copy), v9 (ref), Missile (copy) ]]
	local Missiles = p1.Missiles
	if not Missiles then
		return false
	end
	if LocalPlayer:GetAttribute("MissileCount") <= 0 then
		VehicleUtils.promptMissileBuy()
		return false
	end
	local v1 = tick()
	local v2 = v1 - Missiles.LastFire
	if v2 < 2 and v2 > 0 then
		return false
	end
	Missiles.LastFire = v1
	local v3 = Missiles.Parts[Missiles.i]
	v3.Transparency = 1
	task.delay(2, function() --[[ Line: 2536 | Upvalues: v3 (copy) ]]
		v3.Transparency = 0
	end)
	local v4 = v3.CFrame
	local Velocity = v3.Velocity
	if Velocity.Magnitude < 0.01 then
		Velocity = Vector3.new(0, 0, 0)
	end
	local t = { p1.Model, LocalPlayer.Character }
	local _, v5 = RayCast.RayIgnoreNonCollideWithIgnoreList(v4.p, (p1.Model.Engine.CFrame.LookVector * 60 - Vector3.new(0, 2, 0)).Unit, 999, t)
	local v6 = Time.GetNowSync()
	vehicleEvent:FireServer("aen5zwf0", v4, Velocity, v5, v6, "RocketPart2", 0)
	Missile.LaunchMissile(v4, Velocity, v5, v6, "RocketPart2", 0, t)
	Missiles.i = Missiles.i % #Missiles.Parts + 1
	return true
end
local keyCodeToAxis = {
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.Q] = 5,
	[Enum.KeyCode.E] = 6,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 3,
	[Enum.KeyCode.Left] = 2,
	[Enum.KeyCode.Right] = 4
}
function Chassis.LockCamera(p1) --[[ LockCamera | Line: 2569 | Upvalues: CurrentCamera (copy), RunService (copy) ]]
	assert(not p1.IsCameraLocked)
	local Model = p1.Model
	local InsideCamera = Model:FindFirstChild("InsideCamera")
	if InsideCamera ~= nil then
		p1.IsCameraLocked = true
		Model:SetAttribute("IsCameraLocked", true)
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		p1.seatMaid.cameraLockRenderStepped = RunService.RenderStepped:Connect(function() --[[ Line: 2579 | Upvalues: CurrentCamera (ref), InsideCamera (copy) ]]
			CurrentCamera.CFrame = InsideCamera.CFrame
		end)
		function p1.seatMaid.cameraUnlock() --[[ Line: 2582 | Upvalues: CurrentCamera (ref) ]]
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end
	end
end
function Chassis.UnlockCamera(p1) --[[ UnlockCamera | Line: 2586 | Upvalues: CurrentCamera (copy) ]]
	assert(p1.IsCameraLocked)
	p1.IsCameraLocked = false
	p1.Model:SetAttribute("IsCameraLocked", false)
	CurrentCamera.CameraType = Enum.CameraType.Custom
	p1.seatMaid.cameraLockRenderStepped = nil
	p1.seatMaid.cameraUnlock = nil
end
function Chassis.InputBegan(p1) --[[ InputBegan | Line: 2594 | Upvalues: keyCodeToAxis (copy), inputAxes (ref) ]]
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if keyCodeToAxis[KeyCode] then
			inputAxes[keyCodeToAxis[KeyCode]] = 1
		end
	end
end
function Chassis.InputEnded(p1) --[[ InputEnded | Line: 2602 | Upvalues: keyCodeToAxis (copy), inputAxes (ref) ]]
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if keyCodeToAxis[KeyCode] then
			inputAxes[keyCodeToAxis[KeyCode]] = 0
		end
	elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			inputAxes[keyCodeToAxis[KeyCode]] = 0
		end
	end
end
function Chassis.InputChanged(p1) --[[ InputChanged | Line: 2615 | Upvalues: inputAxes (ref), keyCodeToAxis (copy) ]]
	if p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = p1.Position
			local X = Position.X
			local _Y = Position.Y
			inputAxes[2] = X < -0.24 and (-X) ^ 2 or 0
			inputAxes[4] = X > 0.24 and X ^ 2 or 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = p1.Position.Z
			inputAxes[keyCodeToAxis[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
		end
	end
end
function Chassis.SetEvent(p1) --[[ SetEvent | Line: 2636 | Upvalues: v9 (ref) ]]
	vehicleEvent = p1
end
local CircleAction = UI.CircleAction
local function Action(p1, p2) --[[ Action | Line: 2642 | Upvalues: v9 (ref) ]]
	if p2 then
		vehicleEvent:FireServer("t9hpd4o4", p1.Part)
	end
	return true
end
local function AddedFun(p1) --[[ AddedFun | Line: 2649 | Upvalues: Action (copy), CircleAction (copy) ]]
	CircleAction.Add({
		Name = "Move Ladder",
		NoRay = true,
		Timed = true,
		Duration = 0.25,
		Dist = 10,
		Part = p1,
		Callback = Action
	}, p1)
end
local function RemovedFun(p1) --[[ RemovedFun | Line: 2661 | Upvalues: CircleAction (copy) ]]
	CircleAction.Remove(p1)
end
for i, v in ipairs(CollectionService:GetTagged("Firetruck_Ladder")) do
	CircleAction.Add({
		Name = "Move Ladder",
		NoRay = true,
		Timed = true,
		Duration = 0.25,
		Dist = 10,
		Part = v,
		Callback = Action
	}, v)
end
CollectionService:GetInstanceAddedSignal("Firetruck_Ladder"):Connect(AddedFun)
CollectionService:GetInstanceRemovedSignal("Firetruck_Ladder"):Connect(RemovedFun)
return Chassis
