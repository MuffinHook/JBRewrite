local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local Signal = require(ReplicatedStorage.Std.Signal)
local Players = game:GetService("Players")
local CmdrPermission = require(script.Parent.CmdrPermission)
local CmdrGuiUtils = require(ReplicatedStorage.CmdrExt.CmdrGuiUtils)
local cmdrFrame = nil
local cmdrClient = nil
local isLoaded = false
local loadSignal = Signal.new()
local t = {}
function t.init()
	cmdrFrame = CmdrGuiUtils.frame(Players.LocalPlayer)
	local CmdrFrameValue = Instance.new("ObjectValue")
	CmdrFrameValue.Name = "CmdrFrameValue"
	CmdrFrameValue.Value = cmdrFrame
	CmdrFrameValue.Parent = Players.LocalPlayer
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 1000
	ScreenGui.Parent = Players.LocalPlayer.PlayerGui
	CmdrGuiUtils.autocomplete(ScreenGui)
	task.spawn(t._load, ScreenGui)
end
function t._load(screenGui)
	local CmdrAutocompleteGuiValue = Instance.new("ObjectValue")
	CmdrAutocompleteGuiValue.Name = "CmdrAutocompleteGuiValue"
	CmdrAutocompleteGuiValue.Value = screenGui
	CmdrAutocompleteGuiValue.Parent = Players.LocalPlayer
	cmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"))
	cmdrClient:SetActivationKeys({})
	cmdrClient:SetHideOnLostFocus(false)
	cmdrClient:SetPlaceName("jb")
	loadSignal:Fire()
	isLoaded = true
	local TextBox = cmdrFrame.Entry.TextBox
	TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		local trimmedText = TextBox.Text:gsub("^%s+", "")
		local evaluatedCommand = cmdrClient.Dispatcher:Evaluate(trimmedText, Players.LocalPlayer, true)
		if evaluatedCommand and not trimmedText:sub(#evaluatedCommand.Name + 1, #evaluatedCommand.Name + 1):match("%s") then
			evaluatedCommand = nil
		end
		if evaluatedCommand and (evaluatedCommand.Group and not CmdrPermission.groupAllowed(Players.LocalPlayer, evaluatedCommand.Group)) then
			TextBox.Text = ""
		end
	end)
end
function t.promiseCmdr()
	if isLoaded then
		return Promise.resolve(cmdrClient, cmdrFrame)
	else
		return Promise.fromEvent(loadSignal):andThen(function()
			return cmdrClient, cmdrFrame
		end)
	end
end
function t.mount()  end
return t
