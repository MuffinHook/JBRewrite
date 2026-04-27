local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Audio)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local Roact = require(ReplicatedStorage.Roact)
local Interval = require(ReplicatedStorage.Std.Interval)
local createElement = Roact.createElement
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local BriefcaseConsts = require(ReplicatedStorage.AirDrop.BriefcaseConsts)
local BriefcaseUtils = require(ReplicatedStorage.AirDrop.BriefcaseUtils)
local BriefcaseDisplay = require(ReplicatedStorage.AirDrop.UI.BriefcaseDisplay)
local AirDropUtils = require(ReplicatedStorage.AirDrop.AirDropUtils)
local decalTextureIds = { 9238451278, 9238451797, 9238452703, 9238452956, 9238453431, 9238453749 }
local BriefcaseBinder = {}
BriefcaseBinder.__index = BriefcaseBinder
setmetatable(BriefcaseBinder, BaseObject)
function BriefcaseBinder.new(briefcaseModel)
	local self = BaseObject.new(briefcaseModel)
	setmetatable(self, BriefcaseBinder)
	self.maid:GiveTask(RxInstanceUtils.observeAttribute(briefcaseModel, BriefcaseConsts.BORN_AT_ATTR_NAME, function(bornAtTime, oldBornAtTime)
		if bornAtTime then
			self.maid.updatePositionThread = RunService.Heartbeat:Connect(function()
				self:_update(bornAtTime)
			end)
		end
	end))
	local function onActionPressed(character, isHeldDown)
		self:_pressed(character, isHeldDown)
		if isHeldDown then
			return self:_collect()
		end
	end
	local function onActionReleased(character, isHeldDown)
		self:_released(character, isHeldDown)
	end
	local function updateDecalsWhilePressing(pressProgress)
		local decalIndex = math.ceil(pressProgress * #decalTextureIds)
		for index, decal in ipairs(briefcaseModel:FindFirstChild("Walls"):GetDescendants()) do
			if decal:IsA("Decal") then
				if decalTextureIds[decalIndex] then
					decal.Texture = ("rbxassetid://%d"):format(decalTextureIds[decalIndex])
				else
					decal.Texture = ""
				end
			end
		end
	end
	local function getCurrentPressAccumulation()
		return self.obj:GetAttribute(BriefcaseConsts.BRIEFCASE_PRESS_DURATION_ACCUMULATION_ATTRIBUTE_NAME)
	end
	local openDuration = BriefcaseUtils.getOpenDuration(self.obj)
	assert(openDuration, "No opening duration for this briefcase")
	local circleActionConfig = {
		Name = "Open Crate",
		Timed = true,
		Duration = openDuration,
		Dist = 10,
		Callback = onActionPressed,
		ReleaseCallback = onActionReleased,
		GetAccumulation = getCurrentPressAccumulation,
		WhilePressedUpdate = updateDecalsWhilePressing
	}
	local function onCollectedChanged()
		if self:GetCollected() then
			circleActionConfig.Enabled = false
			briefcaseModel:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = true
			briefcaseModel:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = true
			local function onFinished()
				briefcaseModel:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = false
				briefcaseModel:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = false
			end
			local startTime = os.clock()
			local fadeConnection = nil
			fadeConnection = RunService.Heartbeat:Connect(function()
				local elapsedTime = os.clock() - startTime
				if elapsedTime > 0.4 then
					elapsedTime = 0.4
					fadeConnection:Disconnect()
					fadeConnection = nil
					briefcaseModel:FindFirstChild("Particles"):FindFirstChild("Dust").Enabled = false
					briefcaseModel:FindFirstChild("Particles"):FindFirstChild("Planks").Enabled = false
				end
				briefcaseModel:FindFirstChild("Particles").Transparency = elapsedTime / 0.4
			end)
		end
	end
	onCollectedChanged()
	self.maid:GiveTask(self:GetCollectedChangedSignal():Connect(onCollectedChanged))
	local function onLandedChanged()
		if self:GetLanded() then
			self.maid.updatePositionThread = nil
			circleActionConfig.Part = self.obj.PrimaryPart
			circleActionConfig.ValidRoot = self.obj
			self.maid:GiveTask(CircleAction.Add(circleActionConfig, self.obj))
			self:_update(briefcaseModel:GetAttribute(BriefcaseConsts.BORN_AT_ATTR_NAME))
			self.maid:GiveTask(RunService.Heartbeat:Connect(function()
				local canOpenBriefcase = not AirDropUtils.getPlayerIsInAmbulanceStretcher(Players.LocalPlayer)
				if circleActionConfig.Enabled ~= canOpenBriefcase then
					circleActionConfig.Enabled = canOpenBriefcase
				end
			end))
			local chaute = briefcaseModel:FindFirstChild("Chute")
			local chatuteStartTime = os.clock()
			local chatuteConnection = nil
			chatuteConnection = RunService.Heartbeat:Connect(function()
				local chatuteElapsedTime = os.clock() - chatuteStartTime
				if chatuteElapsedTime > 1 then
					chatuteElapsedTime = 1
					chatuteConnection:Disconnect()
					chatuteConnection = nil
				end
				local chatuteProgress = chatuteElapsedTime / 1
				if not chaute then
					chaute = briefcaseModel:FindFirstChild("Chute")
				end
				if chaute then
					chaute.Transparency = chatuteProgress * 0.75
				end
			end)
		end
	end
	onLandedChanged()
	self.maid:GiveTask(self:GetLandedChangedSignal():Connect(onLandedChanged))
	self.maid:GivePromise(Promise.all({
		RxInstanceUtils.waitForChild(briefcaseModel, "RarityProbsDisplay"),
		RxInstanceUtils.waitForChild(briefcaseModel, BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME),
		RxInstanceUtils.waitForChild(briefcaseModel, BriefcaseConsts.RELEASE_REMOTE_NAME),
		RxInstanceUtils.waitForChild(briefcaseModel, BriefcaseConsts.HOLD_UPDATE_REMOTE_NAME)
	}):andThen(function(results)
		local holdUpdateRemote = results[4]
		local guiHandle = Roact.mount(createElement("SurfaceGui", {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			ResetOnSpawn = false,
			PixelsPerStud = 16,
			Adornee = results[1],
			Face = Enum.NormalId.Front
		}, {
			Display = createElement(BriefcaseDisplay, {
				probsFolder = results[2]
			})
		}), Players.LocalPlayer.PlayerGui, "BriefcaseGui")
		self.maid:GiveTask(function()
			Roact.unmount(guiHandle)
		end)
		self.maid:GiveTask(results[3].OnClientEvent:Connect(function()
			if circleActionConfig.Pressed then
				circleActionConfig.ForceRelease = true
			end
		end))
		self.maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
			if circleActionConfig.Pressed then
				holdUpdateRemote:FireServer()
			end
		end))
	end))
	return self
end
function BriefcaseBinder._collect(self)
	self.obj:FindFirstChild(BriefcaseConsts.COLLECT_REMOTE_NAME):FireServer()
	return true
end
function BriefcaseBinder._pressed(self, character, extraParam)
	self.obj:FindFirstChild(BriefcaseConsts.PRESS_REMOTE_NAME):FireServer(extraParam)
	return true
end
function BriefcaseBinder._released(self, character, extraParam)
	self.obj:FindFirstChild(BriefcaseConsts.RELEASE_REMOTE_NAME):FireServer(extraParam)
	return true
end
function BriefcaseBinder._update(self, bornAtTime)
	local elapsedTime = workspace:GetServerTimeNow() - bornAtTime
	local duration = self:GetDuration()
	if duration < elapsedTime then
		elapsedTime = duration
	end
	if self.obj.PrimaryPart then
		local targetCFrame = self:GetCFrameAt(elapsedTime)
		self.obj:PivotTo(targetCFrame * CFrame.new(0, self.obj.PrimaryPart.Size.Y * 0.5, 0))
	end
end
function BriefcaseBinder.SetOrigin(self, origin)
	return BriefcaseUtils.setOrigin(self.obj, origin)
end
function BriefcaseBinder.GetOrigin(self)
	return BriefcaseUtils.getOrigin(self.obj)
end
function BriefcaseBinder.SetTarget(self, target)
	return BriefcaseUtils.setTarget(self.obj, target)
end
function BriefcaseBinder.GetTarget(self)
	return BriefcaseUtils.getTarget(self.obj)
end
function BriefcaseBinder.SetTargetNormal(self, targetNormal)
	return BriefcaseUtils.setTargetNormal(self.obj, targetNormal)
end
function BriefcaseBinder.GetTargetNormal(self)
	return BriefcaseUtils.getTargetNormal(self.obj)
end
function BriefcaseBinder.SetSpeed(self, speed)
	return BriefcaseUtils.setSpeed(self.obj, speed)
end
function BriefcaseBinder.GetSpeed(self)
	return BriefcaseUtils.getSpeed(self.obj)
end
function BriefcaseBinder.SetBornAt(self, bornAt)
	return BriefcaseUtils.setBornAt(self.obj, bornAt)
end
function BriefcaseBinder.GetBornAt(self)
	return BriefcaseUtils.getBornAt(self.obj)
end
function BriefcaseBinder.SetLanded(self, landed)
	return BriefcaseUtils.setLanded(self.obj, landed)
end
function BriefcaseBinder.GetLanded(self)
	return BriefcaseUtils.getLanded(self.obj)
end
function BriefcaseBinder.GetLandedChangedSignal(self)
	return BriefcaseUtils.getLandedChangedSignal(self.obj)
end
function BriefcaseBinder.SetLandedTime(self, landedTime)
	return BriefcaseUtils.setLandedTime(self.obj, landedTime)
end
function BriefcaseBinder.GetLandedTime(self)
	return BriefcaseUtils.getLandedTime(self.obj)
end
function BriefcaseBinder.SetRarityProbabilities(self, rarityProbabilities)
	return BriefcaseUtils.setRarityProbabilities(self.obj, rarityProbabilities)
end
function BriefcaseBinder.GetRarityProbabilities(self)
	return BriefcaseUtils.getRarityProbabilities(self.obj)
end
function BriefcaseBinder.GetCollected(self)
	return BriefcaseUtils.getCollected(self.obj)
end
function BriefcaseBinder.SetCollected(self, collected)
	return BriefcaseUtils.setCollected(self.obj, collected)
end
function BriefcaseBinder.GetCollectedChangedSignal(self)
	return BriefcaseUtils.getCollectedChangedSignal(self.obj)
end
function BriefcaseBinder.GetDuration(self)
	local origin = self:GetOrigin()
	local target = self:GetTarget()
	local speed = self:GetSpeed()
	assert(speed > 0, "speed must be > 0")
	return (target - origin).Magnitude / speed
end
function BriefcaseBinder.GetPositionAt(self, elapsedTime)
	local origin = self:GetOrigin()
	if origin then
		local target = self:GetTarget()
		if target then
			return BriefcaseUtils.getPositionAt(elapsedTime, origin, target, (self:GetDuration()))
		end
	end
end
function BriefcaseBinder.GetCFrameAt(self, elapsedTime)
	local origin = self:GetOrigin()
	if origin then
		local target = self:GetTarget()
		if target then
			local targetNormal = self:GetTargetNormal()
			if targetNormal then
				return BriefcaseUtils.getCFrameAt(elapsedTime, origin, target, targetNormal, (self:GetDuration()))
			end
		end
	end
end
return Binder.new(BriefcaseConsts.TAG_NAME, BriefcaseBinder)
