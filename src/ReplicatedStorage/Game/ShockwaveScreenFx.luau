local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Spring = require(ReplicatedStorage.Std.Spring)
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {}
t.__index = t
function t.new()
	local instance = {}
	setmetatable(instance, t)
	instance._maid = Maid.new()
	instance._springActive = Spring.new(0, 0, 0.8, 1)
	instance._targetColor = Color3.fromRGB(255, 255, 255)
	instance:_createFx()
	return instance
end
function t._createFx(self)
	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 0
	BlurEffect.Enabled = false
	BlurEffect.Parent = game:GetService("Lighting")
	self._blur = BlurEffect
	self._maid:GiveTask(self._blur)
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	ColorCorrectionEffect.Enabled = false
	ColorCorrectionEffect.Parent = game:GetService("Lighting")
	self._colorCorrection = ColorCorrectionEffect
	self._maid:GiveTask(self._colorCorrection)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = LocalPlayer.PlayerGui
	self._maid:GiveTask(ScreenGui)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 1, 0)
	Frame.BackgroundColor3 = self._targetColor
	Frame.Visible = false
	Frame.Parent = ScreenGui
	self._colorFrame = Frame
end
function t.SetActive(self, shouldActivate)
	self._springActive:SetTarget(if shouldActivate then 1 else 0)
end
function t.Update(self)
	local springValue, _ = self._springActive:Update()
	local isActive = springValue >= 0.001
	if isActive then
		self._blur.Size = math.max(0, 1 - math.abs(springValue * 2 / 0.2 - 1)) * 15
		local transparency = 1 - springValue * 0.01
		if transparency < 0.999 then
			self._colorFrame.Visible = true
		else
			self._colorFrame.Visible = false
		end
		self._colorFrame.Transparency = transparency
	end
	if self._blur.Enabled ~= isActive then
		self._blur.Enabled = isActive
	end
	local isColorActive = springValue > 0.001
	if isColorActive then
		self._colorCorrection.Saturation = 1 * springValue
		self._colorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255):lerp(self._targetColor, springValue)
	end
	if self._colorCorrection.Enabled ~= isColorActive then
		self._colorCorrection.Enabled = isColorActive
	end
end
function t.Destroy(self)
	local maid = self._maid
	self._maid = nil
	maid:Destroy()
	setmetatable(self, nil)
end
return t
