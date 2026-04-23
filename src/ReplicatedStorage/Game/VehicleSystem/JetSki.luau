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
local function GetMoveVector() --[[ Line: 21 ]]
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local v1 = require(ControlModule)
	GetMoveVector = function() --[[ Name: GetMoveVector | Line: 28 | Upvalues: v1 (ref) ]]
		return v1:GetMoveVector()
	end
end
local function SetHumanoidEnabled(p1, p2) --[[ Line: 34 ]]
	local v1 = next
	local v2, v3 = Enum.HumanoidStateType:GetEnumItems()
	for v4, v5 in v1, v2, v3 do
		if v5 ~= Enum.HumanoidStateType.Dead and (v5 ~= Enum.HumanoidStateType.None and v5 ~= Enum.HumanoidStateType.Jumping) then
			p1:SetStateEnabled(v5, p2)
		end
	end
end
local function MakeSound(p1) --[[ Line: 45 ]]
	local Sound = Instance.new("Sound")
	Sound.Volume = 0
	Sound.SoundId = "rbxassetid://" .. p1
	Sound.Looped = true
	Sound.EmitterSize = 10
	Sound.MaxDistance = 160
	return Sound
end
local t = {
	__ClassName = "JetSki"
}
t.__index = t
function t.FromPacket(p1) --[[ Line: 59 | Upvalues: t (copy), Maid (copy), Interval (copy) ]]
	setmetatable(p1, t)
	assert(p1.Id)
	assert(p1.Model)
	assert(p1.Seats)
	local BoundingBox = p1.Model.BoundingBox
	local Engine = p1.Model.Physics.Engine
	p1.BodyGyro = Engine.BodyGyro
	p1.VectorForce = Engine.VectorForce
	p1.EnginePart = Engine
	p1.BoundingBox = BoundingBox
	p1.Maid = Maid.new()
	p1.maid = p1.Maid
	local v2 = false
	p1.maid:GiveTask(Interval.every(0.1):Connect(function() --[[ Line: 76 | Upvalues: p1 (copy), v2 (ref) ]]
		local v1 = p1:GetAreTiresPopped()
		if v1 ~= v2 then
			p1.Model:FindFirstChild("Model"):FindFirstChild("Body"):FindFirstChild("Smoke").Enabled = v1
		end
		v2 = v1
	end))
	return p1
end
function t.GetAreTiresPopped(p1) --[[ Line: 87 | Upvalues: BoatConsts (copy), VehicleUtils (copy) ]]
	return (p1.Model:GetAttribute(BoatConsts.TIRES_POPPED_AT_ATTR_NAME) or 0) + VehicleUtils.getVehicleCombatConfig("JetSki").DisableDuration > workspace:GetServerTimeNow()
end
function t.GetSeatFromPlayer(p1, p2) --[[ Line: 93 ]]
	assert(p2)
	for i = 1, #p1.Seats do
		local v1 = p1.Seats[i]
		if v1.Occupied and v1.Player == p2 then
			return v1
		end
	end
	return false
end
local function UpdateArms(p1, p2) --[[ Line: 105 | Upvalues: ConstraintUtils (copy), R15IKv2 (copy) ]]
	local IKP = p2.IKP
	if p1.Model:IsDescendantOf(workspace) then
		local Steering = p1.Model.Model.Steering
		IKP.RightArm = Steering.CFrame * Vector3.new(1.2, 0.6, 1.1)
		IKP.LeftArm = Steering.CFrame * Vector3.new(-1.2, 0.6, 1.1)
		ConstraintUtils.setJointC1(IKP.RightWrist, CFrame.Angles(0, -1.5707963267948966, 0))
		ConstraintUtils.setJointC1(IKP.LeftWrist, CFrame.Angles(0, 1.5707963267948966, 0))
		R15IKv2.Arms(IKP)
	end
end
local function UpdateForces(p1, p2, p3) --[[ Line: 116 ]]
	local v1 = p1:GetAreTiresPopped()
	local VectorForce = p1.VectorForce
	local BodyGyro = p1.BodyGyro
	local EnginePart = p1.EnginePart
	local BoundingBox = p1.BoundingBox
	local v2 = EnginePart.CFrame
	local WorldPosition = VectorForce.Attachment0.WorldPosition
	local BuoyancySensor = p1.BuoyancySensor
	if not BuoyancySensor then
		local BuoyancySensor_2 = Instance.new("BuoyancySensor")
		BuoyancySensor_2.Parent = BoundingBox
		p1.BuoyancySensor = BuoyancySensor_2
		p1.maid.sensor = BuoyancySensor_2
		BuoyancySensor = BuoyancySensor_2
	end
	local TouchingSurface = BuoyancySensor.TouchingSurface
	local Magnitude = EnginePart.Velocity.Magnitude
	if p1.Model:IsDescendantOf(workspace) then
		local Skeleton = p1.Model.Skeleton
		Skeleton.JetEmitter.Particle.Enabled = TouchingSurface and Magnitude > 20
		Skeleton.MistEmitter.Particle.Enabled = TouchingSurface and Magnitude > 50
		Skeleton.WakeEmitter.Particle.Enabled = TouchingSurface and Magnitude > 100
	end
	local v6 = 0
	if p2 > 0 then
		v6 = -6000 * p2
	elseif p2 < 0 then
		v6 = -1000 * p2
	end
	if TouchingSurface == false then
		v6 = v6 * 0.3
	end
	if v1 then
		v6 = v6 * 0.05
	end
	VectorForce.Force = Vector3.new(0, 0, v6)
	BodyGyro.CFrame = CFrame.new(Vector3.new(), v2.LookVector) * CFrame.Angles(0, 0, p3 * math.pi * 0.2) + v2.p
	local v7 = v2:VectorToObjectSpace(EnginePart.RotVelocity)
	local v11 = Vector3.new(v7.X * if TouchingSurface then 1 else 0.8, v7.Y * 0.9 + p3 * 0.3, v7.Z)
	EnginePart.RotVelocity = v2:VectorToWorldSpace(v11)
	return v11
end
local function MountLocalPlayer(p1, p2, p3) --[[ Line: 164 | Upvalues: SetHumanoidEnabled (copy), Spring (copy), UpdateArms (copy), RunService (copy), InputUtils (copy), GetMoveVector (ref), UpdateForces (copy), ConstraintUtils (copy), UserInputService (copy), ActionButtonService (copy) ]]
	assert(p2)
	assert(p3)
	local Character = p2.Character
	assert(Character)
	local Humanoid = Character:FindFirstChild("Humanoid")
	assert(Humanoid)
	SetHumanoidEnabled(Humanoid, false)
	Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
	local v1 = Spring.new(0, 0, 0.9, 30)
	local v2 = Spring.new(0, 0, 0.6, 10)
	local Neck = Character.Head.Neck
	local v3 = CFrame.new(Neck.C1.p)
	local Waist = Character.UpperTorso.Waist
	local v4 = CFrame.new(Waist.C1.p)
	local Maid = p3.Maid
	local function Stepped() --[[ Line: 184 | Upvalues: UpdateArms (ref), p1 (copy), p3 (copy) ]]
		UpdateArms(p1, p3)
	end
	Maid:GiveTask(RunService.Stepped:Connect(Stepped))
	local t = { 0, 0, 0, 0 }
	local t2 = {
		[Enum.KeyCode.A] = 2,
		[Enum.KeyCode.D] = 4,
		[Enum.KeyCode.ButtonR2] = 1,
		[Enum.KeyCode.ButtonL2] = 3
	}
	local function Heartbeat() --[[ Line: 198 | Upvalues: t (copy), InputUtils (ref), GetMoveVector (ref), UpdateForces (ref), p1 (copy), v1 (copy), v2 (copy), v4 (copy), v3 (copy), ConstraintUtils (ref), Waist (copy), Neck (copy), p3 (copy) ]]
		local v12 = t[1] - t[3]
		local v22 = t[2] - t[4]
		if InputUtils.isTouch() then
			local X = GetMoveVector().X
			local v32 = math.clamp(X, -1, 1)
			v22 = -v32 * math.abs(v32)
		end
		local v42 = v1:SetTarget(UpdateForces(p1, v12, v22).Y * 0.3)
		local v5 = v2:SetTarget(v12)
		local v6 = v4 * CFrame.Angles(-v5 * 0.15 + math.abs(v42) * 0.2, -v42 * 0.5, 0)
		local v7 = v3 * CFrame.Angles(-0.6283185307179586 + v5 * 0.3 - math.abs(v42) * 0.3, 0, 0) * CFrame.Angles(0, -v42 * 0.1, 0)
		ConstraintUtils.setJointC1(Waist, v6)
		ConstraintUtils.setJointC1(Neck, v7)
		local SteeringMotor = p3.SteeringMotor
		SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, v42 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
		if p3.Driver then
			local LowSound = p1.LowSound
			local Magnitude = p1.EnginePart.Velocity.Magnitude
			p1.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
			LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
			LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
		end
	end
	Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
	local function InputBegan(p1, p2) --[[ Line: 237 | Upvalues: t2 (copy), t (copy) ]]
		if p2 then
			return true
		end
		if p1.UserInputType == Enum.UserInputType.Keyboard and t2[p1.KeyCode] then
			t[t2[p1.KeyCode]] = 1
		end
	end
	Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
	local function InputEnded(p1, p2) --[[ Line: 248 | Upvalues: t2 (copy), t (copy) ]]
		if p2 then
			return true
		end
		if p1.UserInputType == Enum.UserInputType.Keyboard and t2[p1.KeyCode] then
			t[t2[p1.KeyCode]] = 0
		end
	end
	Maid:GiveTask(UserInputService.InputEnded:Connect(InputEnded))
	local function InputChanged(p1) --[[ Line: 259 | Upvalues: t (copy), t2 (copy) ]]
		if p1.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = p1.KeyCode
			if KeyCode == Enum.KeyCode.Thumbstick1 then
				local Position = p1.Position
				local X = Position.X
				local Y = Position.Y
				t[2] = X < -0.24 and (-X) ^ 2 or 0
				t[4] = X > 0.24 and X ^ 2 or 0
			elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
				local Z = p1.Position.Z
				t[t2[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
			end
		end
	end
	Maid:GiveTask(UserInputService.InputChanged:Connect(InputChanged))
	p3.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 1000,
		saturateTo = 0,
		image = "rbxassetid://7858765663",
		keyCodes = { Enum.KeyCode.W },
		onPressed = function() --[[ Name: onPressed | Line: 284 | Upvalues: t (copy) ]]
			t[1] = 1
		end,
		onReleased = function() --[[ Name: onReleased | Line: 287 | Upvalues: t (copy) ]]
			t[1] = 0
		end
	}))
	p3.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 700,
		saturateTo = 0,
		image = "rbxassetid://7858764373",
		keyCodes = { Enum.KeyCode.S },
		onPressed = function() --[[ Name: onPressed | Line: 297 | Upvalues: t (copy) ]]
			t[3] = 1
		end,
		onReleased = function() --[[ Name: onReleased | Line: 300 | Upvalues: t (copy) ]]
			t[3] = 0
		end
	}))
	p1.NeckC1 = v3
	p1.WaistC1 = v4
end
local function MountThirdPlayer(p1, p2, p3) --[[ Line: 308 | Upvalues: UpdateArms (copy), RunService (copy) ]]
	assert(p2)
	assert(p3)
	local EnginePart = p1.EnginePart
	local function Stepped() --[[ Line: 314 | Upvalues: UpdateArms (ref), p1 (copy), p3 (copy), EnginePart (copy) ]]
		UpdateArms(p1, p3)
		local v1 = EnginePart.CFrame:VectorToObjectSpace(EnginePart.RotVelocity)
		local SteeringMotor = p3.SteeringMotor
		SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, v1.Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
		if p3.Driver then
			local LowSound = p1.LowSound
			local Magnitude = p1.EnginePart.Velocity.Magnitude
			p1.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
			LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
			LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
		end
	end
	p3.Maid:GiveTask(RunService.Stepped:Connect(Stepped))
end
function t.MountPlayer(p1, p2, p3) --[[ Line: 339 | Upvalues: R15IKv2 (copy), LocalPlayer (copy), MountLocalPlayer (copy), UpdateArms (copy), RunService (copy) ]]
	assert(p2)
	assert(p3)
	if p3.Driver then
		local Character = p2.Character
		assert(Character)
		local v1 = R15IKv2.BuildPacketArms(Character)
		p3.IKP = v1
		p3.RightWristC1 = v1.RightWrist.C1
		p3.LeftWristC1 = v1.LeftWrist.C1
		local Sound = Instance.new("Sound")
		Sound.Volume = 0
		Sound.SoundId = "rbxassetid://" .. 657590761
		Sound.Looped = true
		Sound.EmitterSize = 10
		Sound.MaxDistance = 160
		local Sound_2 = Instance.new("Sound")
		Sound_2.Volume = 0
		Sound_2.SoundId = "rbxassetid://" .. 657591400
		Sound_2.Looped = true
		Sound_2.EmitterSize = 10
		Sound_2.MaxDistance = 160
		Sound.Parent = p1.EnginePart
		Sound_2.Parent = p1.EnginePart
		p1.IdleSound = Sound
		p1.LowSound = Sound_2
		p1.IdleSound:Play()
		p1.LowSound:Play()
	end
	if p2 == LocalPlayer then
		MountLocalPlayer(p1, p2, p3)
	else
		assert(p2)
		assert(p3)
		local EnginePart = p1.EnginePart
		local function Stepped() --[[ Line: 314 | Upvalues: UpdateArms (ref), p1 (copy), p3 (copy), EnginePart (copy) ]]
			UpdateArms(p1, p3)
			local v1 = EnginePart.CFrame:VectorToObjectSpace(EnginePart.RotVelocity)
			local SteeringMotor = p3.SteeringMotor
			SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, v1.Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
			if p3.Driver then
				local LowSound = p1.LowSound
				local Magnitude = p1.EnginePart.Velocity.Magnitude
				p1.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
				LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
				LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
			end
		end
		p3.Maid:GiveTask(RunService.Stepped:Connect(Stepped))
	end
end
local function UnmountLocalPlayer(p1, p2, p3) --[[ Line: 369 | Upvalues: SetHumanoidEnabled (copy), ConstraintUtils (copy) ]]
	assert(p2)
	assert(p3)
	local Character = p2.Character
	if Character and Character:IsDescendantOf(workspace) then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			SetHumanoidEnabled(Humanoid, true)
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			local Head = Character:FindFirstChild("Head")
			if Head then
				local Neck = Head:FindFirstChild("Neck")
				if Neck then
					ConstraintUtils.setJointC1(Neck, p1.NeckC1)
				end
			end
			local UpperTorso = Character:FindFirstChild("UpperTorso")
			if UpperTorso then
				local Waist = UpperTorso:FindFirstChild("Waist")
				if Waist then
					ConstraintUtils.setJointC1(Waist, p1.WaistC1)
				end
			end
		end
	end
	if p3.Driver then
		local IKP = p3.IKP
		if IKP then
			ConstraintUtils.setJointC1(IKP.RightWrist, p3.RightWristC1)
			ConstraintUtils.setJointC1(IKP.LeftWrist, p3.LeftWristC1)
		end
	end
	p1.WaistC1 = nil
	p1.NeckC1 = nil
	local v1 = p1.EnginePart.CFrame
	p1.VectorForce.Force = Vector3.new(0, 0, 0)
	p1.BodyGyro.CFrame = CFrame.new(Vector3.new(), v1.LookVector) + v1.p
	local SteeringMotor = p3.SteeringMotor
	SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
	if p1.Model:IsDescendantOf(workspace) then
		local Skeleton = p1.Model.Skeleton
		Skeleton.JetEmitter.Particle.Enabled = false
		Skeleton.MistEmitter.Particle.Enabled = false
		Skeleton.WakeEmitter.Particle.Enabled = false
	end
end
function t.UnmountPlayer(p1, p2, p3) --[[ Line: 429 | Upvalues: LocalPlayer (copy), UnmountLocalPlayer (copy) ]]
	assert(p2)
	if p3 == nil then
		p3 = p1:GetSeatFromPlayer(p2)
	end
	assert(p3)
	assert(p3.Occupied == true)
	if p3.Driver then
		if p1.IdleSound then
			p1.IdleSound:Destroy()
			p1.IdleSound = nil
		end
		if p1.LowSound then
			p1.LowSound:Destroy()
			p1.LowSound = nil
		end
	end
	if p2 == LocalPlayer then
		UnmountLocalPlayer(p1, p2, p3)
	end
end
function t.UnmountSeat(p1, p2) --[[ Line: 451 ]]
	assert(p2)
	assert(p2.Occupied == true)
	return p1:UnmountPlayer(p2.Player, p2)
end
function t.Destroy(p1) --[[ Line: 477 ]]
	for i = 1, #p1.Seats do
		local v1 = p1.Seats[i]
		if v1.Occupied then
			p1:UnmountSeat(v1)
		end
	end
	p1.Maid:Destroy()
end
return t