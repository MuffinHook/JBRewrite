local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local Interval = require(ReplicatedStorage.Std.Interval)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local BezierPath = require(ReplicatedStorage.Game.BezierPath)
local GraphUtils = require(ReplicatedStorage.Game.Cart.GraphUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local TransportJetConsts = require(ReplicatedStorage.TransportJet.TransportJetConsts)
local placeholderVector = Vector3.new()
local TransportJet = {}
TransportJet.__index = TransportJet
setmetatable(TransportJet, BaseObject)
function TransportJet.new(self)
	local instance = BaseObject.new(self)
	setmetatable(instance, TransportJet)
	local visualModel = ReplicatedStorage.TransportJet.Res.TransportJet:Clone()
	visualModel.Parent = workspace
	instance.visualModel = visualModel
	instance.maid:GiveTask(visualModel)
	instance.jetEngineSound = Audio.ObjectLocal(instance.visualModel.PrimaryPart, 9553468279, {
		Looped = true,
		RollOffMinDistance = 32,
		RollOffMaxDistance = 512,
		Volume = 0,
		DoNotPlay = true
	})
	instance.maid:GiveTask(instance.jetEngineSound)
	instance.jetWindSound = Audio.ObjectLocal(instance.visualModel.PrimaryPart, 9553467792, {
		Looped = true,
		RollOffMinDistance = 64,
		RollOffMaxDistance = 512,
		Volume = 0,
		DoNotPlay = true
	})
	instance.maid:GiveTask(instance.jetWindSound)
	local isFlightPending = false
	local function action(launchButton, isActivated)
		if isActivated then
			local characterRoot = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			local startPosition = characterRoot.Position
			if not isFlightPending then
				isFlightPending = true
				local confirmationDialog = Confirmation.new(("Fly across the map for $%s?"):format(TransportJetConsts.LAUNCH_COST_CASH))
				confirmationDialog.Maid:GiveTask(confirmationDialog.OnYes:Connect(function()
					self:FindFirstChild(TransportJetConsts.REQUEST_LAUNCH_REMOTE_NAME):FireServer()
				end))
				confirmationDialog.Maid:GiveTask(function()
					isFlightPending = false
				end)
				confirmationDialog.Maid:GiveTask(Interval.every(1):Connect(function()
					if (startPosition - characterRoot.Position).Magnitude > 16 then
						confirmationDialog:Destroy()
					end
				end))
				return true
			end
		end
	end
	local launchButton = visualModel:FindFirstChild("RequestLaunch")
	local launchConfig = {
		Part = launchButton,
		ValidRoot = visualModel,
		Name = "Launch",
		Timed = false,
		Dist = 7,
		Callback = action
	}
	instance.maid:GiveTask(CircleAction.Add(launchConfig, launchButton))
	local function updateDoorOpen()
		local isDoorOpen = instance:GetDoorOpen()
		instance:SetDoorOpen(isDoorOpen)
		launchConfig.Enabled = isDoorOpen
	end
	local initialDoorState = instance:GetDoorOpen()
	instance:SetDoorOpen(initialDoorState)
	launchConfig.Enabled = initialDoorState
	instance.maid:GiveTask(self:GetAttributeChangedSignal(TransportJetConsts.DOOR_OPEN_ATTR_NAME):Connect(updateDoorOpen))
	instance.maid:GiveTask(Interval.every(0.5):Connect(function()
		if instance:_isLocalStanding() then
			instance.shouldMovePlayer = true
		else
			instance.shouldMovePlayer = false
		end
	end))
	instance.lastCF = nil
	instance.realRoll = 0
	instance.maid:GiveTask(RxInstanceUtils.observeAttribute(self, TransportJetConsts.LAUNCHED_AT_ATTR_NAME, function()
		instance:_update()
	end))
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(self, TransportJetConsts.PATH_POINTS_OBJ_NAME, function(self, pathMaid)
		if self then
			pathMaid:GiveTask(self.Changed:Connect(function()
				instance:_update()
			end))
		end
		instance:_update()
	end))
	return instance
end
function TransportJet._isLocalStanding(self)
	local characterRoot = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
	raycastParams.FilterDescendantsInstances = self.visualModel:FindFirstChild("TransportFloors"):GetChildren()
	if characterRoot then
		return workspace:Raycast(characterRoot.Position, Vector3.new(0, -20, 0), raycastParams) ~= nil
	else
		return false
	end
end
function TransportJet._update(self)
	local runningMaid = Maid.new()
	self.maid.runningMaid = runningMaid
	local launchTime = self.obj:GetAttribute(TransportJetConsts.LAUNCHED_AT_ATTR_NAME)
	local pathContainer = self.obj:FindFirstChild(TransportJetConsts.PATH_POINTS_OBJ_NAME)
	if pathContainer then
		local startNode = pathContainer.Value
		if startNode then
			local nodeStartOffset = startNode:GetAttribute(TransportJetConsts.NODE_OFFSET_START_ATTR_NAME) or 0
			local nodeEndOffset = startNode:GetAttribute(TransportJetConsts.NODE_OFFSET_END_ATTR_NAME) or 0
			local bezierPath = BezierPath.new()
			local pointsList = {}
			for i = 1, #startNode:GetChildren() do
				local nodeExists
				local currentNode = startNode:FindFirstChild(i)
				nodeExists = currentNode ~= nil
				assert(nodeExists, "missing point")
				table.insert(pointsList, currentNode.Position)
			end
			assert(#pointsList > 0, "no points for transport jet")
			bezierPath:SetPoints(pointsList)
			bezierPath:SetNodeOffset(nodeStartOffset, nodeEndOffset + 1)
			local totalPathLength = bezierPath:ApproximateLength(10000)
			local flightSegments = {}
			local RUNWAY_LENGTH = TransportJetConsts.RUNWAY_LENGTH
			local TOP_SPEED = TransportJetConsts.TOP_SPEED
			table.insert(flightSegments, {
				timeUntil = 10000000000,
				speedStart = 0,
				speedEnd = TOP_SPEED
			})
			assert(GraphUtils.constrainLastTimeToReachTarget(flightSegments, RUNWAY_LENGTH), "cannot constrain last time to reach target")
			table.insert(flightSegments, {
				timeUntil = 10000000000,
				speedStart = TOP_SPEED,
				speedEnd = TOP_SPEED
			})
			assert(GraphUtils.constrainLastTimeToReachTarget(flightSegments, totalPathLength - RUNWAY_LENGTH), "cannot constrain last time to reach target")
			table.insert(flightSegments, {
				timeUntil = 10000000000,
				speedStart = TOP_SPEED,
				speedEnd = 0
			})
			assert(GraphUtils.constrainLastTimeToReachTarget(flightSegments, totalPathLength), "cannot constrain last time to reach target")
			GraphUtils.cap(flightSegments)
			local totalFlightTime = flightSegments[#flightSegments - 1].timeUntil
			local lastWorldPosition = nil
			local lastFrameTime = os.clock()
			local function setFlightElapsed(elapsedTime)
				local currentFrameTime = os.clock()
				local currentWorldPosition, currentDirection = bezierPath:GetWorldPositionAt((GraphUtils.calculateDist(flightSegments, elapsedTime)))
				local remainingTime = totalFlightTime - elapsedTime
				if lastWorldPosition then
					local velocity = (currentWorldPosition - lastWorldPosition).Magnitude / (currentFrameTime - lastFrameTime)
					self.jetEngineSound.Volume = math.clamp(velocity / 100, 0, 1) * 0.8
					self.jetEngineSound.PlaybackSpeed = math.clamp(velocity / 100, 0, 1) * 0.2 + 0.8
					self.jetWindSound.Volume = math.clamp(velocity / 25, 0, 1) * 1
				end
				lastFrameTime = currentFrameTime
				lastWorldPosition = currentWorldPosition
				local rollAngle = self:StepRoll(if remainingTime < 1 then 0 else math.acos((self.visualModel.PrimaryPart.CFrame.LookVector:Dot(currentDirection.Unit))) * 10, if remainingTime < 1 then 0.03 else 0.01)
				local jetCFrame = CFrame.lookAt(placeholderVector, currentDirection) * CFrame.Angles(0, 0, rollAngle) + currentWorldPosition
				if self.shouldMovePlayer then
					local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
					if localPlayer and self.lastCF then
						local cframeOffset = jetCFrame * self.lastCF:Inverse()
						localPlayer.CFrame = cframeOffset * localPlayer.CFrame
						local cameraOffset = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
						CurrentCamera.CFrame = CurrentCamera.CFrame * cameraOffset * (cframeOffset - cframeOffset.p) * cameraOffset:Inverse()
					end
				end
				self.lastCF = jetCFrame
				self.visualModel:PivotTo(jetCFrame)
			end
			local door = self.visualModel:FindFirstChild("Door")
			local doorDuration = DoorUtils.getDuration(door)
			local isTurbineEnabled = false
			local isLandingGearOpen = true
			runningMaid:GiveTask((task.delay(doorDuration + totalFlightTime * 0.5, function()
				Audio.ObjectLocal(self.visualModel.PrimaryPart, 9553470967)
			end)))
			self.jetEngineSound.Volume = 0
			self.jetEngineSound:Play()
			self.jetWindSound.Volume = 0
			self.jetWindSound:Play()
			runningMaid:GiveTask(function()
				self.jetEngineSound:Stop()
				self.jetWindSound:Stop()
			end)
			local flightStartTime = os.clock() - workspace:GetServerTimeNow()
			runningMaid:GiveTask(RunService.Heartbeat:Connect(function()
				local elapsedFrameTime = os.clock() - flightStartTime
				local shouldTurbineRun = if doorDuration < elapsedFrameTime then elapsedFrameTime < doorDuration + totalFlightTime else false
				if shouldTurbineRun ~= isTurbineEnabled then
					isTurbineEnabled = shouldTurbineRun
					for i, turbine in ipairs(self.visualModel:FindFirstChild("Turbines"):GetChildren()) do
						turbine:SetAttribute("SpinnerEnabled", shouldTurbineRun)
						DoorUtils.getInnerModel(turbine):FindFirstChild("Turbine"):FindFirstChildWhichIsA("Attachment"):FindFirstChildWhichIsA("ParticleEmitter").Enabled = shouldTurbineRun
					end
				end
				local shouldGearBeOpen = if doorDuration + 2 < elapsedFrameTime then elapsedFrameTime < doorDuration + totalFlightTime - 2 else false
				if shouldGearBeOpen ~= isLandingGearOpen then
					isLandingGearOpen = shouldGearBeOpen
					DoorUtils.setOpen(self.visualModel:FindFirstChild("FrontLandingGear"), shouldGearBeOpen)
					DoorUtils.setOpen(self.visualModel:FindFirstChild("RearLandingGear"), shouldGearBeOpen)
				end
				setFlightElapsed(if elapsedFrameTime < doorDuration then 0 elseif doorDuration + totalFlightTime < elapsedFrameTime then totalFlightTime else elapsedFrameTime - doorDuration)
				if doorDuration * 2 + totalFlightTime < elapsedFrameTime then
					self:_stopRunning()
				end
			end))
		end
	end
end
function TransportJet._stopRunning(self)
	self.maid.runningMaid = nil
end
function TransportJet.StepRoll(self, targetRoll, smoothingFactor)
	if targetRoll ~= targetRoll then
		targetRoll = 0
	end
	local currentRoll = self.realRoll or 0
	local newRoll = currentRoll + (targetRoll - currentRoll) * smoothingFactor
	self.realRoll = newRoll
	return newRoll
end
function TransportJet.SetDoorOpen(self, isOpen)
	local door = self.visualModel:FindFirstChild("Door")
	DoorUtils.setOpen(door, isOpen)
	Audio.ObjectLocal(door.PrimaryPart, 4487204926)
end
function TransportJet.GetDoorOpen(self)
	return self.obj:GetAttribute(TransportJetConsts.DOOR_OPEN_ATTR_NAME) == true
end
return Binder.new(TransportJetConsts.TAG_NAME, TransportJet)
