local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Math = require(ReplicatedStorage.Module.Math)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Time = require(ReplicatedStorage.Module.Time)
local Audio = require(ReplicatedStorage.Std.Audio)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local C4Binder = require(ReplicatedStorage.Game.C4.C4Binder)
local ChassisShared = require(ReplicatedStorage.Module.ChassisShared)
local CurrentCamera = workspace.CurrentCamera
local currentEvent = nil
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PhysicsLagService = require(ReplicatedStorage.App.PhysicsLagService)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local LocalPlayer = Players.LocalPlayer
local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
local EnvironmentUtils = require(ReplicatedStorage.Environment.EnvironmentUtils)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
require(ReplicatedStorage.Std.Debug.Draw3D)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
require(ReplicatedStorage.Std.Maid)
local ZERO_VECTOR = Vector3.new()
local vectorToObjectSpace = CFrame.new():vectorToObjectSpace
local WorldSpringSetTarget = Math.WorldSpringSetTarget
local WorldSpringUpdate = Math.WorldSpringUpdate
local SoundIds = {
	tire_pop = 4534995816,
	tire_leak = 4534995685
}
local function rotateAxisAngle(axis, vector, angle)
	local sinAngle = math.sin(angle)
	local cosAngle = math.cos(angle)
	local crossProduct = axis:Cross(vector)
	local dotProduct = axis:Dot(vector)
	return dotProduct * axis + cosAngle * (axis - dotProduct * vector) + sinAngle * crossProduct
end
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
	local Humanoid = character:FindFirstChildOfClass("Humanoid")
	for _, stateType in Enum.HumanoidStateType:GetEnumItems() do
		if stateType ~= Enum.HumanoidStateType.Dead and (stateType ~= Enum.HumanoidStateType.None and stateType ~= Enum.HumanoidStateType.Jumping) then
			Humanoid:SetStateEnabled(stateType, enabled)
		end
	end
	Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
end
local Animation = Instance.new("Animation")
local Animation_2 = Instance.new("Animation")
local Animation_3 = Instance.new("Animation")
local Animation_4 = Instance.new("Animation")
if RunUtils.getEnv() == RunConsts.QA_NAME then
	print("Using QA bike animations")
	Animation.AnimationId = "rbxassetid://15294902930"
	Animation_2.AnimationId = "rbxassetid://15294915556"
	Animation_3.AnimationId = "rbxassetid://15294919049"
	Animation_4.AnimationId = "rbxassetid://15294921314"
else
	Animation.AnimationId = "rbxassetid://15280711198"
	Animation_2.AnimationId = "rbxassetid://15280801186"
	Animation_3.AnimationId = "rbxassetid://15280806101"
	Animation_4.AnimationId = "rbxassetid://15280808439"
end
local function hookAnimations(enginePart, maid, character)
	local Animator = character:FindFirstChildOfClass("Humanoid"):WaitForChild("Animator", 10)
	local track1 = Animator:LoadAnimation(Animation)
	local track2 = Animator:LoadAnimation(Animation_2)
	local track3 = Animator:LoadAnimation(Animation_3)
	local track4 = Animator:LoadAnimation(Animation_4)
	local tracks = {
		{
			track = track1
		},
		{
			track = track2
		},
		{
			track = track3
		},
		{
			track = track4
		}
	}
	maid:GiveTask(Interval.every(0.1):Connect(function()
		local localVel = enginePart.CFrame:VectorToObjectSpace(enginePart.Velocity)
		local localRotVel = enginePart.CFrame:VectorToObjectSpace(enginePart.RotVelocity)
		local forwardSpeed = math.abs(localVel.Z)
		local turnRight = math.clamp(localRotVel.Y / 0.5, 0, 1)
		local turnLeft = math.clamp(-localRotVel.Y / 0.5, 0, 1)
		local speedBlend = math.clamp(forwardSpeed / 20, 0, 1)
		local straightBlend = speedBlend * math.clamp(1 - math.max(turnRight, turnLeft) * 2, 0, 1)
		tracks[1].weight = 1 - math.max(straightBlend, turnRight, turnLeft)
		tracks[2].weight = straightBlend
		tracks[3].weight = turnRight
		tracks[4].weight = turnLeft
		local activeIndices = {}
		for i, trackEntry in ipairs(tracks) do
			if trackEntry.weight > 0.1 then
				table.insert(activeIndices, i)
			else
				trackEntry.track:Stop(0.5)
			end
		end
		for i, trackIndex in ipairs(activeIndices) do
			local entry = tracks[trackIndex]
			if not entry.track.IsPlaying then
				entry.track:Play(0.25)
			end
			entry.track:AdjustWeight(entry.weight, 0.25)
		end
	end))
	maid:GiveTask(function()
		track1:Stop()
		track1:Destroy()
		track2:Stop()
		track2:Destroy()
		track3:Stop()
		track3:Destroy()
		track4:Stop()
		track4:Destroy()
	end)
end
local VehicleTypes = {
	Dirtbike = {}
}
local function DirtbikeVehicleEnter(state, character)
	SetHumanoidEnabled(character, false)
	hookAnimations(state.Model:FindFirstChild("Engine"), state.seatMaid, character)
end
VehicleTypes.Dirtbike.VehicleEnter = DirtbikeVehicleEnter
local function DirtbikeUpdateWheel(state, wheel)
	local suspensionHeight = wheel.vh
	if wheel.Front then
		local turnCFrame = CFrame.fromAxisAngle((Vector3.new(0, 1, 1)).unit, -state.VisualTurnAngle)
		if wheel.HoldJoint then
			wheel.HoldJoint.C1 = CFrame.new(0, -suspensionHeight, 0) * CFrame.new(0, wheel.HoldSize.Y * 1.5 - 0.1, wheel.HoldSize.Z * 0.5 - 0.05) * turnCFrame * CFrame.Angles(0, 0, math.pi)
		end
		wheel.VisualJoint.C1 = CFrame.new(0, -suspensionHeight + wheel.VisualHalfHeight, 0) * turnCFrame * CFrame.Angles(state.WheelRotation, 0, 0)
	elseif wheel.Back then
		if wheel.HoldJoint then
			wheel.HoldJoint.C1 = CFrame.new(0, -suspensionHeight, 0) * CFrame.new(0, wheel.HoldSize.Y * 1.5, -wheel.HoldSize.Z * 0.5 + 0.05) * CFrame.Angles(0, 0, math.pi)
		end
		wheel.VisualJoint.C1 = CFrame.new(0, -suspensionHeight + wheel.VisualHalfHeight, 0) * CFrame.Angles(state.WheelRotation, 0, 0)
	end
end
VehicleTypes.Dirtbike.UpdateWheel = DirtbikeUpdateWheel
local function DirtbikeUpdateHQ(state, dt)
	local Engine = state.Model.Engine
	local leanUp = CFrame.fromAxisAngle(Engine.CFrame.LookVector, state.VisualLeanAngle * 0.4) * Vector3.new(0, 1, 0)
	local leanSide = Engine.CFrame.LookVector:Cross(leanUp)
	for _, stableEntry in next, state.Stable do
		stableEntry.Align.Enabled = true
		stableEntry.Align.PrimaryAxis = leanSide
		stableEntry.Torque.Enabled = true
		local localRotVel = Engine.CFrame:VectorToObjectSpace(Engine.RotVelocity)
		stableEntry.Torque.Torque = Engine.AssemblyMass * Vector3.new(-Engine.CFrame.LookVector:Dot(leanUp) * 70 - localRotVel.X * 8, 0, 0)
	end
end
VehicleTypes.Dirtbike.UpdateHQ = DirtbikeUpdateHQ
local function DirtbikeUpdateLQ(state, dt) end
VehicleTypes.Dirtbike.UpdateLQ = DirtbikeUpdateLQ
local function DirtbikeIKP(state, ikPacket)
	local VisualTurnAngle = state.VisualTurnAngle
	if VisualTurnAngle then
		local IKP = state.IKP
		IKP.RightArm = state.Model.Handlebar.RightHand.Position
		IKP.LeftArm = state.Model.Handlebar.LeftHand.Position
		IKP.RightAngle = -0.95 + VisualTurnAngle
		IKP.LeftAngle = 0.95 + VisualTurnAngle
		R15IKv2.Arms(IKP)
		state.HandlebarJoint.C1 = CFrame.Angles(0, -VisualTurnAngle, 0)
	end
end
VehicleTypes.Dirtbike.IKP = DirtbikeIKP
VehicleTypes.Patrol = {}
VehicleTypes.Patrol.VehicleEnter = VehicleTypes.Dirtbike.VehicleEnter
VehicleTypes.Patrol.UpdateWheel = VehicleTypes.Dirtbike.UpdateWheel
VehicleTypes.Patrol.UpdateHQ = VehicleTypes.Dirtbike.UpdateHQ
VehicleTypes.Patrol.UpdateLQ = VehicleTypes.Dirtbike.UpdateLQ
VehicleTypes.Patrol.IKP = VehicleTypes.Dirtbike.IKP
VehicleTypes.FalconS = {}
VehicleTypes.FalconS.VehicleEnter = VehicleTypes.Dirtbike.VehicleEnter
VehicleTypes.FalconS.UpdateWheel = VehicleTypes.Dirtbike.UpdateWheel
VehicleTypes.FalconS.UpdateHQ = VehicleTypes.Dirtbike.UpdateHQ
VehicleTypes.FalconS.UpdateLQ = VehicleTypes.Dirtbike.UpdateLQ
VehicleTypes.FalconS.IKP = VehicleTypes.Dirtbike.IKP
VehicleTypes.DuneBuggy = {}
local function DuneBuggyVehicleEnter(state, character)
	SetHumanoidEnabled(character, false)
end
VehicleTypes.DuneBuggy.VehicleEnter = DuneBuggyVehicleEnter
local function DuneBuggyUpdateWheel(state, wheel)
	local Pivot = wheel.Pivot
	local suspensionHeight = wheel.vh
	if wheel.Front then
		local turnCFrame = CFrame.fromAxisAngle((Vector3.new(0, 1, 0.5)).unit, -state.VisualTurnAngle)
		wheel.VisualJoint.C1 = CFrame.new(0, -suspensionHeight + wheel.VisualHalfHeight, 0) * turnCFrame * CFrame.Angles(state.WheelRotation, 0, 0)
	elseif wheel.Back then
		wheel.VisualJoint.C1 = CFrame.new(0, -suspensionHeight + wheel.VisualHalfHeight, 0) * CFrame.Angles(state.WheelRotation, 0, 0)
	end
	wheel.PivotJoint.C1 = Pivot.CFrame:toObjectSpace(CFrame.new(Pivot.Position, wheel.VisualModelRoot.Position)) * CFrame.new(0, 0, -2)
end
VehicleTypes.DuneBuggy.UpdateWheel = DuneBuggyUpdateWheel
local function DuneBuggyUpdateHQ(state, dt)
	local Engine = state.Model.Engine
end
VehicleTypes.DuneBuggy.UpdateHQ = DuneBuggyUpdateHQ
local function DuneBuggyUpdateLQ(state, dt) end
VehicleTypes.DuneBuggy.UpdateLQ = DuneBuggyUpdateLQ
local function DuneBuggyIKP(state, ikPacket)
	local Character = state.Character
	if Character and Character:IsDescendantOf(workspace) then
		local steeringCFrame = Character.PrimaryPart.CFrame * CFrame.new(0, 0, -1.5)
		local VisualTurnAngle = state.VisualTurnAngle
		if VisualTurnAngle then
			local IKP = state.IKP
			IKP.RightArm = steeringCFrame * Vector3.new(math.cos(VisualTurnAngle) * 0.8, math.sin(VisualTurnAngle) * -0.8, 0)
			IKP.LeftArm = steeringCFrame * Vector3.new(math.cos(VisualTurnAngle) * -0.8, math.sin(VisualTurnAngle) * 0.8, 0)
			IKP.RightAngle = -0.6 + VisualTurnAngle
			IKP.LeftAngle = 0.6 + VisualTurnAngle
			R15IKv2.Arms(IKP)
		end
	end
end
VehicleTypes.DuneBuggy.IKP = DuneBuggyIKP
local inputState = { 0, 0, 0, 0 }
local function updateFOV(state)
	local rawBlend = (state.LastFakeGear or 1) ^ 0.5 * (state.Model.Engine.AssemblyLinearVelocity.Magnitude / 120)
	if rawBlend ~= rawBlend then
		rawBlend = 0
	end
	local clamped = math.clamp(rawBlend, 0, 3)
	local fovBlend, cubeRoot
	if clamped < 0.825155 then
		fovBlend = clamped * clamped * clamped
		if not fovBlend then
			cubeRoot = clamped
			fovBlend = 1 - math.exp(-clamped)
		end
	else
		cubeRoot = clamped
		fovBlend = 1 - math.exp(-clamped)
	end
	local FieldOfView = CurrentCamera.FieldOfView
	CurrentCamera.FieldOfView = FieldOfView + (fovBlend * 30 * (state.Config.FOVMult or 1) + 70 - FieldOfView) * 0.7
end
local function VehicleEnter(state)
	local Character = LocalPlayer.Character
	if Character then
		state.IKP = R15IKv2.BuildPacketArms(Character)
		VehicleTypes[state.Make].VehicleEnter(state, Character)
		state.seatMaid:GiveTask(RunService.Heartbeat:Connect(function()
			updateFOV(state)
		end))
		state.seatMaid:GiveTask(function()
			CurrentCamera.FieldOfView = 70
		end)
		function state.setForward(val)
			inputState[1] = if val then 1 else 0
		end
		function state.setBackward(val)
			inputState[2] = if val then 1 else 0
		end
		if not state.Passenger then
			state.Model.Engine:FindFirstChild("NoGravForce").Enabled = true
		end
	end
end
local function VehicleLeave(state)
	local Character = LocalPlayer.Character
	if Character then
		SetHumanoidEnabled(Character, true)
		CurrentCamera.FieldOfView = 70
		state.IKP = nil
		if not state.Passenger then
			local Model = state.Model
			if Model then
				local Engine = Model:FindFirstChild("Engine")
				if Engine then
					local NoGravForce = Engine:FindFirstChild("NoGravForce")
					if NoGravForce then
						NoGravForce.Enabled = false
					end
				end
			end
			for k, sound in pairs(state.Sounds) do
				sound.Volume = 0
			end
			for _, wheel in next, state.Wheels do
				wheel.VectorForce.Force = ZERO_VECTOR
			end
			for _, stableEntry in next, state.Stable do
				stableEntry.Torque.Torque = ZERO_VECTOR
			end
		end
	end
end
local function UpdateWheels(state, dt, applyForces)
	local c4Models = {}
	for c4Item in pairs(C4Binder:GetAllSet()) do
		c4Models[#c4Models + 1] = c4Item._obj
	end
	c4Models[#c4Models + 1] = state.Model
	c4Models[#c4Models + 1] = LocalPlayer.Character
	local UpdateWheel = VehicleTypes[state.Make].UpdateWheel
	local allOnGround = true
	for _, wheel in next, state.Wheels do
		wheel.IgnoreModel = c4Models
		local suspensionHeight = (state.Config.Height or 1) + (state.Model:GetAttribute("GarageSuspensionHeight") or 0)
		local Part = wheel.Part
		local hitResult, hitPos, _ = RayCast.RayIgnoreNonCollideWithIgnoreList(Part.Position, -Part.CFrame.UpVector, suspensionHeight + 1, c4Models)
		wheel.Hit = hitResult
		wheel.vh = math.clamp((Part.Position - hitPos).Magnitude, suspensionHeight * 0.1, suspensionHeight * 1.1)
		UpdateWheel(state, wheel)
		local Spring = wheel.Spring
		if applyForces then
			if hitResult then
				WorldSpringSetTarget(Spring, hitPos + Vector3.new(0, suspensionHeight, 0))
			else
				Spring.Target = nil
			end
			WorldSpringUpdate(Spring, dt)
			local springForceY = Spring.f3.y
			if springForceY < 0 then
				springForceY = 0
			end
			local forceCapY = 200 + 5 / dt
			if forceCapY < springForceY then
				springForceY = forceCapY
			end
			local suspForce = Part.AssemblyMass * wheel.MassProp * Vector3.new(0, springForceY, 0)
			local ForceDrive = wheel.ForceDrive
			local lagMult = 1
			if PhysicsLagService.getEstimatedPhysicsStepsMult() >= 2 then
				lagMult = lagMult / 2
			end
			local clampedSuspForce = suspForce * math.clamp(lagMult, 0, 1)
			local totalForce = Vector3.new(0, 0, 0) + wheel.ForceFriction
			if hitResult then
				totalForce = totalForce + ForceDrive + clampedSuspForce
			end
			if clampedSuspForce.Magnitude > 1 then
				local Unit = clampedSuspForce.Unit
			end
			wheel.IsOnGround = hitResult and true or false
			if not wheel.IsOnGround then
				allOnGround = false
			end
			wheel.VectorForce.Force = totalForce
		end
	end
	state.AllOnGround = allOnGround
end
local function Blend(x, center, width)
	return math.exp(-(x - center) ^ 2 / (2 * width * width))
end
local function UpdateSounds(state, rpmNorm)
	local idleBlend = math.exp(-(rpmNorm - 0) ^ 2 / 0.18)
	local highBlend = 0.86 * math.exp(-(rpmNorm - 1) ^ 2 / 0.72) + 0.4 * math.exp(-(rpmNorm - 0.3) ^ 2 / 0.32000000000000006)
	state.Sounds.Idle.Volume = 0.5 * idleBlend * 0.7
	state.Sounds.High.Volume = 0.5 * highBlend
	state.Sounds.Idle.Pitch = 0.9 + (rpmNorm - 0.4) * 0.3
	state.Sounds.High.Pitch = 0.9 + (rpmNorm - 0.4) * 1
end
local function UpdateHQ(state, dt)
	local now = tick()
	local Model = state.Model
	local _cachedEngine = state._cachedEngine
	if not _cachedEngine or _cachedEngine.Parent ~= Model then
		local Engine = Model:FindFirstChild("Engine")
		state._cachedEngine = Engine
		_cachedEngine = Engine
	end
	if _cachedEngine then
		local Wheels = state.Wheels
		local Gears = state.Config.Gears
		local throttleInput = inputState[1] - inputState[2]
		local steerInput = inputState[3] - inputState[4]
		if InputUtils.isTouch() then
			local Character = LocalPlayer.Character
			if Character and Character:FindFirstChild("Humanoid") then
				local X = GetMoveVector().X
				local clampedX = math.clamp(X, -1, 1)
				steerInput = clampedX * math.abs(clampedX)
			end
		end
		if state.LockMovement then
			throttleInput = 0
			steerInput = 0
		end
		local Config = state.Config
		local frictionU = Config.u
		local frictionV = Config.v
		local brakeForce = Config.b * (1 + state.GarageBrakes)
		local lastPopTime = Model:GetAttribute("VehicleTiresLastPop") or 0
		local tiresPopped = math.min((Time.GetNowSync() - lastPopTime) / state.DisableDuration, 1) < 0.999
		if tiresPopped then
			brakeForce = brakeForce * 10
			frictionU = 1
			throttleInput = 0
		end
		if state.AreTiresPopped ~= tiresPopped then
			if tiresPopped then
				local soundParams = {
					Volume = 1
				}
				Audio.ObjectLocal(_cachedEngine, SoundIds.tire_pop, soundParams)
				Audio.ObjectLocal(_cachedEngine, SoundIds.tire_leak, soundParams)
			end
			state.AreTiresPopped = tiresPopped
		end
		local localVel = vectorToObjectSpace(_cachedEngine.CFrame, _cachedEngine.Velocity)
		local currentGear = state.Gear or 1
		local lastGear = state.LastGear or 1
		local lastGearSwitch = state.LastGearSwitch or 0
		local gearBlendTime = state.t3 or 0
		state.LastFakeGear = lastGear * (1 - gearBlendTime) + currentGear * gearBlendTime
		local currentGearRatio
		if lastGear == currentGear then
			currentGearRatio = Gears[2 + currentGear]
		else
			currentGearRatio = Gears[2 + lastGear] * (1 - gearBlendTime * gearBlendTime) + Gears[2 + currentGear] * gearBlendTime * gearBlendTime
			local newBlend = gearBlendTime + dt * 1 / 0.23
			state.t3 = newBlend
			if newBlend >= 1 then
				state.LastGear = currentGear
				state.t3 = 0
			end
		end
		local HandBrake = ChassisShared.HandBrake
		if HandBrake then
			HandBrake = steerInput ~= 0
		end
		local DriftSqueal = state.Sounds.DriftSqueal
		local currentDriftVolume = DriftSqueal.Volume
		local targetDriftVolume = if localVel.magnitude > 30 and HandBrake then currentDriftVolume + (0.3 - currentDriftVolume) * 0.06 else currentDriftVolume + (0 - currentDriftVolume) * 0.1
		if math.abs(DriftSqueal.Volume - targetDriftVolume) > 0.001 then
			DriftSqueal.Volume = targetDriftVolume
		end
		if HandBrake ~= Model:GetAttribute("VehicleIsDrifting") then
			Model:SetAttribute("VehicleIsDrifting", HandBrake)
			Model:FindFirstChild("RelayDriftingRemote"):FireServer(HandBrake)
		end
		local Preset = Model:FindFirstChild("Preset")
		if Preset and HandBrake then
			for _, child in Preset:GetChildren() do
				if child.Name == "Drift" then
					local ParticleEmitter = child:FindFirstChildOfClass("ParticleEmitter")
					if ParticleEmitter then
						ParticleEmitter:Emit(1)
					end
				end
			end
		end
		local currentThrottle = state.Throttle or 0
		local smoothedThrottle = currentThrottle + (throttleInput - currentThrottle) * 0.1
		state.Throttle = smoothedThrottle
		local wheelSpeedRPS = math.abs(localVel.Z) / Wheels[1].VisualHalfHeight
		local rpmSlowRaw = state.RPMSlow2 or 0
		local rpmSlowSmoothed = rpmSlowRaw + (wheelSpeedRPS * Gears[1] * Gears[2 + currentGear] * 30 / math.pi - rpmSlowRaw) * 0.2
		state.RPMSlow2 = rpmSlowSmoothed
		if now - lastGearSwitch > 0.3 and (throttleInput > 0 and (state.Config.RPMTopLine < rpmSlowSmoothed and currentGear < 5)) then
			state.LastGearSwitch = now
			currentGear = currentGear + 1
		elseif now - lastGearSwitch > 0.3 and (rpmSlowSmoothed < state.Config.RPMTopLine / 4 + 1000 and currentGear > 1) then
			state.LastGearSwitch = now
			currentGear = currentGear - 1
		end
		state.Gear = currentGear
		local Nitro = state.Nitro
		local engineForce = Config.f + state.GarageEngineSpeed * 1.1 + 1.2
		local targetTurnAngle = Config.TurnSpeed * steerInput
		local turnReductionFactor = math.clamp(1 - (Config.TurnCurveCoeff or 1) * math.sqrt((math.clamp((math.abs(localVel.Z) - 20) / 180, 0, 1))), 0.05, 1) * 0.65
		if not state._turnAngleTween then
			state._turnAngleTween = AccelTween.new(Config.TurnTweenMaxAccel or 15)
		end
		if state._turnAngleTween.t ~= targetTurnAngle then
			state._turnAngleTween.t = targetTurnAngle
		end
		local tweenedTurnAngle = state._turnAngleTween.p
		state.VisualLeanAngle = tweenedTurnAngle
		state.VisualTurnAngle = tweenedTurnAngle * turnReductionFactor
		state.Angle = targetTurnAngle * turnReductionFactor
		for _, wheel in next, Wheels do
			local driveForceFinal, gearRatioForDrive, driveForceRaw, nitroBonus
			local Part = wheel.Part
			local wheelCFrame = Part.CFrame
			if wheel.Front and wheel.IsOnGround then
				wheelCFrame = wheelCFrame * CFrame.Angles(0, -state.Angle, 0)
			end
			local wheelLocalVel = vectorToObjectSpace(wheelCFrame, Part.Velocity)
			local frictionForceU = -frictionU * Vector3.new(0, 0, wheelLocalVel.Z)
			local frictionForceV = -frictionV * Vector3.new(0, 0, wheelLocalVel.Z)
			local totalFriction = (frictionForceU + frictionForceV * math.abs(wheelLocalVel.Z)) * _cachedEngine.AssemblyMass
			local lateralFriction = 12 * (1 / 60 / dt) * _cachedEngine.AssemblyMass
			if wheel.Front then
				if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
					lateralFriction = lateralFriction * 0.85
				end
				totalFriction = totalFriction + -Vector3.new(lateralFriction * math.clamp(wheelLocalVel.X, -30, 30), 0, 0)
			elseif wheel.Back then
				if ChassisShared.HandBrake then
					lateralFriction = lateralFriction * Config.DriftFrictionMult
				end
				totalFriction = totalFriction + -Vector3.new(lateralFriction * math.clamp(wheelLocalVel.X, -30, 30), 0, 0)
			end
			wheel.ForceFriction = Math.Clampv3(totalFriction, -1000000, 1000000)
			local isBack = wheel.Back and true or false
			if isBack then
				gearRatioForDrive = throttleInput > 0 and Gears[2 + currentGear] or Gears[2]
				driveForceRaw = -engineForce * _cachedEngine.AssemblyMass * Vector3.new(0, 0, 1) * Gears[1] * gearRatioForDrive * smoothedThrottle
				if -localVel.Z > 0 and throttleInput < 0 then
					driveForceRaw = driveForceRaw - math.sign(throttleInput) * brakeForce * Vector3.new(0, 0, 1) * _cachedEngine.AssemblyMass
				end
			else
				driveForceRaw = ZERO_VECTOR
			end
			if Nitro and wheel.Back then
				nitroBonus = Nitro and 33 * _cachedEngine.AssemblyMass or 0
				driveForceRaw = driveForceRaw + nitroBonus / 2 * Vector3.new(0, -0.1, -1)
			end
			wheel.ForceDrive = driveForceRaw
		end
		if throttleInput == 0 then
			local _ = math.abs(localVel.Z) < 1
		end
		_cachedEngine.NoGravForce.Force = Vector3.new(0, 1, 0) * _cachedEngine.AssemblyMass * workspace.Gravity * (1 - if Nitro then 30 else 100 / 196.20000000000002)
		state.WheelRotation = (state.WheelRotation + localVel.Z * dt / Wheels[1].VisualHalfHeight) % 6.283185307179586
		UpdateWheels(state, dt, true)
		VehicleTypes[state.Make].UpdateHQ(state, dt)
		local rpmNormalized = math.clamp(wheelSpeedRPS * Gears[1] * currentGearRatio * 30 / math.pi / state.Config.RPMTopLine, 0, 1)
		local rpmSlowOld = state.RPMSlow or 0
		local rpmSlowNew = rpmSlowOld + (rpmNormalized - rpmSlowOld) * 0.5
		state.RPMSlow = rpmSlowNew
		UpdateSounds(state, rpmSlowNew)
		local brakelightsOn = throttleInput <= 0
		if state._lastBrakelightsEnabled ~= brakelightsOn then
			state._lastBrakelightsEnabled = brakelightsOn
			VehicleUtils.setBrakelightsEnabled(Model, brakelightsOn)
		end
	end
end
local function UpdateStepped(state)
	local IKP = state.IKP
	if IKP then
		local ikpFunc = VehicleTypes[state.Make].IKP
		if ikpFunc then
			ikpFunc(state, IKP)
		end
	end
end
local function UpdateLQ(state, dt)
	local Model = state.Model
	local _cachedEngine = state._cachedEngine
	if not _cachedEngine or _cachedEngine.Parent ~= Model then
		local Engine = Model:FindFirstChild("Engine")
		state._cachedEngine = Engine
		_cachedEngine = Engine
	end
	if _cachedEngine then
		local Gears = state.Config.Gears
		local localVel = vectorToObjectSpace(_cachedEngine.CFrame, _cachedEngine.Velocity)
		state.VisualTurnAngle = -_cachedEngine.RotVelocity.Y * 0.3
		local Wheels = state.Wheels
		state.WheelRotation = (state.WheelRotation + localVel.Z * dt / Wheels[1].VisualHalfHeight) % 6.283185307179586
		UpdateWheels(state, dt, false)
		local rpmNormalized = math.clamp(math.abs(localVel.Z) * 60 * dt / Wheels[1].VisualHalfHeight * Gears[1] * Gears[3] * 60 / 6.283185307179586 / state.Config.RPMTopLine, 0, 1)
		local rpmSlowOld = state.RPMSlow or 0
		local rpmSlowNew = rpmSlowOld + (rpmNormalized - rpmSlowOld) * 0.1
		state.RPMSlow = rpmSlowNew
		UpdateSounds(state, rpmSlowNew)
	end
end
local function SetEvent(event)
	currentEvent = event
end
local keyInputMap = {
	[Enum.KeyCode.A] = 4,
	[Enum.KeyCode.D] = 3,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 2,
	[Enum.KeyCode.Left] = 4,
	[Enum.KeyCode.Right] = 3
}
local function InputBegan(input, gameProcessed)
	if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = input.KeyCode
		if keyInputMap[KeyCode] then
			inputState[keyInputMap[KeyCode]] = 1
		end
	end
end
local function InputEnded(input, gameProcessed)
	if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = input.KeyCode
		if keyInputMap[KeyCode] then
			inputState[keyInputMap[KeyCode]] = 0
		end
	elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = input.KeyCode
		if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			inputState[keyInputMap[KeyCode]] = 0
		end
	end
end
local function InputChanged(input)
	if input.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = input.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = input.Position
			local X = Position.X
			local Y = Position.Y
			inputState[4] = X < -0.24 and (-X) ^ 2 or 0
			inputState[3] = X > 0.24 and X ^ 2 or 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = input.Position.Z
			inputState[keyInputMap[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
		end
	end
end
UserInputService.InputBegan:connect(InputBegan)
UserInputService.InputEnded:connect(InputEnded)
UserInputService.InputChanged:connect(InputChanged)
return {
	VehicleEnter = VehicleEnter,
	VehicleLeave = VehicleLeave,
	UpdateHQ = UpdateHQ,
	UpdateLQ = UpdateLQ,
	UpdateStepped = UpdateStepped,
	SetEvent = SetEvent
}
