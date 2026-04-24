-- Reviewed by Claude
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
local function SetHumanoidEnabled(p1, p2)
	local module = next
	local cframe2, cframe3 = Enum.HumanoidStateType:GetEnumItems()
	for cframe4, var5 in module, cframe2, cframe3 do
		if var5 ~= Enum.HumanoidStateType.Dead and (var5 ~= Enum.HumanoidStateType.None and var5 ~= Enum.HumanoidStateType.Jumping) then
			p1:SetStateEnabled(var5, p2)
		end
	end
end
local function MakeSound(p1)
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
function t.FromPacket(p1)
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
	local cframe2 = false
	p1.maid:GiveTask(Interval.every(0.1):Connect(function()
		local module = p1:GetAreTiresPopped()
		if module ~= cframe2 then
			p1.Model:FindFirstChild("Model"):FindFirstChild("Body"):FindFirstChild("Smoke").Enabled = module
		end
		cframe2 = module
	end))
	return p1
end
function t.GetAreTiresPopped(p1)
	return (p1.Model:GetAttribute(BoatConsts.TIRES_POPPED_AT_ATTR_NAME) or 0) + VehicleUtils.getVehicleCombatConfig("JetSki").DisableDuration > workspace:GetServerTimeNow()
end
function t.GetSeatFromPlayer(p1, p2)
	assert(p2)
	for i = 1, #p1.Seats do
		local module = p1.Seats[i]
		if module.Occupied and module.Player == p2 then
			return module
		end
	end
	return false
end
local function UpdateArms(p1, p2)
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
local function UpdateForces(p1, p2, p3)
	local module = p1:GetAreTiresPopped()
	local VectorForce = p1.VectorForce
	local BodyGyro = p1.BodyGyro
	local EnginePart = p1.EnginePart
	local BoundingBox = p1.BoundingBox
	local cframe2 = EnginePart.CFrame
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
	local var6 = 0
	if p2 > 0 then
		var6 = -6000 * p2
	elseif p2 < 0 then
		var6 = -1000 * p2
	end
	if TouchingSurface == false then
		var6 = var6 * 0.3
	end
	if module then
		var6 = var6 * 0.05
	end
	VectorForce.Force = Vector3.new(0, 0, var6)
	BodyGyro.CFrame = CFrame.new(Vector3.new(), cframe2.LookVector) * CFrame.Angles(0, 0, p3 * math.pi * 0.2) + cframe2.p
	local var7 = cframe2:VectorToObjectSpace(EnginePart.RotVelocity)
	local vector11 = Vector3.new(var7.X * if TouchingSurface then 1 else 0.8, var7.Y * 0.9 + p3 * 0.3, var7.Z)
	EnginePart.RotVelocity = cframe2:VectorToWorldSpace(vector11)
	return vector11
end
local function MountLocalPlayer(p1, p2, p3)
	assert(p2)
	assert(p3)
	local Character = p2.Character
	assert(Character)
	local Humanoid = Character:FindFirstChild("Humanoid")
	assert(Humanoid)
	SetHumanoidEnabled(Humanoid, false)
	Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
	local module = Spring.new(0, 0, 0.9, 30)
	local cframe2 = Spring.new(0, 0, 0.6, 10)
	local Neck = Character.Head.Neck
	local cframe3 = CFrame.new(Neck.C1.p)
	local Waist = Character.UpperTorso.Waist
	local cframe4 = CFrame.new(Waist.C1.p)
	local Maid = p3.Maid
	local function Stepped()
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
	local function Heartbeat()
		local var12 = t[1] - t[3]
		local var22 = t[2] - t[4]
		if InputUtils.isTouch() then
			local X = GetMoveVector().X
			local var32 = math.clamp(X, -1, 1)
			var22 = -var32 * math.abs(var32)
		end
		local var42 = module:SetTarget(UpdateForces(p1, var12, var22).Y * 0.3)
		local var5 = cframe2:SetTarget(var12)
		local var6 = cframe4 * CFrame.Angles(-var5 * 0.15 + math.abs(var42) * 0.2, -var42 * 0.5, 0)
		local var7 = cframe3 * CFrame.Angles(-0.6283185307179586 + var5 * 0.3 - math.abs(var42) * 0.3, 0, 0) * CFrame.Angles(0, -var42 * 0.1, 0)
		ConstraintUtils.setJointC1(Waist, var6)
		ConstraintUtils.setJointC1(Neck, var7)
		local SteeringMotor = p3.SteeringMotor
		SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, var42 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
		if p3.Driver then
			local LowSound = p1.LowSound
			local Magnitude = p1.EnginePart.Velocity.Magnitude
			p1.IdleSound.Volume = math.exp(-Magnitude / 50) * 0.5
			LowSound.Volume = (1 - math.exp(-Magnitude / 50)) * 0.5
			LowSound.PlaybackSpeed = 1 - math.exp(-Magnitude / 50)
		end
	end
	Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
	local function InputBegan(p1, p2)
		if p2 then
			return true
		end
		if p1.UserInputType == Enum.UserInputType.Keyboard and t2[p1.KeyCode] then
			t[t2[p1.KeyCode]] = 1
		end
	end
	Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
	local function InputEnded(p1, p2)
		if p2 then
			return true
		end
		if p1.UserInputType == Enum.UserInputType.Keyboard and t2[p1.KeyCode] then
			t[t2[p1.KeyCode]] = 0
		end
	end
	Maid:GiveTask(UserInputService.InputEnded:Connect(InputEnded))
	local function InputChanged(p1)
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
		onPressed = function()
			t[1] = 1
		end,
		onReleased = function()
			t[1] = 0
		end
	}))
	p3.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 700,
		saturateTo = 0,
		image = "rbxassetid://7858764373",
		keyCodes = { Enum.KeyCode.S },
		onPressed = function()
			t[3] = 1
		end,
		onReleased = function()
			t[3] = 0
		end
	}))
	p1.NeckC1 = cframe3
	p1.WaistC1 = cframe4
end
local function MountThirdPlayer(p1, p2, p3)
	assert(p2)
	assert(p3)
	local EnginePart = p1.EnginePart
	local function Stepped()
		UpdateArms(p1, p3)
		local module = EnginePart.CFrame:VectorToObjectSpace(EnginePart.RotVelocity)
		local SteeringMotor = p3.SteeringMotor
		SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, module.Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
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
function t.MountPlayer(p1, p2, p3)
	assert(p2)
	assert(p3)
	if p3.Driver then
		local Character = p2.Character
		assert(Character)
		local module = R15IKv2.BuildPacketArms(Character)
		p3.IKP = module
		p3.RightWristC1 = module.RightWrist.C1
		p3.LeftWristC1 = module.LeftWrist.C1
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
		local function Stepped()
			UpdateArms(p1, p3)
			local module = EnginePart.CFrame:VectorToObjectSpace(EnginePart.RotVelocity)
			local SteeringMotor = p3.SteeringMotor
			SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.Angles(0, module.Y * 0.3 * 0.5, 0) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
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
local function UnmountLocalPlayer(p1, p2, p3)
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
	local module = p1.EnginePart.CFrame
	p1.VectorForce.Force = Vector3.new(0, 0, 0)
	p1.BodyGyro.CFrame = CFrame.new(Vector3.new(), module.LookVector) + module.p
	local SteeringMotor = p3.SteeringMotor
	SteeringMotor.C1 = SteeringMotor.C0:inverse() * CFrame.new(0, 0.4, -0.39999999999999997) * CFrame.new(0, 0, 0.6) * SteeringMotor.C0
	if p1.Model:IsDescendantOf(workspace) then
		local Skeleton = p1.Model.Skeleton
		Skeleton.JetEmitter.Particle.Enabled = false
		Skeleton.MistEmitter.Particle.Enabled = false
		Skeleton.WakeEmitter.Particle.Enabled = false
	end
end
function t.UnmountPlayer(p1, p2, p3)
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
function t.UnmountSeat(p1, p2)
	assert(p2)
	assert(p2.Occupied == true)
	return p1:UnmountPlayer(p2.Player, p2)
end
function t.Destroy(p1)
	for i = 1, #p1.Seats do
		local module = p1.Seats[i]
		if module.Occupied then
			p1:UnmountSeat(module)
		end
	end
	p1.Maid:Destroy()
end
return t
