local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Maid = require(ReplicatedStorage.Std.Maid)
local UIUtil = require(ReplicatedStorage.Game.UIUtil)
local Format = require(ReplicatedStorage.Module.Format)
local HomeSaleUISystem = {}
function HomeSaleUISystem.init()
	local HomeSaleGui = ReplicatedStorage.StarterGui:FindFirstChild("HomeSaleGui")
	HomeSaleGui.Parent = LocalPlayer.PlayerGui
	HomeSaleUISystem.gui = HomeSaleGui
	local instance = Window.new()
	instance:GetOnOpenedSignal():Connect(HomeSaleUISystem._open)
	instance:GetOnClosedSignal():Connect(HomeSaleUISystem._close)
	HomeSaleUISystem._window = instance
	GameUtil.getCenterWindowGroup():Add(instance)
end
function HomeSaleUISystem._open()
	assert(HomeSaleUISystem._maid == nil)
	local instance = Maid.new()
	HomeSaleUISystem._maid = instance
	local gui = HomeSaleUISystem.gui
	gui.Enabled = true
	instance:GiveTask(function()
		gui.Enabled = false
	end)
	UIUtil.selectIfGamepad(gui.Container.ButtonContainer.YesContainer.Button)
end
function HomeSaleUISystem._close()
	assert(HomeSaleUISystem._maid ~= nil)
	local _maid = HomeSaleUISystem._maid
	HomeSaleUISystem._maid = nil
	_maid:Destroy()
end
function HomeSaleUISystem.open()
	HomeSaleUISystem._window:Open()
end
function HomeSaleUISystem.close()
	HomeSaleUISystem._window:Close()
end
function HomeSaleUISystem.isOpen()
	return HomeSaleUISystem._window:IsOpen()
end
function HomeSaleUISystem.getOnClosedSignal()
	return HomeSaleUISystem._window:GetOnClosedSignal()
end
function HomeSaleUISystem.getOnClickYesSignal()
	return HomeSaleUISystem.gui.Container.ButtonContainer.YesContainer.Button.MouseButton1Down
end
function HomeSaleUISystem.getOnClickNoSignal()
	return HomeSaleUISystem.gui.Container.ButtonContainer.NoContainer.Button.MouseButton1Down
end
function HomeSaleUISystem.setPrice(price)
	assert(price ~= nil)
	assert(type(price) == "number")
	HomeSaleUISystem.gui.Container.PriceContainer.TextLabel.Text = Format.Currency(price)
end
return HomeSaleUISystem
