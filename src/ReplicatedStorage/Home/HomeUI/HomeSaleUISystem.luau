-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Maid = require(ReplicatedStorage.Std.Maid)
local UIUtil = require(ReplicatedStorage.Game.UIUtil)
local Format = require(ReplicatedStorage.Module.Format)
local t = {}
function t.init()
	local HomeSaleGui = ReplicatedStorage.StarterGui:FindFirstChild("HomeSaleGui")
	HomeSaleGui.Parent = LocalPlayer.PlayerGui
	t.gui = HomeSaleGui
	local v1 = Window.new()
	v1:GetOnOpenedSignal():Connect(t._open)
	v1:GetOnClosedSignal():Connect(t._close)
	t._window = v1
	GameUtil.getCenterWindowGroup():Add(v1)
end
function t._open()
	assert(t._maid == nil)
	local v1 = Maid.new()
	t._maid = v1
	local gui = t.gui
	gui.Enabled = true
	v1:GiveTask(function()
		gui.Enabled = false
	end)
	UIUtil.selectIfGamepad(gui.Container.ButtonContainer.YesContainer.Button)
end
function t._close()
	assert(t._maid ~= nil)
	local _maid = t._maid
	t._maid = nil
	_maid:Destroy()
end
function t.open()
	t._window:Open()
end
function t.close()
	t._window:Close()
end
function t.isOpen()
	return t._window:IsOpen()
end
function t.getOnClosedSignal()
	return t._window:GetOnClosedSignal()
end
function t.getOnClickYesSignal()
	return t.gui.Container.ButtonContainer.YesContainer.Button.MouseButton1Down
end
function t.getOnClickNoSignal()
	return t.gui.Container.ButtonContainer.NoContainer.Button.MouseButton1Down
end
function t.setPrice(p1)
	assert(p1 ~= nil)
	assert(type(p1) == "number")
	t.gui.Container.PriceContainer.TextLabel.Text = Format.Currency(p1)
end
return t
