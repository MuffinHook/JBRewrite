-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Utils = require(ReplicatedStorage.EzUi.Utils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local t = {}
function t.init()
	local HotbarGui = script.Parent.Res.HotbarGui
	HotbarGui.Parent = Players.LocalPlayer.PlayerGui
	HotbarGui.DisplayOrder = 11
	t.gui = HotbarGui
	local v1 = HotbarGui.Container.Item:Clone()
	HotbarGui.Container.Item:Destroy()
	t.presetFrame = v1
	local function updateSize()
		if Utils.isSmallScreen() then
			HotbarGui.Container.Size = UDim2.new(0.7, 0, 1, 0)
			HotbarGui.UIPadding.PaddingBottom = UDim.new(0.06, 0)
			return
		end
		if InputUtils.isTouch() then
			HotbarGui.Container.Size = UDim2.new(0.7, 0, 1, 0)
		else
			HotbarGui.Container.Size = UDim2.new(0.4, 0, 1, 0)
		end
		HotbarGui.UIPadding.PaddingBottom = UDim.new(0.01, 0)
	end
	Utils.getViewportSizeChangedSignal():Connect(updateSize)
	updateSize()
end
return t
