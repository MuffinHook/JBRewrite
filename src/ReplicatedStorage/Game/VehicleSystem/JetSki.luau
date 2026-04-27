local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local CurrentCamera = workspace.CurrentCamera
local Maid = require(ReplicatedStorage.Std.Maid)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Spring = require(ReplicatedStorage.Std.Spring)
local Players = game:GetService("Players")
local BoatConsts = require(ReplicatedStorage.Game.Boat.BoatConsts)
local ConstraintUtils = require(ReplicatedStorage.Std.ConstraintUtils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
require(ReplicatedStorage.Std.Raycast)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local LocalPlayer = Players.LocalPlayer
local function GetMoveVector()
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local module = require(ControlModule)
	GetMoveVector = function()
		return module:GetMoveVector()
	end
end
local function SetHumanoidEnabled(humanoid, isEnabled)
	local iteratorFn = next
	local stateTypes, stateList = Enum.HumanoidStateType:GetEnumItems()
	for _, stateType in iteratorFn, stateTypes, stateList do
		if stateType ~= Enum.HumanoidStateType.Dead and (stateType ~= Enum.HumanoidStateType.None and stateType ~= Enum.HumanoidStateType.Jumping) then
			humanoid:SetStateEnabled(stateType, isEnabled)
		end
	end
end
local function MakeSound(soundId)
	local Sound = Instance.new("Sound")
	Sound.Volume = 0
	Sound.SoundId = "rbxassetid://" .. soundId
	Sound.Looped = true
	Sound.EmitterSize = 10
	Sound.MaxDistance = 160
	return Sound
end
local JetSki = {
	__ClassName = "JetSki"
}
JetSki.__index = JetSki
function JetSki.FromPacket(jetski)
	setmetatable(jetski, JetSki)
	assert(jetski.Id)
	assert(jetski.Model)
	assert(jetski.Seats)
	local BoundingBox = jetski.Model.BoundingBox
	local Engine = jetski.Model.Physics.Engine
	jetski.BodyGyro = Engine.BodyGyro
	jetski.VectorForce = Engine.VectorForce
	jetski.EnginePart = Engine
	jetski.BoundingBox = BoundingBox
	jetski.Maid = Maid.new()
	jetski.maid = jetski.Maid
	local wasPoppedLastCheck = false
	jetski.maid:GiveTask(Interval.every(0.1):Connect(function()
		local isTirePopped = jetski:GetAreTiresPopped()
		if isTirePopped ~= wasPoppedLastCheck then
			jetski.Model:FindFirstChild("Model"):FindFirstChild("Body"):FindFirstChild("Smoke").Enabled = isTirePopped
		end
		wasPoppedLastCheck = isTirePopped
	end))
	return jetski
end
function JetSki.GetAreTiresPopped(jetski)
	return (jetski.Model:GetAttribute(BoatConsts.TIRES_POPPED_AT_ATTR_NAME) or 0) + VehicleUtils.getVehicleCombatConfig("JetSki").DisableDuration > workspace:GetServerTimeNow()
end
function JetSki.GetSeatFromPlayer(jetski, targetPlayer)
	assert(targetPlayer)
	for i = 1, #jetski.Seats do
		local seat = jetski.Seats[i]
		if seat.Occupied and seat.Player == targetPlayer then
			return seat
		end
	end
	return false
end
local function UpdateArms(jetski, seatData)
	local IKP = seatData.IKP
	if jetski.Model:IsDescendantOf(workspace) then
		local Steering = jetski.Model.Model.Steering
		IKP.RightArm = Steering.CFrame * Vector3.new(1.2, 0.6, 1.1)
		IKP.LeftArm = Steering.CFrame * Vector3.new(-1.2, 0.6, 1.1)
		ConstraintUtils.setJointC1(IKP.RightWrist, CFrame.Angles(0, -1.5707963267948966, 0))
		ConstraintUtils.setJointC1(IKP.LeftWrist, CFrame.Angles(0, 1.5707963267948966, 0))
		R15IKv2.Arms(IKP)
	end
end
local function UpdateForces(jetski, throttleInput, steeringInput)
	local isTirePopped = jetski:GetAreTiresPopped()
	local VectorForce = jetski.VectorForce
	local BodyGyro = jetski.BodyGyro
	local EnginePart = jetski.EnginePart
	local BoundingBox = jetski.BoundingBox
	local engineCFrame = EnginePart.CFrame
	local WorldPosition = VectorForce.Attachment0.WorldPosition
	local BuoyancySensor = jetski.BuoyancySensor
	if not BuoyancySensor then
		local BuoyancySensor_2 = Instance.new("BuoyancySensor")
		BuoyancySensor_2.Parent = BoundingBox
		jetski.BuoyancySensor = BuoyancySensor_2
		jetski.maid.sensor = BuoyancySensor_2
		BuoyancySensor = BuoyancySensor_2
	end
	local TouchingSurface = BuoyancySensor.TouchingSurface
	local Magnitude = EnginePart.Velocity.Magnitude
	if jetski.Model:IsDescendantOf(workspace) then
		local Skeleton = jetski.Model.Skeleton
		Skeleton.JetEmitter.Particle.Enabled = TouchingSurface and Magnitude > 20
		Skeleton.MistEmitter.Particle.Enabled = TouchingSurface and Magnitude > 50
		Skeleton.WakeEmitter.Particle.Enabled = TouchingSurface and Magnitude > 100
	end
	local thrustForce = 0
	if throttleInput > 0 then
		thrustForce = -6000 * throttleInput
	elseif throttleInput < 0 then
		thrustForce = -1000 * throttleInput
	end
	if TouchingSurface == false then
		thrustForce = thrustForce * 0.3
	end
	if isTirePopped then
		thrustForce = thrustForce * 0.05
	end
	VectorForce.Force = Vector3.new(0, 0, thrustForce)
	BodyGyro.CFrame = CFrame.new(Vector3.new(), engineCFrame.LookVector) * CFrame.Angles(0, 0, steeringInput * math.pi * 0.2) + engineCFrame.p
	local rotVelocityLocal = engineCFrame:VectorToObjectSpace(EnginePart.RotVelocity)
	local adjustedRotVelocity = Vector3.new(rotVelocityLocal.X * if TouchingSurface then 1 else 0.8, rotVelocityLocal.Y * 0.9 + steeringInput * 0.3, rotVelocityLocal.Z)
	EnginePart.RotVelocity = engineCFrame:VectorToWorldSpace(adjustedRotVelocity)
	return adjustedRotVelocity
end
local function MountLocalPlayer(jetski, player, seat)
	assert(player)
	assert(seat)
	local Character = player.Character
	assert(Character)
	local Humanoid = Character:FindFirstChild("Humanoid")
	assert(Humanoid)
	SetHumanoidEnabled(Humanoid, false)
	Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
	local pitchSpring = Spring.new(0, 0, 0.9, 30)
	local rollSpring = Spring.new(0, 0, 0.6, 10)
	local Neck = Character.Head.Neck
	local neckC1Default = CFrame.new(Neck.C1.p)
	local Waist = Character.UpperTorso.Waist
	local waistC1Default = CFrame.new(Waist.C1.p)
	local Maid = seat.Maid
	local function Stepped()
		UpdateArms(jetski, seat)
	end
	Maid:GiveTask(RunService.Stepped:Connect(Stepped))
	local inputState = { 0, 0, 0, 0 }
	local keyToInputIndex = {
		[Enum.KeyCode.A] = 2,
		[Enum.KeyCode.D] = 4,
		[Enum.KeyCode.ButtonR2] = 1,
		[Enum.KeyCode.ButtonL2] = 3
	}
	local function Heartbeat()
		local forwardInput = inputState[1] - inputState[3]
		local sideInput = inputState[2] - inputState[4]
		if InputUtils.isTouch() then
			local X = GetMoveVector().X
			local clampedX = math.clamp(X, -1, 1)
			sideInput = -clampedX * math.abs(clampedX)
		end
		local pitchValue = pitchSpring:SetTarget(UpdateForces(jetski, forwardInput, sideInput).Y * 0.3)
		local rollValue = rollSpring:SetTarget(forwardInput)
		local waistAdjustment = waistC1Default * CFrame.Angles(-rollValue * 0.15 + math.abs(pitchValue) * 0.2, -pitchValue * 0.5, 0)
		local neckAdjustment = neckC1Default * CFrame.Angles(-0.6283185307179586 + rollValue * 0.3 - math.abs(pitchValue) * 0.3, 0, 0) * CFrame.Angles(0, -pitchValue * 0.1, 0)
		ConstraintUtils.setJointC1(Waist, waistAdjustment)
		ConstraintUtils.setJointC1(Neck, neckAdjustment)
		local SteeringMotor = seat.SteeringMotor
		SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, pitchValue * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
		if seat.Driver then
			local LowSound = jetski.LowSound
			local Magnitude = jetski.EnginePart.Velocity.Magnitude
			jetski.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
			LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
			LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
		end
	end
	Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
	local function InputBegan(inputObject, gameProcessed)
		if gameProcessed then
			return true
		end
		if inputObject.UserInputType == Enum.UserInputType.Keyboard and keyToInputIndex[inputObject.KeyCode] then
			inputState[keyToInputIndex[inputObject.KeyCode]] = 1
		end
	end
	Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
	local function InputEnded(inputObject, gameProcessed)
		if gameProcessed then
			return true
		end
		if inputObject.UserInputType == Enum.UserInputType.Keyboard and keyToInputIndex[inputObject.KeyCode] then
			inputState[keyToInputIndex[inputObject.KeyCode]] = 0
		end
	end
	Maid:GiveTask(UserInputService.InputEnded:Connect(InputEnded))
	local function InputChanged(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = inputObject.KeyCode
			if KeyCode == Enum.KeyCode.Thumbstick1 then
				local Position = inputObject.Position
				local X = Position.X
				local Y = Position.Y
				inputState[2] = X < -0.24 and (-X) ^ 2 or 0
				inputState[4] = X > 0.24 and X ^ 2 or 0
			elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
				local Z = inputObject.Position.Z
				inputState[keyToInputIndex[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
			end
		end
	end
	Maid:GiveTask(UserInputService.InputChanged:Connect(InputChanged))
	seat.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 1000,
		saturateTo = 0,
		image = "rbxassetid://7858765663",
		keyCodes = { Enum.KeyCode.W },
		onPressed = function()
			inputState[1] = 1
		end,
		onReleased = function()
			inputState[1] = 0
		end
	}))
	seat.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 700,
		saturateTo = 0,
		image = "rbxassetid://7858764373",
		keyCodes = { Enum.KeyCode.S },
		onPressed = function()
			inputState[3] = 1
		end,
		onReleased = function()
			inputState[3] = 0
		end
	}))
	jetski.NeckC1 = neckC1Default
	jetski.WaistC1 = waistC1Default
end
local function MountThirdPlayer(jetski, player, seat)
	assert(player)
	assert(seat)
	local EnginePart = jetski.EnginePart
	local function Stepped()
		UpdateArms(jetski, seat)
		local rotVelocityLocal = EnginePart.CFrame:VectorToObjectSpace(EnginePart.RotVelocity)
		local SteeringMotor = seat.SteeringMotor
		SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, rotVelocityLocal.Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
		if seat.Driver then
			local LowSound = jetski.LowSound
			local Magnitude = jetski.EnginePart.Velocity.Magnitude
			jetski.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
			LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
			LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
		end
	end
	seat.Maid:GiveTask(RunService.Stepped:Connect(Stepped))
end
function JetSki.MountPlayer(jetski, player, seat)
	assert(player)
	assert(seat)
	if seat.Driver then
		local Character = player.Character
		assert(Character)
		local ikArmsPacket = R15IKv2.BuildPacketArms(Character)
		seat.IKP = ikArmsPacket
		seat.RightWristC1 = ikArmsPacket.RightWrist.C1
		seat.LeftWristC1 = ikArmsPacket.LeftWrist.C1
		local IdleSound = Instance.new("Sound")
		IdleSound.Volume = 0
		IdleSound.SoundId = "rbxassetid://" .. 657590761
		IdleSound.Looped = true
		IdleSound.EmitterSize = 10
		IdleSound.MaxDistance = 160
		local LowThrottleSound = Instance.new("Sound")
		LowThrottleSound.Volume = 0
		LowThrottleSound.SoundId = "rbxassetid://" .. 657591400
		LowThrottleSound.Looped = true
		LowThrottleSound.EmitterSize = 10
		LowThrottleSound.MaxDistance = 160
		IdleSound.Parent = jetski.EnginePart
		LowThrottleSound.Parent = jetski.EnginePart
		jetski.IdleSound = IdleSound
		jetski.LowSound = LowThrottleSound
		jetski.IdleSound:Play()
		jetski.LowSound:Play()
	end
	if player == LocalPlayer then
		MountLocalPlayer(jetski, player, seat)
	else
		assert(player)
		assert(seat)
		local EnginePart = jetski.EnginePart
		local function Stepped()
			UpdateArms(jetski, seat)
			local rotVelocityLocal = EnginePart.CFrame:VectorToObjectSpace(EnginePart.RotVelocity)
			local SteeringMotor = seat.SteeringMotor
			SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, rotVelocityLocal.Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
			if seat.Driver then
				local LowSound = jetski.LowSound
				local Magnitude = jetski.EnginePart.Velocity.Magnitude
				jetski.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
				LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
				LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
			end
		end
		seat.Maid:GiveTask(RunService.Stepped:Connect(Stepped))
	end
end
local function UnmountLocalPlayer(jetski, player, seat)
	assert(player)
	assert(seat)
	local Character = player.Character
	if Character and Character:IsDescendantOf(workspace) then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			SetHumanoidEnabled(Humanoid, true)
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			local Head = Character:FindFirstChild("Head")
			if Head then
				local Neck = Head:FindFirstChild("Neck")
				if Neck then
					ConstraintUtils.setJointC1(Neck, jetski.NeckC1)
				end
			end
			local UpperTorso = Character:FindFirstChild("UpperTorso")
			if UpperTorso then
				local Waist = UpperTorso:FindFirstChild("Waist")
				if Waist then
					ConstraintUtils.setJointC1(Waist, jetski.WaistC1)
				end
			end
		end
	end
	if seat.Driver then
		local IKP = seat.IKP
		if IKP then
			ConstraintUtils.setJointC1(IKP.RightWrist, seat.RightWristC1)
			ConstraintUtils.setJointC1(IKP.LeftWrist, seat.LeftWristC1)
		end
	end
	jetski.WaistC1 = nil
	jetski.NeckC1 = nil
	local engineCFrame = jetski.EnginePart.CFrame
	jetski.VectorForce.Force = Vector3.new(0, 0, 0)
	jetski.BodyGyro.CFrame = CFrame.new(Vector3.new(), engineCFrame.LookVector) + engineCFrame.p
	local SteeringMotor = seat.SteeringMotor
	SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
	if jetski.Model:IsDescendantOf(workspace) then
		local Skeleton = jetski.Model.Skeleton
		Skeleton.JetEmitter.Particle.Enabled = false
		Skeleton.MistEmitter.Particle.Enabled = false
		Skeleton.WakeEmitter.Particle.Enabled = false
	end
end
function JetSki.UnmountPlayer(jetski, player, seat)
	assert(player)
	if seat == nil then
		seat = jetski:GetSeatFromPlayer(player)
	end
	assert(seat)
	assert(seat.Occupied == true)
	if seat.Driver then
		if jetski.IdleSound then
			jetski.IdleSound:Destroy()
			jetski.IdleSound = nil
		end
		if jetski.LowSound then
			jetski.LowSound:Destroy()
			jetski.LowSound = nil
		end
	end
	if player == LocalPlayer then
		UnmountLocalPlayer(jetski, player, seat)
	end
end
function JetSki.UnmountSeat(jetski, seat)
	assert(seat)
	assert(seat.Occupied == true)
	return jetski:UnmountPlayer(seat.Player, seat)
end
function JetSki.Destroy(jetski)
	for i = 1, #jetski.Seats do
		local seat = jetski.Seats[i]
		if seat.Occupied then
			jetski:UnmountSeat(seat)
		end
	end
	jetski.Maid:Destroy()
end
return JetSki
