-- https://lua.expert/
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
local v1 = nil
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
local v2 = CFrame.new
local v3 = Vector3.new
local Angles = CFrame.Angles
local v4 = v2()
local v5 = v3()
local vectorToObjectSpace = v4.vectorToObjectSpace
local WorldSpringSetTarget = Math.WorldSpringSetTarget
local WorldSpringUpdate = Math.WorldSpringUpdate
local t = {
	tire_pop = 4534995816,
	tire_leak = 4534995685
}
local function rotateAxisAngle(p1, p2, p3) --[[ rotateAxisAngle | Line: 40 ]]
	local v1 = math.sin(p3)
	local v2 = math.cos(p3)
	local v3 = p1:Cross(p2)
	local v4 = p1:Dot(p2)
	return v4 * p1 + v2 * (p1 - v4 * p2) + v1 * v3
end
local function GetMoveVector() --[[ GetMoveVector | Line: 67 ]]
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local v6 = require(ControlModule)
	GetMoveVector = function() --[[ GetMoveVector | Line: 74 | Upvalues: v6 (ref) ]]
		return v6:GetMoveVector()
	end
end
local function SetHumanoidEnabled(p1, p2) --[[ SetHumanoidEnabled | Line: 80 ]]
	local Humanoid = p1:FindFirstChildOfClass("Humanoid")
	for v1, v2 in Enum.HumanoidStateType:GetEnumItems() do
		if v2 ~= Enum.HumanoidStateType.Dead and (v2 ~= Enum.HumanoidStateType.None and v2 ~= Enum.HumanoidStateType.Jumping) then
			Humanoid:SetStateEnabled(v2, p2)
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
local function hookAnimations(p1, p2, p3) --[[ hookAnimations | Line: 113 | Upvalues: Animation (copy), Animation_2 (copy), Animation_3 (copy), Animation_4 (copy), Interval (copy) ]]
	local Animator = p3:FindFirstChildOfClass("Humanoid"):WaitForChild("Animator", 10)
	local v1 = Animator:LoadAnimation(Animation)
	local v2 = Animator:LoadAnimation(Animation_2)
	local v3 = Animator:LoadAnimation(Animation_3)
	local v4 = Animator:LoadAnimation(Animation_4)
	local t = {
		{
			track = v1
		},
		{
			track = v2
		},
		{
			track = v3
		},
		{
			track = v4
		}
	}
	p2:GiveTask(Interval.every(0.1):Connect(function() --[[ Line: 128 | Upvalues: p1 (copy), t (copy) ]]
		local v1 = p1.CFrame:VectorToObjectSpace(p1.Velocity)
		local v2 = p1.CFrame:VectorToObjectSpace(p1.RotVelocity)
		local v3 = math.abs(v1.Z)
		local v5 = math.clamp(v2.Y / 0.5, 0, 1)
		local v7 = math.clamp(-v2.Y / 0.5, 0, 1)
		local v8 = math.clamp(v3 / 20, 0, 1)
		local v10 = v8 * math.clamp(1 - math.max(v5, v7) * 2, 0, 1)
		t[1].weight = 1 - math.max(v10, v5, v7)
		t[2].weight = v10
		t[3].weight = v5
		t[4].weight = v7
		local list = {}
		for i, v in ipairs(t) do
			if v.weight > 0.1 then
				table.insert(list, i)
			else
				v.track:Stop(0.5)
			end
		end
		for i, v in ipairs(list) do
			local v12 = t[v]
			if not v12.track.IsPlaying then
				v12.track:Play(0.25)
			end
			v12.track:AdjustWeight(v12.weight, 0.25)
		end
	end))
	p2:GiveTask(function() --[[ Line: 162 | Upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy) ]]
		v1:Stop()
		v1:Destroy()
		v2:Stop()
		v2:Destroy()
		v3:Stop()
		v3:Destroy()
		v4:Stop()
		v4:Destroy()
	end)
end
local t2 = {
	Dirtbike = {}
}
local function VehicleEnter(p1, p2) --[[ VehicleEnter | Line: 179 | Upvalues: SetHumanoidEnabled (copy), hookAnimations (copy) ]]
	SetHumanoidEnabled(p2, false)
	hookAnimations(p1.Model:FindFirstChild("Engine"), p1.seatMaid, p2)
end
t2.Dirtbike.VehicleEnter = VehicleEnter
local function UpdateWheel(p1, p2) --[[ UpdateWheel | Line: 187 | Upvalues: v2 (copy), Angles (copy) ]]
	local vh = p2.vh
	if p2.Front then
		local v1 = CFrame.fromAxisAngle((Vector3.new(0, 1, 1)).unit, -p1.VisualTurnAngle)
		if p2.HoldJoint then
			p2.HoldJoint.C1 = v2(0, -vh, 0) * v2(0, p2.HoldSize.Y * 1.5 - 0.1, p2.HoldSize.Z * 0.5 - 0.05) * v1 * Angles(0, 0, math.pi)
		end
		p2.VisualJoint.C1 = v2(0, -vh + p2.VisualHalfHeight, 0) * v1 * Angles(p1.WheelRotation, 0, 0)
	elseif p2.Back then
		if p2.HoldJoint then
			p2.HoldJoint.C1 = v2(0, -vh, 0) * v2(0, p2.HoldSize.Y * 1.5, -p2.HoldSize.Z * 0.5 + 0.05) * Angles(0, 0, math.pi)
		end
		p2.VisualJoint.C1 = v2(0, -vh + p2.VisualHalfHeight, 0) * Angles(p1.WheelRotation, 0, 0)
	end
end
t2.Dirtbike.UpdateWheel = UpdateWheel
local function UpdateHQ(p1, p2) --[[ UpdateHQ | Line: 207 | Upvalues: v3 (copy) ]]
	local Engine = p1.Model.Engine
	local v1 = CFrame.fromAxisAngle(Engine.CFrame.LookVector, p1.VisualLeanAngle * 0.4) * Vector3.new(0, 1, 0)
	local v2 = Engine.CFrame.LookVector:Cross(v1)
	for v32, v4 in next, p1.Stable do
		v4.Align.Enabled = true
		v4.Align.PrimaryAxis = v2
		v4.Torque.Enabled = true
		local v5 = Engine.CFrame:VectorToObjectSpace(Engine.RotVelocity)
		v4.Torque.Torque = Engine.AssemblyMass * v3(-Engine.CFrame.LookVector:Dot(v1) * 70 - v5.X * 8, 0, 0)
	end
end
t2.Dirtbike.UpdateHQ = UpdateHQ
local function UpdateLQ(p1, p2) --[[ UpdateLQ | Line: 229 ]] end
t2.Dirtbike.UpdateLQ = UpdateLQ
local function IKP(p1, p2) --[[ IKP | Line: 230 | Upvalues: R15IKv2 (copy), Angles (copy) ]]
	local VisualTurnAngle = p1.VisualTurnAngle
	if VisualTurnAngle then
		local IKP = p1.IKP
		IKP.RightArm = p1.Model.Handlebar.RightHand.Position
		IKP.LeftArm = p1.Model.Handlebar.LeftHand.Position
		IKP.RightAngle = -0.95 + VisualTurnAngle
		IKP.LeftAngle = 0.95 + VisualTurnAngle
		R15IKv2.Arms(IKP)
		p1.HandlebarJoint.C1 = Angles(0, -VisualTurnAngle, 0)
	end
end
t2.Dirtbike.IKP = IKP
t2.Patrol = {}
t2.Patrol.VehicleEnter = t2.Dirtbike.VehicleEnter
t2.Patrol.UpdateWheel = t2.Dirtbike.UpdateWheel
t2.Patrol.UpdateHQ = t2.Dirtbike.UpdateHQ
t2.Patrol.UpdateLQ = t2.Dirtbike.UpdateLQ
t2.Patrol.IKP = t2.Dirtbike.IKP
t2.FalconS = {}
t2.FalconS.VehicleEnter = t2.Dirtbike.VehicleEnter
t2.FalconS.UpdateWheel = t2.Dirtbike.UpdateWheel
t2.FalconS.UpdateHQ = t2.Dirtbike.UpdateHQ
t2.FalconS.UpdateLQ = t2.Dirtbike.UpdateLQ
t2.FalconS.IKP = t2.Dirtbike.IKP
t2.DuneBuggy = {}
local function VehicleEnter_2(p1, p2) --[[ VehicleEnter | Line: 263 | Upvalues: SetHumanoidEnabled (copy) ]]
	SetHumanoidEnabled(p2, false)
end
t2.DuneBuggy.VehicleEnter = VehicleEnter_2
local function UpdateWheel_2(p1, p2) --[[ UpdateWheel | Line: 266 | Upvalues: v2 (copy), Angles (copy) ]]
	local Pivot = p2.Pivot
	local vh = p2.vh
	if p2.Front then
		local v1 = CFrame.fromAxisAngle((Vector3.new(0, 1, 0.5)).unit, -p1.VisualTurnAngle)
		p2.VisualJoint.C1 = v2(0, -vh + p2.VisualHalfHeight, 0) * v1 * Angles(p1.WheelRotation, 0, 0)
	elseif p2.Back then
		p2.VisualJoint.C1 = v2(0, -vh + p2.VisualHalfHeight, 0) * Angles(p1.WheelRotation, 0, 0)
	end
	p2.PivotJoint.C1 = Pivot.CFrame:toObjectSpace(v2(Pivot.Position, p2.VisualModelRoot.Position)) * v2(0, 0, -2)
end
t2.DuneBuggy.UpdateWheel = UpdateWheel_2
local function UpdateHQ_2(p1, p2) --[[ UpdateHQ | Line: 279 ]]
	local Engine = p1.Model.Engine
end
t2.DuneBuggy.UpdateHQ = UpdateHQ_2
local function UpdateLQ_2(p1, p2) --[[ UpdateLQ | Line: 292 ]] end
t2.DuneBuggy.UpdateLQ = UpdateLQ_2
local function IKP_2(p1, p2) --[[ IKP | Line: 293 | Upvalues: v2 (copy), v3 (copy), R15IKv2 (copy) ]]
	local Character = p1.Character
	if Character and Character:IsDescendantOf(workspace) then
		local v1 = Character.PrimaryPart.CFrame * v2(0, 0, -1.5)
		local VisualTurnAngle = p1.VisualTurnAngle
		if VisualTurnAngle then
			local IKP = p1.IKP
			IKP.RightArm = v1 * v3(math.cos(VisualTurnAngle) * 0.8, math.sin(VisualTurnAngle) * -0.8, 0)
			IKP.LeftArm = v1 * v3(math.cos(VisualTurnAngle) * -0.8, math.sin(VisualTurnAngle) * 0.8, 0)
			IKP.RightAngle = -0.6 + VisualTurnAngle
			IKP.LeftAngle = 0.6 + VisualTurnAngle
			R15IKv2.Arms(IKP)
		end
	end
end
t2.DuneBuggy.IKP = IKP_2
local t3 = { 0, 0, 0, 0 }
local function updateFOV(p1) --[[ updateFOV | Line: 319 | Upvalues: CurrentCamera (copy) ]]
	local v1 = (p1.LastFakeGear or 1) ^ 0.5 * (p1.Model.Engine.AssemblyLinearVelocity.Magnitude / 120)
	if v1 ~= v1 then
		v1 = 0
	end
	local v2 = math.clamp(v1, 0, 3)
	local v3, v4
	if v2 < 0.825155 then
		v3 = v2 * v2 * v2
		if not v3 then
			v4 = v2
			v3 = 1 - math.exp(-v2)
		end
	else
		v4 = v2
		v3 = 1 - math.exp(-v2)
	end
	local FieldOfView = CurrentCamera.FieldOfView
	CurrentCamera.FieldOfView = FieldOfView + (v3 * 30 * (p1.Config.FOVMult or 1) + 70 - FieldOfView) * 0.7
end
local function VehicleEnter_3(p1) --[[ VehicleEnter | Line: 334 | Upvalues: LocalPlayer (copy), R15IKv2 (copy), t2 (copy), RunService (copy), updateFOV (copy), CurrentCamera (copy), t3 (copy) ]]
	local Character = LocalPlayer.Character
	if Character then
		p1.IKP = R15IKv2.BuildPacketArms(Character)
		t2[p1.Make].VehicleEnter(p1, Character)
		p1.seatMaid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 345 | Upvalues: updateFOV (ref), p1 (copy) ]]
			updateFOV(p1)
		end))
		p1.seatMaid:GiveTask(function() --[[ Line: 348 | Upvalues: CurrentCamera (ref) ]]
			CurrentCamera.FieldOfView = 70
		end)
		function p1.setForward(p1) --[[ setForward | Line: 352 | Upvalues: t3 (ref) ]]
			t3[1] = if p1 then 1 else 0
		end
		function p1.setBackward(p1) --[[ setBackward | Line: 355 | Upvalues: t3 (ref) ]]
			t3[2] = if p1 then 1 else 0
		end
		if not p1.Passenger then
			p1.Model.Engine:FindFirstChild("NoGravForce").Enabled = true
		end
	end
end
local function VehicleLeave(p1) --[[ VehicleLeave | Line: 365 | Upvalues: LocalPlayer (copy), SetHumanoidEnabled (copy), CurrentCamera (copy), v5 (copy) ]]
	local Character = LocalPlayer.Character
	if Character then
		SetHumanoidEnabled(Character, true)
		CurrentCamera.FieldOfView = 70
		p1.IKP = nil
		if not p1.Passenger then
			local Model = p1.Model
			if Model then
				local Engine = Model:FindFirstChild("Engine")
				if Engine then
					local NoGravForce = Engine:FindFirstChild("NoGravForce")
					if NoGravForce then
						NoGravForce.Enabled = false
					end
				end
			end
			for k, v in pairs(p1.Sounds) do
				v.Volume = 0
			end
			for v1, v2 in next, p1.Wheels do
				v2.VectorForce.Force = v5
			end
			for v3, v4 in next, p1.Stable do
				v4.Torque.Torque = v5
			end
		end
	end
end
local function UpdateWheels(p1, p2, p3) --[[ UpdateWheels | Line: 398 | Upvalues: C4Binder (copy), LocalPlayer (copy), t2 (copy), RayCast (copy), WorldSpringSetTarget (copy), v3 (copy), WorldSpringUpdate (copy), PhysicsLagService (copy) ]]
	local t = {}
	for k in pairs(C4Binder:GetAllSet()) do
		t[#t + 1] = k._obj
	end
	t[#t + 1] = p1.Model
	t[#t + 1] = LocalPlayer.Character
	local UpdateWheel = t2[p1.Make].UpdateWheel
	local v1 = true
	for v2, v32 in next, p1.Wheels do
		v32.IgnoreModel = t
		local v4 = (p1.Config.Height or 1) + (p1.Model:GetAttribute("GarageSuspensionHeight") or 0)
		local Part = v32.Part
		local v5, v6, _ = RayCast.RayIgnoreNonCollideWithIgnoreList(Part.Position, -Part.CFrame.UpVector, v4 + 1, t)
		v32.Hit = v5
		v32.vh = math.clamp((Part.Position - v6).Magnitude, v4 * 0.1, v4 * 1.1)
		UpdateWheel(p1, v32)
		local Spring = v32.Spring
		if p3 then
			if v5 then
				WorldSpringSetTarget(Spring, v6 + v3(0, v4, 0))
			else
				Spring.Target = nil
			end
			WorldSpringUpdate(Spring, p2)
			local y = Spring.f3.y
			if y < 0 then
				y = 0
			end
			local v7 = 200 + 5 / p2
			if v7 < y then
				y = v7
			end
			local v8 = Part.AssemblyMass * v32.MassProp * v3(0, y, 0)
			local ForceDrive = v32.ForceDrive
			local v9 = 1
			if PhysicsLagService.getEstimatedPhysicsStepsMult() >= 2 then
				v9 = v9 / 2
			end
			local v10 = v8 * math.clamp(v9, 0, 1)
			local v11 = Vector3.new(0, 0, 0) + v32.ForceFriction
			if v5 then
				v11 = v11 + ForceDrive + v10
			end
			if v10.Magnitude > 1 then
				local Unit = v10.Unit
			end
			v32.IsOnGround = v5 and true or false
			if not v32.IsOnGround then
				v1 = false
			end
			v32.VectorForce.Force = v11
		end
	end
	p1.AllOnGround = v1
end
local function Blend(p1, p2, p3) --[[ Blend | Line: 481 ]]
	return math.exp(-(p1 - p2) ^ 2 / (2 * p3 * p3))
end
local function UpdateSounds(p1, p2) --[[ UpdateSounds | Line: 484 ]]
	local v1 = math.exp(-(p2 - 0) ^ 2 / 0.18)
	local v2 = 0.86 * math.exp(-(p2 - 1) ^ 2 / 0.72) + 0.4 * math.exp(-(p2 - 0.3) ^ 2 / 0.32000000000000006)
	p1.Sounds.Idle.Volume = 0.5 * v1 * 0.7
	p1.Sounds.High.Volume = 0.5 * v2
	p1.Sounds.Idle.Pitch = 0.9 + (p2 - 0.4) * 0.3
	p1.Sounds.High.Pitch = 0.9 + (p2 - 0.4) * 1
end
local function UpdateHQ_3(p1, p2) --[[ UpdateHQ | Line: 495 | Upvalues: t3 (copy), InputUtils (copy), LocalPlayer (copy), GetMoveVector (ref), Time (copy), Audio (copy), t (copy), vectorToObjectSpace (copy), ChassisShared (copy), AccelTween (copy), v3 (copy), EnvironmentUtils (copy), EnvironmentConsts (copy), Math (copy), v5 (copy), UpdateWheels (copy), t2 (copy), UpdateSounds (copy), VehicleUtils (copy) ]]
	local v1 = tick()
	local Model = p1.Model
	local _cachedEngine = p1._cachedEngine
	if not _cachedEngine or _cachedEngine.Parent ~= Model then
		local Engine = Model:FindFirstChild("Engine")
		p1._cachedEngine = Engine
		_cachedEngine = Engine
	end
	if _cachedEngine then
		local Wheels = p1.Wheels
		local Gears = p1.Config.Gears
		local v2 = t3[1] - t3[2]
		local v32 = t3[3] - t3[4]
		if InputUtils.isTouch() then
			local Character = LocalPlayer.Character
			if Character and Character:FindFirstChild("Humanoid") then
				local X = GetMoveVector().X
				local v4 = math.clamp(X, -1, 1)
				v32 = v4 * math.abs(v4)
			end
		end
		if p1.LockMovement then
			v32 = 0
			v2 = 0
		end
		local Config = p1.Config
		local u = Config.u
		local v = Config.v
		local v52 = Config.b * (1 + p1.GarageBrakes)
		local v6 = Model:GetAttribute("VehicleTiresLastPop") or 0
		local v8 = math.min((Time.GetNowSync() - v6) / p1.DisableDuration, 1) < 0.999
		if v8 then
			u = 1
			v2 = 0
			v52 = v52 * 10
		end
		if p1.AreTiresPopped ~= v8 then
			if v8 then
				local t4 = {
					Volume = 1
				}
				Audio.ObjectLocal(_cachedEngine, t.tire_pop, t4)
				Audio.ObjectLocal(_cachedEngine, t.tire_leak, t4)
			end
			p1.AreTiresPopped = v8
		end
		local v9 = vectorToObjectSpace(_cachedEngine.CFrame, _cachedEngine.Velocity)
		local count = p1.Gear or 1
		local v10 = p1.LastGear or 1
		local v11 = p1.LastGearSwitch or 0
		local v12 = p1.t3 or 0
		p1.LastFakeGear = v10 * (1 - v12) + count * v12
		local v13
		if v10 == count then
			v13 = Gears[2 + count]
		else
			v13 = Gears[2 + v10] * (1 - v12 * v12) + Gears[2 + count] * v12 * v12
			local v14 = v12 + p2 * 1 / 0.23
			p1.t3 = v14
			if v14 >= 1 then
				p1.LastGear = count
				p1.t3 = 0
			end
		end
		local HandBrake = ChassisShared.HandBrake
		if HandBrake then
			HandBrake = v32 ~= 0
		end
		local DriftSqueal = p1.Sounds.DriftSqueal
		local Volume = DriftSqueal.Volume
		local v16 = if v9.magnitude > 30 and HandBrake then Volume + (0.3 - Volume) * 0.06 else Volume + (0 - Volume) * 0.1
		if math.abs(DriftSqueal.Volume - v16) > 0.001 then
			DriftSqueal.Volume = v16
		end
		if HandBrake ~= Model:GetAttribute("VehicleIsDrifting") then
			Model:SetAttribute("VehicleIsDrifting", HandBrake)
			Model:FindFirstChild("RelayDriftingRemote"):FireServer(HandBrake)
		end
		local Preset = Model:FindFirstChild("Preset")
		if Preset and HandBrake then
			for v18, v19 in Preset:GetChildren() do
				if v19.Name == "Drift" then
					local ParticleEmitter = v19:FindFirstChildOfClass("ParticleEmitter")
					if ParticleEmitter then
						ParticleEmitter:Emit(1)
					end
				end
			end
		end
		local v20 = p1.Throttle or 0
		local v21 = v20 + (v2 - v20) * 0.1
		p1.Throttle = v21
		local v22 = math.abs(v9.Z) / Wheels[1].VisualHalfHeight
		local v24 = p1.RPMSlow2 or 0
		local v25 = v24 + (v22 * Gears[1] * Gears[2 + count] * 30 / math.pi - v24) * 0.2
		p1.RPMSlow2 = v25
		if v1 - v11 > 0.3 and (v2 > 0 and (p1.Config.RPMTopLine < v25 and count < 5)) then
			p1.LastGearSwitch = v1
			count = count + 1
		elseif v1 - v11 > 0.3 and (v25 < p1.Config.RPMTopLine / 4 + 1000 and count > 1) then
			p1.LastGearSwitch = v1
			count = count - 1
		end
		p1.Gear = count
		local Nitro = p1.Nitro
		local v26 = Config.f + p1.GarageEngineSpeed * 1.1 + 1.2
		local v28 = Config.TurnSpeed * v32
		local v322 = math.clamp(1 - (Config.TurnCurveCoeff or 1) * math.sqrt((math.clamp((math.abs(v9.Z) - 20) / 180, 0, 1))), 0.05, 1) * 0.65
		if not p1._turnAngleTween then
			p1._turnAngleTween = AccelTween.new(Config.TurnTweenMaxAccel or 15)
		end
		if p1._turnAngleTween.t ~= v28 then
			p1._turnAngleTween.t = v28
		end
		local p = p1._turnAngleTween.p
		p1.VisualLeanAngle = p
		p1.VisualTurnAngle = p * v322
		p1.Angle = v28 * v322
		for v36, v37 in next, Wheels do
			local v33, v34, sum, v35
			local Part = v37.Part
			local v38 = Part.CFrame
			if v37.Front and v37.IsOnGround then
				v38 = v38 * CFrame.Angles(0, -p1.Angle, 0)
			end
			local v39 = vectorToObjectSpace(v38, Part.Velocity)
			local v40 = -u * v3(0, 0, v39.Z)
			local v41 = -v * v3(0, 0, v39.Z)
			local sum_2 = (v40 + v41 * math.abs(v39.Z)) * _cachedEngine.AssemblyMass
			local v42 = 12 * (1 / 60 / p2) * _cachedEngine.AssemblyMass
			if v37.Front then
				if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
					v42 = v42 * 0.85
				end
				sum_2 = sum_2 + -v3(v42 * math.clamp(v39.X, -30, 30), 0, 0)
			elseif v37.Back then
				if ChassisShared.HandBrake then
					v42 = v42 * Config.DriftFrictionMult
				end
				sum_2 = sum_2 + -v3(v42 * math.clamp(v39.X, -30, 30), 0, 0)
			end
			v37.ForceFriction = Math.Clampv3(sum_2, -1000000, 1000000)
			v33 = v37.Back and true or false
			if v33 then
				v34 = v2 > 0 and Gears[2 + count] or Gears[2]
				sum = -v26 * _cachedEngine.AssemblyMass * Vector3.new(0, 0, 1) * Gears[1] * v34 * v21
				if -v9.Z > 0 and v2 < 0 then
					sum = sum - math.sign(v2) * v52 * Vector3.new(0, 0, 1) * _cachedEngine.AssemblyMass
				end
			else
				sum = v5
			end
			if Nitro and v37.Back then
				v35 = Nitro and 33 * _cachedEngine.AssemblyMass or 0
				sum = sum + v35 / 2 * Vector3.new(0, -0.1, -1)
			end
			v37.ForceDrive = sum
		end
		if v2 == 0 then
			local _ = math.abs(v9.Z) < 1
		end
		_cachedEngine.NoGravForce.Force = Vector3.new(0, 1, 0) * _cachedEngine.AssemblyMass * workspace.Gravity * (1 - if Nitro then 30 else 100 / 196.20000000000002)
		p1.WheelRotation = (p1.WheelRotation + v9.Z * p2 / Wheels[1].VisualHalfHeight) % 6.283185307179586
		UpdateWheels(p1, p2, true)
		t2[p1.Make].UpdateHQ(p1, p2)
		local v48 = math.clamp(v22 * Gears[1] * v13 * 30 / math.pi / p1.Config.RPMTopLine, 0, 1)
		local v49 = p1.RPMSlow or 0
		local v50 = v49 + (v48 - v49) * 0.5
		p1.RPMSlow = v50
		UpdateSounds(p1, v50)
		local v51 = v2 <= 0
		if p1._lastBrakelightsEnabled ~= v51 then
			p1._lastBrakelightsEnabled = v51
			VehicleUtils.setBrakelightsEnabled(Model, v51)
		end
	end
end
local function UpdateStepped(p1) --[[ UpdateStepped | Line: 800 | Upvalues: t2 (copy) ]]
	local IKP = p1.IKP
	if IKP then
		local IKP_2 = t2[p1.Make].IKP
		if IKP_2 then
			IKP_2(p1, IKP)
		end
	end
end
local function UpdateLQ_3(p1, p2) --[[ UpdateLQ | Line: 810 | Upvalues: vectorToObjectSpace (copy), UpdateWheels (copy), UpdateSounds (copy) ]]
	local Model = p1.Model
	local _cachedEngine = p1._cachedEngine
	if not _cachedEngine or _cachedEngine.Parent ~= Model then
		local Engine = Model:FindFirstChild("Engine")
		p1._cachedEngine = Engine
		_cachedEngine = Engine
	end
	if _cachedEngine then
		local Gears = p1.Config.Gears
		local v1 = vectorToObjectSpace(_cachedEngine.CFrame, _cachedEngine.Velocity)
		p1.VisualTurnAngle = -_cachedEngine.RotVelocity.Y * 0.3
		local Wheels = p1.Wheels
		p1.WheelRotation = (p1.WheelRotation + v1.Z * p2 / Wheels[1].VisualHalfHeight) % 6.283185307179586
		UpdateWheels(p1, p2, false)
		local v4 = math.clamp(math.abs(v1.Z) * 60 * p2 / Wheels[1].VisualHalfHeight * Gears[1] * Gears[3] * 60 / 6.283185307179586 / p1.Config.RPMTopLine, 0, 1)
		local v5 = p1.RPMSlow or 0
		local v6 = v5 + (v4 - v5) * 0.1
		p1.RPMSlow = v6
		UpdateSounds(p1, v6)
	end
end
local function SetEvent(p1) --[[ SetEvent | Line: 858 | Upvalues: v1 (ref) ]]
	v1 = p1
end
local t4 = {
	[Enum.KeyCode.A] = 4,
	[Enum.KeyCode.D] = 3,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 2,
	[Enum.KeyCode.Left] = 4,
	[Enum.KeyCode.Right] = 3
}
local function InputBegan(p1, p2) --[[ InputBegan | Line: 873 | Upvalues: t4 (copy), t3 (copy) ]]
	if not p2 and p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t4[KeyCode] then
			t3[t4[KeyCode]] = 1
		end
	end
end
local function InputEnded(p1, p2) --[[ InputEnded | Line: 884 | Upvalues: t4 (copy), t3 (copy) ]]
	if not p2 and p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t4[KeyCode] then
			t3[t4[KeyCode]] = 0
		end
	elseif not p2 and p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			t3[t4[KeyCode]] = 0
		end
	end
end
local function InputChanged(p1) --[[ InputChanged | Line: 900 | Upvalues: t3 (copy), t4 (copy) ]]
	if p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = p1.Position
			local X = Position.X
			local Y = Position.Y
			t3[4] = X < -0.24 and (-X) ^ 2 or 0
			t3[3] = X > 0.24 and X ^ 2 or 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = p1.Position.Z
			t3[t4[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
		end
	end
end
UserInputService.InputBegan:connect(InputBegan)
UserInputService.InputEnded:connect(InputEnded)
UserInputService.InputChanged:connect(InputChanged)
return {
	VehicleEnter = VehicleEnter_3,
	VehicleLeave = VehicleLeave,
	UpdateHQ = UpdateHQ_3,
	UpdateLQ = UpdateLQ_3,
	UpdateStepped = UpdateStepped,
	SetEvent = SetEvent
}
