-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RadioUI = require(script.Parent.RadioUI)
local RadioPlayer = require(script.Parent.RadioPlayer)
local t = {}
function t.Init()
	local RadioGui = ReplicatedStorage.StarterGui:FindFirstChild("RadioGui")
	RadioGui.Parent = LocalPlayer.PlayerGui
	t.Gui = RadioGui
	t.Window = Window.new()
	local v1 = nil
	t.Window:GetOnOpenedSignal():Connect(function()
		v1 = RadioUI.new(t.Gui)
		v1.Maid:GiveTask(v1.Gui.Container.Close.MouseButton1Down:Connect(function()
			t.Close()
		end))
		v1.Maid:GiveTask(ActionButtonService.pushHide())
	end)
	t.Window:GetOnClosedSignal():Connect(function()
		v1:Destroy()
		v1 = nil
	end)
	if t.Gui.Enabled then
		t.Window:Open()
	end
	RadioPlayer.OnSongEnded:Connect(function()
		if RadioPlayer.PlayRandomSongAfter then
			RadioPlayer.PlayRandomSong()
			if v1 ~= nil then
				v1:UpdatePlayButton()
			end
		end
	end)
	GameUtil.getCenterWindowGroup():Add(t.Window)
end
function t.Open()
	return t.Window:Open()
end
function t.Close()
	return t.Window:Close()
end
function t.IsOpen()
	return t.Window:IsOpen()
end
function t.Toggle()
	if t.IsOpen() then
		t.Close()
	else
		t.Open()
	end
end
return t
