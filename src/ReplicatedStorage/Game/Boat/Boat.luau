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
local function calculateTotalMass(instance)
	local sum = 0
	for index, child in ipairs(instance:GetChildren()) do
		if child:IsA("BasePart") then
			sum = sum + child:GetMass()
		end
		sum = sum + calculateTotalMass(child)
	end
	return sum
end
local IdentityCFrame = CFrame.new()
local function FromAxisAngle(axisAngle)
	local x = axisAngle.x
	local y = axisAngle.y
	local z = axisAngle.z
	local magnitude = (x * x + y * y + z * z) ^ 0.5
	if magnitude > 0.00001 then
		local sinHalf = math.sin(magnitude * 0.5) / magnitude
		return CFrame.new(0, 0, 0, sinHalf * x, sinHalf * y, sinHalf * z, (math.cos(magnitude * 0.5)))
	else
		return IdentityCFrame
	end
end
local Boat = {
	__ClassName = "Boat"
}
Boat.__index = Boat
function Boat.Init()
	PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
end
function Boat.new(config, meta)
	local boat = {}
	setmetatable(boat, Boat)
	boat.Config = config
	boat.Meta = meta
	boat.Maid = Maid.new()
	boat.maid = boat.Maid
	boat.BornAt = tick()
	boat.WaterHeight = 0
	boat.Model = meta.Model
	boat.Skeleton = boat.Model.Skeleton
	boat.PartBase = boat.Skeleton:FindFirstChild("Base")
	boat.Force = boat.PartBase.VectorForce
	boat.AlignOrientation = boat.PartBase.AlignOrientation
	boat:SetupSeats()
	local wasPopped = false
	boat.maid:GiveTask(Interval.every(0.1):Connect(function()
		local areTiresPoppped = boat:GetAreTiresPopped()
		if areTiresPoppped ~= wasPopped then
			boat.Model:FindFirstChild("Visual"):FindFirstChild("Body"):FindFirstChild("Smoke").Enabled = areTiresPoppped
		end
		wasPopped = areTiresPoppped
	end))
	return boat
end
function Boat.Setup(self)
	self.SpringForward = Spring.new(0, 0, 1, 10)
	self.SpringAccel = Spring.new(0, 0, 1, 5)
	self.SpringHeading = Spring.new(0, 0, 1, 20)
end
function Boat.SetupSeats(self)
	assert(self.Seats == nil)
	local seats = {}
	local seatData = {}
	seatData.Part = assert(self.Model.Seat)
	seatData.Driver = true
	seats[1] = seatData
	self.Seats = seats
end
function Boat.MountLocalCamera(self, player)
	local Player = player.Player
	assert(Player)
	local CameraMaxZoomDistance = Player.CameraMaxZoomDistance
	player.Maid:GiveTask(function()
		Player.CameraMaxZoomDistance = CameraMaxZoomDistance
	end)
	Player.CameraMaxZoomDistance = 120
end
function Boat.MountPlayer(self, targetPlayer, seat)
	assert(targetPlayer ~= nil)
	assert(seat ~= nil)
	seat.Local = targetPlayer == LocalPlayer
	seat.Character = assert(targetPlayer.Character)
	seat.Humanoid = assert(seat.Character:FindFirstChild("Humanoid"))
	seat.JointNeck = seat.Character.Head.Neck
	seat.JointWaist = seat.Character.UpperTorso.Waist
	seat.JointNeckC0 = seat.JointNeck.C0
	seat.JointWaistC0 = seat.JointWaist.C0
	seat.Maid:GiveTask(function()
		ConstraintUtils.setJointC0(seat.JointNeck, seat.JointNeckC0)
		ConstraintUtils.setJointC0(seat.JointWaist, seat.JointWaistC0)
	end)
	CharacterUtil.setHumanoidEnabled(seat.Humanoid, false)
	seat.Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
	seat.Maid:GiveTask(function()
		CharacterUtil.setHumanoidEnabled(seat.Humanoid, true)
		seat.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end)
	if seat.Driver then
		self.AlignOrientation.Enabled = true
		self.AlignOrientation.CFrame = self.Model:GetPivot()
		if seat.Local then
			self:MountLocalCamera(seat)
			self:SetupLocalDriverInputs(seat)
		end
		seat.Maid:GiveTask(function()
			self.AlignOrientation.Enabled = false
			if self.ForceFront ~= nil then
				self.ForceFront.Force = Vector3.new()
			end
		end)
		seat.SpringWaistRotation = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
		seat.SpringNeckRotation = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
		seat.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			if self.Model ~= nil then
				self:HeartbeatDriver(seat)
			end
		end))
	end
end
function Boat.UnmountSeat(self, seat)
	assert(seat ~= nil)
	assert(seat.Occupied == true)
	seat.Local = nil
end
function Boat.UpdateCharacterJoints(self, seat)
	ConstraintUtils.setJointC0(seat.JointWaist, seat.JointWaistC0 * FromAxisAngle((seat.SpringWaistRotation:Update())))
	ConstraintUtils.setJointC0(seat.JointNeck, seat.JointNeckC0 * FromAxisAngle((seat.SpringNeckRotation:Update())))
end
local KeyCodeMap = {
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 3
}
function Boat.UpdateInput(self)
	local horizontalInput = self.WASD[1] - self.WASD[3]
	local verticalInput = self.WASD[2] - self.WASD[4]
	if InputUtils.isTouch() then
		local X = PlayerModule:GetControls():GetMoveVector().X
		local clampedX = math.clamp(X, -1, 1)
		verticalInput = -clampedX * math.abs(clampedX)
	end
	self.Forward = horizontalInput
	self.Heading = verticalInput
	self.SpringForwardp = self.SpringForward:SetTarget(horizontalInput)
	self.SpringHeadingp = self.SpringHeading:SetTarget(verticalInput)
	self.SpringAccelp = self.SpringAccel:SetTarget(self.Forward)
end
function Boat.UpdateThirdInput(self)
	error("TODO: Implement")
end
function Boat.CalculateSway(self)
	local elapsedTime = tick() - self.BornAt
	local swayOffset1 = -125925.51356 + self.BornAt
	local swayOffset2 = -51235.65816 + self.BornAt
	local swayX = math.cos(elapsedTime * 1.1 + swayOffset1) * 0.1 * (0.5 * (1 - self.SpringForwardp) + 0.5) + math.noise(elapsedTime, swayOffset1) * 0.05
	local forwardMagnitude = math.abs(self.SpringForwardp)
	self.SwayX = swayX * (1 - forwardMagnitude)
	self.SwayY = (math.sin(elapsedTime * 0.8 + swayOffset2) * 0.4 + math.noise(elapsedTime, swayOffset2) * 0.1) * (1 - forwardMagnitude)
end
function Boat.GetAreTiresPopped(self)
	local tiresPoppedAt = self.Model:GetAttribute(BoatConsts.TIRES_POPPED_AT_ATTR_NAME) or 0
	return tiresPoppedAt + VehicleUtils.getVehicleCombatConfig(self.Model.Name).DisableDuration > workspace:GetServerTimeNow()
end
function Boat.UpdatePhysics(self)
	local areTiresPopped = self:GetAreTiresPopped()
	local BuoyancySensor = self.BuoyancySensor
	if not BuoyancySensor then
		local BuoyancySensor_2 = Instance.new("BuoyancySensor")
		BuoyancySensor_2.Parent = self.PartBase
		self.BuoyancySensor = BuoyancySensor_2
		self.maid.sensor = BuoyancySensor_2
		BuoyancySensor = BuoyancySensor_2
	end
	local TouchingSurface = BuoyancySensor.TouchingSurface
	self.AlignOrientation.Enabled = TouchingSurface
	local baseCFrame = self.PartBase.CFrame
	local localVelocity = baseCFrame:VectorToObjectSpace(self.PartBase.Velocity)
	local forceVector = Vector3.new(0, 0, -self.SpringAccelp * if self.SpringAccelp > 0 then self.Config.SpeedForward else self.Config.SpeedForward * 0.5)
	if areTiresPopped then
		forceVector = forceVector * 0.05
	end
	if not TouchingSurface then
		forceVector = forceVector * 0.25
	end
	self.Force.Force = forceVector * self.PartBase.AssemblyMass * 10 + -Vector3.new(localVelocity.X * 3, 0, localVelocity.Z * (self.Config.FrictionFwd or 0.05) + localVelocity.Z * math.abs(localVelocity.Z) * 0.001) * self.PartBase.AssemblyMass
	local rotationInput = math.clamp(-baseCFrame:VectorToObjectSpace(self.PartBase.RotVelocity).Y / 0.5, -1, 1)
	local pitchInput = math.clamp(-localVelocity.z / 80, -1, 1) * 0.8 + self.SpringAccelp * 0.2
	local yawAngle = math.clamp(1 - (self.Config.TurnCurveCoeff or 1) * math.sqrt((math.clamp((math.abs(-localVelocity.Z) - 100) / 800, 0, 1))), 0.05, 1) * (self.SpringHeadingp * math.pi * self.Config.MaximumTurnAngle) * 0.25
	local CFrameNew = CFrame.new
	self.AlignOrientation.CFrame = CFrameNew(Vector3.new(0, 0, 0), Vector3.new(baseCFrame.LookVector.X, 0, baseCFrame.LookVector.Z).Unit) * CFrame.Angles(0, 0, (rotationInput + self.SwayY) * math.pi * 0.03) * CFrame.Angles((pitchInput + self.SwayX) * math.pi * 0.02, 0, 0) * CFrame.Angles(0, yawAngle, 0) + baseCFrame.p
end
function Boat.HeartbeatDriver(self, seat)
	assert(seat ~= nil)
	if self.Model ~= nil then
		if seat.Local then
			self:UpdateInput()
			self:CalculateSway()
			self:UpdatePhysics()
		else
			self:UpdateThirdInput()
		end
		self:UpdateCharacterJoints(seat)
	end
end
function Boat.SetupLocalDriverInputs(self, seat)
	self.WASD = { 0, 0, 0, 0 }
	local function InputBegan(inputObject, gameProcessedEvent)
		if gameProcessedEvent then
			return true
		end
		if inputObject.UserInputType == Enum.UserInputType.Keyboard and KeyCodeMap[inputObject.KeyCode] then
			self.WASD[KeyCodeMap[inputObject.KeyCode]] = 1
		end
	end
	seat.Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
	local function InputEnded(inputObject, gameProcessedEvent)
		if gameProcessedEvent then
			return true
		end
		if inputObject.UserInputType == Enum.UserInputType.Keyboard and KeyCodeMap[inputObject.KeyCode] then
			self.WASD[KeyCodeMap[inputObject.KeyCode]] = 0
		end
	end
	seat.Maid:GiveTask(UserInputService.InputEnded:Connect(InputEnded))
	local function InputChanged(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = inputObject.KeyCode
			if KeyCode == Enum.KeyCode.Thumbstick1 then
				local Position = inputObject.Position
				local X = Position.X
				local Y = Position.Y
				self.WASD[2] = X < -0.24 and (-X) ^ 2 or 0
				self.WASD[4] = X > 0.24 and X ^ 2 or 0
			elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
				local Z = inputObject.Position.Z
				self.WASD[KeyCodeMap[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
			end
		end
	end
	seat.Maid:GiveTask(UserInputService.InputChanged:Connect(InputChanged))
	seat.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 1000,
		saturateTo = 0,
		image = "rbxassetid://7858765663",
		keyCodes = { Enum.KeyCode.W },
		onPressed = function()
			self.WASD[1] = 1
		end,
		onReleased = function()
			self.WASD[1] = 0
		end
	}))
	seat.Maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 700,
		saturateTo = 0,
		image = "rbxassetid://7858764373",
		keyCodes = { Enum.KeyCode.S },
		onPressed = function()
			self.WASD[3] = 1
		end,
		onReleased = function()
			self.WASD[3] = 0
		end
	}))
	self:UpdateInput()
end
function Boat.Destroy(self)
	self.Maid:Destroy()
end
return Boat
