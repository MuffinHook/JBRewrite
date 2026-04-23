local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("StarterPlayer")
local UserInputService = game:GetService("UserInputService")
local UI = require(ReplicatedStorage.Module.UI)
local CollectionService = game:GetService("CollectionService")
require(ReplicatedStorage.Game.LoadingBar)
require(ReplicatedStorage.Module.AlexWM)
local Time = require(ReplicatedStorage.Module.Time)
local CrossHair = require(ReplicatedStorage.Game.CrossHair)
require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local Binder = require(ReplicatedStorage.Std.Binder)
require(ReplicatedStorage.Std.GeomUtils)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Missile = require(ReplicatedStorage.Game.Missile)
Missile.Init()
local Bomb = require(script.Bomb)
local Players = game:GetService("Players")
local C4Consts = require(ReplicatedStorage.Game.C4.C4Consts)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Raycast = require(ReplicatedStorage.Std.Raycast)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local v1 = CFrame.new
local v2 = Vector3.new
local Angles = CFrame.Angles
local v3 = v1(0, 0, 0)
local abs = math.abs
local vectorToObjectSpace = v3.vectorToObjectSpace
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local function GetMoveVector() --[[ Line: 40 ]]
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local v4 = require(ControlModule)
	GetMoveVector = function() --[[ Name: GetMoveVector | Line: 47 | Upvalues: v4 (ref) ]]
		return v4:GetMoveVector()
	end
end
local v5 = nil
local v6 = Binder.new("HeliSpotlight", require(ReplicatedStorage.Game.Vehicle.Heli.Spotlight))
local t = { 0, 0, 0, 0, 0, 0 }
local t2 = {}
local function SpinProp(p1, p2) --[[ Line: 60 | Upvalues: Angles (copy) ]]
	local PropAlpha = p1.PropAlpha
	local TopRotorMotor = p1.TopRotorMotor
	TopRotorMotor.C1 = TopRotorMotor.C1 * Angles(0, 31.4 * p2 * PropAlpha, 0)
	local TailRotorMotor = p1.TailRotorMotor
	TailRotorMotor.C1 = TailRotorMotor.C1 * Angles(0, 31.4 * p2 * PropAlpha, 0)
	if p1._lastPropAlpha ~= PropAlpha then
		p1._lastPropAlpha = PropAlpha
		p1.Model.Model.TailDisc.Transparency = 1 - PropAlpha * 0.15
		p1.Model.Model.TopDisc.Transparency = 1 - PropAlpha * 0.15
	end
end
local function FadeInProp(p1) --[[ Line: 74 | Upvalues: SpinProp (copy), RunService (copy) ]]
	local v1 = 0
	local v2 = nil
	local v3 = p1.OverrideSpinPropi and p1.OverrideSpinPropi + 1 or 0
	p1.OverrideSpinPropi = v3
	local function Heartbeat(p12) --[[ Line: 79 | Upvalues: v1 (ref), p1 (copy), SpinProp (ref), v2 (ref), v3 (copy) ]]
		v1 = v1 + p12 * 1 / 3
		if v1 >= 1 then
			v1 = 1
		end
		p1.PropAlpha = v1
		SpinProp(p1, p12)
		if v1 >= 1 then
			p1.OverrideSpinPropi = nil
			v2:disconnect()
		end
		if p1.OverrideSpinPropi ~= v3 then
			v2:disconnect()
		end
	end
	v2 = RunService.Heartbeat:connect(Heartbeat)
end
local function FadeOutProp(p1) --[[ Line: 97 | Upvalues: SpinProp (copy), RunService (copy) ]]
	local v1 = 0
	local v2 = nil
	local v3 = p1.OverrideSpinPropi and p1.OverrideSpinPropi + 1 or 0
	p1.OverrideSpinPropi = v3
	local function Heartbeat(p12) --[[ Line: 102 | Upvalues: v1 (ref), p1 (copy), SpinProp (ref), v2 (ref), v3 (copy) ]]
		v1 = v1 + p12 * 1 / 1
		if v1 >= 1 then
			v1 = 1
		end
		p1.PropAlpha = 1 - v1
		SpinProp(p1, p12)
		if v1 >= 1 then
			p1.OverrideSpinPropi = nil
			v2:disconnect()
		end
		if p1.OverrideSpinPropi ~= v3 then
			v2:disconnect()
		end
	end
	v2 = RunService.Heartbeat:connect(Heartbeat)
end
local function FadeOutSpringSpin(p1) --[[ Line: 121 | Upvalues: t2 (copy), RunService (copy) ]]
	local v1 = 0
	local v2 = nil
	local v3 = (p1.OverrideSpringFadePropi or 0) + 1
	p1.OverrideSpringFadePropi = v3
	local function Heartbeat(p12) --[[ Line: 126 | Upvalues: v1 (ref), p1 (copy), t2 (ref), v2 (ref), v3 (copy) ]]
		v1 = v1 + p12 * 1 / 1
		if v1 >= 1 then
			v1 = 1
		end
		local v12 = 1 - v1
		if p1.IsUFO then
			t2.SpinUFO(p1, p12, v12)
		elseif p1.IsDrone then
			t2.SpinDrone(p1, p12, v12)
		elseif p1.IsCrewCapsule then
			t2.SpinCrewCapsule(p1, p12, v12)
		end
		if v1 >= 1 then
			p1.OverrideSpringFadePropi = nil
			v2:disconnect()
		end
		if p1.OverrideSpringFadePropi ~= v3 then
			v2:disconnect()
		end
	end
	v2 = RunService.Heartbeat:connect(Heartbeat)
end
local function SetBladeEffectsVisible(p1, p2) --[[ Line: 151 ]]
	local v1 = p1.Model:FindFirstChild("Effects") or p1.Model:FindFirstChild("Vents")
	if v1 then
		for i, v in ipairs(v1:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("Attachment") then
				v.Smoke.Enabled = p2
			end
		end
	end
end
t2.SpinProp = SpinProp
function t2.SpinUFO(p1, p2, p3) --[[ Line: 163 ]]
	p1.MotorUFOBody.C1 = p1.MotorUFOBody.C1 * CFrame.Angles(0, p2 * 2 * if p3 == nil then p1.SpringSpinAlpha and p1.SpringSpinAlpha:Update() or 1 else p3, 0)
end
function t2.SpinCrewCapsule(p1, p2, p3) --[[ Line: 170 ]]
	p1.MotorBody.C1 = p1.MotorBody.C1 * CFrame.Angles(0, p2 * 2 * if p3 == nil then p1.SpringSpinAlpha and p1.SpringSpinAlpha:Update() or 1 else p3, 0)
end
function t2.SpinDrone(p1, p2, p3) --[[ Line: 177 ]]
	local v1 = if p3 == nil then p1.SpringSpinAlpha and p1.SpringSpinAlpha:Update() or 1 else p3
	for i, v in ipairs(p1.ListBladeMotor) do
		local v3 = v.C0:Inverse()
		v.C1 = v.C1 * v3 * CFrame.Angles(0, p2 * 20 * v1, 0) * v.C0
	end
end
local function GetMouseLocation() --[[ Line: 187 | Upvalues: InputUtils (copy), CurrentCamera (copy), UserInputService (copy) ]]
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
local function projectCircleToSquare(p1, p2) --[[ Line: 199 ]]
	local v1 = math.sqrt(p1 * p1 + p2 * p2)
	local v2
	if v1 <= 0.001 then
		v2 = 0
	else
		local v3 = math.abs(p1)
		v2 = p1 / math.max(v3, (math.abs(p2))) * v1
	end
	if v1 <= 0.001 then
		return v2, 0
	else
		local v5 = math.abs(p1)
		return v2, p2 / math.max(v5, (math.abs(p2))) * v1
	end
end
function t2.Update(p1, p2) --[[ Line: 212 | Upvalues: t (ref), InputUtils (copy), GetMoveVector (ref), abs (copy), TableUtils (copy), CollectionService (copy), C4Consts (copy), Raycast (copy), CurrentCamera (copy), UserInputService (copy), v2 (copy), Time (copy), t2 (copy), v1 (copy), Angles (copy), SpinProp (copy), VehicleUtils (copy) ]]
	local v12 = tick()
	local v22 = t[1] - t[3]
	local v3 = t[2] - t[4]
	local v4 = t[6] - t[5]
	if InputUtils.isTouch() then
		local v5 = GetMoveVector()
		local v6, v7
		if v5.Magnitude > 0.001 then
			local Unit = v5.Unit
			local X = Unit.X
			local Z = Unit.Z
			local v8 = math.sqrt(X * X + Z * Z)
			local v9
			if v8 <= 0.001 then
				v9 = 0
			else
				local v10 = math.abs(X)
				v9 = X / math.max(v10, (math.abs(Z))) * v8
			end
			local v122
			if v8 <= 0.001 then
				v122 = 0
			else
				local v13 = math.abs(X)
				v122 = Z / math.max(v13, (math.abs(Z))) * v8
			end
			v6 = v122
			v7 = v9
		else
			v6 = 0
			v7 = 0
		end
		v22 = -v6 * abs(v6)
		v3 = -v7 * abs(v7)
	end
	if p1.LockMovement then
		v3 = 0
		v22 = 0
		v4 = 0
	end
	if p1.IsFalling then
		v4 = v4 * 0.1
		v3 = v3 * 0.1
		v22 = v22 * 0.1
	end
	local v15 = 0
	local v16 = 30
	local v17 = 0
	if p1.IsHeli then
		v15 = 140
		v17 = 0.01
	elseif p1.IsLittleBird then
		v15 = 150
		v17 = 0.01
	elseif p1.IsEscapeBot then
		v15 = 140
		v17 = 0.01
	elseif p1.IsBlackHawk then
		v15 = 180
		v17 = 0.01
	elseif p1.IsUFO then
		v15 = 162
		v17 = 0.02
	elseif p1.IsDrone then
		v15 = 190
		v17 = 0.01
	elseif p1.IsBlade or p1.IsLia then
		v15 = 220
		v17 = 0.01
	elseif p1.IsBionic then
		v15 = 210
		v17 = 0.01
	elseif p1.IsCrewCapsule then
		v15 = 120
		v17 = 0.02
	elseif p1.IsCelsior then
		v15 = 155
		v17 = 0.01
		v16 = 45
	end
	if p1.SpeedMult then
		v15 = v15 * p1.SpeedMult
	end
	if p1.ForwardMult then
		v17 = v17 * p1.ForwardMult
	end
	if p1.UpMult then
		v16 = v16 * p1.UpMult
	end
	if p1.IsBionic and (v4 == 0 and os.clock() - p1._enteredAt < 0.2) then
		v4 = 0.6
	end
	local Model = p1.Model
	local Engine = Model.Engine
	local Gyro = p1.Gyro
	local Velocity = p1.Velocity
	local Rotate = p1.Rotate
	local v18 = Engine.Position.Y > p1.MaxHeight
	if p1.IsBlade or (p1.IsLia or (p1.IsDrone or (p1.IsCrewCapsule or (p1.IsCelsior or p1.IsBionic)))) then
		local Body = Model.Model:FindFirstChild("Body")
		local v19 = Body and Body:FindFirstChild("Ground") or nil
		if not p1._bladeRaycastParams then
			p1._bladeRaycastParams = RaycastParams.new()
			p1._bladeRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
			p1._bladeRaycastParamsLastUpdate = 0
		end
		local v20 = os.clock()
		if v20 - p1._bladeRaycastParamsLastUpdate > 2 then
			p1._bladeRaycastParamsLastUpdate = v20
			local t3 = { workspace.Vehicles }
			TableUtils.concatInPlace(t3, CollectionService:GetTagged(C4Consts.TAG_NAME))
			p1._bladeRaycastParams.FilterDescendantsInstances = t3
		end
		local v21 = Raycast.collidable(Engine.Position, Vector3.new(0, -1, 0), 1000, p1._bladeRaycastParams)
		local v222 = if v21 then v21.Position else Engine.Position + Vector3.new(0, -1000, 0)
		local Magnitude = (v222 - Engine.Position).Magnitude
		local v23 = if p1.IsCrewCapsule then 22 elseif p1.IsCelsior then 18 else 40
		if Magnitude < v23 then
			v18 = false
			if v19 then
				v19.WorldPosition = v222
			end
		else
			v18 = true
		end
		if v23 - 10 < Magnitude then
			local v24 = math.max(0, (v23 - Magnitude) / 10)
			if v4 > 0 then
				v4 = v4 * v24 * v24 * v24
			end
		end
		if v18 then
			if v19 and v19.Smoke.Enabled ~= false then
				v19.Smoke.Enabled = false
			end
			v4 = -1
		elseif v19 and v19.Smoke.Enabled ~= true then
			v19.Smoke.Enabled = true
		end
	end
	if p1.CrossHair then
		local v25
		if InputUtils.isTouch() then
			local ViewportSize = CurrentCamera.ViewportSize
			v25 = Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
		else
			v25 = UserInputService:GetMouseLocation()
		end
		p1.CrossHair:Update(v25)
	end
	local RopePull = Model.Preset:FindFirstChild("RopePull")
	if RopePull ~= nil and RopePull:FindFirstChild("IsHoldingObj") then
		v15 = v15 * 0.65
	end
	if p1.IsCelsior and v22 < 0 then
		v22 = v22 * 0.6666666666666666
	end
	local vForward = p1.vForward
	local v32 = vForward + v22 * p2 * 60 - vForward * if v22 == 0 then 0.02 else v17 * p2 * 60
	p1.vForward = v32
	local sum = v32 * v17
	local vUp = p1.vUp
	local v35 = vUp + v4 * p2 * 60 - vUp * 0.05 * p2 * 60
	p1.vUp = v35
	local sum_2 = v35 * 0.05
	local vHeading = p1.vHeading
	local v38 = vHeading + v3 * p2 * 60 - vHeading * 0.05 * p2 * 60
	p1.vHeading = v38
	local sum_3 = v38 * 0.05
	if Engine.Velocity.Magnitude < 4 then
		sum = sum + math.sin(v12 * 1.6) * 0.005
		sum_2 = sum_2 + math.cos(v12 * 2.3) * 0.02
		sum_3 = sum_3 + math.cos(v12 * 1.3) * 0.01
	end
	local BoundsDisabled = p1.BoundsDisabled
	if not BoundsDisabled then
		BoundsDisabled = (Engine.Position - p1.MapCenter).Magnitude <= p1.BoundRadius
	end
	local unit = v2(Engine.CFrame.lookVector.X, 0, Engine.CFrame.lookVector.Z).unit
	local v40 = Vector3.new(0, 1, 0) * v16 * sum_2
	if v18 and v40.Y > 0 then
		v40 = Vector3.new(0, 0, 0)
	end
	if p1.IsFalling then
		v40 = Vector3.new(0, -5, 0)
		if Time.GetNowSync() - p1.FellAt > p1.DisableDuration then
			t2.FallOutOfSkyEnd(p1)
		end
	end
	local v41 = unit * v15 * sum + v40
	if not BoundsDisabled then
		v41 = v41 * 0.1
	end
	Velocity.Velocity = v41
	if p1.IsHeli or (p1.IsBlackHawk or (p1.IsLittleBird or p1.IsEscapeBot)) then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((v2(0, sum_3 * 1.5, 0)))
		Gyro.CFrame = v1(Vector3.new(0, 0, 0), unit) * Angles(-sum * 0.24, 0, sum_3 * 0.4)
	elseif p1.IsUFO then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((v2(0, sum_3 * 3, 0)))
		Gyro.CFrame = v1(Vector3.new(0, 0, 0), unit) * Angles(-sum * 0.24, 0, sum_3 * 0.2)
	elseif p1.IsBlade or (p1.IsLia or (p1.IsDrone or (p1.IsCrewCapsule or p1.IsBionic))) then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((v2(0, sum_3 * 1.5, 0)))
		Gyro.CFrame = v1(Vector3.new(0, 0, 0), unit) * Angles(-sum * 0.1, 0, sum_3 * 0.4)
	elseif p1.IsCelsior then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((v2(0, sum_3 * 2, 0)))
		Gyro.CFrame = v1(Vector3.new(0, 0, 0), unit) * Angles(-sum * 0.15, 0, sum_3 * 0.5)
	end
	if (p1.IsHeli or (p1.IsBlackHawk or p1.IsLittleBird)) and not p1.OverrideSpinPropi then
		SpinProp(p1, p2)
	end
	if p1.IsDrone then
		t2.SpinDrone(p1, p2)
	end
	if p1.IsUFO then
		t2.SpinUFO(p1, p2)
	end
	if p1.IsCrewCapsule then
		t2.SpinCrewCapsule(p1, p2)
	end
	if RopePull then
		local Winch = Model.Winch
		RopePull.VectorForce.Force = -RopePull.Velocity * 15 + (Winch.Attachment.WorldPosition + Vector3.new(0, -Winch.RopeConstraint.Length, 0) - RopePull.Attachment.WorldPosition) * 50
	end
	if p1.IsBlade or (p1.IsLia or (p1.IsDrone or (p1.IsCrewCapsule or (p1.IsCelsior or (p1.IsEscapeBot or p1.IsBionic))))) then
		local v45 = Engine.Velocity.Magnitude / v15
		local v46 = (1 - v45) * 0.8 + v45 * 1.2
		if math.abs(p1.RotorSound.PlaybackSpeed - v46) > 0.001 then
			p1.RotorSound.PlaybackSpeed = v46
		end
		if p1.BionicBendBeams then
			local v48 = 2 + v45 * 13
			if math.abs((p1._lastBionicTextureSpeed or 0) - v48) > 0.01 then
				p1._lastBionicTextureSpeed = v48
				for v50, v51 in p1.BionicBendBeams do
					v51.TextureSpeed = v48
				end
			end
		end
	end
	local v52 = v22 < 1e-6
	if p1._flagBrakelightsEnabled ~= v52 then
		p1._flagBrakelightsEnabled = v52
		VehicleUtils.setBrakelightsEnabled(Model, v52)
	end
end
function t2.FallOutOfSkyEnd(p1) --[[ Line: 506 ]]
	p1.IsFalling = nil
	p1.FellAt = nil
	p1.Velocity.MaxForce = Vector3.new(100000000, 100000000, 100000000)
end
function t2.FallOutOfSky(p1) --[[ Line: 512 | Upvalues: Time (copy) ]]
	print("falling out of sky now")
	p1.FellAt = Time.GetNowSync()
	p1.IsFalling = true
	p1.Velocity.MaxForce = Vector3.new(100000000, 0, 100000000)
end
local t3 = {
	[Enum.KeyCode.W] = 1,
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.S] = 3,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.Q] = 5,
	[Enum.KeyCode.E] = 6,
	[Enum.KeyCode.ButtonR2] = 6,
	[Enum.KeyCode.ButtonL2] = 5
}
function t2.InputBegan(p1) --[[ Line: 529 | Upvalues: t3 (copy), t (ref) ]]
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t3[KeyCode] then
			t[t3[KeyCode]] = 1
		end
	end
end
function t2.InputEnded(p1) --[[ Line: 537 | Upvalues: t3 (copy), t (ref) ]]
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t3[KeyCode] then
			t[t3[KeyCode]] = 0
		end
	end
end
function t2.InputChanged(p1) --[[ Line: 545 | Upvalues: t (ref), t3 (copy) ]]
	if p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = p1.Position
			local X = Position.X
			local Y = Position.Y
			t[1] = if Y > 0.22 then Y else 0
			t[3] = Y < -0.22 and -Y or 0
			t[2] = X < -0.22 and -X or 0
			t[4] = if X > 0.22 then X else 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = p1.Position.Z
			t[t3[KeyCode]] = Z > 0.1 and Z ^ 0.5 or 0
		end
	end
end
return function(p1) --[[ Line: 564 | Upvalues: v5 (ref), Bomb (copy), v6 (copy), ReplicatedStorage (copy), LocalPlayer (copy), SetBladeEffectsVisible (copy), t (ref), SpinProp (copy), RunService (copy), Spring (copy), InputUtils (copy), CrossHair (copy), Players (copy), Time (copy), t2 (copy), VehicleUtils (copy), UI (copy), RunUtils (copy), CollectionService (copy), CurrentCamera (copy), UserInputService (copy), RayCast (copy), Missile (copy) ]]
	local em = p1.em
	v5 = p1.Event
	local ScreenGui = p1.ScreenGui
	local MainWindowGroup = p1.MainWindowGroup
	Bomb.Init({
		Event = v5
	})
	v6:Start()
	function t2.VehicleEnter(p1) --[[ Line: 571 | Upvalues: ReplicatedStorage (ref), LocalPlayer (ref), SetBladeEffectsVisible (ref), t (ref), SpinProp (ref), RunService (ref), Spring (ref), InputUtils (ref), CrossHair (ref), Players (ref), Time (ref), t2 (ref) ]]
		local Passenger = p1.Passenger
		local Model = p1.Model
		local Make = p1.Make
		if p1.CarSitTrack ~= nil then
			p1.CarSitTrack:Stop()
			p1.CarSitTrack:Destroy()
			p1.CarSitTrack = nil
		end
		if p1.Seat:FindFirstChild("SitAnim") then
			local v1 = LocalPlayer.Character.Humanoid:LoadAnimation(ReplicatedStorage.Resource.CarSitAnimation)
			v1:AdjustSpeed(0)
			v1:Play()
			p1.CarSitTrack = v1
		end
		if not Passenger then
			if p1.IsBlade or (p1.IsLia or (p1.IsDrone or p1.IsBionic)) then
				SetBladeEffectsVisible(p1.Model, true)
			end
			p1._enteredAt = os.clock()
			p1._flagBrakelightsEnabled = false
			t = { 0, 0, 0, 0, 0, 0 }
			p1.vForward = 0
			p1.vUp = 0
			p1.vHeading = 0
			if p1.IsHeli or (p1.IsBlackHawk or p1.IsLittleBird) then
				p1.PropAlpha = 0
				local v2 = 0
				local v3 = nil
				local v4 = p1.OverrideSpinPropi and p1.OverrideSpinPropi + 1 or 0
				p1.OverrideSpinPropi = v4
				local function Heartbeat(p12) --[[ Line: 79 | Upvalues: v2 (ref), p1 (copy), SpinProp (ref), v3 (ref), v4 (copy) ]]
					v2 = v2 + p12 * 1 / 3
					if v2 >= 1 then
						v2 = 1
					end
					p1.PropAlpha = v2
					SpinProp(p1, p12)
					if v2 >= 1 then
						p1.OverrideSpinPropi = nil
						v3:disconnect()
					end
					if p1.OverrideSpinPropi ~= v4 then
						v3:disconnect()
					end
				end
				v3 = RunService.Heartbeat:connect(Heartbeat)
			end
			if p1.IsUFO or (p1.IsDrone or p1.IsCrewCapsule) then
				p1.OverrideSpringFadePropi = (p1.OverrideSpringFadePropi or 0) + 1
				p1.SpringSpinAlpha = Spring.new(0, 0, 1, 2)
				p1.SpringSpinAlpha:SetTarget(1)
			end
			if InputUtils.isTouch() and Make == "BlackHawk" then
				p1.CrossHair = CrossHair.Make()
				p1.CrossHair.Gui.Parent = Players.LocalPlayer.PlayerGui
				p1.seatMaid:GiveTask(function() --[[ Line: 618 | Upvalues: p1 (copy) ]]
					p1.CrossHair:Destroy()
					p1.CrossHair = nil
				end)
			end
			if p1.FellAt ~= nil and Time.GetNowSync() - p1.FellAt < p1.DisableDuration then
				t2.FallOutOfSky(p1)
				p1.FellAt = p1.FellAt
			end
		end
	end
	function t2.VehicleLeave(p1) --[[ Line: 638 | Upvalues: SpinProp (ref), RunService (ref), t2 (ref), SetBladeEffectsVisible (ref), v6 (ref), VehicleUtils (ref) ]]
		local Make = p1.Make
		if p1.CarSitTrack ~= nil then
			p1.CarSitTrack:Stop()
			p1.CarSitTrack:Destroy()
			p1.CarSitTrack = nil
		end
		if not p1.Passenger then
			if p1.IsHeli or (p1.IsBlackHawk or p1.IsLittleBird) then
				local v1 = 0
				local v2 = nil
				local v3 = p1.OverrideSpinPropi and p1.OverrideSpinPropi + 1 or 0
				p1.OverrideSpinPropi = v3
				local function Heartbeat(p12) --[[ Line: 102 | Upvalues: v1 (ref), p1 (copy), SpinProp (ref), v2 (ref), v3 (copy) ]]
					v1 = v1 + p12 * 1 / 1
					if v1 >= 1 then
						v1 = 1
					end
					p1.PropAlpha = 1 - v1
					SpinProp(p1, p12)
					if v1 >= 1 then
						p1.OverrideSpinPropi = nil
						v2:disconnect()
					end
					if p1.OverrideSpinPropi ~= v3 then
						v2:disconnect()
					end
				end
				v2 = RunService.Heartbeat:connect(Heartbeat)
			end
			if p1.IsUFO or (p1.IsDrone or p1.IsCrewCapsule) then
				local v4 = 0
				local v5 = nil
				local v62 = (p1.OverrideSpringFadePropi or 0) + 1
				p1.OverrideSpringFadePropi = v62
				local function Heartbeat(p12) --[[ Line: 126 | Upvalues: v4 (ref), p1 (copy), t2 (ref), v5 (ref), v62 (copy) ]]
					v4 = v4 + p12 * 1 / 1
					if v4 >= 1 then
						v4 = 1
					end
					local v1 = 1 - v4
					if p1.IsUFO then
						t2.SpinUFO(p1, p12, v1)
					elseif p1.IsDrone then
						t2.SpinDrone(p1, p12, v1)
					elseif p1.IsCrewCapsule then
						t2.SpinCrewCapsule(p1, p12, v1)
					end
					if v4 >= 1 then
						p1.OverrideSpringFadePropi = nil
						v5:disconnect()
					end
					if p1.OverrideSpringFadePropi ~= v62 then
						v5:disconnect()
					end
				end
				v5 = RunService.Heartbeat:connect(Heartbeat)
			end
			if p1.IsBlade or (p1.IsLia or (p1.IsDrone or p1.IsBionic)) then
				SetBladeEffectsVisible(p1.Model, false)
			end
			if p1.SpotlightMotor ~= nil then
				v6:Get(p1.SpotlightMotor):UnhookLocal()
			end
			p1.Rotate.AngularVelocity = Vector3.new(0, 0, 0)
			local RopePull = p1.Model.Preset:FindFirstChild("RopePull")
			if RopePull then
				RopePull.VectorForce.Force = Vector3.new(0, 0, 0)
			end
			if p1.RopePickupPacket ~= nil then
				p1.RopePickupPacket.Maid:Destroy()
				p1.RopePickupPacket = nil
			end
			VehicleUtils.setBrakelightsEnabled(p1.Model, false)
		end
	end
	local CharacterAnim = require(ReplicatedStorage.Game.CharacterAnim)
	t2.Roped = false
	function t2.AttemptRopeDetach() --[[ Line: 685 | Upvalues: t2 (ref), v5 (ref) ]]
		assert(t2.Roped)
		v5:FireServer("s" .. "" .. ("resgm5srwb"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "zpnz8")
	end
	function em.shbm9fuh(p1) --[[ Line: 689 | Upvalues: t2 (ref), LocalPlayer (ref), CharacterAnim (copy) ]]
		t2.Roped = p1
		for i, v in ipairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
			v:Stop()
		end
		local v1 = CharacterAnim.getRopeGrabTrack()
		if p1 then
			v1:Play()
		else
			v1:Stop()
		end
	end
	local function AttemptDropRope() --[[ Line: 702 | Upvalues: v5 (ref) ]]
		v5:FireServer("a" .. ("gay24m"):sub(5, 5):reverse():reverse():reverse() .. "" .. "" .. ("e9ob4"):sub(3, 3):reverse() .. "" .. "" .. ("jne5s6"):sub(4, 4):reverse() .. "" .. "" .. ("cfp8lcz"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("gky5uvk"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("lf3i3w"):sub(3, 3):reverse():reverse():reverse() .. "e")
	end
	local CircleAction = UI.CircleAction
	local function Action(p1, p2) --[[ Line: 706 | Upvalues: v5 (ref) ]]
		if p2 then
			v5:FireServer("q" .. ("a1h9t"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("plb4kr9li"):sub(4, 5):reverse() .. "" .. "" .. ("y1tlmi"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("nnuxplv6b"):sub(5, 5):reverse() .. "" .. "" .. ("wh89juw0"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "h", p1.Part)
			return true
		end
	end
	local function AddedFun(p1) --[[ Line: 712 | Upvalues: Action (copy), CircleAction (copy) ]]
		CircleAction.Add({
			Part = p1,
			Name = "Rope",
			Timed = true,
			Duration = 0.5,
			Dist = 15,
			Callback = Action
		}, p1)
	end
	local function RemovedFun(p1) --[[ Line: 727 | Upvalues: CircleAction (copy) ]]
		CircleAction.Remove(p1)
	end
	if not RunUtils.isTradeWorld() then
		local v1 = next
		local v2, v3 = CollectionService:GetTagged("RopePull")
		for v4, v52 in v1, v2, v3 do
			CircleAction.Add({
				Part = v52,
				Name = "Rope",
				Timed = true,
				Duration = 0.5,
				Dist = 15,
				Callback = Action
			}, v52)
		end
		CollectionService:GetInstanceAddedSignal("RopePull"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("RopePull"):Connect(RemovedFun)
	end
	function em.fevtvl2i(p1) --[[ Line: 739 | Upvalues: em (copy) ]]
		if p1.NonZero then
			em.mq92d5a8({
				Title = "Store",
				Text = "Try again when you have 0 explosives!"
			})
		elseif p1.NotEnoughMoney then
			em.mq92d5a8({
				Title = "Store",
				Text = "You don\'t have enough cash!"
			})
			em.qx9ks3jo()
		else
			assert(false, "No flag found")
		end
	end
	local function ClampUnitVectorCone(p1, p2, p3) --[[ Line: 752 ]]
		local v1 = p1:VectorToObjectSpace(p2)
		local v2 = math.acos(v1.Z)
		local v3 = math.atan2(v1.Y, v1.X)
		local v4 = math.clamp(v2, math.pi - p3, math.pi + p3)
		return p1:VectorToWorldSpace((Vector3.new(math.sin(v4) * math.cos(v3), math.sin(v4) * math.sin(v3), (math.cos(v4)))))
	end
	local function AttemptFireMissile() --[[ Line: 761 | Upvalues: RunUtils (ref), p1 (copy), LocalPlayer (ref), VehicleUtils (ref), InputUtils (ref), CurrentCamera (ref), UserInputService (ref), RayCast (ref), ClampUnitVectorCone (copy), Time (ref), v5 (ref), Missile (ref) ]]
		if RunUtils.isTradeWorld() then
			return false
		end
		local v1 = p1.GetVehiclePacket()
		if not v1.IsBlackHawk then
			return false
		end
		local Missiles = v1.Missiles
		if not Missiles then
			return false
		end
		if LocalPlayer:GetAttribute("MissileCount") <= 0 then
			VehicleUtils.promptMissileBuy()
			return false
		end
		local v2 = tick()
		local v3 = v2 - Missiles.LastFire
		if v3 < 2 and v3 > 0 then
			return false
		end
		Missiles.LastFire = v2
		local v4 = Missiles.Parts[Missiles.i]
		v4.Transparency = 1
		delay(2, function() --[[ Line: 789 | Upvalues: v4 (copy) ]]
			v4.Transparency = 0
		end)
		local v52 = v4.CFrame * CFrame.Angles(0, math.pi, 0)
		local Velocity = v4.Velocity
		local v6
		if InputUtils.isTouch() then
			local ViewportSize = CurrentCamera.ViewportSize
			v6 = Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
		else
			v6 = UserInputService:GetMouseLocation()
		end
		local v11 = CurrentCamera:ViewportPointToRay(v6.X, v6.Y)
		local _, v12 = RayCast.RayIgnoreNonCollideWithIgnoreList(v11.Origin, v11.Direction, 999, { v1.Model, LocalPlayer.Character })
		local _2, v14 = RayCast.RayIgnoreNonCollideWithIgnoreList(v52.p, ClampUnitVectorCone(v1.Model.Engine.CFrame, (v12 - v52.p).Unit, 1.0471975511965976), 999, { v1.Model, LocalPlayer.Character })
		local v15 = Time.GetNowSync()
		v5:FireServer("e" .. "" .. ("cslr0avxm8g"):sub(5, 8):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("elw"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("d80p4r3"):sub(5, 5):reverse():reverse():reverse() .. "q", v52, Velocity, v14, v15)
		Missile.LaunchMissile(v52, Velocity, v14, v15)
		Missiles.i = Missiles.i % #Missiles.Parts + 1
	end
	function em.exva0l4q(p1, p2, p3, p4, p5, p6, p7) --[[ Line: 817 | Upvalues: Missile (ref) ]]
		Missile.LaunchMissile(p1, p2, p3, p4, p5, p6, p7)
	end
	local function AttemptDropBomb() --[[ Line: 820 | Upvalues: RunUtils (ref), p1 (copy), LocalPlayer (ref), VehicleUtils (ref), Time (ref), Bomb (ref), v5 (ref) ]]
		if RunUtils.isTradeWorld() then
			return false
		end
		local v1 = p1.GetVehiclePacket()
		local Missiles = v1.Missiles
		if not Missiles then
			return false
		end
		if LocalPlayer:GetAttribute("MissileCount") <= 0 then
			VehicleUtils.promptMissileBuy()
			return false
		end
		if tick() - Missiles.LastFire < 1 then
			return false
		end
		Missiles.LastFire = tick()
		local BoundingBox = v1.Model.BoundingBox
		local v2 = BoundingBox.CFrame * CFrame.new(0, -BoundingBox.Size.Y * 0.5 + 4, -BoundingBox.Size.Z * 0.5 + 10)
		local Velocity = BoundingBox.Velocity
		local v3 = Time.GetNowSync()
		Bomb.DropBomb(v2, Velocity, v3, LocalPlayer)
		v5:FireServer("u" .. ("n4ckknda"):sub(3, 5):reverse() .. "mz0e", v2, Velocity, v3)
	end
	function em.ukkcmz0e(p1, p2, p3, p4) --[[ Line: 850 | Upvalues: Bomb (ref) ]]
		Bomb.DropBomb(p1, p2, p3, p4)
	end
	function t2.attemptDropRope() --[[ Line: 853 | Upvalues: AttemptDropRope (ref) ]]
		AttemptDropRope()
	end
	function t2.attemptFireMissile() --[[ Line: 856 | Upvalues: AttemptFireMissile (copy) ]]
		AttemptFireMissile()
	end
	function t2.attemptDropBomb() --[[ Line: 859 | Upvalues: AttemptDropBomb (copy) ]]
		AttemptDropBomb()
	end
	function t2.toggleHeadlights(p1) --[[ Line: 862 | Upvalues: v6 (ref), v5 (ref) ]]
		if p1.SpotlightMotor then
			local v1 = v6:Get(p1.SpotlightMotor)
			if v1 then
				v1:RequestToggle()
			end
		else
			v5:FireServer("s" .. ("zlabcgyvi8"):sub(2, 6):reverse():reverse():reverse() .. "" .. "" .. ("ndmbr3"):sub(3, 3):reverse():reverse():reverse() .. "d", "Lights")
		end
	end
	function t2.setUp(p1) --[[ Line: 872 | Upvalues: t (ref) ]]
		t[6] = if p1 then 1 else 0
	end
	function t2.setDown(p1) --[[ Line: 875 | Upvalues: t (ref) ]]
		t[5] = if p1 then 1 else 0
	end
	t2.SpotlightBinder = v6
	return t2
end