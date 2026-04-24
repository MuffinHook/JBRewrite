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
local v1 = Vector3.new()
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local v3 = ReplicatedStorage.TransportJet.Res.TransportJet:Clone()
	v3.Parent = workspace
	v1.visualModel = v3
	v1.maid:GiveTask(v3)
	v1.jetEngineSound = Audio.ObjectLocal(v1.visualModel.PrimaryPart, 9553468279, {
		Looped = true,
		RollOffMinDistance = 32,
		RollOffMaxDistance = 512,
		Volume = 0,
		DoNotPlay = true
	})
	v1.maid:GiveTask(v1.jetEngineSound)
	v1.jetWindSound = Audio.ObjectLocal(v1.visualModel.PrimaryPart, 9553467792, {
		Looped = true,
		RollOffMinDistance = 64,
		RollOffMaxDistance = 512,
		Volume = 0,
		DoNotPlay = true
	})
	v1.maid:GiveTask(v1.jetWindSound)
	local v4 = false
	local function action(p12, p2)
		if p2 then
			local v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			local Position = v1.Position
			if not v4 then
				v4 = true
				local v2 = Confirmation.new(("Fly across the map for $%s?"):format(TransportJetConsts.LAUNCH_COST_CASH))
				v2.Maid:GiveTask(v2.OnYes:Connect(function()
					p1:FindFirstChild(TransportJetConsts.REQUEST_LAUNCH_REMOTE_NAME):FireServer()
				end))
				v2.Maid:GiveTask(function()
					v4 = false
				end)
				v2.Maid:GiveTask(Interval.every(1):Connect(function()
					if (Position - v1.Position).Magnitude > 16 then
						v2:Destroy()
					end
				end))
				return true
			end
		end
	end
	local RequestLaunch = v3:FindFirstChild("RequestLaunch")
	local t2 = {
		Part = RequestLaunch,
		ValidRoot = v3,
		Name = "Launch",
		Timed = false,
		Dist = 7,
		Callback = action
	}
	v1.maid:GiveTask(CircleAction.Add(t2, RequestLaunch))
	local function updateDoorOpen()
		local v12 = v1:GetDoorOpen()
		v1:SetDoorOpen(v12)
		t2.Enabled = v12
	end
	local v5 = v1:GetDoorOpen()
	v1:SetDoorOpen(v5)
	t2.Enabled = v5
	v1.maid:GiveTask(p1:GetAttributeChangedSignal(TransportJetConsts.DOOR_OPEN_ATTR_NAME):Connect(updateDoorOpen))
	v1.maid:GiveTask(Interval.every(0.5):Connect(function()
		if v1:_isLocalStanding() then
			v1.shouldMovePlayer = true
		else
			v1.shouldMovePlayer = false
		end
	end))
	v1.lastCF = nil
	v1.realRoll = 0
	v1.maid:GiveTask(RxInstanceUtils.observeAttribute(p1, TransportJetConsts.LAUNCHED_AT_ATTR_NAME, function()
		v1:_update()
	end))
	v1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, TransportJetConsts.PATH_POINTS_OBJ_NAME, function(p1, p2)
		if p1 then
			p2:GiveTask(p1.Changed:Connect(function()
				v1:_update()
			end))
		end
		v1:_update()
	end))
	return v1
end
function t._isLocalStanding(p1)
	local v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
	local v2 = RaycastParams.new()
	v2.FilterType = Enum.RaycastFilterType.Whitelist
	v2.FilterDescendantsInstances = p1.visualModel:FindFirstChild("TransportFloors"):GetChildren()
	if v1 then
		return workspace:Raycast(v1.Position, Vector3.new(0, -20, 0), v2) ~= nil
	else
		return false
	end
end
function t._update(p1)
	local v12 = Maid.new()
	p1.maid.runningMaid = v12
	local v2 = p1.obj:GetAttribute(TransportJetConsts.LAUNCHED_AT_ATTR_NAME)
	local v3 = p1.obj:FindFirstChild(TransportJetConsts.PATH_POINTS_OBJ_NAME)
	if v3 then
		local v4 = v3.Value
		if v4 then
			local v5 = v4:GetAttribute(TransportJetConsts.NODE_OFFSET_START_ATTR_NAME) or 0
			local v6 = v4:GetAttribute(TransportJetConsts.NODE_OFFSET_END_ATTR_NAME) or 0
			local v7 = BezierPath.new()
			local t = {}
			for i = 1, #v4:GetChildren() do
				local v8
				local v9 = v4:FindFirstChild(i)
				v8 = v9 ~= nil
				assert(v8, "missing point")
				table.insert(t, v9.Position)
			end
			assert(#t > 0, "no points for transport jet")
			v7:SetPoints(t)
			v7:SetNodeOffset(v5, v6 + 1)
			local v11 = v7:ApproximateLength(10000)
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
			assert(GraphUtils.constrainLastTimeToReachTarget(t2, v11 - RUNWAY_LENGTH), "cannot constrain last time to reach target")
			table.insert(t2, {
				timeUntil = 10000000000,
				speedStart = TOP_SPEED,
				speedEnd = 0
			})
			assert(GraphUtils.constrainLastTimeToReachTarget(t2, v11), "cannot constrain last time to reach target")
			GraphUtils.cap(t2)
			local timeUntil = t2[#t2 - 1].timeUntil
			local v15 = nil
			local v16 = os.clock()
			local function setFlightElapsed(p12)
				local v12 = os.clock()
				local v2, v3 = v7:GetWorldPositionAt((GraphUtils.calculateDist(t2, p12)))
				local v4 = timeUntil - p12
				if v15 then
					local v5 = (v2 - v15).Magnitude / (v12 - v16)
					p1.jetEngineSound.Volume = math.clamp(v5 / 100, 0, 1) * 0.8
					p1.jetEngineSound.PlaybackSpeed = math.clamp(v5 / 100, 0, 1) * 0.2 + 0.8
					p1.jetWindSound.Volume = math.clamp(v5 / 25, 0, 1) * 1
				end
				v16 = v12
				v15 = v2
				local v11 = p1:StepRoll(if v4 < 1 then 0 else math.acos((p1.visualModel.PrimaryPart.CFrame.LookVector:Dot(v3.Unit))) * 10, if v4 < 1 then 0.03 else 0.01)
				local v122 = CFrame.lookAt(v1, v3) * CFrame.Angles(0, 0, v11) + v2
				if p1.shouldMovePlayer then
					local v13 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
					if v13 and p1.lastCF then
						local v14 = v122 * p1.lastCF:Inverse()
						v13.CFrame = v14 * v13.CFrame
						local v152 = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
						CurrentCamera.CFrame = CurrentCamera.CFrame * v152 * (v14 - v14.p) * v152:Inverse()
					end
				end
				p1.lastCF = v122
				p1.visualModel:PivotTo(v122)
			end
			local Door = p1.visualModel:FindFirstChild("Door")
			local v17 = DoorUtils.getDuration(Door)
			local v18 = false
			local v19 = true
			v12:GiveTask((task.delay(v17 + timeUntil * 0.5, function()
				Audio.ObjectLocal(p1.visualModel.PrimaryPart, 9553470967)
			end)))
			p1.jetEngineSound.Volume = 0
			p1.jetEngineSound:Play()
			p1.jetWindSound.Volume = 0
			p1.jetWindSound:Play()
			v12:GiveTask(function()
				p1.jetEngineSound:Stop()
				p1.jetWindSound:Stop()
			end)
			local v20 = os.clock() + (v2 - workspace:GetServerTimeNow())
			v12:GiveTask(RunService.Heartbeat:Connect(function()
				local v1 = os.clock() - v20
				local v3 = if v17 < v1 then v1 < v17 + timeUntil else false
				if v3 ~= v18 then
					v18 = v3
					for i, v in ipairs(p1.visualModel:FindFirstChild("Turbines"):GetChildren()) do
						v:SetAttribute("SpinnerEnabled", v3)
						DoorUtils.getInnerModel(v):FindFirstChild("Turbine"):FindFirstChildWhichIsA("Attachment"):FindFirstChildWhichIsA("ParticleEmitter").Enabled = v3
					end
				end
				local v4 = if v17 + 2 < v1 then v1 < v17 + timeUntil - 2 else false
				if v4 ~= v19 then
					v19 = v4
					DoorUtils.setOpen(p1.visualModel:FindFirstChild("FrontLandingGear"), v4)
					DoorUtils.setOpen(p1.visualModel:FindFirstChild("RearLandingGear"), v4)
				end
				setFlightElapsed(if v1 < v17 then 0 elseif v17 + timeUntil < v1 then timeUntil else v1 - v17)
				if v17 * 2 + timeUntil < v1 then
					p1:_stopRunning()
				end
			end))
		end
	end
end
function t._stopRunning(p1)
	p1.maid.runningMaid = nil
end
function t.StepRoll(p1, p2, p3)
	if p2 ~= p2 then
		p2 = 0
	end
	local v1 = p1.realRoll or 0
	local v2 = v1 + (p2 - v1) * p3
	p1.realRoll = v2
	return v2
end
function t.SetDoorOpen(p1, p2)
	local Door = p1.visualModel:FindFirstChild("Door")
	DoorUtils.setOpen(Door, p2)
	Audio.ObjectLocal(Door.PrimaryPart, 4487204926)
end
function t.GetDoorOpen(p1)
	return p1.obj:GetAttribute(TransportJetConsts.DOOR_OPEN_ATTR_NAME) == true
end
return Binder.new(TransportJetConsts.TAG_NAME, t)
