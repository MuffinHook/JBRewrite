local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Maid = require(ReplicatedStorage.Std.Maid)
local UIUtil = require(ReplicatedStorage.Game.UIUtil)
local Format = require(ReplicatedStorage.Module.Format)
local t = {}
function t.init() --[[ Line: 11 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t (copy), Window (copy), GameUtil (copy) ]]
	local HomeSaleGui = ReplicatedStorage.StarterGui:FindFirstChild("HomeSaleGui")
	HomeSaleGui.Parent = LocalPlayer.PlayerGui
	t.gui = HomeSaleGui
	local v1 = Window.new()
	v1:GetOnOpenedSignal():Connect(t._open)
	v1:GetOnClosedSignal():Connect(t._close)
	t._window = v1
	GameUtil.getCenterWindowGroup():Add(v1)
end
function t._open() --[[ Line: 22 | Upvalues: t (copy), Maid (copy), UIUtil (copy) ]]
	assert(t._maid == nil)
	local v1 = Maid.new()
	t._maid = v1
	local gui = t.gui
	gui.Enabled = true
	v1:GiveTask(function() --[[ Line: 29 | Upvalues: gui (copy) ]]
		gui.Enabled = false
	end)
	UIUtil.selectIfGamepad(gui.Container.ButtonContainer.YesContainer.Button)
end
function t._close() --[[ Line: 35 | Upvalues: t (copy) ]]
	assert(t._maid ~= nil)
	local _maid = t._maid
	t._maid = nil
	_maid:Destroy()
end
function t.open() --[[ Line: 41 | Upvalues: t (copy) ]]
	t._window:Open()
end
function t.close() --[[ Line: 44 | Upvalues: t (copy) ]]
	t._window:Close()
end
function t.isOpen() --[[ Line: 47 | Upvalues: t (copy) ]]
	return t._window:IsOpen()
end
function t.getOnClosedSignal() --[[ Line: 50 | Upvalues: t (copy) ]]
	return t._window:GetOnClosedSignal()
end
function t.getOnClickYesSignal() --[[ Line: 53 | Upvalues: t (copy) ]]
	return t.gui.Container.ButtonContainer.YesContainer.Button.MouseButton1Down
end
function t.getOnClickNoSignal() --[[ Line: 57 | Upvalues: t (copy) ]]
	return t.gui.Container.ButtonContainer.NoContainer.Button.MouseButton1Down
end
function t.setPrice(p1) --[[ Line: 61 | Upvalues: t (copy), Format (copy) ]]
	assert(p1 ~= nil)
	assert(type(p1) == "number")
	t.gui.Container.PriceContainer.TextLabel.Text = Format.Currency(p1)
end
return t