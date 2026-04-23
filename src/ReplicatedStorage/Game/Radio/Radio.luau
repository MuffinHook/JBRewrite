local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RadioUI = require(script.Parent.RadioUI)
local RadioPlayer = require(script.Parent.RadioPlayer)
local t = {}
function t.Init() --[[ Line: 14 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t (copy), Window (copy), RadioUI (copy), ActionButtonService (copy), RadioPlayer (copy), GameUtil (copy) ]]
	local RadioGui = ReplicatedStorage.StarterGui:FindFirstChild("RadioGui")
	RadioGui.Parent = LocalPlayer.PlayerGui
	t.Gui = RadioGui
	t.Window = Window.new()
	local v1 = nil
	t.Window:GetOnOpenedSignal():Connect(function() --[[ Line: 20 | Upvalues: v1 (ref), RadioUI (ref), t (ref), ActionButtonService (ref) ]]
		v1 = RadioUI.new(t.Gui)
		v1.Maid:GiveTask(v1.Gui.Container.Close.MouseButton1Down:Connect(function() --[[ Line: 22 | Upvalues: t (ref) ]]
			t.Close()
		end))
		v1.Maid:GiveTask(ActionButtonService.pushHide())
	end)
	t.Window:GetOnClosedSignal():Connect(function() --[[ Line: 27 | Upvalues: v1 (ref) ]]
		v1:Destroy()
		v1 = nil
	end)
	if t.Gui.Enabled then
		t.Window:Open()
	end
	RadioPlayer.OnSongEnded:Connect(function() --[[ Line: 36 | Upvalues: RadioPlayer (ref), v1 (ref) ]]
		if RadioPlayer.PlayRandomSongAfter then
			RadioPlayer.PlayRandomSong()
			if v1 ~= nil then
				v1:UpdatePlayButton()
			end
		end
	end)
	GameUtil.getCenterWindowGroup():Add(t.Window)
end
function t.Open() --[[ Line: 47 | Upvalues: t (copy) ]]
	return t.Window:Open()
end
function t.Close() --[[ Line: 50 | Upvalues: t (copy) ]]
	return t.Window:Close()
end
function t.IsOpen() --[[ Line: 53 | Upvalues: t (copy) ]]
	return t.Window:IsOpen()
end
function t.Toggle() --[[ Line: 56 | Upvalues: t (copy) ]]
	if t.IsOpen() then
		t.Close()
	else
		t.Open()
	end
end
return t