local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local Signal = require(ReplicatedStorage.Std.Signal)
local Players = game:GetService("Players")
local CmdrPermission = require(script.Parent.CmdrPermission)
local CmdrGuiUtils = require(ReplicatedStorage.CmdrExt.CmdrGuiUtils)
local v1 = nil
local v2 = nil
local v3 = false
local v4 = Signal.new()
local t = {}
function t.init() --[[ Line: 15 | Upvalues: v1 (ref), CmdrGuiUtils (copy), Players (copy), t (copy) ]]
	v1 = CmdrGuiUtils.frame(Players.LocalPlayer)
	local CmdrFrameValue = Instance.new("ObjectValue")
	CmdrFrameValue.Name = "CmdrFrameValue"
	CmdrFrameValue.Value = v1
	CmdrFrameValue.Parent = Players.LocalPlayer
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 1000
	ScreenGui.Parent = Players.LocalPlayer.PlayerGui
	CmdrGuiUtils.autocomplete(ScreenGui)
	task.spawn(t._load, ScreenGui)
end
function t._load(p1) --[[ Line: 32 | Upvalues: Players (copy), v2 (ref), ReplicatedStorage (copy), v4 (copy), v3 (ref), v1 (ref), CmdrPermission (copy) ]]
	local CmdrAutocompleteGuiValue = Instance.new("ObjectValue")
	CmdrAutocompleteGuiValue.Name = "CmdrAutocompleteGuiValue"
	CmdrAutocompleteGuiValue.Value = p1
	CmdrAutocompleteGuiValue.Parent = Players.LocalPlayer
	v2 = require(ReplicatedStorage:WaitForChild("CmdrClient"))
	v2:SetActivationKeys({})
	v2:SetHideOnLostFocus(false)
	v2:SetPlaceName("jb")
	v4:Fire()
	v3 = true
	local TextBox = v1.Entry.TextBox
	TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 47 | Upvalues: TextBox (copy), v2 (ref), Players (ref), CmdrPermission (ref) ]]
		local v1 = TextBox.Text:gsub("^%s+", "")
		local v22 = v2.Dispatcher:Evaluate(v1, Players.LocalPlayer, true)
		if v22 and not v1:sub(#v22.Name + 1, #v22.Name + 1):match("%s") then
			v22 = nil
		end
		if v22 and (v22.Group and not CmdrPermission.groupAllowed(Players.LocalPlayer, v22.Group)) then
			TextBox.Text = ""
		end
	end)
end
function t.promiseCmdr() --[[ Line: 62 | Upvalues: v3 (ref), Promise (copy), v2 (ref), v1 (ref), v4 (copy) ]]
	if v3 then
		return Promise.resolve(v2, v1)
	else
		return Promise.fromEvent(v4):andThen(function() --[[ Line: 66 | Upvalues: v2 (ref), v1 (ref) ]]
			return v2, v1
		end)
	end
end
function t.mount() --[[ Line: 71 ]] end
return t