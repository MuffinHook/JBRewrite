-- Reviewed by Claude
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
local vector = Vector3.new()
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(self)
	local vector = BaseObject.new(self)
	setmetatable(vector, t)
	local var3 = ReplicatedStorage.TransportJet.Res.TransportJet:Clone()
	var3.Parent = workspace
	vector.visualModel = var3
	vector.maid:GiveTask(var3)
	vector.jetEngineSound = Audio.ObjectLocal(vector.visualModel.PrimaryPart, 9553468279, {
		Looped = true,
		RollOffMinDistance = 32,
		RollOffMaxDistance = 512,
		Volume = 0,
		DoNotPlay = true
	})
	vector.maid:GiveTask(vector.jetEngineSound)
	vector.jetWindSound = Audio.ObjectLocal(vector.visualModel.PrimaryPart, 9553467792, {
		Looped = true,
		RollOffMinDistance = 64,
		RollOffMaxDistance = 512,
		Volume = 0,
		DoNotPlay = true
	})
	vector.maid:GiveTask(vector.jetWindSound)
	local var4 = false
	local function action(p12, p2)
		if p2 then
			local vector = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			local Position = vector.Position
			if not var4 then
				var4 = true
				local instance2 = Confirmation.new(("Fly across the map for $%s?"):format(TransportJetConsts.LAUNCH_COST_CASH))
				instance2.Maid:GiveTask(instance2.OnYes:Connect(function()
					self:FindFirstChild(TransportJetConsts.REQUEST_LAUNCH_REMOTE_NAME):FireServer()
				end))
				instance2.Maid:GiveTask(function()
					var4 = false
				end)
				instance2.Maid:GiveTask(Interval.every(1):Connect(function()
					if (Position - vector.Position).Magnitude > 16 then
						instance2:Destroy()
					end
				end))
				return true
			end
		end
	end
	local RequestLaunch = var3:FindFirstChild("RequestLaunch")
	local t2 = {
		Part = RequestLaunch,
		ValidRoot = var3,
		Name = "Launch",
		Timed = false,
		Dist = 7,
		Callback = action
	}
	vector.maid:GiveTask(CircleAction.Add(t2, RequestLaunch))
	local function updateDoorOpen()
		local var12 = vector:GetDoorOpen()
		vector:SetDoorOpen(var12)
		t2.Enabled = var12
	end
	local var5 = vector:GetDoorOpen()
	vector:SetDoorOpen(var5)
	t2.Enabled = var5
	vector.maid:GiveTask(self:GetAttributeChangedSignal(TransportJetConsts.DOOR_OPEN_ATTR_NAME):Connect(updateDoorOpen))
	vector.maid:GiveTask(Interval.every(0.5):Connect(function()
		if vector:_isLocalStanding() then
			vector.shouldMovePlayer = true
		else
			vector.shouldMovePlayer = false
		end
	end))
	vector.lastCF = nil
	vector.realRoll = 0
	vector.maid:GiveTask(RxInstanceUtils.observeAttribute(self, TransportJetConsts.LAUNCHED_AT_ATTR_NAME, function()
		vector:_update()
	end))
	vector.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(self, TransportJetConsts.PATH_POINTS_OBJ_NAME, function(self, p2)
		if self then
			p2:GiveTask(self.Changed:Connect(function()
				vector:_update()
			end))
		end
		vector:_update()
	end))
	return vector
end
function t._isLocalStanding(self)
	local vector = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
	local instance2 = RaycastParams.new()
	instance2.FilterType = Enum.RaycastFilterType.Whitelist
	instance2.FilterDescendantsInstances = self.visualModel:FindFirstChild("TransportFloors"):GetChildren()
	if vector then
		return workspace:Raycast(vector.Position, Vector3.new(0, -20, 0), instance2) ~= nil
	else
		return false
	end
end
function t._update(self)
	local var12 = Maid.new()
	self.maid.runningMaid = var12
	local instance2 = self.obj:GetAttribute(TransportJetConsts.LAUNCHED_AT_ATTR_NAME)
	local var3 = self.obj:FindFirstChild(TransportJetConsts.PATH_POINTS_OBJ_NAME)
	if var3 then
		local var4 = var3.Value
		if var4 then
			local var5 = var4:GetAttribute(TransportJetConsts.NODE_OFFSET_START_ATTR_NAME) or 0
			local var6 = var4:GetAttribute(TransportJetConsts.NODE_OFFSET_END_ATTR_NAME) or 0
			local instance7 = BezierPath.new()
			local t = {}
			for i = 1, #var4:GetChildren() do
				local v8
				local var9 = var4:FindFirstChild(i)
				v8 = var9 ~= nil
				assert(v8, "missing point")
				table.insert(t, var9.Position)
			end
			assert(#t > 0, "no points for transport jet")
			instance7:SetPoints(t)
			instance7:SetNodeOffset(var5, var6 + 1)
			local var11 = instance7:ApproximateLength(10000)
			local t2 = {}
			local RUNWAY_LENGTH = TransportJetConsts.RUNWAY_LENGTH
			local TOP_SPEED = TransportJetConsts.TOP_SPEED
			table.insert(t2, {
				timeUntil = 10000000000,
				speedStart = 0,
				speedEnd = TOP_SPEED
			})
			assert(GraphUtils.constrainLastTimeToReachTarget(t2, RUNWAY_LENGTH), "cannot constrain last time to reach target")
			table.insert(t2, {
				timeUntil = 10000000000,
				speedStart = TOP_SPEED,
				speedEnd = TOP_SPEED
			})
			assert(GraphUtils.constrainLastTimeToReachTarget(t2, var11 - RUNWAY_LENGTH), "cannot constrain last time to reach target")
			table.insert(t2, {
				timeUntil = 10000000000,
				speedStart = TOP_SPEED,
				speedEnd = 0
			})
			assert(GraphUtils.constrainLastTimeToReachTarget(t2, var11), "cannot constrain last time to reach target")
			GraphUtils.cap(t2)
			local timeUntil = t2[#t2 - 1].timeUntil
			local var15 = nil
			local var16 = os.clock()
			local function setFlightElapsed(p12)
				local var12 = os.clock()
				local instance2, var3 = instance7:GetWorldPositionAt((GraphUtils.calculateDist(t2, p12)))
				local var4 = timeUntil - p12
				if var15 then
					local var5 = (instance2 - var15).Magnitude / (var12 - var16)
					self.jetEngineSound.Volume = math.clamp(var5 / 100, 0, 1) * 0.8
					self.jetEngineSound.PlaybackSpeed = math.clamp(var5 / 100, 0, 1) * 0.2 + 0.8
					self.jetWindSound.Volume = math.clamp(var5 / 25, 0, 1) * 1
				end
				var16 = var12
				var15 = instance2
				local var11 = self:StepRoll(if var4 < 1 then 0 else math.acos((self.visualModel.PrimaryPart.CFrame.LookVector:Dot(var3.Unit))) * 10, if var4 < 1 then 0.03 else 0.01)
				local cframe122 = CFrame.lookAt(vector, var3) * CFrame.Angles(0, 0, var11) + instance2
				if self.shouldMovePlayer then
					local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
					if localPlayer and self.lastCF then
						local var14 = cframe122 * self.lastCF:Inverse()
						localPlayer.CFrame = var14 * localPlayer.CFrame
						local cframe152 = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
						CurrentCamera.CFrame = CurrentCamera.CFrame * cframe152 * (var14 - var14.p) * cframe152:Inverse()
					end
				end
				self.lastCF = cframe122
				self.visualModel:PivotTo(cframe122)
			end
			local Door = self.visualModel:FindFirstChild("Door")
			local var17 = DoorUtils.getDuration(Door)
			local var18 = false
			local var19 = true
			var12:GiveTask((task.delay(var17 + timeUntil * 0.5, function()
				Audio.ObjectLocal(self.visualModel.PrimaryPart, 9553470967)
			end)))
			self.jetEngineSound.Volume = 0
			self.jetEngineSound:Play()
			self.jetWindSound.Volume = 0
			self.jetWindSound:Play()
			var12:GiveTask(function()
				self.jetEngineSound:Stop()
				self.jetWindSound:Stop()
			end)
			local var20 = os.clock() + (instance2 - workspace:GetServerTimeNow())
			var12:GiveTask(RunService.Heartbeat:Connect(function()
				local vector = os.clock() - var20
				local var3 = if var17 < vector then vector < var17 + timeUntil else false
				if var3 ~= var18 then
					var18 = var3
					for i, v in ipairs(self.visualModel:FindFirstChild("Turbines"):GetChildren()) do
						v:SetAttribute("SpinnerEnabled", var3)
						DoorUtils.getInnerModel(v):FindFirstChild("Turbine"):FindFirstChildWhichIsA("Attachment"):FindFirstChildWhichIsA("ParticleEmitter").Enabled = var3
					end
				end
				local var4 = if var17 + 2 < vector then vector < var17 + timeUntil - 2 else false
				if var4 ~= var19 then
					var19 = var4
					DoorUtils.setOpen(self.visualModel:FindFirstChild("FrontLandingGear"), var4)
					DoorUtils.setOpen(self.visualModel:FindFirstChild("RearLandingGear"), var4)
				end
				setFlightElapsed(if vector < var17 then 0 elseif var17 + timeUntil < vector then timeUntil else vector - var17)
				if var17 * 2 + timeUntil < vector then
					self:_stopRunning()
				end
			end))
		end
	end
end
function t._stopRunning(self)
	self.maid.runningMaid = nil
end
function t.StepRoll(self, p2, p3)
	if p2 ~= p2 then
		p2 = 0
	end
	local vector = self.realRoll or 0
	local instance2 = vector + (p2 - vector) * p3
	self.realRoll = instance2
	return instance2
end
function t.SetDoorOpen(self, p2)
	local Door = self.visualModel:FindFirstChild("Door")
	DoorUtils.setOpen(Door, p2)
	Audio.ObjectLocal(Door.PrimaryPart, 4487204926)
end
function t.GetDoorOpen(self)
	return self.obj:GetAttribute(TransportJetConsts.DOOR_OPEN_ATTR_NAME) == true
end
return Binder.new(TransportJetConsts.TAG_NAME, t)
