local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local PlayerModule = nil
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local Audio = require(ReplicatedStorage.Std.Audio)
local WheelWorld = require(ReplicatedStorage.Module.Wheel.WheelWorld)
local Wheel = require(ReplicatedStorage.Module.Wheel.Wheel)
local WheelLQ = require(ReplicatedStorage.Module.Wheel.WheelLQ)
local CharacterAnim = require(ReplicatedStorage.Game.CharacterAnim)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local DoorConsts = require(ReplicatedStorage.Door2.DoorConsts)
local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local rng = Random.new()
local abs = math.abs
local function RandomVector(magnitude)
	local x = magnitude * (rng:NextNumber() * 2 - 1)
	local y = magnitude * (rng:NextNumber() * 2 - 1)
	return Vector3.new(x, y, magnitude * (rng:NextNumber() * 2 - 1))
end
local function SetHumanoidEnabled(humanoid, enabled)
	local iterNext = next
	local enumItems, startKey = Enum.HumanoidStateType:GetEnumItems()
	for _, stateType in iterNext, enumItems, startKey do
		if stateType ~= Enum.HumanoidStateType.Dead and (stateType ~= Enum.HumanoidStateType.None and stateType ~= Enum.HumanoidStateType.Jumping) then
			humanoid:SetStateEnabled(stateType, enabled)
		end
	end
end
local t = {
	__ClassName = "BaseUserControlledPlane"
}
t.__index = t
function t.Init()
	PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
end
function t.new(planeData, constOverrides)
	local self = setmetatable({}, t)
	self.Id = planeData.Id
	assert(self.Id)
	self.Mass = planeData.Mass
	self.Maid = Maid.new()
	self.Model = planeData.Model
	local Wing = self.Model.Skeleton.Wing
	local Thrust = self.Model.Skeleton.Thrust
	self.PartBoundingBox = self.Model.BoundingBox
	self.PartWing = Wing
	self.WingVectorForce = Wing.VectorForce
	self.WingAngularVelocity = Wing.AngularVelocity
	self.PartThrust = Thrust
	self.ThrustVectorForce = Thrust.VectorForce
	self.AreaWing = Wing.Size.X * Wing.Size.Z
	self.Seats = {}
	self:SetupSeats()
	self.CorrectingRoll = false
	self.CorrectingRollFlag = false
	self.OnTakeoff = nil
	self.OnLanding = nil
	local consts = {
		GRAVITY = 196.20000000000002,
		ANGULAR_MAXTORQUE_FLYING = 100000000,
		ANGULAR_MAXTORQUE_LANDING = 1000,
		COEFFICIENT_DRAG = 0.8,
		ROLL_ADJUSTMENT_TIMER = 0.1,
		JOYSTICK_RECENTER_MULTIPLIER = 0.95,
		MAX_THRUST = 700,
		CAMERA_SHAKE_MIN_GS = 1.5,
		CAMERA_SHAKE_COEFF_GS = 1,
		CAMERA_OFFSET_CF = CFrame.new(0, 8, 25),
		SOUND_RUMBLE_COEFF_GS = 1/3,
		SOUND_BREATHING_MIN_GS = 1,
		SOUND_BREATHING_TIMER = 2,
		SOUND_BREATHING_DURATION = 3,
		SUSPENSION_HEIGHT_FRONT = 5,
		SUSPENSION_HEIGHT_BACK = 4,
		WHEEL_VISUAL_RADIUS_FRONT = 0.83,
		WHEEL_VISUAL_RADIUS_BACK = 0.83,
		THROTTLE_WHEEL_TURN_MIN = 0.2,
		THROTTLE_TAKEOFF = 0.4,
		HEIGHT_MAX = 5000
	}
	if constOverrides then
		for key, value in next, constOverrides do
			assert(consts[key], key)
			consts[key] = value
		end
	end
	self.CONST = consts
	self.Joystickx = 0
	self.Joysticky = 0
	self.InputYaw = 0
	self.Throttle = 0
	self._controlsEnabled = true
	return self
end
function t.SetupSeats(self)
	table.insert(self.Seats, {
		Part = self.Model:FindFirstChild("Seat"),
		Driver = true
	})
end
function t.SetParticlesEnabled(self, enabled)
	if self.Model then
		local Particles = self.Model:FindFirstChild("Particles")
		if Particles then
			local iterNext = next
			local children, startKey = Particles:GetChildren()
			for _, particleFolder in iterNext, children, startKey do
				particleFolder:FindFirstChildOfClass("ParticleEmitter").Enabled = enabled
			end
		end
	end
end
local function MountLocalPlayer(plane, seatInfo)
	local sitTrack = CharacterAnim.getCarSitTrack()
	sitTrack:Play()
	seatInfo.Maid:GiveTask(function()
		sitTrack:Stop()
	end)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			SetHumanoidEnabled(Humanoid, false)
			Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
		end
	end
	if seatInfo.Driver then
		local cameraOffsetSpring = Spring.new(Vector3.new(), Vector3.new(), 0.8, 30)
		local cameraAngleSpring = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
		local gearSpring = Spring.new(0, 0, 0.6, 5)
		local yawSpring = Spring.new(0, 0, 0.7, 5)
		local rollSpring = Spring.new(0, 0, 0.95, 15)
		seatInfo.CameraSpring = cameraOffsetSpring
		local planeGui = ReplicatedStorage.Resource.Plane.PlaneGui:Clone()
		planeGui.Parent = LocalPlayer.PlayerGui
		plane.PlaneGui = planeGui
		local soundRumble = Audio.ObjectLocal(planeGui, 3378049562, {
			Looped = true,
			Volume = 0,
			Pitch = 1
		})
		plane.SoundRumble = soundRumble
		local soundWind = Audio.ObjectLocal(planeGui, 3378078999, {
			Looped = true,
			Volume = 1.25
		})
		plane.SoundWind = soundWind
		local soundBreathing = Audio.ObjectLocal(planeGui, 9058670257, {
			Looped = true,
			Volume = 0
		})
		plane.SoundBreathing = soundBreathing
		local breathingVolumeDuration = 0
		local breathingActiveTimer = 0
		local throttleInputs = { 0, 0, 0, 0 }
		local joystickLastActiveTime = tick()
		local joystickRecenterEnabled = true
		local rollInput = 0
		local pitchInput = 0
		local prevVelocity = Vector3.new()
		local breathingAccumulator = 0
		local function updatePlaneHealth()
			if VehicleUtils.getTireHealth(plane.Model) <= 0 then
				breathingActiveTimer = 0
			end
		end
		if VehicleUtils.getTireHealth(plane.Model) <= 0 then
			breathingActiveTimer = 0
		end
		seatInfo.Maid:GiveTask(VehicleUtils.getTireHealthChangedSignal(plane.Model):Connect(updatePlaneHealth))
		plane.IsFlying = false
		local isCameraFlying = false
		local cameraObjectSpace = nil
		local function RunTakeoff()
			plane.IsFlying = true
			plane.Model:FindFirstChild("SetIsFlyingRemote"):FireServer(plane.IsFlying)
			if plane.OnTakeoff then
				plane.OnTakeoff()
			end
			Audio.ObjectLocal(planeGui, 3382610090)
			for _, wheelConf in next, plane.WheelsConf do
				wheelConf.Wheel:Clear()
				wheelConf.Motor.C0 = CFrame.new()
			end
			gearSpring:SetTarget(1)
			plane.WingAngularVelocity.MaxTorque = plane.CONST.ANGULAR_MAXTORQUE_FLYING
			planeGui.Controls.Mouse.Visible = true
			planeGui.Controls.Altitude.Visible = true
			plane:SetParticlesEnabled(true)
		end
		local function RunLanding()
			if plane.IsFlying then
				Audio.ObjectLocal(planeGui, 3382610090)
			end
			plane.IsFlying = false
			plane.Model:FindFirstChild("SetIsFlyingRemote"):FireServer(plane.IsFlying)
			if plane.OnLanding then
				plane.OnLanding()
			end
			gearSpring:SetTarget(0)
			plane.WingAngularVelocity.MaxTorque = plane.CONST.ANGULAR_MAXTORQUE_LANDING
			planeGui.Controls.Mouse.Visible = false
			planeGui.Controls.Altitude.Visible = false
			plane:SetParticlesEnabled(false)
		end
		local function HeartbeatWing(dt)
			local PartWing = plane.PartWing
			local wingCFrame = PartWing.CFrame
			local pitch = math.asin(wingCFrame.LookVector.Y)
			if pitch ~= pitch then
				pitch = 0
			end
			local roll = math.asin(wingCFrame.RightVector.Y)
			if roll ~= roll then
				roll = 0
			end
			plane.ObservedPitch = pitch
			plane.ObservedRoll = roll
			local Velocity = PartWing.Velocity
			local speedSq = Velocity:Dot(Velocity)
			plane.WingVectorForce.Force = if speedSq > 0.001 then (plane.IsFlying and plane.CONST.COEFFICIENT_DRAG or 0.1) * 0.5 * speedSq * plane.AreaWing * -Velocity.Unit + (plane.IsFlying and math.cos(pitch) * 0.95 or 0.1) * plane.CONST.GRAVITY * plane.Mass * Vector3.new(0, 1, 0) else Vector3.new(0, 0, 0)
			local rollSpringValue = rollSpring:Update()
			plane.WingAngularVelocity.AngularVelocity = Vector3.new(rollInput * 3 * (1 + -0.9 * rollSpringValue), if plane.IsFlying then plane.InputYaw * 0.5 else 0, pitchInput * 2.5 * (1 + 2 * rollSpringValue))
			plane.ObservedAcceleration = ((Velocity - prevVelocity) / dt).Magnitude
			prevVelocity = Velocity
		end
		local heightLimitStartTime = 0
		local function HeartbeatThrust(dt)
			local thrustCFrame = plane.PartThrust.CFrame
			local throttleValue
			local now = tick()
			if thrustCFrame.Y > plane.CONST.HEIGHT_MAX then
				throttleValue = 0
				heightLimitStartTime = now
			end
			if now - heightLimitStartTime < 5 then
				throttleValue = 0
			end
			plane.ThrustVectorForce.Force = thrustCFrame.LookVector * plane.Mass * (throttleValue * plane.CONST.MAX_THRUST)
		end
		local function HeartbeatSounds(dt)
			local gForce = plane.ObservedAcceleration / plane.CONST.GRAVITY
			if plane.IsFlying == false then
				gForce = 0
			end
			local rumbleLevel = 1 - math.exp(-gForce * plane.CONST.SOUND_RUMBLE_COEFF_GS)
			soundRumble.Volume = rumbleLevel * 2
			soundWind.Volume = (1.25 - rumbleLevel * 0.2) * (0.2 + 0.8 * gearSpring:Update())
			breathingAccumulator = if plane.CONST.SOUND_BREATHING_MIN_GS < gForce then breathingAccumulator + dt else 0
			if breathingAccumulator > plane.CONST.SOUND_BREATHING_TIMER then
				breathingVolumeDuration = plane.CONST.SOUND_BREATHING_DURATION
			end
			breathingVolumeDuration = breathingVolumeDuration - dt
			if breathingVolumeDuration > 0 then
				soundBreathing.Volume = (1 - math.exp(-breathingVolumeDuration)) * 0.4
			end
		end
		local function HeartbeatWheels(dt)
			if plane.IsFlying == false then
				local steerAngle = yawSpring:Update()
				for _, wheelConf in next, plane.WheelsConf do
					local turnAngle
					turnAngle = wheelConf.Front and breathingActiveTimer < plane.CONST.THROTTLE_WHEEL_TURN_MIN and steerAngle * math.pi * 0.2 or 0
					local suspensionOffset, rotationAngle = wheelConf.Wheel:Update(dt, turnAngle)
					if wheelConf.DoorModel and wheelConf.DoorModel:GetAttribute(DoorConsts.OPEN_ATTR_NAME) == true then
						rotationAngle = 0
						suspensionOffset = 0
					end
					wheelConf.Motor.C0 = CFrame.Angles(-rotationAngle, -turnAngle, 0) * CFrame.new(0, -suspensionOffset, 0)
					wheelConf.MotorArm.C1 = CFrame.new(0, suspensionOffset, 0) * CFrame.Angles(0, turnAngle, 0) * wheelConf.ArmOffset
				end
			end
		end
		local prevThrottle = breathingActiveTimer
		local throttleIdleTime = tick()
		local function HeartbeatControls(dt)
			local now = tick()
			local throttleDelta = throttleInputs[1] - throttleInputs[3]
			if VehicleUtils.getTireHealth(plane.Model) <= 0 then
				throttleDelta = 0
			end
			local yawValue
			if InputUtils.isTouch() then
				local moveVec = PlayerModule:GetControls():GetMoveVector()
				if moveVec.Magnitude > 1 then
					moveVec = moveVec.Unit
				end
				local steerX = -moveVec.X
				rollInput = steerX
				pitchInput = -moveVec.Z
				yawValue = yawSpring:SetTarget(steerX)
			else
				yawValue = yawSpring:Update()
			end
			if throttleDelta > 0 then
				breathingActiveTimer = breathingActiveTimer + dt * 0.2
				throttleIdleTime = now
			elseif throttleDelta < 0 then
				breathingActiveTimer = breathingActiveTimer - dt * 0.2
				throttleIdleTime = now
			end
			if now - throttleIdleTime > 1 and (not (breathingActiveTimer > plane.CONST.THROTTLE_TAKEOFF) and breathingActiveTimer > 0.15) then
				breathingActiveTimer = breathingActiveTimer - dt * 0.1
			end
			if breathingActiveTimer < -1/15 then
				breathingActiveTimer = -1/15
			end
			if breathingActiveTimer > 1 then
				breathingActiveTimer = 1
			end
			if prevThrottle < plane.CONST.THROTTLE_TAKEOFF and breathingActiveTimer >= plane.CONST.THROTTLE_TAKEOFF then
				RunTakeoff()
			elseif prevThrottle > plane.CONST.THROTTLE_TAKEOFF and breathingActiveTimer <= plane.CONST.THROTTLE_TAKEOFF then
				RunLanding()
			end
			prevThrottle = breathingActiveTimer
			local timeSinceJoystickActive = now - joystickLastActiveTime
			if plane.CONST.ROLL_ADJUSTMENT_TIMER < timeSinceJoystickActive then
				rollInput = rollInput + -plane.ObservedRoll * 0.1 * (1 - math.exp(-(timeSinceJoystickActive - plane.CONST.ROLL_ADJUSTMENT_TIMER)))
			end
			if joystickRecenterEnabled then
				rollInput = rollInput * plane.CONST.JOYSTICK_RECENTER_MULTIPLIER
				pitchInput = pitchInput * plane.CONST.JOYSTICK_RECENTER_MULTIPLIER
			end
			if rollInput < -1 then
				rollInput = -1
			end
			if rollInput > 1 then
				rollInput = 1
			end
			if pitchInput < -1 then
				pitchInput = -1
			end
			if pitchInput > 1 then
				pitchInput = 1
			end
			if yawValue < -1 then
				yawValue = -1
			end
			if yawValue > 1 then
				yawValue = 1
			end
			plane.Joystickx = rollInput
			plane.Joysticky = pitchInput
			plane.InputYaw = yawValue
			plane.Throttle = breathingActiveTimer
		end
		local function HeartbeatUI(dt)
			local normRoll = rollInput
			local normPitch = pitchInput
			local len = (normRoll * normRoll + normPitch * normPitch) ^ 0.5
			if len > 1 then
				normRoll = normRoll / len
				normPitch = normPitch / len
			end
			planeGui.Controls.Mouse.Dot.Position = UDim2.new(-(normRoll * 0.9) * 0.5 + 0.5, 0, -(normPitch * 0.9) * 0.5 + 0.5, 0)
			planeGui.Controls.Altitude.Text = ("%04d"):format(plane.PartWing.Position.Y)
			planeGui.Controls.Throttle.Value.Size = UDim2.new(1, 0, breathingActiveTimer, 0)
			planeGui.Controls.Throttle.Value.Position = UDim2.new(0, 0, 1 - breathingActiveTimer, 0)
		end
		local function Heartbeat(dt)
			HeartbeatControls(dt)
			HeartbeatWing(dt)
			HeartbeatThrust(dt)
			HeartbeatSounds(dt)
			HeartbeatWheels(dt)
			HeartbeatUI(dt)
		end
		seatInfo.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
		local currentFov = 70
		local function RenderSteppedCamera(dt)
			local gearLevel = gearSpring:Update()
			if plane.IsFlying then
				if not isCameraFlying then
					isCameraFlying = true
					cameraObjectSpace = plane.PartWing.CFrame:toObjectSpace(CurrentCamera.CFrame)
					CurrentCamera.CameraType = Enum.CameraType.Scriptable
				end
			elseif isCameraFlying and gearLevel < 0.001 then
				isCameraFlying = false
				CurrentCamera.CameraType = Enum.CameraType.Custom
				CurrentCamera.CFrame = plane.PartWing.CFrame * cameraObjectSpace
			end
			local shouldShowMouse = not plane.IsFlying or not plane._controlsEnabled
			UserInputService.MouseIconEnabled = shouldShowMouse
			if shouldShowMouse then
				if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end
			elseif UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			end
			local targetFov
			if isCameraFlying then
				targetFov = math.clamp((plane.PartWing.Velocity:Dot(plane.PartWing.CFrame.LookVector) - 50) / 300, 0, 1) * 20 + 70
				local joystickOffset = Vector3.new(rollInput * -2, pitchInput * 2, 0)
				local camOffset = cameraOffsetSpring:SetTarget(joystickOffset)
				local camAngle = cameraAngleSpring:SetTarget(joystickOffset)
				local wingCFrame = plane.PartWing.CFrame
				local savedCameraSpace = cameraObjectSpace
				local targetCF = plane.CONST.CAMERA_OFFSET_CF * CFrame.new(camOffset) * CFrame.Angles(-camAngle.y * 0.02, camAngle.x * 0.02, 0)
				if not plane.Model:GetAttribute("IsCameraLocked") then
					CurrentCamera.CFrame = wingCFrame * savedCameraSpace:Lerp(targetCF, gearLevel)
				end
				local gForce = plane.ObservedAcceleration / plane.CONST.GRAVITY
				if plane.CONST.CAMERA_SHAKE_MIN_GS < gForce then
					local shakeIntensity = (1 - math.exp(-(gForce - plane.CONST.CAMERA_SHAKE_MIN_GS) * plane.CONST.CAMERA_SHAKE_COEFF_GS)) * 15
					cameraOffsetSpring:Accelerate((Vector3.new(shakeIntensity * (rng:NextNumber() * 2 - 1), shakeIntensity * (rng:NextNumber() * 2 - 1), shakeIntensity * (rng:NextNumber() * 2 - 1))))
				end
			else
				targetFov = 70
			end
			currentFov = currentFov + (targetFov - currentFov) * 0.7
			CurrentCamera.FieldOfView = currentFov
		end
		local function RenderStepped(dt)
			RenderSteppedCamera(dt)
		end
		seatInfo.Maid:GiveTask(RunService.RenderStepped:Connect(RenderStepped))
		local keyToThrottleSlot = {
			[Enum.KeyCode.A] = 2,
			[Enum.KeyCode.D] = 4,
			[Enum.KeyCode.ButtonR2] = 1,
			[Enum.KeyCode.ButtonL2] = 3
		}
		local function InputBegan(input, gameProcessed)
			if gameProcessed then
				return false
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.Q then
					rollSpring:SetTarget(1)
				elseif input.KeyCode == Enum.KeyCode.LeftShift then
					for _, wheelConf in next, plane.WheelsConf do
						if not wheelConf.Front then
							wheelConf.Wheel:SetForwardFriction(3)
						end
					end
				end
			end
			if keyToThrottleSlot[input.KeyCode] then
				throttleInputs[keyToThrottleSlot[input.KeyCode]] = 1
				yawSpring:SetTarget(throttleInputs[2] - throttleInputs[4])
			end
		end
		seatInfo.Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
		local function InputEnded(input, gameProcessed)
			if gameProcessed then
				return false
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.Q then
					rollSpring:SetTarget(0)
				elseif input.KeyCode == Enum.KeyCode.LeftShift then
					for _, wheelConf in next, plane.WheelsConf do
						wheelConf.Wheel:SetForwardFriction(0.02)
					end
				end
			end
			if keyToThrottleSlot[input.KeyCode] then
				throttleInputs[keyToThrottleSlot[input.KeyCode]] = 0
				yawSpring:SetTarget(throttleInputs[2] - throttleInputs[4])
			end
		end
		seatInfo.Maid:GiveTask(UserInputService.InputEnded:Connect(InputEnded))
		local joystick1Spring = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
		local function InputChanged(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				rollInput = rollInput - input.Delta.X * 0.015
				pitchInput = pitchInput - input.Delta.Y * 0.015
				joystickLastActiveTime = tick()
				joystickRecenterEnabled = true
			elseif input.UserInputType == Enum.UserInputType.Gamepad1 then
				local KeyCode = input.KeyCode
				if KeyCode == Enum.KeyCode.Thumbstick1 then
					local function isJoyStickActive()
						local smoothed = joystick1Spring:SetTarget(input.Position)
						local X = smoothed.X
						local Y = smoothed.Y
						return abs(X) > 0.24 or abs(Y) > 0.24, X, Y
					end
					local smoothed1 = joystick1Spring:SetTarget(input.Position)
					if if abs(smoothed1.X) > 0.24 then true else abs(smoothed1.Y) > 0.24 and not seatInfo.Maid.joystickActiveThread then
						local function update()
							local smoothed = joystick1Spring:SetTarget(input.Position)
							local X = smoothed.X
							local Y = smoothed.Y
							local isActive = abs(X) > 0.24 or abs(Y) > 0.24
							if not isActive then
								seatInfo.Maid.joystickActiveThread = nil
							end
							joystickLastActiveTime = tick()
							joystickRecenterEnabled = not isActive
							local newRoll, newPitch
							if abs(X) > 0.24 then
								newRoll = -X * abs(X)
								newPitch = Y
							else
								newRoll = 0
								newPitch = Y
							end
							rollInput = newRoll
							pitchInput = if abs(newPitch) > 0.24 then newPitch * abs(newPitch) else 0
						end
						update()
						seatInfo.Maid.joystickActiveThread = RunService.Heartbeat:Connect(update)
					end
				elseif KeyCode == Enum.KeyCode.Thumbstick2 then
					local function isJoyStick2Active()
						local X = input.Position.X
						return abs(X) > 0.24, X
					end
					if abs(input.Position.X) > 0.24 and not seatInfo.Maid.joystickActiveThread then
						local function update()
							local X = input.Position.X
							if not (abs(X) > 0.24) then
								seatInfo.Maid.joystick2ActiveThread = nil
							end
							yawSpring:SetTarget(if abs(X) > 0.24 then -X * abs(X) else 0)
						end
						local X = input.Position.X
						if not (abs(X) > 0.24) then
							seatInfo.Maid.joystick2ActiveThread = nil
						end
						yawSpring:SetTarget(if abs(X) > 0.24 then -X * abs(X) else 0)
						seatInfo.Maid.joystick2ActiveThread = RunService.Heartbeat:Connect(update)
					end
				elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
					local Z = input.Position.Z
					throttleInputs[keyToThrottleSlot[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
				end
			end
		end
		seatInfo.Maid:GiveTask(UserInputService.InputChanged:Connect(InputChanged))
		local wheelWorld = WheelWorld.new()
		wheelWorld:SetModel(plane.Model)
		for _, wheelConf in next, plane.WheelsConf do
			local isFront
			isFront = wheelConf.PartNode.CFrame:toObjectSpace(plane.PartBoundingBox.CFrame).Z > 0
			local wheel = Wheel.new(wheelConf.PartNode)
			wheel:SetSpringConstants(2, 3)
			if isFront then
				wheel:SetVisualRadius(plane.CONST.WHEEL_VISUAL_RADIUS_FRONT)
				wheel:SetSuspensionHeight(plane.CONST.SUSPENSION_HEIGHT_FRONT)
			else
				wheel:SetVisualRadius(plane.CONST.WHEEL_VISUAL_RADIUS_BACK)
				wheel:SetSuspensionHeight(plane.CONST.SUSPENSION_HEIGHT_BACK)
			end
			wheelConf.Front = isFront
			wheelConf.Wheel = wheel
			wheelWorld:AddWheel(wheel)
		end
		seatInfo.Maid:GiveTask(wheelWorld)
		local function ThrottleUpPress()
			throttleInputs[1] = 1
		end
		local function ThrottleUpRelease()
			throttleInputs[1] = 0
		end
		local function ThrottleDownPress()
			throttleInputs[3] = 1
		end
		local function ThrottleDownRelease()
			throttleInputs[3] = 0
		end
		seatInfo.Maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 1000,
			saturateTo = 0,
			image = "rbxassetid://7858765663",
			keyCodes = { Enum.KeyCode.W, Enum.KeyCode.ButtonR2 },
			onPressed = function(inputType)
				if inputType ~= Enum.UserInputType.Gamepad1 then
					throttleInputs[1] = 1
				end
			end,
			onReleased = function(inputType)
				if inputType ~= Enum.UserInputType.Gamepad1 then
					throttleInputs[1] = 0
				end
			end
		}))
		seatInfo.Maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 700,
			saturateTo = 0,
			image = "rbxassetid://7858764373",
			keyCodes = { Enum.KeyCode.S, Enum.KeyCode.ButtonL2 },
			onPressed = function(inputType)
				if inputType ~= Enum.UserInputType.Gamepad1 then
					throttleInputs[3] = 1
				end
			end,
			onReleased = function(inputType)
				if inputType ~= Enum.UserInputType.Gamepad1 then
					throttleInputs[3] = 0
				end
			end
		}))
		ActionButtonService.setButtonPrimary(DefaultActions.jumpButton, false)
		seatInfo.Maid:GiveTask(function()
			ActionButtonService.setButtonPrimary(DefaultActions.jumpButton, true)
		end)
		seatInfo.Maid:GiveTask(planeGui)
		planeGui.Controls.Visible = true
		planeGui.Controls.Throttle.Line.Position = UDim2.new(0, -2, 1 - plane.CONST.THROTTLE_TAKEOFF, 1)
		RunLanding()
	end
end
local function MountThirdPlayer(plane, player, seatInfo)
	if seatInfo.Driver then
		local function HeartbeatWheels(dt)
			for _, wheelConf in next, plane.WheelsConf do
				local suspensionOffset, rotationAngle = wheelConf.Wheel:Update(dt)
				wheelConf.Motor.C0 = CFrame.Angles(-rotationAngle, -0, 0) * CFrame.new(0, -suspensionOffset, 0)
				wheelConf.MotorArm.C1 = CFrame.new(0, suspensionOffset, 0) * CFrame.Angles(0, 0, 0) * wheelConf.ArmOffset
			end
		end
		local function Heartbeat(dt)
			HeartbeatWheels(dt)
		end
		seatInfo.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
		local wheelWorld = WheelWorld.new()
		wheelWorld:SetModel(plane.Model)
		for _, wheelConf in next, plane.WheelsConf do
			local isFront
			isFront = wheelConf.PartNode.CFrame:toObjectSpace(plane.PartWing.CFrame).Z > 0
			local wheel = WheelLQ.new(wheelConf.PartNode)
			if isFront then
				wheel:SetVisualRadius(plane.CONST.WHEEL_VISUAL_RADIUS_FRONT)
				wheel:SetSuspensionHeight(plane.CONST.SUSPENSION_HEIGHT_FRONT)
			else
				wheel:SetVisualRadius(plane.CONST.WHEEL_VISUAL_RADIUS_BACK)
				wheel:SetSuspensionHeight(plane.CONST.SUSPENSION_HEIGHT_BACK)
			end
			wheelConf.Front = isFront
			wheelConf.Wheel = wheel
			wheelWorld:AddWheel(wheel)
		end
		seatInfo.Maid:GiveTask(wheelWorld)
	end
end
function t.MountPlayer(self, player, seatInfo)
	if player == LocalPlayer then
		MountLocalPlayer(self, seatInfo)
	else
		MountThirdPlayer(self, player, seatInfo)
	end
	return true
end
local function UnmountLocalPlayer(plane, seatInfo)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			SetHumanoidEnabled(Humanoid, true)
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end
	if seatInfo.Driver then
		plane.ThrustVectorForce.Force = Vector3.new()
		plane.WingVectorForce.Force = Vector3.new()
		plane.WingAngularVelocity.AngularVelocity = Vector3.new()
		plane.WingAngularVelocity.MaxTorque = 0
		plane.SoundRumble:Destroy()
		plane.SoundRumble = nil
		plane.SoundWind:Destroy()
		plane.SoundWind = nil
		plane.SoundBreathing:Destroy()
		plane.SoundBreathing = nil
		UserInputService.MouseIconEnabled = true
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		plane:SetParticlesEnabled(false)
		CurrentCamera.CameraType = Enum.CameraType.Custom
		CurrentCamera.FieldOfView = 70
	end
end
local function UmmountThirdPlayer(plane, player, seatInfo) end
function t.UnmountSeat(self, seatInfo)
	assert(seatInfo)
	assert(seatInfo.Occupied)
	if seatInfo.Player ~= nil then
		if seatInfo.Player == LocalPlayer then
			UnmountLocalPlayer(self, seatInfo)
			return
		end
		local Player = seatInfo.Player
	end
end
function t.SetControlsEnabled(self, enabled)
	self._controlsEnabled = enabled
end
function t.Destroy(self)
	if self.Maid then
		self.Maid:Destroy()
		self.Maid = nil
	end
end
return t
