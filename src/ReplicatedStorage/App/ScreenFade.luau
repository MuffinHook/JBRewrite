local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Maid = require(ReplicatedStorage.Std.Maid)
require(ReplicatedStorage.Std.Signal)
local module = {}
module.__index = module
local function _makeFadeGui()
	local screenGui = Instance.new("ScreenGui")
	screenGui.DisplayOrder = 100
	screenGui.IgnoreGuiInset = true
	screenGui.ClipToDeviceSafeArea = false
	screenGui.ScreenInsets = Enum.ScreenInsets.None
	screenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
	screenGui.ResetOnSpawn = false
	screenGui.Name = "_Fade"
	local Frame = Instance.new("Frame")
	Frame.Position = UDim2.fromScale(0, 0)
	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BorderSizePixel = 0
	Frame.Interactable = false
	Frame.BackgroundTransparency = 1
	Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame.Parent = screenGui
	return screenGui, Frame
end
function module.new()
	local self = {}
	setmetatable(self, module)
	self.maid = Maid.new()
	local screenGui, frame = _makeFadeGui()
	self.maid:GiveTask(screenGui)
	screenGui.Parent = Players.LocalPlayer.PlayerGui
	self.frame = frame
	return self
end
function module._FadeTo(self, transparency, tweenInfo)
	if self._tween then
		self._tween:Cancel()
	end
	self._tween = TweenService:Create(self.frame, tweenInfo, {
		BackgroundTransparency = transparency
	})
	self._tween:Play()
end
function module.FadeToLinear(self, transparency, duration)
	self:_FadeTo(transparency, TweenInfo.new(duration, 0))
end
function module.Set(self, transparency)
	if self._tween then
		self._tween:Cancel()
	end
	self.frame.BackgroundTransparency = transparency
end
function module.Destroy(self)
	self.maid:Destroy()
	setmetatable(self, nil)
end
return module
