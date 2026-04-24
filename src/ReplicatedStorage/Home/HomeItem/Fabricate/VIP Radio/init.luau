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
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	local _obj = p1._obj
	t2._obj = _obj
	t2._maid = Maid.new()
	local v2 = Maid.new()
	local function action(p1, p2)
		if p2 then
			Radio.Open()
			v2.listenOnClose = Radio.Window:GetOnClosedSignal():Connect(function()
				v2:Destroy()
			end)
			v2.listenOnSongStarted = RadioPlayer.OnSongStarted:Connect(function(p1)
				_obj:FindFirstChild(RadioConsts.PLAY_REMOTE_NAME):FireServer(p1)
			end)
			p1.Enabled = false
			return true
		else
			return false
		end
	end
	local function preUpdateFun(p12)
		local v1 = not Radio.IsOpen() and not HomeItemSystem.isCustomizing()
		local v2 = HomeSystem.queryCurrentStandingHome()
		if not v2 then
			v1 = false
		end
		local v3 = p1:GetHome()
		if v3 == v2 then
			if not v3:HasPermissionToEdit(LocalPlayer) then
				v1 = false
			end
		else
			v1 = false
		end
		p12.Enabled = v1
	end
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(_obj, "Radio", function(p1, p2)
		CircleAction.Add({
			Part = p1,
			Name = "Open Radio",
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.1
		}, p1)
		p2:GiveTask(function()
			CircleAction.Remove(p1)
		end)
	end))
	local v3 = 0
	local v4 = 0
	local function updateCameraFov()
		if RadioPlayer.CurrentSound then
			local PlaybackLoudness = RadioPlayer.CurrentSound.PlaybackLoudness
			if PlaybackLoudness ~= PlaybackLoudness then
				PlaybackLoudness = 0
			end
			if v4 ~= v4 then
				v4 = 0
			end
			if v3 ~= v3 then
				v3 = 0
			end
			if v4 > 999 then
				v4 = 0
			end
			if v3 > 999 then
				v3 = 0
			end
			if v4 < -999 then
				v4 = 0
			end
			if v3 < -999 then
				v3 = 0
			end
			v3 = v3 * 0.86 + PlaybackLoudness * 0.14
			v4 = v4 * 0.97 + math.tanh((PlaybackLoudness - v3) / 150) * 0.030000000000000027
			local v2 = v4
			if v2 < -1 then
				v2 = -1
			end
			if v2 > 1 then
				v2 = 1
			end
			if v2 ~= v2 then
				v2 = 0
			end
			CurrentCamera.FieldOfView = v2 * 10 + 70
		end
	end
	local function playId(p1)
		local v1 = Time.GetNowSync() - t2:GetStartedAt()
		RadioPlayer.PlayRandomSongAfter = false
		RadioPlayer.PlayId(p1, v1, false)
		t2._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
	end
	t2._maid:GiveTask(t2._obj:GetAttributeChangedSignal(RadioConsts.SONG_ID_ATTR_NAME):Connect(function()
		if HomeSystem.queryCurrentStandingHome() == p1:GetHome() then
			local v1 = t2:GetSongId()
			if v1 then
				local v2 = Time.GetNowSync() - t2:GetStartedAt()
				RadioPlayer.PlayRandomSongAfter = false
				RadioPlayer.PlayId(v1, v2, false)
				t2._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
				return
			end
			RadioPlayer.Stop()
			t2._maid.updateFov = nil
		end
	end))
	t2._maid:GiveTask(HomeSystem.onEntered:Connect(function(p12)
		if p1:GetHome() == p12 then
			local v1 = t2:GetSongId()
			if v1 then
				local v2 = Time.GetNowSync() - t2:GetStartedAt()
				RadioPlayer.PlayRandomSongAfter = false
				RadioPlayer.PlayId(v1, v2, false)
				t2._maid.updateFov = RunService.Heartbeat:Connect(updateCameraFov)
			end
		end
	end))
	t2._maid:GiveTask(HomeSystem.onExited:Connect(function(p12)
		if p1:GetHome() == p12 then
			local v1 = t2:GetSongId()
			if v1 and RadioPlayer.CurrentSoundId == v1 then
				RadioPlayer.Stop()
				t2._maid.updateFov = nil
			end
		end
	end))
	return t2
end
function t.GetSongId(p1)
	return p1._obj:GetAttribute(RadioConsts.SONG_ID_ATTR_NAME)
end
function t.GetStartedAt(p1)
	return p1._obj:GetAttribute(RadioConsts.STARTED_AT_ATTR_NAME)
end
function t.Destroy(p1)
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return {
	setup = function(p1)
		local v1 = t.new(p1)
		p1._maid:GiveTask(v1)
		p1._radio = v1
	end
}
