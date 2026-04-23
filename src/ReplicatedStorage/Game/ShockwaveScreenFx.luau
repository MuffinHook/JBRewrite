local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Spring = require(ReplicatedStorage.Std.Spring)
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {}
t.__index = t
function t.new() --[[ Line: 10 | Upvalues: t (copy), Maid (copy), Spring (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._springActive = Spring.new(0, 0, 0.8, 1)
	t2._targetColor = Color3.fromRGB(255, 255, 255)
	t2:_createFx()
	return t2
end
function t._createFx(p1) --[[ Line: 24 | Upvalues: LocalPlayer (copy) ]]
	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 0
	BlurEffect.Enabled = false
	BlurEffect.Parent = game:GetService("Lighting")
	p1._blur = BlurEffect
	p1._maid:GiveTask(p1._blur)
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	ColorCorrectionEffect.Enabled = false
	ColorCorrectionEffect.Parent = game:GetService("Lighting")
	p1._colorCorrection = ColorCorrectionEffect
	p1._maid:GiveTask(p1._colorCorrection)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = LocalPlayer.PlayerGui
	p1._maid:GiveTask(ScreenGui)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 1, 0)
	Frame.BackgroundColor3 = p1._targetColor
	Frame.Visible = false
	Frame.Parent = ScreenGui
	p1._colorFrame = Frame
end
function t.SetActive(p1, p2) --[[ Line: 50 ]]
	p1._springActive:SetTarget(if p2 then 1 else 0)
end
function t.Update(p1) --[[ Line: 53 ]]
	local v1, _ = p1._springActive:Update()
	local v2 = v1 >= 0.001
	if v2 then
		p1._blur.Size = math.max(0, 1 - math.abs(v1 * 2 / 0.2 - 1)) * 15
		local v5 = 1 - v1 * 0.01
		if v5 < 0.999 then
			p1._colorFrame.Visible = true
		else
			p1._colorFrame.Visible = false
		end
		p1._colorFrame.Transparency = v5
	end
	if p1._blur.Enabled ~= v2 then
		p1._blur.Enabled = v2
	end
	local v6 = v1 > 0.001
	if v6 then
		p1._colorCorrection.Saturation = 1 * v1
		p1._colorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255):lerp(p1._targetColor, v1)
	end
	if p1._colorCorrection.Enabled ~= v6 then
		p1._colorCorrection.Enabled = v6
	end
end
function t.Destroy(p1) --[[ Line: 85 ]]
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
	setmetatable(p1, nil)
end
return t