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
local newCFrame = CFrame.new
local newVector3 = Vector3.new
local Angles = CFrame.Angles
local zeroCFrame = newCFrame(0, 0, 0)
local abs = math.abs
local vectorToObjectSpace = zeroCFrame.vectorToObjectSpace
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local function GetMoveVector()
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local controlModule = require(ControlModule)
	GetMoveVector = function()
		return controlModule:GetMoveVector()
	end
end
local serverEvent = nil
local SpotlightBinder = Binder.new("HeliSpotlight", require(ReplicatedStorage.Game.Vehicle.Heli.Spotlight))
local inputState = { 0, 0, 0, 0, 0, 0 }
local HeliModule = {}
local function SpinProp(vehiclePacket, dt)
	local PropAlpha = vehiclePacket.PropAlpha
	local TopRotorMotor = vehiclePacket.TopRotorMotor
	TopRotorMotor.C1 = TopRotorMotor.C1 * Angles(0, 31.4 * dt * PropAlpha, 0)
	local TailRotorMotor = vehiclePacket.TailRotorMotor
	TailRotorMotor.C1 = TailRotorMotor.C1 * Angles(0, 31.4 * dt * PropAlpha, 0)
	if vehiclePacket._lastPropAlpha ~= PropAlpha then
		vehiclePacket._lastPropAlpha = PropAlpha
		vehiclePacket.Model.Model.TailDisc.Transparency = 1 - PropAlpha * 0.15
		vehiclePacket.Model.Model.TopDisc.Transparency = 1 - PropAlpha * 0.15
	end
end
local function FadeInProp(vehiclePacket)
	local fadeProgress = 0
	local heartbeatConn = nil
	local overrideIndex = vehiclePacket.OverrideSpinPropi and vehiclePacket.OverrideSpinPropi + 1 or 0
	vehiclePacket.OverrideSpinPropi = overrideIndex
	local function Heartbeat(dt)
		fadeProgress = fadeProgress + dt * 1 / 3
		if fadeProgress >= 1 then
			fadeProgress = 1
		end
		vehiclePacket.PropAlpha = fadeProgress
		SpinProp(vehiclePacket, dt)
		if fadeProgress >= 1 then
			vehiclePacket.OverrideSpinPropi = nil
			heartbeatConn:disconnect()
		end
		if vehiclePacket.OverrideSpinPropi ~= overrideIndex then
			heartbeatConn:disconnect()
		end
	end
	heartbeatConn = RunService.Heartbeat:connect(Heartbeat)
end
local function FadeOutProp(vehiclePacket)
	local fadeProgress = 0
	local heartbeatConn = nil
	local overrideIndex = vehiclePacket.OverrideSpinPropi and vehiclePacket.OverrideSpinPropi + 1 or 0
	vehiclePacket.OverrideSpinPropi = overrideIndex
	local function Heartbeat(dt)
		fadeProgress = fadeProgress + dt * 1 / 1
		if fadeProgress >= 1 then
			fadeProgress = 1
		end
		vehiclePacket.PropAlpha = 1 - fadeProgress
		SpinProp(vehiclePacket, dt)
		if fadeProgress >= 1 then
			vehiclePacket.OverrideSpinPropi = nil
			heartbeatConn:disconnect()
		end
		if vehiclePacket.OverrideSpinPropi ~= overrideIndex then
			heartbeatConn:disconnect()
		end
	end
	heartbeatConn = RunService.Heartbeat:connect(Heartbeat)
end
local function FadeOutSpringSpin(vehiclePacket)
	local fadeProgress = 0
	local heartbeatConn = nil
	local overrideIndex = (vehiclePacket.OverrideSpringFadePropi or 0) + 1
	vehiclePacket.OverrideSpringFadePropi = overrideIndex
	local function Heartbeat(dt)
		fadeProgress = fadeProgress + dt * 1 / 1
		if fadeProgress >= 1 then
			fadeProgress = 1
		end
		local spinAlpha = 1 - fadeProgress
		if vehiclePacket.IsUFO then
			HeliModule.SpinUFO(vehiclePacket, dt, spinAlpha)
		elseif vehiclePacket.IsDrone then
			HeliModule.SpinDrone(vehiclePacket, dt, spinAlpha)
		elseif vehiclePacket.IsCrewCapsule then
			HeliModule.SpinCrewCapsule(vehiclePacket, dt, spinAlpha)
		end
		if fadeProgress >= 1 then
			vehiclePacket.OverrideSpringFadePropi = nil
			heartbeatConn:disconnect()
		end
		if vehiclePacket.OverrideSpringFadePropi ~= overrideIndex then
			heartbeatConn:disconnect()
		end
	end
	heartbeatConn = RunService.Heartbeat:connect(Heartbeat)
end
local function SetBladeEffectsVisible(vehiclePacket, visible)
	local effects = vehiclePacket.Model:FindFirstChild("Effects") or vehiclePacket.Model:FindFirstChild("Vents")
	if effects then
		for i, v in ipairs(effects:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("Attachment") then
				v.Smoke.Enabled = visible
			end
		end
	end
end
HeliModule.SpinProp = SpinProp
function HeliModule.SpinUFO(vehiclePacket, dt, overrideAlpha)
	vehiclePacket.MotorUFOBody.C1 = vehiclePacket.MotorUFOBody.C1 * CFrame.Angles(0, dt * 2 * if overrideAlpha == nil then vehiclePacket.SpringSpinAlpha and vehiclePacket.SpringSpinAlpha:Update() or 1 else overrideAlpha, 0)
end
function HeliModule.SpinCrewCapsule(vehiclePacket, dt, overrideAlpha)
	vehiclePacket.MotorBody.C1 = vehiclePacket.MotorBody.C1 * CFrame.Angles(0, dt * 2 * if overrideAlpha == nil then vehiclePacket.SpringSpinAlpha and vehiclePacket.SpringSpinAlpha:Update() or 1 else overrideAlpha, 0)
end
function HeliModule.SpinDrone(vehiclePacket, dt, overrideAlpha)
	local spinAlpha = if overrideAlpha == nil then vehiclePacket.SpringSpinAlpha and vehiclePacket.SpringSpinAlpha:Update() or 1 else overrideAlpha
	for i, motor in ipairs(vehiclePacket.ListBladeMotor) do
		local invC0 = motor.C0:Inverse()
		motor.C1 = motor.C1 * invC0 * CFrame.Angles(0, dt * 20 * spinAlpha, 0) * motor.C0
	end
end
local function GetMouseLocation()
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
local function projectCircleToSquare(x, y)
	local mag = math.sqrt(x * x + y * y)
	local squareX
	if mag <= 0.001 then
		squareX = 0
	else
		local absX = math.abs(x)
		squareX = x / math.max(absX, (math.abs(y))) * mag
	end
	if mag <= 0.001 then
		return squareX, 0
	else
		local absX = math.abs(x)
		return squareX, y / math.max(absX, (math.abs(y))) * mag
	end
end
function HeliModule.Update(vehiclePacket, dt)
	local now = tick()
	local inputForward = inputState[1] - inputState[3]
	local inputTurn = inputState[2] - inputState[4]
	local inputUp = inputState[6] - inputState[5]
	if InputUtils.isTouch() then
		local moveVec = GetMoveVector()
		local touchForward, touchTurn
		if moveVec.Magnitude > 0.001 then
			local Unit = moveVec.Unit
			local X = Unit.X
			local Z = Unit.Z
			local mag = math.sqrt(X * X + Z * Z)
			local squareX
			if mag <= 0.001 then
				squareX = 0
			else
				local absX = math.abs(X)
				squareX = X / math.max(absX, (math.abs(Z))) * mag
			end
			local squareZ
			if mag <= 0.001 then
				squareZ = 0
			else
				local absX = math.abs(X)
				squareZ = Z / math.max(absX, (math.abs(Z))) * mag
			end
			touchForward = squareZ
			touchTurn = squareX
		else
			touchForward = 0
			touchTurn = 0
		end
		inputForward = -touchForward * abs(touchForward)
		inputTurn = -touchTurn * abs(touchTurn)
	end
	if vehiclePacket.LockMovement then
		inputTurn = 0
		inputForward = 0
		inputUp = 0
	end
	if vehiclePacket.IsFalling then
		inputUp = inputUp * 0.1
		inputTurn = inputTurn * 0.1
		inputForward = inputForward * 0.1
	end
	local maxSpeed = 0
	local upForce = 30
	local forwardDrag = 0
	if vehiclePacket.IsHeli then
		maxSpeed = 140
		forwardDrag = 0.01
	elseif vehiclePacket.IsLittleBird then
		maxSpeed = 150
		forwardDrag = 0.01
	elseif vehiclePacket.IsEscapeBot then
		maxSpeed = 140
		forwardDrag = 0.01
	elseif vehiclePacket.IsBlackHawk then
		maxSpeed = 180
		forwardDrag = 0.01
	elseif vehiclePacket.IsUFO then
		maxSpeed = 162
		forwardDrag = 0.02
	elseif vehiclePacket.IsDrone then
		maxSpeed = 190
		forwardDrag = 0.01
	elseif vehiclePacket.IsBlade or vehiclePacket.IsLia then
		maxSpeed = 220
		forwardDrag = 0.01
	elseif vehiclePacket.IsBionic then
		maxSpeed = 210
		forwardDrag = 0.01
	elseif vehiclePacket.IsCrewCapsule then
		maxSpeed = 120
		forwardDrag = 0.02
	elseif vehiclePacket.IsCelsior then
		maxSpeed = 155
		forwardDrag = 0.01
		upForce = 45
	end
	if vehiclePacket.SpeedMult then
		maxSpeed = maxSpeed * vehiclePacket.SpeedMult
	end
	if vehiclePacket.ForwardMult then
		forwardDrag = forwardDrag * vehiclePacket.ForwardMult
	end
	if vehiclePacket.UpMult then
		upForce = upForce * vehiclePacket.UpMult
	end
	if vehiclePacket.IsBionic and (inputUp == 0 and os.clock() - vehiclePacket._enteredAt < 0.2) then
		inputUp = 0.6
	end
	local Model = vehiclePacket.Model
	local Engine = Model.Engine
	local Gyro = vehiclePacket.Gyro
	local Velocity = vehiclePacket.Velocity
	local Rotate = vehiclePacket.Rotate
	local aboveMaxHeight = Engine.Position.Y > vehiclePacket.MaxHeight
	if vehiclePacket.IsBlade or (vehiclePacket.IsLia or (vehiclePacket.IsDrone or (vehiclePacket.IsCrewCapsule or (vehiclePacket.IsCelsior or vehiclePacket.IsBionic)))) then
		local Body = Model.Model:FindFirstChild("Body")
		local groundAttachment = Body and Body:FindFirstChild("Ground") or nil
		if not vehiclePacket._bladeRaycastParams then
			vehiclePacket._bladeRaycastParams = RaycastParams.new()
			vehiclePacket._bladeRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
			vehiclePacket._bladeRaycastParamsLastUpdate = 0
		end
		local clockNow = os.clock()
		if clockNow - vehiclePacket._bladeRaycastParamsLastUpdate > 2 then
			vehiclePacket._bladeRaycastParamsLastUpdate = clockNow
			local filterList = { workspace.Vehicles }
			TableUtils.concatInPlace(filterList, CollectionService:GetTagged(C4Consts.TAG_NAME))
			vehiclePacket._bladeRaycastParams.FilterDescendantsInstances = filterList
		end
		local rayResult = Raycast.collidable(Engine.Position, Vector3.new(0, -1, 0), 1000, vehiclePacket._bladeRaycastParams)
		local groundPos = if rayResult then rayResult.Position else Engine.Position + Vector3.new(0, -1000, 0)
		local distToGround = (groundPos - Engine.Position).Magnitude
		local minGroundDist = if vehiclePacket.IsCrewCapsule then 22 elseif vehiclePacket.IsCelsior then 18 else 40
		if distToGround < minGroundDist then
			aboveMaxHeight = false
			if groundAttachment then
				groundAttachment.WorldPosition = groundPos
			end
		else
			aboveMaxHeight = true
		end
		if minGroundDist - 10 < distToGround then
			local groundAlpha = math.max(0, (minGroundDist - distToGround) / 10)
			if inputUp > 0 then
				inputUp = inputUp * groundAlpha * groundAlpha * groundAlpha
			end
		end
		if aboveMaxHeight then
			if groundAttachment and groundAttachment.Smoke.Enabled ~= false then
				groundAttachment.Smoke.Enabled = false
			end
			inputUp = -1
		elseif groundAttachment and groundAttachment.Smoke.Enabled ~= true then
			groundAttachment.Smoke.Enabled = true
		end
	end
	if vehiclePacket.CrossHair then
		local mousePos
		if InputUtils.isTouch() then
			local ViewportSize = CurrentCamera.ViewportSize
			mousePos = Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
		else
			mousePos = UserInputService:GetMouseLocation()
		end
		vehiclePacket.CrossHair:Update(mousePos)
	end
	local RopePull = Model.Preset:FindFirstChild("RopePull")
	if RopePull ~= nil and RopePull:FindFirstChild("IsHoldingObj") then
		maxSpeed = maxSpeed * 0.65
	end
	if vehiclePacket.IsCelsior and inputForward < 0 then
		inputForward = inputForward * 2/3
	end
	local vForward = vehiclePacket.vForward
	local newVForward = vForward + inputForward * dt * 60 - vForward * if inputForward == 0 then 0.02 else forwardDrag * dt * 60
	vehiclePacket.vForward = newVForward
	local forwardContrib = newVForward * forwardDrag
	local vUp = vehiclePacket.vUp
	local newVUp = vUp + inputUp * dt * 60 - vUp * 0.05 * dt * 60
	vehiclePacket.vUp = newVUp
	local upContrib = newVUp * 0.05
	local vHeading = vehiclePacket.vHeading
	local newVHeading = vHeading + inputTurn * dt * 60 - vHeading * 0.05 * dt * 60
	vehiclePacket.vHeading = newVHeading
	local headingContrib = newVHeading * 0.05
	if Engine.Velocity.Magnitude < 4 then
		forwardContrib = forwardContrib + math.sin(now * 1.6) * 0.005
		upContrib = upContrib + math.cos(now * 2.3) * 0.02
		headingContrib = headingContrib + math.cos(now * 1.3) * 0.01
	end
	local BoundsDisabled = vehiclePacket.BoundsDisabled
	if not BoundsDisabled then
		BoundsDisabled = (Engine.Position - vehiclePacket.MapCenter).Magnitude <= vehiclePacket.BoundRadius
	end
	local lookUnit = newVector3(Engine.CFrame.lookVector.X, 0, Engine.CFrame.lookVector.Z).unit
	local upVelocity = Vector3.new(0, 1, 0) * upForce * upContrib
	if aboveMaxHeight and upVelocity.Y > 0 then
		upVelocity = Vector3.new(0, 0, 0)
	end
	if vehiclePacket.IsFalling then
		upVelocity = Vector3.new(0, -5, 0)
		if Time.GetNowSync() - vehiclePacket.FellAt > vehiclePacket.DisableDuration then
			HeliModule.FallOutOfSkyEnd(vehiclePacket)
		end
	end
	local targetVelocity = lookUnit * maxSpeed * forwardContrib + upVelocity
	if not BoundsDisabled then
		targetVelocity = targetVelocity * 0.1
	end
	Velocity.Velocity = targetVelocity
	if vehiclePacket.IsHeli or (vehiclePacket.IsBlackHawk or (vehiclePacket.IsLittleBird or vehiclePacket.IsEscapeBot)) then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((newVector3(0, headingContrib * 1.5, 0)))
		Gyro.CFrame = newCFrame(Vector3.new(0, 0, 0), lookUnit) * Angles(-forwardContrib * 0.24, 0, headingContrib * 0.4)
	elseif vehiclePacket.IsUFO then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((newVector3(0, headingContrib * 3, 0)))
		Gyro.CFrame = newCFrame(Vector3.new(0, 0, 0), lookUnit) * Angles(-forwardContrib * 0.24, 0, headingContrib * 0.2)
	elseif vehiclePacket.IsBlade or (vehiclePacket.IsLia or (vehiclePacket.IsDrone or (vehiclePacket.IsCrewCapsule or vehiclePacket.IsBionic))) then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((newVector3(0, headingContrib * 1.5, 0)))
		Gyro.CFrame = newCFrame(Vector3.new(0, 0, 0), lookUnit) * Angles(-forwardContrib * 0.1, 0, headingContrib * 0.4)
	elseif vehiclePacket.IsCelsior then
		Rotate.AngularVelocity = Engine.CFrame:vectorToWorldSpace((newVector3(0, headingContrib * 2, 0)))
		Gyro.CFrame = newCFrame(Vector3.new(0, 0, 0), lookUnit) * Angles(-forwardContrib * 0.15, 0, headingContrib * 0.5)
	end
	if (vehiclePacket.IsHeli or (vehiclePacket.IsBlackHawk or vehiclePacket.IsLittleBird)) and not vehiclePacket.OverrideSpinPropi then
		SpinProp(vehiclePacket, dt)
	end
	if vehiclePacket.IsDrone then
		HeliModule.SpinDrone(vehiclePacket, dt)
	end
	if vehiclePacket.IsUFO then
		HeliModule.SpinUFO(vehiclePacket, dt)
	end
	if vehiclePacket.IsCrewCapsule then
		HeliModule.SpinCrewCapsule(vehiclePacket, dt)
	end
	if RopePull then
		local Winch = Model.Winch
		RopePull.VectorForce.Force = -RopePull.Velocity * 15 + (Winch.Attachment.WorldPosition + Vector3.new(0, -Winch.RopeConstraint.Length, 0) - RopePull.Attachment.WorldPosition) * 50
	end
	if vehiclePacket.IsBlade or (vehiclePacket.IsLia or (vehiclePacket.IsDrone or (vehiclePacket.IsCrewCapsule or (vehiclePacket.IsCelsior or (vehiclePacket.IsEscapeBot or vehiclePacket.IsBionic))))) then
		local speedRatio = Engine.Velocity.Magnitude / maxSpeed
		local targetPlaybackSpeed = (1 - speedRatio) * 0.8 + speedRatio * 1.2
		if math.abs(vehiclePacket.RotorSound.PlaybackSpeed - targetPlaybackSpeed) > 0.001 then
			vehiclePacket.RotorSound.PlaybackSpeed = targetPlaybackSpeed
		end
		if vehiclePacket.BionicBendBeams then
			local textureSpeed = 2 + speedRatio * 13
			if math.abs((vehiclePacket._lastBionicTextureSpeed or 0) - textureSpeed) > 0.01 then
				vehiclePacket._lastBionicTextureSpeed = textureSpeed
				for _, beam in vehiclePacket.BionicBendBeams do
					beam.TextureSpeed = textureSpeed
				end
			end
		end
	end
	local brakeLightsOn = inputForward < 1e-6
	if vehiclePacket._flagBrakelightsEnabled ~= brakeLightsOn then
		vehiclePacket._flagBrakelightsEnabled = brakeLightsOn
		VehicleUtils.setBrakelightsEnabled(Model, brakeLightsOn)
	end
end
function HeliModule.FallOutOfSkyEnd(vehiclePacket)
	vehiclePacket.IsFalling = nil
	vehiclePacket.FellAt = nil
	vehiclePacket.Velocity.MaxForce = Vector3.new(100000000, 100000000, 100000000)
end
function HeliModule.FallOutOfSky(vehiclePacket)
	print("falling out of sky now")
	vehiclePacket.FellAt = Time.GetNowSync()
	vehiclePacket.IsFalling = true
	vehiclePacket.Velocity.MaxForce = Vector3.new(100000000, 0, 100000000)
end
local keyToInputIndex = {
	[Enum.KeyCode.W] = 1,
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.S] = 3,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.Q] = 5,
	[Enum.KeyCode.E] = 6,
	[Enum.KeyCode.ButtonR2] = 6,
	[Enum.KeyCode.ButtonL2] = 5
}
function HeliModule.InputBegan(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = inputObject.KeyCode
		if keyToInputIndex[KeyCode] then
			inputState[keyToInputIndex[KeyCode]] = 1
		end
	end
end
function HeliModule.InputEnded(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = inputObject.KeyCode
		if keyToInputIndex[KeyCode] then
			inputState[keyToInputIndex[KeyCode]] = 0
		end
	end
end
function HeliModule.InputChanged(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = inputObject.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = inputObject.Position
			local X = Position.X
			local Y = Position.Y
			inputState[1] = if Y > 0.22 then Y else 0
			inputState[3] = Y < -0.22 and -Y or 0
			inputState[2] = X < -0.22 and -X or 0
			inputState[4] = if X > 0.22 then X else 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = inputObject.Position.Z
			inputState[keyToInputIndex[KeyCode]] = Z > 0.1 and Z ^ 0.5 or 0
		end
	end
end
return function(initPacket)
	local eventModule = initPacket.em
	serverEvent = initPacket.Event
	local ScreenGui = initPacket.ScreenGui
	local MainWindowGroup = initPacket.MainWindowGroup
	Bomb.Init({
		Event = serverEvent
	})
	SpotlightBinder:Start()
	function HeliModule.VehicleEnter(vehiclePacket)
		local Passenger = vehiclePacket.Passenger
		local Model = vehiclePacket.Model
		local Make = vehiclePacket.Make
		if vehiclePacket.CarSitTrack ~= nil then
			vehiclePacket.CarSitTrack:Stop()
			vehiclePacket.CarSitTrack:Destroy()
			vehiclePacket.CarSitTrack = nil
		end
		if vehiclePacket.Seat:FindFirstChild("SitAnim") then
			local sitTrack = LocalPlayer.Character.Humanoid:LoadAnimation(ReplicatedStorage.Resource.CarSitAnimation)
			sitTrack:AdjustSpeed(0)
			sitTrack:Play()
			vehiclePacket.CarSitTrack = sitTrack
		end
		if not Passenger then
			if vehiclePacket.IsBlade or (vehiclePacket.IsLia or (vehiclePacket.IsDrone or vehiclePacket.IsBionic)) then
				SetBladeEffectsVisible(vehiclePacket.Model, true)
			end
			vehiclePacket._enteredAt = os.clock()
			vehiclePacket._flagBrakelightsEnabled = false
			inputState = { 0, 0, 0, 0, 0, 0 }
			vehiclePacket.vForward = 0
			vehiclePacket.vUp = 0
			vehiclePacket.vHeading = 0
			if vehiclePacket.IsHeli or (vehiclePacket.IsBlackHawk or vehiclePacket.IsLittleBird) then
				vehiclePacket.PropAlpha = 0
				local fadeProgress = 0
				local heartbeatConn = nil
				local overrideIndex = vehiclePacket.OverrideSpinPropi and vehiclePacket.OverrideSpinPropi + 1 or 0
				vehiclePacket.OverrideSpinPropi = overrideIndex
				local function Heartbeat(dt)
					fadeProgress = fadeProgress + dt * 1 / 3
					if fadeProgress >= 1 then
						fadeProgress = 1
					end
					vehiclePacket.PropAlpha = fadeProgress
					SpinProp(vehiclePacket, dt)
					if fadeProgress >= 1 then
						vehiclePacket.OverrideSpinPropi = nil
						heartbeatConn:disconnect()
					end
					if vehiclePacket.OverrideSpinPropi ~= overrideIndex then
						heartbeatConn:disconnect()
					end
				end
				heartbeatConn = RunService.Heartbeat:connect(Heartbeat)
			end
			if vehiclePacket.IsUFO or (vehiclePacket.IsDrone or vehiclePacket.IsCrewCapsule) then
				vehiclePacket.OverrideSpringFadePropi = (vehiclePacket.OverrideSpringFadePropi or 0) + 1
				vehiclePacket.SpringSpinAlpha = Spring.new(0, 0, 1, 2)
				vehiclePacket.SpringSpinAlpha:SetTarget(1)
			end
			if InputUtils.isTouch() and Make == "BlackHawk" then
				vehiclePacket.CrossHair = CrossHair.Make()
				vehiclePacket.CrossHair.Gui.Parent = Players.LocalPlayer.PlayerGui
				vehiclePacket.seatMaid:GiveTask(function()
					vehiclePacket.CrossHair:Destroy()
					vehiclePacket.CrossHair = nil
				end)
			end
			if vehiclePacket.FellAt ~= nil and Time.GetNowSync() - vehiclePacket.FellAt < vehiclePacket.DisableDuration then
				HeliModule.FallOutOfSky(vehiclePacket)
				vehiclePacket.FellAt = vehiclePacket.FellAt
			end
		end
	end
	function HeliModule.VehicleLeave(vehiclePacket)
		local Make = vehiclePacket.Make
		if vehiclePacket.CarSitTrack ~= nil then
			vehiclePacket.CarSitTrack:Stop()
			vehiclePacket.CarSitTrack:Destroy()
			vehiclePacket.CarSitTrack = nil
		end
		if not vehiclePacket.Passenger then
			if vehiclePacket.IsHeli or (vehiclePacket.IsBlackHawk or vehiclePacket.IsLittleBird) then
				local fadeProgress = 0
				local heartbeatConn = nil
				local overrideIndex = vehiclePacket.OverrideSpinPropi and vehiclePacket.OverrideSpinPropi + 1 or 0
				vehiclePacket.OverrideSpinPropi = overrideIndex
				local function Heartbeat(dt)
					fadeProgress = fadeProgress + dt * 1 / 1
					if fadeProgress >= 1 then
						fadeProgress = 1
					end
					vehiclePacket.PropAlpha = 1 - fadeProgress
					SpinProp(vehiclePacket, dt)
					if fadeProgress >= 1 then
						vehiclePacket.OverrideSpinPropi = nil
						heartbeatConn:disconnect()
					end
					if vehiclePacket.OverrideSpinPropi ~= overrideIndex then
						heartbeatConn:disconnect()
					end
				end
				heartbeatConn = RunService.Heartbeat:connect(Heartbeat)
			end
			if vehiclePacket.IsUFO or (vehiclePacket.IsDrone or vehiclePacket.IsCrewCapsule) then
				local fadeProgress = 0
				local heartbeatConn = nil
				local overrideIndex = (vehiclePacket.OverrideSpringFadePropi or 0) + 1
				vehiclePacket.OverrideSpringFadePropi = overrideIndex
				local function Heartbeat(dt)
					fadeProgress = fadeProgress + dt * 1 / 1
					if fadeProgress >= 1 then
						fadeProgress = 1
					end
					local spinAlpha = 1 - fadeProgress
					if vehiclePacket.IsUFO then
						HeliModule.SpinUFO(vehiclePacket, dt, spinAlpha)
					elseif vehiclePacket.IsDrone then
						HeliModule.SpinDrone(vehiclePacket, dt, spinAlpha)
					elseif vehiclePacket.IsCrewCapsule then
						HeliModule.SpinCrewCapsule(vehiclePacket, dt, spinAlpha)
					end
					if fadeProgress >= 1 then
						vehiclePacket.OverrideSpringFadePropi = nil
						heartbeatConn:disconnect()
					end
					if vehiclePacket.OverrideSpringFadePropi ~= overrideIndex then
						heartbeatConn:disconnect()
					end
				end
				heartbeatConn = RunService.Heartbeat:connect(Heartbeat)
			end
			if vehiclePacket.IsBlade or (vehiclePacket.IsLia or (vehiclePacket.IsDrone or vehiclePacket.IsBionic)) then
				SetBladeEffectsVisible(vehiclePacket.Model, false)
			end
			if vehiclePacket.SpotlightMotor ~= nil then
				SpotlightBinder:Get(vehiclePacket.SpotlightMotor):UnhookLocal()
			end
			vehiclePacket.Rotate.AngularVelocity = Vector3.new(0, 0, 0)
			local RopePull = vehiclePacket.Model.Preset:FindFirstChild("RopePull")
			if RopePull then
				RopePull.VectorForce.Force = Vector3.new(0, 0, 0)
			end
			if vehiclePacket.RopePickupPacket ~= nil then
				vehiclePacket.RopePickupPacket.Maid:Destroy()
				vehiclePacket.RopePickupPacket = nil
			end
			VehicleUtils.setBrakelightsEnabled(vehiclePacket.Model, false)
		end
	end
	local CharacterAnim = require(ReplicatedStorage.Game.CharacterAnim)
	HeliModule.Roped = false
	function HeliModule.AttemptRopeDetach()
		assert(HeliModule.Roped)
		serverEvent:FireServer("s5mzpnz8")
	end
	function eventModule.shbm9fuh(isRoped)
		HeliModule.Roped = isRoped
		for i, v in ipairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
			v:Stop()
		end
		local ropeGrabTrack = CharacterAnim.getRopeGrabTrack()
		if isRoped then
			ropeGrabTrack:Play()
		else
			ropeGrabTrack:Stop()
		end
	end
	local function AttemptDropRope()
		serverEvent:FireServer("a4o5l53e")
	end
	local CircleAction = UI.CircleAction
	local function Action(actionData, held)
		if held then
			serverEvent:FireServer("q9k4lp9h", actionData.Part)
			return true
		end
	end
	local function AddedFun(part)
		CircleAction.Add({
			Part = part,
			Name = "Rope",
			Timed = true,
			Duration = 0.5,
			Dist = 15,
			Callback = Action
		}, part)
	end
	local function RemovedFun(part)
		CircleAction.Remove(part)
	end
	if not RunUtils.isTradeWorld() then
		for _, ropePart in next, CollectionService:GetTagged("RopePull") do
			CircleAction.Add({
				Part = ropePart,
				Name = "Rope",
				Timed = true,
				Duration = 0.5,
				Dist = 15,
				Callback = Action
			}, ropePart)
		end
		CollectionService:GetInstanceAddedSignal("RopePull"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("RopePull"):Connect(RemovedFun)
	end
	function eventModule.fevtvl2i(result)
		if result.NonZero then
			eventModule.mq92d5a8({
				Title = "Store",
				Text = "Try again when you have 0 explosives!"
			})
		elseif result.NotEnoughMoney then
			eventModule.mq92d5a8({
				Title = "Store",
				Text = "You don\'t have enough cash!"
			})
			eventModule.qx9ks3jo()
		else
			assert(false, "No flag found")
		end
	end
	local function ClampUnitVectorCone(baseCFrame, direction, coneAngle)
		local localDir = baseCFrame:VectorToObjectSpace(direction)
		local polar = math.acos(localDir.Z)
		local azimuth = math.atan2(localDir.Y, localDir.X)
		local clampedPolar = math.clamp(polar, math.pi - coneAngle, math.pi + coneAngle)
		return baseCFrame:VectorToWorldSpace((Vector3.new(math.sin(clampedPolar) * math.cos(azimuth), math.sin(clampedPolar) * math.sin(azimuth), (math.cos(clampedPolar)))))
	end
	local function AttemptFireMissile()
		if RunUtils.isTradeWorld() then
			return false
		end
		local vp = initPacket.GetVehiclePacket()
		if not vp.IsBlackHawk then
			return false
		end
		local Missiles = vp.Missiles
		if not Missiles then
			return false
		end
		if LocalPlayer:GetAttribute("MissileCount") <= 0 then
			VehicleUtils.promptMissileBuy()
			return false
		end
		local now = tick()
		local timeSinceLastFire = now - Missiles.LastFire
		if timeSinceLastFire < 2 and timeSinceLastFire > 0 then
			return false
		end
		Missiles.LastFire = now
		local missilePart = Missiles.Parts[Missiles.i]
		missilePart.Transparency = 1
		task.delay(2, function()
			missilePart.Transparency = 0
		end)
		local missileCFrame = missilePart.CFrame * CFrame.Angles(0, math.pi, 0)
		local missileVelocity = missilePart.Velocity
		local mousePos
		if InputUtils.isTouch() then
			local ViewportSize = CurrentCamera.ViewportSize
			mousePos = Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
		else
			mousePos = UserInputService:GetMouseLocation()
		end
		local screenRay = CurrentCamera:ViewportPointToRay(mousePos.X, mousePos.Y)
		local _, worldTarget = RayCast.RayIgnoreNonCollideWithIgnoreList(screenRay.Origin, screenRay.Direction, 999, { vp.Model, LocalPlayer.Character })
		local _, aimTarget = RayCast.RayIgnoreNonCollideWithIgnoreList(missileCFrame.p, ClampUnitVectorCone(vp.Model.Engine.CFrame, (worldTarget - missileCFrame.p).Unit, 1.0471975511965976), 999, { vp.Model, LocalPlayer.Character })
		local fireTime = Time.GetNowSync()
		serverEvent:FireServer("exva0l4q", missileCFrame, missileVelocity, aimTarget, fireTime)
		Missile.LaunchMissile(missileCFrame, missileVelocity, aimTarget, fireTime)
		Missiles.i = Missiles.i % #Missiles.Parts + 1
	end
	function eventModule.exva0l4q(missileCFrame, missileVelocity, aimTarget, fireTime, extraParam1, extraParam2, extraParam3)
		Missile.LaunchMissile(missileCFrame, missileVelocity, aimTarget, fireTime, extraParam1, extraParam2, extraParam3)
	end
	local function AttemptDropBomb()
		if RunUtils.isTradeWorld() then
			return false
		end
		local vp = initPacket.GetVehiclePacket()
		local Missiles = vp.Missiles
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
		local BoundingBox = vp.Model.BoundingBox
		local dropCFrame = BoundingBox.CFrame * CFrame.new(0, -BoundingBox.Size.Y * 0.5 + 4, -BoundingBox.Size.Z * 0.5 + 10)
		local dropVelocity = BoundingBox.Velocity
		local dropTime = Time.GetNowSync()
		Bomb.DropBomb(dropCFrame, dropVelocity, dropTime, LocalPlayer)
		serverEvent:FireServer("ukkcmz0e", dropCFrame, dropVelocity, dropTime)
	end
	function eventModule.ukkcmz0e(dropCFrame, dropVelocity, dropTime, player)
		Bomb.DropBomb(dropCFrame, dropVelocity, dropTime, player)
	end
	function HeliModule.attemptDropRope()
		AttemptDropRope()
	end
	function HeliModule.attemptFireMissile()
		AttemptFireMissile()
	end
	function HeliModule.attemptDropBomb()
		AttemptDropBomb()
	end
	function HeliModule.toggleHeadlights(vehiclePacket)
		if vehiclePacket.SpotlightMotor then
			local spotlight = SpotlightBinder:Get(vehiclePacket.SpotlightMotor)
			if spotlight then
				spotlight:RequestToggle()
			end
		else
			serverEvent:FireServer("sgcbalmd", "Lights")
		end
	end
	function HeliModule.setUp(active)
		inputState[6] = if active then 1 else 0
	end
	function HeliModule.setDown(active)
		inputState[5] = if active then 1 else 0
	end
	HeliModule.SpotlightBinder = SpotlightBinder
	return HeliModule
end
