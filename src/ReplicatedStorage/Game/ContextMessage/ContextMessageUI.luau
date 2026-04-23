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
function t.init() --[[ Line: 16 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t (copy), WorldMarkerGroup (copy), WorldMarker (copy), WorldMarkerSystem (copy) ]]
	local ContextMessageGui = ReplicatedStorage.StarterGui:FindFirstChild("ContextMessageGui")
	ContextMessageGui.Parent = LocalPlayer.PlayerGui
	t.gui = ContextMessageGui
	local v1 = WorldMarkerGroup.new()
	v1:SetEnabled(false)
	t._worldMarkerGroup = v1
	local v2 = WorldMarker.new()
	v2:SetScreenGui(WorldMarkerSystem.gui)
	v2:SetIcon(5920742944)
	v2.FrameInner.ImageColor3 = Color3.fromRGB(255, 203, 70)
	v1:Add(v2)
	WorldMarkerSystem.addGroup(v1)
	t._worldMarker = v2
end
function t.open() --[[ Line: 35 | Upvalues: t (copy), Maid (copy) ]]
	assert(t._maid == nil)
	local v1 = Maid.new()
	t._maid = v1
	local gui = t.gui
	gui.Enabled = true
	v1:GiveTask(function() --[[ Line: 42 | Upvalues: gui (copy) ]]
		gui.Enabled = false
	end)
	v1:GiveTask(function() --[[ Line: 45 | Upvalues: t (ref) ]]
		t.setWorldMarkerEnabled(false)
	end)
	v1:GiveTask(gui.Container.Close.MouseButton1Down:Connect(function() --[[ Line: 49 | Upvalues: t (ref) ]]
		t.onCloseClicked:Fire()
		t.close()
	end))
end
function t.close() --[[ Line: 54 | Upvalues: t (copy) ]]
	assert(t._maid ~= nil)
	local _maid = t._maid
	t._maid = nil
	_maid:Destroy()
end
function t.setMessage(p1) --[[ Line: 61 | Upvalues: t (copy), Audio (copy) ]]
	local gui = t.gui
	gui.Container.Container.Message.Text = p1
	Audio.ObjectLocal(gui, 131184732929614)
end
function t.setWorldMarkerEnabled(p1) --[[ Line: 68 | Upvalues: t (copy) ]]
	t._worldMarkerGroup:SetEnabled(p1)
end
function t.setWorldMarkerPosition(p1) --[[ Line: 71 | Upvalues: t (copy) ]]
	t._worldMarker:SetPosition(p1)
end
function t.setWorldMarkerSizes(p1) --[[ Line: 74 | Upvalues: t (copy) ]]
	t._worldMarker:SetSizes(p1)
end
function t.isOpen() --[[ Line: 77 | Upvalues: t (copy) ]]
	return t._maid ~= nil
end
return t