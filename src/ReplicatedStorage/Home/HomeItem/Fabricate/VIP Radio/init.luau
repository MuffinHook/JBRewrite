-- Reviewed by Claude
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
local t = {}
t.__index = t
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	local _obj = self._obj
	t2._obj = _obj
	t2._maid = Maid.new()
	local instance2 = Maid.new()
	local function action(self, p2)
		if p2 then
			Radio.Open()
			instance2.listenOnClose = Radio.Window:GetOnClosedSignal():Connect(function()
				instance2:Destroy()
			end)
			instance2.listenOnSongStarted = RadioPlayer.OnSongStarted:Connect(function(self)
				_obj:FindFirstChild(RadioConsts.PLAY_REMOTE_NAME):FireServer(self)
			end)
			self.Enabled = false
			return true
		else
			return false
		end
	end
	local function preUpdateFun(p12)
		local instance = not Radio.IsOpen() and not HomeItemSystem.isCustomizing()
		local instance2 = HomeSystem.queryCurrentStandingHome()
		if not instance2 then
			instance = false
		end
		local var3 = self:GetHome()
		if var3 == instance2 then
			if not var3:HasPermissionToEdit(LocalPlayer) then
				instance = false
			end
		else
			instance = false
		end
		p12.Enabled = instance
	end
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(_obj, "Radio", function(self, p2)
		CircleAction.Add({
			Part = self,
			Name = "Open Radio",
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.1
		}, self)
		p2:GiveTask(function()
			CircleAction.Remove(self)
		end)
	end))
	local var3 = 0
	local var4 = 0
	local function updateCameraFov()
		if RadioPlayer.CurrentSound then
			local PlaybackLoudness = RadioPlayer.CurrentSound.PlaybackLoudness
			if PlaybackLoudness ~= PlaybackLoudness then
				PlaybackLoudness = 0
			end
			if var4 ~= var4 then
				var4 = 0
			end
			if var3 ~= var3 then
				var3 = 0
			end
			if var4 > 999 then
				var4 = 0
			end
			if var3 > 999 then
				var3 = 0
			end
			if var4 < -999 then
				var4 = 0
			end
			if var3 < -999 then
				var3 = 0
			end
			var3 = var3 * 0.86 + PlaybackLoudness * 0.14
			var4 = var4 * 0.97 + math.tanh((PlaybackLoudness - var3) / 150) * 0.030000000000000027
			local instance2 = var4
			if instance2 < -1 then
				instance2 = -1
			end
			if instance2 > 1 then
				instance2 = 1
			end
			if instance2 ~= instance2 then
				instance2 = 0
			end
			CurrentCamera.FieldOfView = instance2 * 10 + 70
		end
	end
	local function playId(self)
		local instance = Time.GetNowSync() - t2:GetStartedAt()
		RadioPlayer.PlayRandomSongAfter = false
		RadioPlayer.PlayId(self, instance, false)
		t2._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
	end
	t2._maid:GiveTask(t2._obj:GetAttributeChangedSignal(RadioConsts.SONG_ID_ATTR_NAME):Connect(function()
		if HomeSystem.queryCurrentStandingHome() == self:GetHome() then
			local instance = t2:GetSongId()
			if instance then
				local instance2 = Time.GetNowSync() - t2:GetStartedAt()
				RadioPlayer.PlayRandomSongAfter = false
				RadioPlayer.PlayId(instance, instance2, false)
				t2._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
				return
			end
			RadioPlayer.Stop()
			t2._maid.updateFov = nil
		end
	end))
	t2._maid:GiveTask(HomeSystem.onEntered:Connect(function(p12)
		if self:GetHome() == p12 then
			local instance = t2:GetSongId()
			if instance then
				local instance2 = Time.GetNowSync() - t2:GetStartedAt()
				RadioPlayer.PlayRandomSongAfter = false
				RadioPlayer.PlayId(instance, instance2, false)
				t2._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
			end
		end
	end))
	t2._maid:GiveTask(HomeSystem.onExited:Connect(function(p12)
		if self:GetHome() == p12 then
			local instance = t2:GetSongId()
			if instance and RadioPlayer.CurrentSoundId == instance then
				RadioPlayer.Stop()
				t2._maid.updateFov = nil
			end
		end
	end))
	return t2
end
function t.GetSongId(self)
	return self._obj:GetAttribute(RadioConsts.SONG_ID_ATTR_NAME)
end
function t.GetStartedAt(self)
	return self._obj:GetAttribute(RadioConsts.STARTED_AT_ATTR_NAME)
end
function t.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return {
	setup = function(self)
		local instance = t.new(self)
		self._maid:GiveTask(instance)
		self._radio = instance
	end
}
