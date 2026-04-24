-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Maid = require(ReplicatedStorage.Std.Maid)
require(ReplicatedStorage.Std.Signal)
local module = {}
module.__index = module
local function _makeFadeGui()
	local _Fade = Instance.new("ScreenGui")
	_Fade.DisplayOrder = 100
	_Fade.IgnoreGuiInset = true
	_Fade.ClipToDeviceSafeArea = false
	_Fade.ScreenInsets = Enum.ScreenInsets.None
	_Fade.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
	_Fade.ResetOnSpawn = false
	_Fade.Name = "_Fade"
	local Frame = Instance.new("Frame")
	Frame.Position = UDim2.fromScale(0, 0)
	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BorderSizePixel = 0
	Frame.Interactable = false
	Frame.BackgroundTransparency = 1
	Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame.Parent = _Fade
	return _Fade, Frame
end
function module.new()
	local t2 = {}
	setmetatable(t2, module)
	t2.maid = Maid.new()
	local v2, v3 = _makeFadeGui()
	t2.maid:GiveTask(v2)
	v2.Parent = Players.LocalPlayer.PlayerGui
	t2.frame = v3
	return t2
end
function module._FadeTo(p1, p2, p3)
	if p1._tween then
		p1._tween:Cancel()
	end
	p1._tween = TweenService:Create(p1.frame, p3, {
		BackgroundTransparency = p2
	})
	p1._tween:Play()
end
function module.FadeToLinear(p1, p2, p3)
	p1:_FadeTo(p2, TweenInfo.new(p3, 0))
end
function module.Set(p1, p2)
	if p1._tween then
		p1._tween:Cancel()
	end
	p1.frame.BackgroundTransparency = p2
end
function module.Destroy(p1)
	p1.maid:Destroy()
	setmetatable(p1, nil)
end
return module