local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local Radio = require(ReplicatedStorage.Game.Radio.Radio)
local RadioPlayer = require(ReplicatedStorage.Game.Radio.RadioPlayer)
local HomeItemSystem = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local HomeSystem = require(ReplicatedStorage.Home.HomeSystem)
local Time = require(ReplicatedStorage.Module.Time)
local RadioConsts = require(script.RadioConsts)
local VipRadioClass = {}
VipRadioClass.__index = VipRadioClass
function VipRadioClass.new(self)
	local vipRadioItem = {}
	setmetatable(vipRadioItem, VipRadioClass)
	local _obj = self._obj
	vipRadioItem._obj = _obj
	vipRadioItem._maid = Maid.new()
	local radioMaid = Maid.new()
	local function action(self, shouldOpen)
		if shouldOpen then
			Radio.Open()
			radioMaid.listenOnClose = Radio.Window:GetOnClosedSignal():Connect(function()
				radioMaid:Destroy()
			end)
			radioMaid.listenOnSongStarted = RadioPlayer.OnSongStarted:Connect(function(self)
				_obj:FindFirstChild(RadioConsts.PLAY_REMOTE_NAME):FireServer(self)
			end)
			self.Enabled = false
			return true
		else
			return false
		end
	end
	local function preUpdateFun(homeObject)
		local enableState = not Radio.IsOpen() and not HomeItemSystem.isCustomizing()
		local currentHome = HomeSystem.queryCurrentStandingHome()
		if not currentHome then
			enableState = false
		end
		local playerHome = self:GetHome()
		if playerHome == currentHome then
			if not playerHome:HasPermissionToEdit(LocalPlayer) then
				enableState = false
			end
		else
			enableState = false
		end
		homeObject.Enabled = enableState
	end
	vipRadioItem._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(_obj, "Radio", function(self, maidCleanup)
		CircleAction.Add({
			Part = self,
			Name = "Open Radio",
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.1
		}, self)
		maidCleanup:GiveTask(function()
			CircleAction.Remove(self)
		end)
	end))
	local smoothedLoudness = 0
	local loudnessDerivative = 0
	local function updateCameraFov()
		if RadioPlayer.CurrentSound then
			local PlaybackLoudness = RadioPlayer.CurrentSound.PlaybackLoudness
			if PlaybackLoudness ~= PlaybackLoudness then
				PlaybackLoudness = 0
			end
			if loudnessDerivative ~= loudnessDerivative then
				loudnessDerivative = 0
			end
			if smoothedLoudness ~= smoothedLoudness then
				smoothedLoudness = 0
			end
			if loudnessDerivative > 999 then
				loudnessDerivative = 0
			end
			if smoothedLoudness > 999 then
				smoothedLoudness = 0
			end
			if loudnessDerivative < -999 then
				loudnessDerivative = 0
			end
			if smoothedLoudness < -999 then
				smoothedLoudness = 0
			end
			smoothedLoudness = smoothedLoudness * 0.86 + PlaybackLoudness * 0.14
			loudnessDerivative = loudnessDerivative * 0.97 + math.tanh((PlaybackLoudness - smoothedLoudness) / 150) * 0.030000000000000027
			local fovModifier = loudnessDerivative
			if fovModifier < -1 then
				fovModifier = -1
			end
			if fovModifier > 1 then
				fovModifier = 1
			end
			if fovModifier ~= fovModifier then
				fovModifier = 0
			end
			CurrentCamera.FieldOfView = fovModifier * 10 + 70
		end
	end
	local function playId(songId)
		local elapsedTime = Time.GetNowSync() - vipRadioItem:GetStartedAt()
		RadioPlayer.PlayRandomSongAfter = false
		RadioPlayer.PlayId(songId, elapsedTime, false)
		vipRadioItem._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
	end
	vipRadioItem._maid:GiveTask(vipRadioItem._obj:GetAttributeChangedSignal(RadioConsts.SONG_ID_ATTR_NAME):Connect(function()
		if HomeSystem.queryCurrentStandingHome() == self:GetHome() then
			local songId = vipRadioItem:GetSongId()
			if songId then
				local elapsedTime = Time.GetNowSync() - vipRadioItem:GetStartedAt()
				RadioPlayer.PlayRandomSongAfter = false
				RadioPlayer.PlayId(songId, elapsedTime, false)
				vipRadioItem._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
				return
			end
			RadioPlayer.Stop()
			vipRadioItem._maid.updateFov = nil
		end
	end))
	vipRadioItem._maid:GiveTask(HomeSystem.onEntered:Connect(function(homeObject)
		if self:GetHome() == homeObject then
			local songId = vipRadioItem:GetSongId()
			if songId then
				local elapsedTime = Time.GetNowSync() - vipRadioItem:GetStartedAt()
				RadioPlayer.PlayRandomSongAfter = false
				RadioPlayer.PlayId(songId, elapsedTime, false)
				vipRadioItem._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
			end
		end
	end))
	vipRadioItem._maid:GiveTask(HomeSystem.onExited:Connect(function(homeObject)
		if self:GetHome() == homeObject then
			local songId = vipRadioItem:GetSongId()
			if songId and RadioPlayer.CurrentSoundId == songId then
				RadioPlayer.Stop()
				vipRadioItem._maid.updateFov = nil
			end
		end
	end))
	return vipRadioItem
end
function VipRadioClass.GetSongId(self)
	return self._obj:GetAttribute(RadioConsts.SONG_ID_ATTR_NAME)
end
function VipRadioClass.GetStartedAt(self)
	return self._obj:GetAttribute(RadioConsts.STARTED_AT_ATTR_NAME)
end
function VipRadioClass.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return {
	setup = function(self)
		local vipRadioItem = VipRadioClass.new(self)
		self._maid:GiveTask(vipRadioItem)
		self._radio = vipRadioItem
	end
}
