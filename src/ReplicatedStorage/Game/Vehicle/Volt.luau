local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local Audio = require(ReplicatedStorage.Std.Audio)
local Time = require(ReplicatedStorage.Module.Time)
local C4Binder = require(ReplicatedStorage.Game.C4.C4Binder)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local WheelWorld = require(ReplicatedStorage.Module.Wheel.WheelWorld)
local Wheel = require(ReplicatedStorage.Module.Wheel.Wheel)
game:GetService("UserInputService")
local Players = game:GetService("Players")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local LocalPlayer = Players.LocalPlayer
local eventManager = nil
local eventManagerEmitter = nil
local soundIdMap = {
	tire_pop = 4534995816,
	tire_leak = 17871250897,
	tire_respawn = 77257382359638
}
local inputStateArray = { 0, 0, 0, 0, 0, 0 }
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
local function SetHumanoidEnabled(character, enabled)
	local instance = next
	local instance2, module3 = Enum.HumanoidStateType:GetEnumItems()
	for i, humanoidState in instance, instance2, module3 do
		if humanoidState ~= Enum.HumanoidStateType.Dead and (humanoidState ~= Enum.HumanoidStateType.None and humanoidState ~= Enum.HumanoidStateType.Jumping) then
			character.Humanoid:SetStateEnabled(humanoidState, enabled)
		end
	end
end
local function calculateTotalMass(vehicle)
	local sum = 0
	for i, part in ipairs(vehicle:GetChildren()) do
		if part:IsA("BasePart") then
			local partMass = part:GetMass()
			if part.CustomPhysicalProperties then
				local Density = part.CustomPhysicalProperties.Density
				if Density ~= Density then
					Density = 0
				end
				partMass = partMass * Density
			end
			sum = sum + partMass
		end
		sum = sum + calculateTotalMass(part)
	end
	return sum
end
local lastUpdateTime = os.clock()
local function VehicleEnter(vehicle)
	inputStateArray = { 0, 0, 0, 0, 0, 0 }
	lastUpdateTime = os.clock()
	local Character = LocalPlayer.Character
	SetHumanoidEnabled(Character, false)
	Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	vehicle.Rotate.MaxTorque = Vector3.new(0, 10000000, 10000000)
	vehicle.fv = Vector3.new()
	vehicle.hv = 0
	vehicle.Mass = calculateTotalMass(vehicle.Model)
	vehicle._defaultForwardFriction = 0.01
	local wheelWorld = WheelWorld.new()
	wheelWorld:SetModel(vehicle.Model)
	local frontWheel = Wheel.new(vehicle.Model.SuspensionFront)
	frontWheel:SetSpringConstants(2, 4)
	frontWheel:SetVisualRadius(1)
	frontWheel:SetForwardFriction(vehicle._defaultForwardFriction)
	frontWheel:SetForwardFriction2(0)
	frontWheel:SetHorizontalFriction(0)
	frontWheel:SetSuspensionHeight(6.5)
	wheelWorld:AddWheel(frontWheel)
	local backWheel = Wheel.new(vehicle.Model.SuspensionBack)
	backWheel:SetSpringConstants(2, 4)
	backWheel:SetVisualRadius(1)
	backWheel:SetForwardFriction(vehicle._defaultForwardFriction)
	backWheel:SetForwardFriction2(0.001)
	backWheel:SetHorizontalFriction(0)
	backWheel:SetSuspensionHeight(6.5)
	wheelWorld:AddWheel(backWheel)
	vehicle.WheelWorld = wheelWorld
	function vehicle.setForward(isPressed)
		inputStateArray[1] = if isPressed then 1 else 0
	end
	function vehicle.setBackward(isPressed)
		inputStateArray[3] = if isPressed then 1 else 0
	end
end
local function VehicleLeave(vehicle)
	local Character = LocalPlayer.Character
	if Character and Character:FindFirstChild("Humanoid") then
		SetHumanoidEnabled(Character, true)
	end
	vehicle.Rotate.MaxTorque = Vector3.new()
	vehicle.Force.Force = Vector3.new()
	vehicle.WheelWorld:Destroy()
	vehicle.WheelWorld = nil
	CurrentCamera.FieldOfView = 70
	inputStateArray = { 0, 0, 0, 0, 0, 0 }
end
local origin = Vector3.new()
os.clock()
local function Update(vehicle)
	local currentTime = os.clock()
	local deltaTime = currentTime - lastUpdateTime
	lastUpdateTime = currentTime
	local verticalInput = inputStateArray[1] - inputStateArray[3]
	local horizontalInput = inputStateArray[2] - inputStateArray[4]
	if InputUtils.isTouch() then
		local Character = LocalPlayer.Character
		if Character and Character:FindFirstChild("Humanoid") then
			local X = GetMoveVector().X
			local clampedX = math.clamp(X, -1, 1)
			horizontalInput = -clampedX * math.abs(clampedX)
		end
	end
	local Model = vehicle.Model
	local Engine = Model:FindFirstChild("Engine")
	if Engine then
		local BoundingBox = Model.BoundingBox
		local ignoreList = {}
		for _, c4Object in C4Binder:GetAll() do
			table.insert(ignoreList, c4Object.obj)
		end
		ignoreList[#ignoreList + 1] = Model
		ignoreList[#ignoreList + 1] = LocalPlayer.Character
		for i, wheel in ipairs(vehicle.WheelWorld.Wheels) do
			wheel.IgnoreModel = ignoreList
			wheel:Update(deltaTime, 0)
		end
		local lastTirePopTime = Model:GetAttribute("VehicleTiresLastPop") or 0
		local areTiresPoppedNow = math.min((Time.GetNowSync() - lastTirePopTime) / vehicle.DisableDuration, 1) < 0.999
		if areTiresPoppedNow then
			verticalInput = 0
		end
		if vehicle.AreTiresPopped ~= areTiresPoppedNow then
			local audioConfig = {
				Volume = 1
			}
			if vehicle.AreTiresPopped == nil or not areTiresPoppedNow then
				if vehicle.AreTiresPopped ~= nil and areTiresPoppedNow ~= nil then
					Audio.ObjectLocal(Engine, soundIdMap.tire_respawn, audioConfig)
				end
			else
				Audio.ObjectLocal(Engine, soundIdMap.tire_pop, audioConfig)
				Audio.ObjectLocal(Engine, soundIdMap.tire_leak, audioConfig)
			end
			for i, wheel in ipairs(vehicle.WheelWorld.Wheels) do
				local frictionMultiplier
				frictionMultiplier = if areTiresPoppedNow then 50 else 1
				wheel:SetForwardFriction(vehicle._defaultForwardFriction * frictionMultiplier)
			end
			vehicle.AreTiresPopped = areTiresPoppedNow
		end
		if vehicle.LockMovement then
			horizontalInput = 0
			verticalInput = 0
		end
		local velocityDot = Engine.Velocity:Dot(Engine.CFrame.LookVector)
		local wheelRotation = velocityDot * deltaTime / 1.7035
		vehicle.FrontWheelMotor.C1 = vehicle.FrontWheelMotor.C1 * vehicle.FrontWheelMotor.C0:Inverse() * CFrame.Angles(-wheelRotation, 0, 0) * vehicle.FrontWheelMotor.C0
		vehicle.BackWheelMotor.C1 = vehicle.BackWheelMotor.C1 * vehicle.BackWheelMotor.C0:Inverse() * CFrame.Angles(-wheelRotation, 0, 0) * vehicle.BackWheelMotor.C0
		local speedFraction = velocityDot / 200
		if speedFraction ~= speedFraction then
			speedFraction = 0
		end
		local clampedSpeedFraction = math.clamp(speedFraction, 0, 3)
		local cameraShakeIntensity, cameraShakeFallback
		if clampedSpeedFraction < 0.825155 then
			cameraShakeIntensity = clampedSpeedFraction * clampedSpeedFraction * clampedSpeedFraction
			if not cameraShakeIntensity then
				cameraShakeFallback = clampedSpeedFraction
				cameraShakeIntensity = 1 - math.exp(-clampedSpeedFraction)
			end
		else
			cameraShakeFallback = clampedSpeedFraction
			cameraShakeIntensity = 1 - math.exp(-clampedSpeedFraction)
		end
		local FieldOfView = CurrentCamera.FieldOfView
		CurrentCamera.FieldOfView = FieldOfView + (cameraShakeIntensity * 30 + 70 - FieldOfView) * 0.7
		local Magnitude = Engine.Velocity.Magnitude
		local thrustForce = 145
		if verticalInput < 0 then
			thrustForce = thrustForce * if velocityDot > 0 then 0.5 else 0.15
		end
		local totalForce = Engine.CFrame.LookVector * verticalInput * Engine.AssemblyMass * thrustForce
		if vehicle.Nitro then
			totalForce = totalForce + Engine.CFrame.LookVector * Engine.AssemblyMass * 50
		end
		if not RayCast.RayIgnoreNonCollideWithIgnoreList(BoundingBox.CFrame * Vector3.new(0, -BoundingBox.Size.Y * 0.5, 0), Vector3.new(0, -1, 0), 10, ignoreList) then
			totalForce = origin
		end
		vehicle.Force.Force = totalForce - math.min(50, Engine.Velocity:Dot(Engine.CFrame.RightVector)) * 10 * Engine.CFrame.RightVector * Engine.AssemblyMass
		local hv = vehicle.hv
		local horizontalVelocitySmoothed = hv + (horizontalInput - hv) * 0.1
		local horizontalVelocityFinal = if horizontalInput * horizontalInput <= 0.01 then horizontalVelocitySmoothed * 0.9 else horizontalVelocitySmoothed * 0.99
		vehicle.hv = horizontalVelocityFinal
		local rollDirection = if Engine.Velocity:Dot(Engine.CFrame.LookVector) < -5 then -1 else 1
		vehicle.Rotate.CFrame = CFrame.new(origin, Engine.CFrame.LookVector) * CFrame.Angles(0, 0.5 * horizontalVelocityFinal * rollDirection, 0.8 * horizontalVelocityFinal * rollDirection)
	end
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
local function InputBegan(inputEvent)
	if inputEvent.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = inputEvent.KeyCode
		if keyCodeToInputIndexMap[KeyCode] then
			inputStateArray[keyCodeToInputIndexMap[KeyCode]] = 1
		end
	end
end
local function InputEnded(inputEvent)
	if inputEvent.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = inputEvent.KeyCode
		if keyCodeToInputIndexMap[KeyCode] then
			inputStateArray[keyCodeToInputIndexMap[KeyCode]] = 0
		end
	elseif inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = inputEvent.KeyCode
		if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			inputStateArray[keyCodeToInputIndexMap[KeyCode]] = 0
		end
	end
end
local function InputChanged(inputEvent, p2)
	if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = inputEvent.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = inputEvent.Position
			local X = Position.X
			local Y = Position.Y
			inputStateArray[2] = X < -0.24 and (-X) ^ 2 or 0
			inputStateArray[4] = X > 0.24 and X ^ 2 or 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = inputEvent.Position.Z
			inputStateArray[keyCodeToInputIndexMap[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
		end
	end
end
return {
	Init = function(p1)
		eventManager = p1.Event
		eventManagerEmitter = p1.em
	end,
	VehicleEnter = VehicleEnter,
	VehicleLeave = VehicleLeave,
	InputBegan = InputBegan,
	InputEnded = InputEnded,
	InputChanged = InputChanged,
	Update = Update
}
