-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Audio = require(ReplicatedStorage.Std.Audio)
local WorldMarkerSystem = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local WorldMarker = require(ReplicatedStorage.Game.WorldMarker.WorldMarker)
local WorldMarkerGroup = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerGroup)
local t = {
	_maid = nil,
	onCloseClicked = Signal.new()
}
function t.init()
	local ContextMessageGui = ReplicatedStorage.StarterGui:FindFirstChild("ContextMessageGui")
	ContextMessageGui.Parent = LocalPlayer.PlayerGui
	t.gui = ContextMessageGui
	local markerGroup = WorldMarkerGroup.new()
	markerGroup:SetEnabled(false)
	t._worldMarkerGroup = markerGroup
	local marker = WorldMarker.new()
	marker:SetScreenGui(WorldMarkerSystem.gui)
	marker:SetIcon(5920742944)
	marker.FrameInner.ImageColor3 = Color3.fromRGB(255, 203, 70)
	markerGroup:Add(marker)
	WorldMarkerSystem.addGroup(markerGroup)
	t._worldMarker = marker
end
function t.open()
	assert(t._maid == nil)
	local maid = Maid.new()
	t._maid = maid
	local gui = t.gui
	gui.Enabled = true
	maid:GiveTask(function()
		gui.Enabled = false
	end)
	maid:GiveTask(function()
		t.setWorldMarkerEnabled(false)
	end)
	maid:GiveTask(gui.Container.Close.MouseButton1Down:Connect(function()
		t.onCloseClicked:Fire()
		t.close()
	end))
end
function t.close()
	assert(t._maid ~= nil)
	local _maid = t._maid
	t._maid = nil
	_maid:Destroy()
end
function t.setMessage(message)
	local gui = t.gui
	gui.Container.Container.Message.Text = message
	Audio.ObjectLocal(gui, 131184732929614)
end
function t.setWorldMarkerEnabled(enabled)
	t._worldMarkerGroup:SetEnabled(enabled)
end
function t.setWorldMarkerPosition(position)
	t._worldMarker:SetPosition(position)
end
function t.setWorldMarkerSizes(sizes)
	t._worldMarker:SetSizes(sizes)
end
function t.isOpen()
	return t._maid ~= nil
end
return t
