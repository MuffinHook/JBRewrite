local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Anim = require(ReplicatedStorage.Module.Anim)
local CamShaker = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local Promise = require(ReplicatedStorage.Std.Promise)
local SmokeGrenadeConsts = require(script.Parent.SmokeGrenadeConsts)
local SmokeGrenade = {}
SmokeGrenade.__index = SmokeGrenade
SmokeGrenade.__ClassName = "SmokeGrenade"
function SmokeGrenade.new(grenadeObj)
	local instance = {}
	setmetatable(instance, SmokeGrenade)
	instance._maid = Maid.new()
	instance.maid = instance._maid
	instance._obj = grenadeObj
	instance.obj = instance._obj
	instance._thrownRemote = grenadeObj:WaitForChild(SmokeGrenadeConsts.THROWN_REMOTE_NAME)
	instance._thrownValue = grenadeObj:WaitForChild(SmokeGrenadeConsts.THROWN_VALUE_NAME)
	instance._maid:GiveTask(grenadeObj:WaitForChild(SmokeGrenadeConsts.EXPLODE_REMOTE_NAME).OnClientEvent:Connect(function()
		instance:_playExplosionFx()
	end))
	instance._creatorIdValue = grenadeObj:WaitForChild(SmokeGrenadeConsts.CREATOR_ID_VALUE_NAME)
	return instance
end
local whiteColor = Color3.new(255/255, 255/255, 255/255)
function SmokeGrenade._getJ(self, targetPosition)
	local distanceRatio = (self._obj.PrimaryPart.Position - targetPosition).Magnitude / SmokeGrenadeConsts.BLAST_RADIUS
	if distanceRatio < 0.001 then
		distanceRatio = 0
	end
	if distanceRatio > 0.999 then
		distanceRatio = 1
	end
	return 1 - distanceRatio
end
function SmokeGrenade._playExplosionFx(self)
	local FX_DURATION = SmokeGrenadeConsts.FX_DURATION
	local maidInstance = Maid.new()
	Promise.delay(FX_DURATION):andThenCall(maidInstance.Destroy, maidInstance)
	local playerHumanoid = PlayerUtils.getHumanoid(LocalPlayer)
	local playerRootPart = PlayerUtils.getRootPart(LocalPlayer)
	if (self._obj.PrimaryPart.Position - playerRootPart.Position).Magnitude < SmokeGrenadeConsts.BLAST_RADIUS then
		local cameraShaker = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(shakeCFrame)
			CurrentCamera.CFrame = CurrentCamera.CFrame * shakeCFrame
		end)
		cameraShaker:Start()
		cameraShaker:Shake(CamShaker.Presets.Explosion)
		Promise.delay(2):andThenCall(cameraShaker.Stop, cameraShaker)
		playerHumanoid.NameDisplayDistance = 0
		maidInstance:GiveTask(function()
			playerHumanoid.NameDisplayDistance = 100
		end)
	end
	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 0
	BlurEffect.Parent = Lighting
	maidInstance:GiveTask(BlurEffect)
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	ColorCorrectionEffect.TintColor = whiteColor
	ColorCorrectionEffect.Parent = Lighting
	maidInstance:GiveTask(ColorCorrectionEffect)
	local animationInitial = Anim.new(0.1)
	animationInitial.OnCompleted:Connect(function()
		animationInitial:Destroy()
	end)
	maidInstance:GiveTask(animationInitial)
	animationInitial.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local progressRatio = animationInitial:Update()
		local distanceRatio = self:_getJ(playerRootPart.Position)
		BlurEffect.Size = progressRatio * distanceRatio * SmokeGrenadeConsts.FX_BLUR_SIZE
		ColorCorrectionEffect.TintColor = whiteColor:lerp(SmokeGrenadeConsts.FX_COLOR, progressRatio * distanceRatio)
	end))
	animationInitial.Maid:GiveTask(function()
		maidInstance.distanceRuntime = RunService.Heartbeat:Connect(function()
			playerRootPart = PlayerUtils.getRootPart(LocalPlayer)
			local distanceRatio = self:_getJ(playerRootPart.Position)
			BlurEffect.Size = distanceRatio * SmokeGrenadeConsts.FX_BLUR_SIZE
			ColorCorrectionEffect.TintColor = whiteColor:lerp(SmokeGrenadeConsts.FX_COLOR, distanceRatio)
		end)
	end)
	Promise.delay(FX_DURATION - 0.1 - 1):andThen(function()
		maidInstance.distanceRuntime = nil
		local animationFadeOut = Anim.new(1)
		maidInstance:GiveTask(animationFadeOut)
		animationFadeOut.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			local progressRatio = animationFadeOut:Update()
			local distanceRatio = self:_getJ(playerRootPart.Position)
			BlurEffect.Size = (1 - progressRatio) * distanceRatio * SmokeGrenadeConsts.FX_BLUR_SIZE
			ColorCorrectionEffect.TintColor = whiteColor:lerp(SmokeGrenadeConsts.FX_COLOR, (1 - progressRatio) * distanceRatio)
		end))
	end)
	Promise.delay(FX_DURATION):andThen(function()
		maidInstance:Destroy()
		maidInstance = nil
	end)
end
function SmokeGrenade.SetThrown(self)
	self._thrownValue.Value = true
	self._thrownRemote:FireServer()
end
function SmokeGrenade.GetThrown(self)
	return self._thrownValue.Value
end
function SmokeGrenade.GetCreator(self)
	return Players:GetPlayerByUserId(self._creatorIdValue.Value)
end
function SmokeGrenade.SetVelocity(self, velocityVector)
	assert(velocityVector ~= nil)
	self._obj.PrimaryPart.Velocity = velocityVector
end
function SmokeGrenade.SetRotVelocity(self, rotationalVelocityVector)
	assert(rotationalVelocityVector ~= nil)
	self._obj.PrimaryPart.RotVelocity = rotationalVelocityVector
end
function SmokeGrenade.Destroy(self)
	assert(self._maid)
	local _maid_2 = self._maid
	self._maid = nil
	_maid_2:Destroy()
	setmetatable(self, nil)
end
return SmokeGrenade
