-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Promise = require(ReplicatedStorage.Std.Promise)
local CamShaker = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local CameraShakeInstance = require(ReplicatedStorage.Game.CamShaker.CameraShakeInstance)
local ProximityCamShakeConsts = require(script.Parent.ProximityCamShakeConsts)
local randomGenerator = Random.new()
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
local ProximityCamShakeClass = {}
ProximityCamShakeClass.__index = ProximityCamShakeClass
local function makeCamShakeInst()
	local cameraShakeInstance = CameraShakeInstance.new(2, 6, 1, 1)
	cameraShakeInstance.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
	cameraShakeInstance.RotationInfluence = Vector3.new(1, 1, 1)
	return cameraShakeInstance
end
function ProximityCamShakeClass.new(targetObject)
	local instance = {}
	setmetatable(instance, ProximityCamShakeClass)
	instance._maid = Maid.new()
	if not targetObject:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
		targetObject:SetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME, false)
	end
	if not targetObject:GetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME) then
		targetObject:SetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME, 32)
	end
	if not targetObject:GetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME) then
		targetObject:SetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME, 1)
	end
	local function updateEnabled()
		if targetObject:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
			instance:Listen(targetObject)
		else
			instance._maid._listenLoop = nil
		end
	end
	instance._maid:GiveTask(targetObject:GetAttributeChangedSignal(ProximityCamShakeConsts.ENABLED_ATTR_NAME):Connect(updateEnabled))
	if targetObject:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
		instance:Listen(targetObject)
	else
		instance._maid._listenLoop = nil
	end
	return instance
end
function ProximityCamShakeClass.Listen(self, targetObject)
	self._maid._listenLoop = Interval.every(0.5):Connect(function()
		local rootPart = PlayerUtils.getRootPart(LocalPlayer)
		if rootPart and ((rootPart.Position - targetObject.Position).Magnitude / targetObject:GetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME) <= 1 and not self._maid._camUpdater) then
			self:StartUpdater(targetObject)
		end
	end)
end
function ProximityCamShakeClass.StartUpdater(self, targetObject)
	local renderPriority = Enum.RenderPriority.Camera.Value + 5
	local v2 = CurrentCamera.CFrame
	local camShaker = CamShaker.new(renderPriority, function(p1)
		v2 = CurrentCamera.CFrame
		CurrentCamera.CFrame = CurrentCamera.CFrame * p1
	end)
	local v4 = RunService.Heartbeat:Connect(function()
		CurrentCamera.CFrame = v2
	end)
	camShaker._renderName = "ProximityCamShake_" .. tostring((randomGenerator:NextInteger(1, 1000000000)))
	camShaker:Start()
	local shakeInstance = CameraShakeInstance.new(2, 6, 1, 1)
	shakeInstance.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
	shakeInstance.RotationInfluence = Vector3.new(1, 1, 1)
	local shakeSustain = camShaker:ShakeSustain(shakeInstance)
	self._maid._camUpdater = RunService.Heartbeat:Connect(function()
		local v2 = (CurrentCamera.CFrame.Position - targetObject.Position).Magnitude / targetObject:GetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME)
		if v2 > 1 or not targetObject:GetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME) then
			self._maid._stop = nil
		else
			local v3 = 1 - v2
			local v4, v5
			if v3 < 0.5 then
				v4 = 2 * v3 * v3
				if not v4 then
					v5 = v3
					v4 = -1 - 2 * (v3 - 2) * v3
				end
			else
				v5 = v3
				v4 = -1 - 2 * (v3 - 2) * v3
			end
			shakeSustain:SetScaleMagnitude(v4 * targetObject:GetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME))
		end
	end)
	function self._maid._stop()
		shakeSustain:StartFadeOut(1)
		Promise.delay(1):andThen(function()
			camShaker:Stop()
			v4:Disconnect()
		end):catch(warn)
		if self._maid then
			self._maid._camUpdater = nil
		end
	end
end
function ProximityCamShakeClass.Destroy(self)
	local _maid = self._maid
	self._maid = nil
	_maid:Destroy()
end
return ProximityCamShakeClass
