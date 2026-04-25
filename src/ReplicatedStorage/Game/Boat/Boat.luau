-- Reviewed by Claude
-- variables reassigned
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local BoatConsts = require(ReplicatedStorage.Game.Boat.BoatConsts)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local ConstraintUtils = require(ReplicatedStorage.Std.ConstraintUtils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
require(ReplicatedStorage.Std.Raycast)
local Spring = require(ReplicatedStorage.Std.Spring)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local PlayerModule = nil
Vector3.new()
local function v2(p1)
	local sum = 0
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") then
			sum = sum + v:GetMass()
		end
		sum = sum + v2(v)
	end
	return sum
end
local IdentityCFrame = CFrame.new()
local function FromAxisAngle(p1)
	local x = p1.x
	local y = p1.y
	local z = p1.z
	local magnitude = (x * x + y * y + z * z) ^ 0.5
	if magnitude > 0.00001 then
		local sinHalf = math.sin(magnitude * 0.5) / magnitude
		return CFrame.new(0, 0, 0, sinHalf * x, sinHalf * y, sinHalf * z, (math.cos(magnitude * 0.5)))
	else
		return IdentityCFrame
	end
end
local t = {
	__ClassName = "Boat"
}
t.__index = t
function t.Init()
	PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
end
function t.new(p1, p2)
	local t2 = {}
	setmetatable(t2, t)
	t2.Config = p1
	t2.Meta = p2
	t2.Maid = Maid.new()
	t2.maid = t2.Maid
	t2.BornAt = tick()
	t2.WaterHeight = 0
	t2.Model = p2.Model
	t2.Skeleton = t2.Model.Skeleton
	t2.PartBase = t2.Skeleton:FindFirstChild("Base")
	t2.Force = t2.PartBase.VectorForce
	t2.AlignOrientation = t2.PartBase.AlignOrientation
	t2:SetupSeats()
	local wasPopped = false
	t2.maid:GiveTask(Interval.every(0.1):Connect(function()
		local areTiresPoppped = t2:GetAreTiresPopped()
		if areTiresPoppped ~= wasPopped then
			t2.Model:FindFirstChild("Visual"):FindFirstChild("Body"):FindFirstChild("Smoke").Enabled = areTiresPoppped
		end
		wasPopped = areTiresPoppped
	end))
	return t2
end
function t.Setup(p1)
	p1.SpringForward = Spring.new(0, 0, 1, 10)
	p1.SpringAccel = Spring.new(0, 0, 1, 5)
	p1.SpringHeading = Spring.new(0, 0, 1, 20)
end
function t.SetupSeats(p1)
	assert(p1.Seats == nil)
	local t = {}
	local t2 = {}
	t2.Part = assert(p1.Model.Seat)
	t2.Driver = true
	t[1] = t2
	p1.Seats = t
end
function t.MountLocalCamera(p1, p2)
	local Player = p2.Player
	assert(Player)
	local CameraMaxZoomDistance = Player.CameraMaxZoomDistance
	p2.Maid:GiveTask(function()
		Player.CameraMaxZoomDistance = CameraMaxZoomDistance
	end)
	Player.CameraMaxZoomDistance = 120
end
function t.MountPlayer(p1, p2, p3)
	assert(p2 ~= nil)
	assert(p3 ~= nil)
	p3.Local = p2 == LocalPlayer
	p3.Character = assert(p2.Character)
	p3.Humanoid = assert(p3.Character:FindFirstChild("Humanoid"))
	p3.JointNeck = p3.Character.Head.Neck
	p3.JointWaist = p3.Character.UpperTorso.Waist
	p3.JointNeckC0 = p3.JointNeck.C0
	p3.JointWaistC0 = p3.JointWaist.C0
	p3.Maid:GiveTask(function()
		ConstraintUtils.setJointC0(p3.JointNeck, p3.JointNeckC0)
		ConstraintUtils.setJointC0(p3.JointWaist, p3.JointWaistC0)
	end)
	CharacterUtil.setHumanoidEnabled(p3.Humanoid, false)
	p3.Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
	p3.Maid:GiveTask(function()
		CharacterUtil.setHumanoidEnabled(p3.Humanoid, true)
		p3.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end)
	if p3.Driver then
		p1.AlignOrientation.Enabled = true
		p1.AlignOrientation.CFrame = p1.Model:GetPivot()
		if p3.Local then
			p1:MountLocalCamera(p3)
			p1:SetupLocalDriverInputs(p3)
		end
		p3.Maid:GiveTask(function()
			p1.AlignOrientation.Enabled = false
			if p1.ForceFront ~= nil then
				p1.ForceFront.Force = Vector3.new()
			end
		end)
		p3.SpringWaistRotation = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
		p3.SpringNeckRotation = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
		p3.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			if p1.Model ~= nil then
				p1:HeartbeatDriver(p3)
			end
		end))
	end
end
function t.UnmountSeat(p1, p2)
	assert(p2 ~= nil)
	assert(p2.Occupied == true)
	p2.Local = nil
end
function t.UpdateCharacterJoints(p1, p2)
	ConstraintUtils.setJointC0(p2.JointWaist, p2.JointWaistC0 * FromAxisAngle((p2.SpringWaistRotation:Update())))
	ConstraintUtils.setJointC0(p2.JointNeck, p2.JointNeckC0 * FromAxisAngle((p2.SpringNeckRotation:Update())))
end
local KeyCodeMap = {
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 3
}
function t.UpdateInput(p1)
	local horizontalInput = p1.WASD[1] - p1.WASD[3]
	local verticalInput = p1.WASD[2] - p1.WASD[4]
	if InputUtils.isTouch() then
		local X = PlayerModule:GetControls():GetMoveVector().X
		local clampedX = math.clamp(X, -1, 1)
		verticalInput = -clampedX * math.abs(clampedX)
	end
	p1.Forward = horizontalInput
	p1.Heading = verticalInput
	p1.SpringForwardp = p1.SpringForward:SetTarget(horizontalInput)
	p1.SpringHeadingp = p1.SpringHeading:SetTarget(verticalInput)
	p1.SpringAccelp = p1.SpringAccel:SetTarget(p1.Forward)
end
function t.UpdateThirdInput(p1)
	error("TODO: Implement")
end
function t.CalculateSway(p1)
	local elapsedTime = tick() - p1.BornAt
	local swayOffset1 = -125925.51356 + p1.BornAt
	local swayOffset2 = -51235.65816 + p1.BornAt
	local swayX = math.cos(elapsedTime * 1.1 + swayOffset1) * 0.1 * (0.5 * (1 - p1.SpringForwardp) + 0.5) + math.noise(elapsedTime, swayOffset1) * 0.05
	local forwardMagnitude = math.abs(p1.SpringForwardp)
	p1.SwayX = swayX * (1 - forwardMagnitude)
	p1.SwayY = (math.sin(elapsedTime * 0.8 + swayOffset2) * 0.4 + math.noise(elapsedTime, swayOffset2) * 0.1) * (1 - forwardMagnitude)
end
function t.GetAreTiresPopped(p1)
	local tiresPoppedAt = p1.Model:GetAttribute(BoatConsts.TIRES_POPPED_AT_ATTR_NAME) or 0
	return tiresPoppedAt + VehicleUtils.getVehicleCombatConfig(p1.Model.Name).DisableDuration > workspace:GetServerTimeNow()
end
function t.UpdatePhysics(p1)
	local areTiresPopped = p1:GetAreTiresPopped()
	local BuoyancySensor = p1.BuoyancySensor
	if not BuoyancySensor then
		local BuoyancySensor_2 = Instance.new("BuoyancySensor")
		BuoyancySensor_2.Parent = p1.PartBase
		p1.BuoyancySensor = BuoyancySensor_2
		p1.maid.sensor = BuoyancySensor_2
		BuoyancySensor = BuoyancySensor_2
	end
	local TouchingSurface = BuoyancySensor.TouchingSurface
	p1.AlignOrientation.Enabled = TouchingSurface
	local baseCFrame = p1.PartBase.CFrame
	local localVelocity = baseCFrame:VectorToObjectSpace(p1.PartBase.Velocity)
	local forceVector = Vector3.new(0, 0, -p1.SpringAccelp * if p1.SpringAccelp > 0 then p1.Config.SpeedForward else p1.Config.SpeedForward * 0.5)
	if areTiresPopped then
		forceVector = forceVector * 0.05
	end
	if not TouchingSurface then
		forceVector = forceVector * 0.25
	end
	p1.Force.Force = forceVector * p1.PartBase.AssemblyMass * 10 + -Vector3.new(localVelocity.X * 3, 0, localVelocity.Z * (p1.Config.FrictionFwd or 0.05) + localVelocity.Z * math.abs(localVelocity.Z) * 0.001) * p1.PartBase.AssemblyMass
	local rotationInput = math.clamp(-baseCFrame:VectorToObjectSpace(p1.PartBase.RotVelocity).Y / 0.5, -1, 1)
	local pitchInput = math.clamp(-localVelocity.z / 80, -1, 1) * 0.8 + p1.SpringAccelp * 0.2
	local yawAngle = math.clamp(1 - (p1.Config.TurnCurveCoeff or 1) * math.sqrt((math.clamp((math.abs(-localVelocity.Z) - 100) / 800, 0, 1))), 0.05, 1) * (p1.SpringHeadingp * math.pi * p1.Config.MaximumTurnAngle) * 0.25
	local CFrameNew = CFrame.new
	p1.AlignOrientation.CFrame = CFrameNew(Vector3.new(0, 0, 0), Vector3.new(baseCFrame.LookVector.X, 0, baseCFrame.LookVector.Z).Unit) * CFrame.Angles(0, 0, (rotationInput + p1.SwayY) * math.pi * 0.03) * CFrame.Angles((pitchInput + p1.SwayX) * math.pi * 0.02, 0, 0) * CFrame.Angles(0, yawAngle, 0) + baseCFrame.p
end
function t.HeartbeatDriver(p1, p2)
	assert(p2 ~= nil)
	if p1.Model ~= nil then
		if p2.Local then
			p1:UpdateInput()
			p1:CalculateSway()
			p1:UpdatePhysics()
		else
			p1:UpdateThirdInput()
		end
		p1:UpdateCharacterJoints(p2)
	end
end
function t.SetupLocalDriverInputs(p1, p2)
	p1.WASD = { 0, 0, 0, 0 }
	local function InputBegan(p12, p2)
		if p2 then
			return true
		end
		if p12.UserInputType == Enum.UserInputType.Keyboard and KeyCodeMap[p12.KeyCode] then
			p1.WASD[KeyCodeMap[p12.KeyCode]] = 1
		end
	end
	p2.Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
	local function InputEnded(p12, p2)
		if p2 then
			return true
		end
		if p12.UserInputType == Enum.UserInputType.Keyboard and KeyCodeMap[p12.KeyCode] then
			p1.WASD[KeyCodeMap[p12.KeyCode]] = 0
		end
	end
	p2.Maid:GiveTask(UserInputService.InputEnded:Connect(InputEnded))
	local function InputChanged(p12)
		if p12.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = p12.KeyCode
			if KeyCode == Enum.KeyCode.Thumbstick1 then
				local Position = p12.Position
				local X = Position.X
				local Y = Position.Y
				p1.WASD[2] = X < -0.24 and (-X) ^ 2 or 0
				p1.WASD[4] = X > 0.24 and X ^ 2 or 0
			elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
				local Z = p12.Position.Z
				p1.WASD[KeyCodeMap[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
			end
		end
	end
	p2.Maid:GiveTask(UserInputService.InputChanged:Connect(InputChanged))
	p2.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 1000,
		saturateTo = 0,
		image = "rbxassetid://7858765663",
		keyCodes = { Enum.KeyCode.W },
		onPressed = function()
			p1.WASD[1] = 1
		end,
		onReleased = function()
			p1.WASD[1] = 0
		end
	}))
	p2.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 700,
		saturateTo = 0,
		image = "rbxassetid://7858764373",
		keyCodes = { Enum.KeyCode.S },
		onPressed = function()
			p1.WASD[3] = 1
		end,
		onReleased = function()
			p1.WASD[3] = 0
		end
	}))
	p1:UpdateInput()
end
function t.Destroy(p1)
	p1.Maid:Destroy()
end
return t
