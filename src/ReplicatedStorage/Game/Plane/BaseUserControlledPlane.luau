local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local v1 = nil
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
local v2 = Random.new()
local abs = math.abs
local function RandomVector(p1) --[[ Line: 46 | Upvalues: v2 (copy) ]]
	local v1 = p1 * (v2:NextNumber() * 2 - 1)
	local v22 = p1 * (v2:NextNumber() * 2 - 1)
	return Vector3.new(v1, v22, p1 * (v2:NextNumber() * 2 - 1))
end
local function SetHumanoidEnabled(p1, p2) --[[ Line: 53 ]]
	local v1 = next
	local v2, v3 = Enum.HumanoidStateType:GetEnumItems()
	for v4, v5 in v1, v2, v3 do
		if v5 ~= Enum.HumanoidStateType.Dead and (v5 ~= Enum.HumanoidStateType.None and v5 ~= Enum.HumanoidStateType.Jumping) then
			p1:SetStateEnabled(v5, p2)
		end
	end
end
local t = {
	__ClassName = "BaseUserControlledPlane"
}
t.__index = t
function t.Init() --[[ Line: 68 | Upvalues: v1 (ref), LocalPlayer (copy) ]]
	v1 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
end
function t.new(p1, p2) --[[ Line: 71 | Upvalues: t (copy), Maid (copy) ]]
	local v2 = setmetatable({}, t)
	v2.Id = p1.Id
	assert(v2.Id)
	v2.Mass = p1.Mass
	v2.Maid = Maid.new()
	v2.Model = p1.Model
	local Wing = v2.Model.Skeleton.Wing
	local Thrust = v2.Model.Skeleton.Thrust
	v2.PartBoundingBox = v2.Model.BoundingBox
	v2.PartWing = Wing
	v2.WingVectorForce = Wing.VectorForce
	v2.WingAngularVelocity = Wing.AngularVelocity
	v2.PartThrust = Thrust
	v2.ThrustVectorForce = Thrust.VectorForce
	v2.AreaWing = Wing.Size.X * Wing.Size.Z
	v2.Seats = {}
	v2:SetupSeats()
	v2.CorrectingRoll = false
	v2.CorrectingRollFlag = false
	v2.OnTakeoff = nil
	v2.OnLanding = nil
	local t2 = {
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
		SOUND_RUMBLE_COEFF_GS = 0.3333333333333333,
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
	if p2 then
		for v3, v4 in next, p2 do
			assert(t2[v3], v3)
			t2[v3] = v4
		end
	end
	v2.CONST = t2
	v2.Joystickx = 0
	v2.Joysticky = 0
	v2.InputYaw = 0
	v2.Throttle = 0
	v2._controlsEnabled = true
	return v2
end
function t.SetupSeats(p1) --[[ Line: 148 ]]
	table.insert(p1.Seats, {
		Part = p1.Model:FindFirstChild("Seat"),
		Driver = true
	})
end
function t.SetParticlesEnabled(p1, p2) --[[ Line: 154 ]]
	if p1.Model then
		local Particles = p1.Model:FindFirstChild("Particles")
		if Particles then
			local v1 = next
			local v2, v3 = Particles:GetChildren()
			for v4, v5 in v1, v2, v3 do
				v5:FindFirstChildOfClass("ParticleEmitter").Enabled = p2
			end
		end
	end
end
local function MountLocalPlayer(p1, p2) --[[ Line: 166 | Upvalues: CharacterAnim (copy), LocalPlayer (copy), SetHumanoidEnabled (copy), Spring (copy), ReplicatedStorage (copy), Audio (copy), VehicleUtils (copy), DoorConsts (copy), InputUtils (copy), v1 (ref), RunService (copy), CurrentCamera (copy), UserInputService (copy), v2 (copy), abs (copy), WheelWorld (copy), Wheel (copy), ActionButtonService (copy), DefaultActions (copy) ]]
	local v12 = CharacterAnim.getCarSitTrack()
	v12:Play()
	p2.Maid:GiveTask(function() --[[ Line: 171 | Upvalues: v12 (copy) ]]
		v12:Stop()
	end)
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			SetHumanoidEnabled(Humanoid, false)
			Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
		end
	end
	if p2.Driver then
		local v22 = Spring.new(Vector3.new(), Vector3.new(), 0.8, 30)
		local v3 = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
		local v4 = Spring.new(0, 0, 0.6, 5)
		local v5 = Spring.new(0, 0, 0.7, 5)
		local v6 = Spring.new(0, 0, 0.95, 15)
		p2.CameraSpring = v22
		local v7 = ReplicatedStorage.Resource.Plane.PlaneGui:Clone()
		v7.Parent = LocalPlayer.PlayerGui
		p1.PlaneGui = v7
		local v8 = Audio.ObjectLocal(v7, 3378049562, {
			Looped = true,
			Volume = 0,
			Pitch = 1
		})
		p1.SoundRumble = v8
		local v9 = Audio.ObjectLocal(v7, 3378078999, {
			Looped = true,
			Volume = 1.25
		})
		p1.SoundWind = v9
		local v10 = Audio.ObjectLocal(v7, 9058670257, {
			Looped = true,
			Volume = 0
		})
		p1.SoundBreathing = v10
		local v11 = 0
		local v122 = 0
		local t = { 0, 0, 0, 0 }
		local v13 = tick()
		local v14 = true
		local v15 = 0
		local v16 = 0
		local v17 = Vector3.new()
		local v18 = 0
		local function updatePlaneHealth() --[[ Line: 223 | Upvalues: VehicleUtils (ref), p1 (copy), v122 (ref) ]]
			if VehicleUtils.getTireHealth(p1.Model) <= 0 then
				v122 = 0
			end
		end
		if VehicleUtils.getTireHealth(p1.Model) <= 0 then
			v122 = 0
		end
		p2.Maid:GiveTask(VehicleUtils.getTireHealthChangedSignal(p1.Model):Connect(updatePlaneHealth))
		p1.IsFlying = false
		local v19 = false
		local v20 = nil
		local function RunTakeoff() --[[ Line: 235 | Upvalues: p1 (copy), Audio (ref), v7 (ref), v4 (copy) ]]
			p1.IsFlying = true
			p1.Model:FindFirstChild("SetIsFlyingRemote"):FireServer(p1.IsFlying)
			if p1.OnTakeoff then
				p1.OnTakeoff()
			end
			Audio.ObjectLocal(v7, 3382610090)
			for v1, v2 in next, p1.WheelsConf do
				v2.Wheel:Clear()
				v2.Motor.C0 = CFrame.new()
			end
			v4:SetTarget(1)
			p1.WingAngularVelocity.MaxTorque = p1.CONST.ANGULAR_MAXTORQUE_FLYING
			v7.Controls.Mouse.Visible = true
			v7.Controls.Altitude.Visible = true
			p1:SetParticlesEnabled(true)
		end
		local function RunLanding() --[[ Line: 254 | Upvalues: p1 (copy), Audio (ref), v7 (ref), v4 (copy) ]]
			if p1.IsFlying then
				Audio.ObjectLocal(v7, 3382610090)
			end
			p1.IsFlying = false
			p1.Model:FindFirstChild("SetIsFlyingRemote"):FireServer(p1.IsFlying)
			if p1.OnLanding then
				p1.OnLanding()
			end
			v4:SetTarget(0)
			p1.WingAngularVelocity.MaxTorque = p1.CONST.ANGULAR_MAXTORQUE_LANDING
			v7.Controls.Mouse.Visible = false
			v7.Controls.Altitude.Visible = false
			p1:SetParticlesEnabled(false)
		end
		local function HeartbeatWing(p12) --[[ Line: 271 | Upvalues: p1 (copy), v6 (copy), v16 (ref), v15 (ref), v17 (ref) ]]
			local PartWing = p1.PartWing
			local v1 = PartWing.CFrame
			local v2 = math.asin(v1.LookVector.Y)
			if v2 ~= v2 then
				v2 = 0
			end
			local v3 = math.asin(v1.RightVector.Y)
			if v3 ~= v3 then
				v3 = 0
			end
			p1.ObservedPitch = v2
			p1.ObservedRoll = v3
			local Velocity = PartWing.Velocity
			local v5 = Velocity:Dot(Velocity)
			p1.WingVectorForce.Force = if v5 > 0.001 then (p1.IsFlying and p1.CONST.COEFFICIENT_DRAG or 0.1) * 0.5 * v5 * p1.AreaWing * -Velocity.Unit + (p1.IsFlying and math.cos(v2) * 0.95 or 0.1) * p1.CONST.GRAVITY * p1.Mass * Vector3.new(0, 1, 0) else Vector3.new(0, 0, 0)
			local v10 = v6:Update()
			p1.WingAngularVelocity.AngularVelocity = Vector3.new(v16 * 3 * (1 + -0.9 * v10), if p1.IsFlying then p1.InputYaw * 0.5 else 0, v15 * 2.5 * (1 + 2 * v10))
			p1.ObservedAcceleration = ((Velocity - v17) / p12).Magnitude
			v17 = Velocity
		end
		local v21 = 0
		local function HeartbeatThrust(p12) --[[ Line: 323 | Upvalues: p1 (copy), v122 (ref), v21 (ref) ]]
			local v1 = p1.PartThrust.CFrame
			local v2
			local v3 = tick()
			if v1.Y > p1.CONST.HEIGHT_MAX then
				v2 = 0
				v21 = v3
			end
			if v3 - v21 < 5 then
				v2 = 0
			end
			p1.ThrustVectorForce.Force = v1.LookVector * p1.Mass * (v2 * p1.CONST.MAX_THRUST)
		end
		local function HeartbeatSounds(p12) --[[ Line: 341 | Upvalues: p1 (copy), v8 (copy), v4 (copy), v9 (copy), v18 (ref), v11 (ref), v10 (copy) ]]
			local v1 = p1.ObservedAcceleration / p1.CONST.GRAVITY
			if p1.IsFlying == false then
				v1 = 0
			end
			local v3 = 1 - math.exp(-v1 * p1.CONST.SOUND_RUMBLE_COEFF_GS)
			v8.Volume = v3 * 2
			v9.Volume = (1.25 - v3 * 0.2) * (0.2 + 0.8 * v4:Update())
			v18 = if p1.CONST.SOUND_BREATHING_MIN_GS < v1 then v18 + p12 else 0
			if v18 > p1.CONST.SOUND_BREATHING_TIMER then
				v11 = p1.CONST.SOUND_BREATHING_DURATION
			end
			v11 = v11 - p12
			if v11 > 0 then
				v10.Volume = (1 - math.exp(-v11)) * 0.4
			end
		end
		local function HeartbeatWheels(p12) --[[ Line: 383 | Upvalues: p1 (copy), v5 (copy), v122 (ref), DoorConsts (ref) ]]
			if p1.IsFlying == false then
				local v1 = v5:Update()
				for v3, v4 in next, p1.WheelsConf do
					local v2
					v2 = v4.Front and v122 < p1.CONST.THROTTLE_WHEEL_TURN_MIN and v1 * math.pi * 0.2 or 0
					local v52, v6 = v4.Wheel:Update(p12, v2)
					if v4.DoorModel and v4.DoorModel:GetAttribute(DoorConsts.OPEN_ATTR_NAME) == true then
						v6 = 0
						v52 = 0
					end
					v4.Motor.C0 = CFrame.Angles(-v6, -v2, 0) * CFrame.new(0, -v52, 0)
					v4.MotorArm.C1 = CFrame.new(0, v52, 0) * CFrame.Angles(0, v2, 0) * v4.ArmOffset
				end
			end
		end
		local v222 = v122
		local v23 = tick()
		local function HeartbeatControls(p12) --[[ Line: 404 | Upvalues: t (copy), VehicleUtils (ref), p1 (copy), InputUtils (ref), v1 (ref), v15 (ref), v16 (ref), v5 (copy), v122 (ref), v23 (ref), v222 (ref), RunTakeoff (copy), RunLanding (copy), v13 (ref), v14 (ref) ]]
			local v12 = tick()
			local v2 = t[1] - t[3]
			if VehicleUtils.getTireHealth(p1.Model) <= 0 then
				v2 = 0
			end
			local v3
			if InputUtils.isTouch() then
				local v4 = v1:GetControls():GetMoveVector()
				if v4.Magnitude > 1 then
					v4 = v4.Unit
				end
				local v52 = -v4.X
				v15 = v52
				v16 = -v4.Z
				v3 = v5:SetTarget(v52)
			else
				v3 = v5:Update()
			end
			if v2 > 0 then
				v122 = v122 + p12 * 0.2
				v23 = v12
			elseif v2 < 0 then
				v122 = v122 - p12 * 0.2
				v23 = v12
			end
			if v12 - v23 > 1 and (not (v122 > p1.CONST.THROTTLE_TAKEOFF) and v122 > 0.15) then
				v122 = v122 - p12 * 0.1
			end
			if v122 < -0.06666666666666667 then
				v122 = -0.06666666666666667
			end
			if v122 > 1 then
				v122 = 1
			end
			if v222 < p1.CONST.THROTTLE_TAKEOFF and v122 >= p1.CONST.THROTTLE_TAKEOFF then
				RunTakeoff()
			elseif v222 > p1.CONST.THROTTLE_TAKEOFF and v122 <= p1.CONST.THROTTLE_TAKEOFF then
				RunLanding()
			end
			v222 = v122
			local v9 = v12 - v13
			if p1.CONST.ROLL_ADJUSTMENT_TIMER < v9 then
				v15 = v15 + -p1.ObservedRoll * 0.1 * (1 - math.exp(-(v9 - p1.CONST.ROLL_ADJUSTMENT_TIMER)))
			end
			if v14 then
				v15 = v15 * p1.CONST.JOYSTICK_RECENTER_MULTIPLIER
				v16 = v16 * p1.CONST.JOYSTICK_RECENTER_MULTIPLIER
			end
			if v15 < -1 then
				v15 = -1
			end
			if v15 > 1 then
				v15 = 1
			end
			if v16 < -1 then
				v16 = -1
			end
			if v16 > 1 then
				v16 = 1
			end
			if v3 < -1 then
				v3 = -1
			end
			if v3 > 1 then
				v3 = 1
			end
			p1.Joystickx = v15
			p1.Joysticky = v16
			p1.InputYaw = v3
			p1.Throttle = v122
		end
		local function HeartbeatUI(p12) --[[ Line: 509 | Upvalues: v15 (ref), v16 (ref), v7 (ref), p1 (copy), v122 (ref) ]]
			local v1 = v15
			local v2 = v16
			local v3 = (v1 * v1 + v2 * v2) ^ 0.5
			if v3 > 1 then
				v1 = v1 / v3
				v2 = v2 / v3
			end
			v7.Controls.Mouse.Dot.Position = UDim2.new(-(v1 * 0.9) * 0.5 + 0.5, 0, -(v2 * 0.9) * 0.5 + 0.5, 0)
			v7.Controls.Altitude.Text = ("%04d"):format(p1.PartWing.Position.Y)
			v7.Controls.Throttle.Value.Size = UDim2.new(1, 0, v122, 0)
			v7.Controls.Throttle.Value.Position = UDim2.new(0, 0, 1 - v122, 0)
		end
		local function Heartbeat(p1) --[[ Line: 523 | Upvalues: HeartbeatControls (copy), HeartbeatWing (copy), HeartbeatThrust (copy), HeartbeatSounds (copy), HeartbeatWheels (copy), HeartbeatUI (copy) ]]
			HeartbeatControls(p1)
			HeartbeatWing(p1)
			HeartbeatThrust(p1)
			HeartbeatSounds(p1)
			HeartbeatWheels(p1)
			HeartbeatUI(p1)
		end
		p2.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
		local v24 = 70
		local function RenderSteppedCamera(p12) --[[ Line: 534 | Upvalues: v4 (copy), p1 (copy), v19 (ref), v20 (ref), CurrentCamera (ref), UserInputService (ref), v15 (ref), v16 (ref), v22 (copy), v3 (copy), v2 (ref), v24 (ref) ]]
			local v1 = v4:Update()
			if p1.IsFlying then
				if not v19 then
					v19 = true
					v20 = p1.PartWing.CFrame:toObjectSpace(CurrentCamera.CFrame)
					CurrentCamera.CameraType = Enum.CameraType.Scriptable
				end
			elseif v19 and v1 < 0.001 then
				v19 = false
				CurrentCamera.CameraType = Enum.CameraType.Custom
				CurrentCamera.CFrame = p1.PartWing.CFrame * v20
			end
			local v23 = not p1.IsFlying or not p1._controlsEnabled
			UserInputService.MouseIconEnabled = v23
			if v23 then
				if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end
			elseif UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			end
			local v32
			if v19 then
				v32 = math.clamp((p1.PartWing.Velocity:Dot(p1.PartWing.CFrame.LookVector) - 50) / 300, 0, 1) * 20 + 70
				local v7 = Vector3.new(v15 * -2, v16 * 2, 0)
				local v8 = v22:SetTarget(v7)
				local v9 = v3:SetTarget(v7)
				local v10 = p1.PartWing.CFrame
				local v11 = v20
				local v12 = p1.CONST.CAMERA_OFFSET_CF * CFrame.new(v8) * CFrame.Angles(-v9.y * 0.02, v9.x * 0.02, 0)
				if not p1.Model:GetAttribute("IsCameraLocked") then
					CurrentCamera.CFrame = v10 * v11:Lerp(v12, v1)
				end
				local v13 = p1.ObservedAcceleration / p1.CONST.GRAVITY
				if p1.CONST.CAMERA_SHAKE_MIN_GS < v13 then
					local v162 = (1 - math.exp(-(v13 - p1.CONST.CAMERA_SHAKE_MIN_GS) * p1.CONST.CAMERA_SHAKE_COEFF_GS)) * 15
					v22:Accelerate((Vector3.new(v162 * (v2:NextNumber() * 2 - 1), v162 * (v2:NextNumber() * 2 - 1), v162 * (v2:NextNumber() * 2 - 1))))
				end
			else
				v32 = 70
			end
			v24 = v24 + (v32 - v24) * 0.7
			CurrentCamera.FieldOfView = v24
		end
		local function RenderStepped(p1) --[[ Line: 593 | Upvalues: RenderSteppedCamera (copy) ]]
			RenderSteppedCamera(p1)
		end
		p2.Maid:GiveTask(RunService.RenderStepped:Connect(RenderStepped))
		local t2 = {
			[Enum.KeyCode.A] = 2,
			[Enum.KeyCode.D] = 4,
			[Enum.KeyCode.ButtonR2] = 1,
			[Enum.KeyCode.ButtonL2] = 3
		}
		local function InputBegan(p12, p2) --[[ Line: 608 | Upvalues: v6 (copy), p1 (copy), t2 (copy), t (copy), v5 (copy) ]]
			if p2 then
				return false
			end
			if p12.UserInputType == Enum.UserInputType.Keyboard then
				if p12.KeyCode == Enum.KeyCode.Q then
					v6:SetTarget(1)
				elseif p12.KeyCode == Enum.KeyCode.LeftShift then
					for v1, v2 in next, p1.WheelsConf do
						if not v2.Front then
							v2.Wheel:SetForwardFriction(3)
						end
					end
				end
			end
			if t2[p12.KeyCode] then
				t[t2[p12.KeyCode]] = 1
				v5:SetTarget(t[2] - t[4])
			end
		end
		p2.Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
		local function InputEnded(p12, p2) --[[ Line: 633 | Upvalues: v6 (copy), p1 (copy), t2 (copy), t (copy), v5 (copy) ]]
			if p2 then
				return false
			end
			if p12.UserInputType == Enum.UserInputType.Keyboard then
				if p12.KeyCode == Enum.KeyCode.Q then
					v6:SetTarget(0)
				elseif p12.KeyCode == Enum.KeyCode.LeftShift then
					for v1, v2 in next, p1.WheelsConf do
						v2.Wheel:SetForwardFriction(0.02)
					end
				end
			end
			if t2[p12.KeyCode] then
				t[t2[p12.KeyCode]] = 0
				v5:SetTarget(t[2] - t[4])
			end
		end
		p2.Maid:GiveTask(UserInputService.InputEnded:Connect(InputEnded))
		local v25 = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
		local function InputChanged(p1) --[[ Line: 659 | Upvalues: v15 (ref), v16 (ref), v13 (ref), v14 (ref), v25 (copy), abs (ref), p2 (copy), RunService (ref), v5 (copy), t (copy), t2 (copy) ]]
			if p1.UserInputType == Enum.UserInputType.MouseMovement then
				v15 = v15 - p1.Delta.X * 0.015
				v16 = v16 - p1.Delta.Y * 0.015
				v13 = tick()
				v14 = true
			elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then
				local KeyCode = p1.KeyCode
				if KeyCode == Enum.KeyCode.Thumbstick1 then
					local function isJoyStickActive() --[[ Line: 669 | Upvalues: p1 (copy), v25 (ref), abs (ref) ]]
						local v1 = v25:SetTarget(p1.Position)
						local X = v1.X
						local Y = v1.Y
						return abs(X) > 0.24 or abs(Y) > 0.24, X, Y
					end
					local v1 = v25:SetTarget(p1.Position)
					if if abs(v1.X) > 0.24 then true else abs(v1.Y) > 0.24 and not p2.Maid.joystickActiveThread then
						local function update() --[[ Line: 677 | Upvalues: p1 (copy), v25 (ref), abs (ref), p2 (ref), v13 (ref), v14 (ref), v15 (ref), v16 (ref) ]]
							local v1 = v25:SetTarget(p1.Position)
							local X = v1.X
							local Y = v1.Y
							local v2 = abs(X) > 0.24 or abs(Y) > 0.24
							if not v2 then
								p2.Maid.joystickActiveThread = nil
							end
							v13 = tick()
							v14 = not v2
							local v3, v4
							if abs(X) > 0.24 then
								v3 = -X * abs(X)
								v4 = Y
							else
								v3 = 0
								v4 = Y
							end
							v15 = v3
							v16 = if abs(v4) > 0.24 then v4 * abs(v4) else 0
						end
						update()
						p2.Maid.joystickActiveThread = RunService.Heartbeat:Connect(update)
					end
				elseif KeyCode == Enum.KeyCode.Thumbstick2 then
					local function isJoyStick2Active() --[[ Line: 693 | Upvalues: p1 (copy), abs (ref) ]]
						local X = p1.Position.X
						return abs(X) > 0.24, X
					end
					if abs(p1.Position.X) > 0.24 and not p2.Maid.joystickActiveThread then
						local function update() --[[ Line: 699 | Upvalues: p1 (copy), abs (ref), p2 (ref), v5 (ref) ]]
							local X = p1.Position.X
							if not (abs(X) > 0.24) then
								p2.Maid.joystick2ActiveThread = nil
							end
							v5:SetTarget(if abs(X) > 0.24 then -X * abs(X) else 0)
						end
						local X = p1.Position.X
						if not (abs(X) > 0.24) then
							p2.Maid.joystick2ActiveThread = nil
						end
						v5:SetTarget(if abs(X) > 0.24 then -X * abs(X) else 0)
						p2.Maid.joystick2ActiveThread = RunService.Heartbeat:Connect(update)
					end
				elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
					local Z = p1.Position.Z
					t[t2[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
				end
			end
		end
		p2.Maid:GiveTask(UserInputService.InputChanged:Connect(InputChanged))
		local v26 = WheelWorld.new()
		v26:SetModel(p1.Model)
		for v28, v29 in next, p1.WheelsConf do
			local v27
			v27 = v29.PartNode.CFrame:toObjectSpace(p1.PartBoundingBox.CFrame).Z > 0
			local v30 = Wheel.new(v29.PartNode)
			v30:SetSpringConstants(2, 3)
			if v27 then
				v30:SetVisualRadius(p1.CONST.WHEEL_VISUAL_RADIUS_FRONT)
				v30:SetSuspensionHeight(p1.CONST.SUSPENSION_HEIGHT_FRONT)
			else
				v30:SetVisualRadius(p1.CONST.WHEEL_VISUAL_RADIUS_BACK)
				v30:SetSuspensionHeight(p1.CONST.SUSPENSION_HEIGHT_BACK)
			end
			v29.Front = v27
			v29.Wheel = v30
			v26:AddWheel(v30)
		end
		p2.Maid:GiveTask(v26)
		local function ThrottleUpPress() --[[ Line: 740 | Upvalues: t (copy) ]]
			t[1] = 1
		end
		local function ThrottleUpRelease() --[[ Line: 743 | Upvalues: t (copy) ]]
			t[1] = 0
		end
		local function ThrottleDownPress() --[[ Line: 746 | Upvalues: t (copy) ]]
			t[3] = 1
		end
		local function ThrottleDownRelease() --[[ Line: 749 | Upvalues: t (copy) ]]
			t[3] = 0
		end
		p2.Maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 1000,
			saturateTo = 0,
			image = "rbxassetid://7858765663",
			keyCodes = { Enum.KeyCode.W, Enum.KeyCode.ButtonR2 },
			onPressed = function(p1) --[[ Name: onPressed | Line: 758 | Upvalues: t (copy) ]]
				if p1 ~= Enum.UserInputType.Gamepad1 then
					t[1] = 1
				end
			end,
			onReleased = function(p1) --[[ Name: onReleased | Line: 764 | Upvalues: t (copy) ]]
				if p1 ~= Enum.UserInputType.Gamepad1 then
					t[1] = 0
				end
			end
		}))
		p2.Maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 700,
			saturateTo = 0,
			image = "rbxassetid://7858764373",
			keyCodes = { Enum.KeyCode.S, Enum.KeyCode.ButtonL2 },
			onPressed = function(p1) --[[ Name: onPressed | Line: 777 | Upvalues: t (copy) ]]
				if p1 ~= Enum.UserInputType.Gamepad1 then
					t[3] = 1
				end
			end,
			onReleased = function(p1) --[[ Name: onReleased | Line: 783 | Upvalues: t (copy) ]]
				if p1 ~= Enum.UserInputType.Gamepad1 then
					t[3] = 0
				end
			end
		}))
		ActionButtonService.setButtonPrimary(DefaultActions.jumpButton, false)
		p2.Maid:GiveTask(function() --[[ Line: 791 | Upvalues: ActionButtonService (ref), DefaultActions (ref) ]]
			ActionButtonService.setButtonPrimary(DefaultActions.jumpButton, true)
		end)
		p2.Maid:GiveTask(v7)
		v7.Controls.Visible = true
		v7.Controls.Throttle.Line.Position = UDim2.new(0, -2, 1 - p1.CONST.THROTTLE_TAKEOFF, 1)
		RunLanding()
	end
end
local function MountThirdPlayer(p1, p2, p3) --[[ Line: 802 | Upvalues: RunService (copy), WheelWorld (copy), WheelLQ (copy) ]]
	if p3.Driver then
		local function HeartbeatWheels(p12) --[[ Line: 806 | Upvalues: p1 (copy) ]]
			for v1, v2 in next, p1.WheelsConf do
				local v3, v4 = v2.Wheel:Update(p12)
				v2.Motor.C0 = CFrame.Angles(-v4, -0, 0) * CFrame.new(0, -v3, 0)
				v2.MotorArm.C1 = CFrame.new(0, v3, 0) * CFrame.Angles(0, 0, 0) * v2.ArmOffset
			end
		end
		local function Heartbeat(p1) --[[ Line: 816 | Upvalues: HeartbeatWheels (copy) ]]
			HeartbeatWheels(p1)
		end
		p3.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
		local v1 = WheelWorld.new()
		v1:SetModel(p1.Model)
		for v3, v4 in next, p1.WheelsConf do
			local v2
			v2 = v4.PartNode.CFrame:toObjectSpace(p1.PartWing.CFrame).Z > 0
			local v5 = WheelLQ.new(v4.PartNode)
			if v2 then
				v5:SetVisualRadius(p1.CONST.WHEEL_VISUAL_RADIUS_FRONT)
				v5:SetSuspensionHeight(p1.CONST.SUSPENSION_HEIGHT_FRONT)
			else
				v5:SetVisualRadius(p1.CONST.WHEEL_VISUAL_RADIUS_BACK)
				v5:SetSuspensionHeight(p1.CONST.SUSPENSION_HEIGHT_BACK)
			end
			v4.Front = v2
			v4.Wheel = v5
			v1:AddWheel(v5)
		end
		p3.Maid:GiveTask(v1)
	end
end
function t.MountPlayer(p1, p2, p3) --[[ Line: 840 | Upvalues: LocalPlayer (copy), MountLocalPlayer (copy), MountThirdPlayer (copy) ]]
	if p2 == LocalPlayer then
		MountLocalPlayer(p1, p3)
	else
		MountThirdPlayer(p1, p2, p3)
	end
	return true
end
local function UnmountLocalPlayer(p1, p2) --[[ Line: 848 | Upvalues: LocalPlayer (copy), SetHumanoidEnabled (copy), UserInputService (copy), CurrentCamera (copy) ]]
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			SetHumanoidEnabled(Humanoid, true)
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end
	if p2.Driver then
		p1.ThrustVectorForce.Force = Vector3.new()
		p1.WingVectorForce.Force = Vector3.new()
		p1.WingAngularVelocity.AngularVelocity = Vector3.new()
		p1.WingAngularVelocity.MaxTorque = 0
		p1.SoundRumble:Destroy()
		p1.SoundRumble = nil
		p1.SoundWind:Destroy()
		p1.SoundWind = nil
		p1.SoundBreathing:Destroy()
		p1.SoundBreathing = nil
		UserInputService.MouseIconEnabled = true
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		p1:SetParticlesEnabled(false)
		CurrentCamera.CameraType = Enum.CameraType.Custom
		CurrentCamera.FieldOfView = 70
	end
end
local function UmmountThirdPlayer(p1, p2, p3) --[[ Line: 882 ]] end
function t.UnmountSeat(p1, p2) --[[ Line: 883 | Upvalues: LocalPlayer (copy), UnmountLocalPlayer (copy) ]]
	assert(p2)
	assert(p2.Occupied)
	if p2.Player ~= nil then
		if p2.Player == LocalPlayer then
			UnmountLocalPlayer(p1, p2)
			return
		end
		local Player = p2.Player
	end
end
function t.SetControlsEnabled(p1, p2) --[[ Line: 894 ]]
	p1._controlsEnabled = p2
end
function t.Destroy(p1) --[[ Line: 897 ]]
	if p1.Maid then
		p1.Maid:Destroy()
		p1.Maid = nil
	end
end
return t