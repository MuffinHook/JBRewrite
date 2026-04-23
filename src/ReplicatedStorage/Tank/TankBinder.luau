game:GetService("GuiService")
local Players = game:GetService("Players")
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TankUtils = require(script.Parent.TankUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Signal = require(ReplicatedStorage.Std.Signal)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local Spring = require(ReplicatedStorage.Std.Spring)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DrivingControls = require(ReplicatedStorage.DrivingControls.DrivingControls)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local MilitaryTurretUtils = require(ReplicatedStorage.Game.MilitaryTurret.MilitaryTurretUtils)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local WheelWorld = require(ReplicatedStorage.Module.Wheel.WheelWorld)
local Wheel = require(ReplicatedStorage.Module.Wheel.Wheel)
local Missile = require(ReplicatedStorage.Game.Missile)
local Time = require(ReplicatedStorage.Module.Time)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local WheelType = Enumer({ "Wheel", "Front", "Gear" })
local TankBinder = {}
TankBinder.__index = TankBinder
function TankBinder.new(obj, manifest)
	local self = {}
	setmetatable(self, TankBinder)
	self.obj = obj
	self.manifest = manifest
	self._maid = Maid.new()
	self._onGunnerSeatLeft = Signal.new()
	self._gunnerMaid = Maid.new()
	self._maid:GiveTask(self._gunnerMaid)
	self._lastShoot = 0
	self.mobileInputObject = nil
	self._flagBrakelightsEnabled = false
	self:_handleIdleUpdate()
	self:_listenSeats("Seat")
	self:_listenSeats("Passenger")
	self:_listenNetwork()
	return self
end
function TankBinder._listenSeats(self, seatName)
	self._maid:GiveTask(RxInstanceUtils.observeChildrenNamed(self.obj, seatName, function(seatInstance, seatMaid)
		seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(seatInstance, "PlayerName", function(playerNameValue, playerNameMaid)
			self:_handlePlayerNameChanged(seatInstance, playerNameValue, playerNameMaid)
			playerNameMaid:GiveTask(playerNameValue.Changed:Connect(function()
				self:_handlePlayerNameChanged(seatInstance, playerNameValue, playerNameMaid)
			end))
		end))
	end))
end
function TankBinder._handlePlayerNameChanged(self, seatInstance, playerNameValue, playerNameMaid)
	local player = Players:FindFirstChild(playerNameValue.Value)
	if player then
		local seatMaid = Maid.new()
		playerNameMaid.seatMaid = seatMaid
		self:_handleSeated(player, seatMaid, seatInstance)
	else
		playerNameMaid.seatMaid = nil
	end
end
function TankBinder._getMouseLocation(self)
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5)
	else
		return UserInputService:GetMouseLocation()
	end
end
function TankBinder._transformLocalMousePosition(self, position)
	return position
end
function TankBinder._getIgnoreList(self)
	return { self.obj }
end
function TankBinder._projectMouseLocationToWorld(self, screenPos)
	local ray = CurrentCamera:ViewportPointToRay(screenPos.x, screenPos.y)
	self.raycastParams.FilterDescendantsInstances = self:_getIgnoreList()
	local result = Raycast.collidable(ray.Origin, ray.Direction, 999, self.raycastParams)
	return self:_transformLocalMousePosition(result and result.Position or ray.Origin + ray.Direction * 999), ray.Direction
end
function TankBinder._getMouseWorldPosition(self)
	return self:_projectMouseLocationToWorld(self:_getMouseLocation())
end
function TankBinder._flip(self)
	local PrimaryPart = self.obj.PrimaryPart
	local LookVector = PrimaryPart.CFrame.LookVector
	local Unit = LookVector:Cross(Vector3.new(0, 1, 0)).Unit
	self.obj:SetPrimaryPartCFrame(CFrame.fromMatrix(PrimaryPart.Position, Unit, Vector3.new(0, 1, 0), -LookVector))
end
function TankBinder._handleSeated(self, player, seatMaid, seat)
	if seat.Name == "Seat" then
		self:_handleSeatedDriver(player, seatMaid)
	end
	seatMaid:GiveTask(self._onGunnerSeatLeft:Connect(function()
		self:_checkIfThisPlayerIsGunner(player, seatMaid)
	end))
	self:_checkIfThisPlayerIsGunner(player, seatMaid)
end
function TankBinder._checkIfThisPlayerIsGunner(self, player, seatMaid)
	local gunner = TankUtils.getGunner(self.obj)
	if gunner == player and (gunner and gunner ~= self._currentGunner) then
		self._currentGunner = gunner
		self:_handleSeatedGunner(gunner, seatMaid)
	end
end
function TankBinder._handleSeatedGunner(self, gunner, seatMaid)
	local isLocalPlayer = gunner == Players.LocalPlayer
	local gunnerMaid = Maid.new()
	self._maid.gunnerMaid = gunnerMaid
	seatMaid:GiveTask(function()
		if self._maid.gunnerMaid == gunnerMaid then
			self._currentGunner = nil
			self._maid.gunnerMaid = nil
			self._onGunnerSeatLeft:Fire(nil)
		end
	end)
	local turretAudio = Audio.ObjectLocal(self.obj.PrimaryPart, 8206012878, {
		Volume = 0,
		Pitch = 1,
		Looped = true
	})
	gunnerMaid:GiveTask(function()
		Audio.promiseFadeTo(turretAudio, 0, 0.5):andThen(function()
			turretAudio:Destroy()
		end)
	end)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = self:_getIgnoreList()
	raycastParams.IgnoreWater = true
	self.raycastParams = raycastParams
	local topMotor = self.manifest.topMotor
	local gunMotor = self.manifest.gunMotor
	if not self._lastPitch then
		self._lastPitch = 0
	end
	if not self._lastYaw then
		self._lastYaw = 0
	end
	if not self._pitchAccel then
		self._pitchAccel = AccelTween.new(20)
	end
	if not self._yawAccel then
		self._yawAccel = AccelTween.new(15)
	end
	if not self._kickSpring then
		self._kickSpring = Spring.new(0, 0, 0.5, 15)
	end
	local lastReplicateTime = os.clock()
	local isFiring = false
	gunnerMaid:GiveTask(RunService.Heartbeat:Connect(function()
		if isLocalPlayer then
			if isFiring then
				local topMotorWorldCFrame = topMotor.Part1.CFrame * topMotor.C0:Inverse()
				local mouseWorldPos = self:_getMouseWorldPosition()
				local localMousePos = topMotorWorldCFrame:PointToObjectSpace(mouseWorldPos)
				local yawAngle = math.atan2(-localMousePos.x, -localMousePos.z)
				local gunLocalPos = (topMotorWorldCFrame * CFrame.Angles(0, yawAngle, 0) * gunMotor.C0:Inverse()):PointToObjectSpace(mouseWorldPos)
				local pitchAngle = math.atan2(gunLocalPos.y, -gunLocalPos.z)
				self._lastYaw = self._lastYaw + MilitaryTurretUtils.shortAngleDist(self._lastYaw, yawAngle)
				self._lastPitch = math.clamp(pitchAngle, -0.2617993877991494, 0.5235987755982988)
			end
			local now = os.clock()
			if now - lastReplicateTime > 0.06666666666666667 then
				lastReplicateTime = now
				self.manifest.replicateRingRemote:FireServer(self._lastYaw, self._lastPitch)
			end
		end
		if self._yawAccel.t ~= self._lastYaw then
			self._yawAccel.t = self._lastYaw
		end
		if self._pitchAccel.t ~= self._lastPitch then
			self._pitchAccel.t = self._lastPitch
		end
		turretAudio.Volume = (math.clamp(math.abs(self._yawAccel.v) / 4, 0, 1) * 0.9 + 0.1) * 0.8
		local kickOffset = self._kickSpring:Update()
		topMotor.C1 = topMotor.C0:Inverse() * CFrame.Angles(0, self._yawAccel.p, 0) * topMotor.C0
		gunMotor.C1 = gunMotor.C0:Inverse() * CFrame.Angles(self._pitchAccel.p, 0, 0) * CFrame.new(0, 0, kickOffset) * gunMotor.C0
	end))
	if isLocalPlayer then
		local function shoot()
			if self.obj:GetAttribute("TankDisabled") == true then
				return
			end
			if Players.LocalPlayer:GetAttribute("MissileCount") <= 0 and not Players.LocalPlayer.Character:GetAttribute("TankRoyaleAlive") then
				VehicleUtils.promptMissileBuy()
				return false
			end
			local now = os.clock()
			if not (now - self._lastShoot < 1 / self.obj:GetAttribute("MissileLaunchHz")) then
				self._lastShoot = now
				local Part0 = gunMotor.Part0
				local gunCFrame = Part0.CFrame
				local rayResult = Raycast.collidable(gunCFrame.p, gunCFrame.LookVector, 999, self.raycastParams)
				local targetPos = rayResult and rayResult.Position or gunCFrame.p + gunCFrame.LookVector * 999
				local launchCFrame = gunCFrame * CFrame.new(0, 0, -14)
				local timestamp = Time.GetNowSync()
				self:_launchMissile(launchCFrame, Part0.Velocity, targetPos, timestamp)
				self.manifest.shootRemote:FireServer(self._yawAccel.p, self._pitchAccel.p, targetPos, timestamp)
			end
		end
		gunnerMaid:GiveTask(ActionButtonService.add({
			priority = 350,
			image = "rbxassetid://4939740665",
			keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonX },
			onPressed = function()
				shoot()
			end
		}))
		gunnerMaid:GiveTask(UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
				isFiring = true
			elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Touch then
				self._mobileInputObject = input
			end
		end))
		gunnerMaid:GiveTask(UserInputService.InputEnded:Connect(function(input, gameProcessed)
			if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
				isFiring = false
			elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Touch then
				local is_mobileInputObject = self._mobileInputObject == input
			end
		end))
		gunnerMaid:GiveTask(ActionButtonService.add({
			priority = 975,
			image = "rbxassetid://4939736720",
			touchIsToggle = true,
			keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL1 },
			onPressed = function()
				self._mobileInputObject = nil
				isFiring = true
			end,
			onReleased = function()
				isFiring = false
			end
		}))
	end
end
function TankBinder._updateTreads(self, wheelWorld, dt)
	local leftCount = 0
	local leftSum = 0
	local rightCount = 0
	local suspensionOffsets = {}
	local treadTypes = {}
	local fakeTreadMotors = {}
	local rightSum = 0
	for i, wheel in ipairs(wheelWorld.Wheels) do
		local suspOffset, spinAngle, treadSpeed = wheel:Update(dt, 0)
		wheel.wheelMotor.C1 = CFrame.new(0, suspOffset, 0) * CFrame.Angles(spinAngle, 0, 0)
		suspensionOffsets[wheel.PartNode] = suspOffset
		treadTypes[wheel.PartNode] = wheel.treadType
		fakeTreadMotors[wheel.PartNode] = wheel.fakeTreadMotor
		if wheel.fakeTreadMotor then
			wheel.fakeTreadMotor.C1 = CFrame.new(0, suspOffset, 0)
		end
		if wheel._isRight then
			rightCount = rightCount + 1
			rightSum = rightSum + treadSpeed
		else
			leftSum = leftSum + treadSpeed
			leftCount = leftCount + 1
		end
	end
	local leftAvg = leftSum / leftCount
	local rightAvg = rightSum / rightCount
	for i, wheel in ipairs(wheelWorld.Wheels) do
		local treadScrollAmount
		local PartNode = wheel.PartNode
		local treadToTarget = wheel.treadToTarget
		local nodeOffset = suspensionOffsets[PartNode]
		local targetOffset = suspensionOffsets[treadToTarget]
		local nodeWorldPos = nil
		local targetWorldPos = nil
		if treadTypes[PartNode] == WheelType.Wheel then
			nodeWorldPos = PartNode.CFrame * Vector3.new(0, nodeOffset - wheel.RadiusVisual + 0.1, 0)
		elseif treadTypes[PartNode] == WheelType.Gear then
			nodeWorldPos = fakeTreadMotors[PartNode].Part0.Bottom.WorldPosition
		elseif treadTypes[PartNode] == WheelType.Front then
			nodeWorldPos = fakeTreadMotors[PartNode].Part0.Top.WorldPosition
		end
		if treadTypes[treadToTarget] == WheelType.Wheel then
			targetWorldPos = treadToTarget.CFrame * Vector3.new(0, targetOffset - wheel.RadiusVisual + 0.1, 0)
		elseif treadTypes[treadToTarget] == WheelType.Gear then
			targetWorldPos = fakeTreadMotors[treadToTarget].Part0.Top.WorldPosition
		elseif treadTypes[treadToTarget] == WheelType.Front then
			targetWorldPos = fakeTreadMotors[treadToTarget].Part0.Bottom.WorldPosition
		end
		local segmentLength = (nodeWorldPos - targetWorldPos).Magnitude
		wheel.treadMotor.C1 = PartNode.CFrame:ToObjectSpace(CFrame.lookAt(nodeWorldPos, targetWorldPos, self.obj.PrimaryPart.CFrame.UpVector) * CFrame.new(0, 0, -segmentLength * 0.5))
		local treadPart = wheel.treadMotor.Part0
		treadPart.Size = Vector3.new(treadPart.Size.X, treadPart.Size.Y, segmentLength)
		treadScrollAmount = if wheel._isRight and rightAvg then rightAvg else leftAvg
		local newOffset = wheel.treadTex[1].OffsetStudsV - treadScrollAmount
		for i2, tex in ipairs(wheel.treadTex) do
			tex.OffsetStudsV = newOffset
		end
	end
	return leftAvg, rightAvg
end
local function getUpdateRate(elapsed, minDist, maxDist)
	if elapsed < minDist then
		return 0
	else
		return (elapsed - minDist) / (maxDist - minDist)
	end
end
function TankBinder._handleIdleUpdate(self)
	local idleMaid = Maid.new()
	self._maid.lqMaid = idleMaid
	local wheelWorld = self:_buildWheelWorld(idleMaid, false)
	local lastUpdate = os.clock()
	idleMaid:GiveTask(RunService.Heartbeat:Connect(function()
		local now = os.clock()
		local dt = now - lastUpdate
		local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		if rootPart then
			local Magnitude = (rootPart.Position - self.obj.PrimaryPart.Position).Magnitude
			if not (dt < if Magnitude < 0 then 0 else (Magnitude - 0) / 256) then
				lastUpdate = now
				self:_updateTreads(wheelWorld, dt)
			end
		end
	end))
end
function TankBinder._handleSeatedDriver(self, player, seatMaid)
	self._maid.lqMaid = nil
	seatMaid:GiveTask(function()
		self:_handleIdleUpdate()
	end)
	local isLocalPlayer = player == Players.LocalPlayer
	local drivingControls
	if isLocalPlayer then
		drivingControls = DrivingControls.new()
		seatMaid:GiveTask(drivingControls)
		local obj = self.obj
		seatMaid:GiveTask(function()
			VehicleUtils.setBrakelightsEnabled(obj, false)
		end)
	else
		drivingControls = nil
	end
	local wheelWorld = self:_buildWheelWorld(seatMaid, isLocalPlayer)
	local effWheelCount = wheelWorld:GetEffWheelCount()
	local forwardBackwardAccel = AccelTween.new(500)
	local leftRightAccel = AccelTween.new(2000)
	local engineAudio = Audio.ObjectLocal(self.obj.PrimaryPart, 9058406725, {
		Volume = 0,
		Pitch = 1,
		Looped = true
	})
	seatMaid:GiveTask(function()
		Audio.promiseFadeTo(engineAudio, 0, 0.5):andThen(function()
			engineAudio:Destroy()
		end)
	end)
	local trackAudio = Audio.ObjectLocal(self.obj.PrimaryPart, 8206014264, {
		Volume = 0,
		Pitch = 1,
		Looped = true
	})
	seatMaid:GiveTask(function()
		Audio.promiseFadeTo(trackAudio, 0, 0.5):andThen(function()
			trackAudio:Destroy()
		end)
	end)
	local engineSpeed = 0
	seatMaid:GiveTask(RunService.Heartbeat:Connect(function(dt)
		local maxSpeed = 60
		if drivingControls then
			local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
			local movementLocked = if self.obj:GetAttribute("TankDisabled") == true then true else vehiclePacket.LockMovement
			local forwardInput = drivingControls:GetForwardBackward()
			if movementLocked then
				forwardInput = 0
			end
			if forwardBackwardAccel.t ~= forwardInput then
				forwardBackwardAccel.t = forwardInput
				forwardBackwardAccel.v = 0
			end
			local turnInput = drivingControls:GetLeftRight()
			if movementLocked then
				turnInput = 0
			end
			if leftRightAccel.t ~= turnInput then
				leftRightAccel.t = turnInput
				leftRightAccel.v = 0
			end
			if forwardBackwardAccel.p < 0 then
				maxSpeed = maxSpeed * 0.5
			end
			engineSpeed = if math.abs(forwardBackwardAccel.p) < 0.1 then engineSpeed + math.sign(0 - engineSpeed) * 75 * dt else engineSpeed + math.sign(maxSpeed - engineSpeed) * 30 * dt
			engineSpeed = math.max(engineSpeed, 0)
			local isBraking = forwardInput < 1e-6
			if self._flagBrakelightsEnabled ~= isBraking then
				self._flagBrakelightsEnabled = isBraking
				VehicleUtils.setBrakelightsEnabled(self.obj, isBraking)
			end
		end
		for i, wheel in ipairs(wheelWorld.Wheels) do
			local wheelForce
			local isRight = wheel._isRight
			if drivingControls then
				local forwardP = forwardBackwardAccel.p
				local turnP = leftRightAccel.p
				local accelSum = Vector3.new()
				if math.abs(forwardP) >= 0.001 then
					accelSum = accelSum + Vector3.new(0, 0, -engineSpeed * forwardP) / effWheelCount
				end
				if math.abs(turnP) >= 0.001 then
					wheelForce = if isRight then 1 else -1
					accelSum = accelSum + Vector3.new(0, 0, -10 * turnP * wheelForce) / effWheelCount
				end
				wheel:SetExternalGroundAccel(accelSum)
			end
		end
	end))
	seatMaid:GiveTask(RunService.Heartbeat:Connect(function(dt)
		local leftAvg, rightAvg = self:_updateTreads(wheelWorld, dt)
		trackAudio.Volume = (math.clamp((math.abs(leftAvg) + math.abs(rightAvg)) * 0.5 / dt / 10, 0, 1) * 0.9 + 0.1) * 0.8
		local forwardSpeed = math.abs((self.obj.PrimaryPart.Velocity:Dot(self.obj.PrimaryPart.CFrame.LookVector)))
		engineAudio.Volume = (math.clamp(forwardSpeed / 90, 0, 1) * 0.6 + 0.4) * 1
		engineAudio.PlaybackSpeed = math.clamp(forwardSpeed / 100, 0, 1) * 0.4 + 0.8
	end))
	if isLocalPlayer then
		local lastFlipTime = os.clock()
		seatMaid:GiveTask(ActionButtonService.add({
			priority = 850,
			image = "rbxassetid://4939737424",
			keyCodes = { Enum.KeyCode.V, Enum.KeyCode.ButtonR1 },
			onPressed = function()
				local now = os.clock()
				if not (now - lastFlipTime < 1) then
					lastFlipTime = now
					self:_flip()
				end
			end
		}))
	end
end
function TankBinder._listenNetwork(self)
	self._maid:GiveTask(self.manifest.replicateRingRemote.OnClientEvent:Connect(function(yaw, pitch)
		self._lastYaw = yaw
		self._lastPitch = pitch
	end))
	self._maid:GiveTask(self.manifest.shootRemote.OnClientEvent:Connect(function(yaw, pitch, targetPos, timestamp)
		local topMotor = self.manifest.topMotor
		local gunMotor = self.manifest.gunMotor
		self._lastYaw = yaw
		self._lastPitch = pitch
		self:_launchMissile(topMotor.Part1.CFrame * topMotor.C0:Inverse() * CFrame.Angles(0, yaw, 0) * gunMotor.C0:Inverse() * CFrame.Angles(pitch, 0, 0) * CFrame.new(0, 0, -14) * CFrame.new(0, 0, -14), gunMotor.Part0.Velocity, targetPos, timestamp)
	end))
end
function TankBinder._launchMissile(self, launchCFrame, velocity, targetPos, timestamp)
	Missile.LaunchMissile(velocity, targetPos, timestamp, "TankMissile", 0, self:_getIgnoreList())
	self.obj.PrimaryPart:ApplyImpulseAtPosition(-launchCFrame.LookVector * self.obj.PrimaryPart.AssemblyMass * 30, launchCFrame.p)
	self._kickSpring:Accelerate(80)
	Audio.ObjectLocal(self.obj.PrimaryPart, 8206015084, {
		Volume = 0.6
	})
	local ParticlePart = self.obj:FindFirstChild("Top"):FindFirstChild("Gun"):FindFirstChild("ParticlePart")
	for i, v in ipairs(ParticlePart:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v:Emit(10)
		end
	end
end
function TankBinder._buildWheelWorld(self, taskMaid, applyForces)
	local wheelWorld = WheelWorld.new()
	wheelWorld:SetModel(self.obj)
	taskMaid:GiveTask(wheelWorld)
	for i, wheelPart in ipairs(self.obj:FindFirstChild("Wheels"):GetChildren()) do
		local isRight
		local localCFrame = self.obj.PrimaryPart.CFrame:ToObjectSpace(wheelPart.CFrame)
		isRight = localCFrame.x > 0
		local _ = localCFrame.z < 0
		local wheel = Wheel.new(wheelPart, not applyForces)
		local wheelType = WheelType.Wheel
		if wheelPart.Name == "Front" then
			wheelType = WheelType.Front
		elseif wheelPart.Name == "Gear" then
			wheelType = WheelType.Gear
		end
		wheel.treadType = wheelType
		wheel._isRight = isRight
		wheel:SetSpringConstants(2, 6)
		wheel:SetHorizontalFriction(6)
		wheel:SetForwardFriction(2)
		wheel:SetForwardFriction2(0.01)
		wheel:SetVisualRadius(1.6384999999999998)
		if wheelType == WheelType.Wheel then
			wheel:SetSuspensionHeight(5.3)
		else
			wheel:SetSuspensionHeight(3.3)
		end
		wheel:SetVersion(2)
		if applyForces then
			wheel:SetApplyForces(wheelType == WheelType.Wheel)
		end
		wheelWorld:AddWheel(wheel)
		wheel.wheelMotor = wheelPart:FindFirstChild("WheelMotor")
		wheel.fakeTreadMotor = wheelPart:FindFirstChild("FakeTreadMotor")
		wheel.treadMotor = wheelPart:FindFirstChild("TreadMotor")
		wheel.treadToTarget = wheelPart:FindFirstChild("_TrackToWheel").Value
		wheel.treadTex = { wheel.treadMotor.Part0:FindFirstChild("TreadTex0"), wheel.treadMotor.Part0:FindFirstChild("TreadTex1") }
		if wheel.fakeTreadMotor then
			for i2, sibling in ipairs(wheel.fakeTreadMotor.Part0.Parent:GetChildren()) do
				if sibling.Name == "Tread" then
					for i3, child in ipairs(sibling:GetChildren()) do
						if child:IsA("Texture") then
							table.insert(wheel.treadTex, child)
						end
					end
				end
			end
		end
	end
	return wheelWorld
end
function TankBinder.Destroy(self)
	self._maid:Destroy()
	setmetatable(self, nil)
end
return ManifestBinder.new("Tank", {
	topMotor = "BoundingBox/TopMotor",
	gunMotor = "BoundingBox/GunMotor",
	shootRemote = "ShootRemote",
	replicateRingRemote = "ReplicateRingRemote"
}, TankBinder)
