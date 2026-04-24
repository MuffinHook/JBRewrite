-- Reviewed by Claude
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Logic = require(ReplicatedStorage.Module.Logic)
local function Update(p1, p2)
	local v1 = p1.Spring:Update()
	local CrossHair = p1.Gui.CrossHair
	local v2 = p2 or UserInputService:GetMouseLocation()
	local AbsoluteSize = CrossHair.AbsoluteSize
	CrossHair.Position = UDim2.new(0, v2.X - AbsoluteSize.X * 0.5, 0, v2.Y - AbsoluteSize.Y * 0.5)
	CrossHair.VerticalTop.Position = UDim2.new(0.5, 0, 0, -v1)
	CrossHair.VerticalBottom.Position = UDim2.new(0.5, 0, 0.5, v1)
	CrossHair.HorizontalLeft.Position = UDim2.new(0, -v1, 0.5, -1)
	CrossHair.HorizontalRight.Position = UDim2.new(0.5, v1, 0.5, -1)
end
local v1 = Color3.new(255/255, 0/255, 0/255)
local v2 = Color3.new(255/255, 255/255, 255/255)
local function FlareCrossHair(p1)
	local v12 = p1.Int + 1
	p1.Int = v12
	local Gui = p1.Gui
	if not Gui then
		return false
	end
	local CrossHair = Gui.CrossHair
	local VerticalTop = CrossHair.VerticalTop
	local VerticalBottom = CrossHair.VerticalBottom
	local HorizontalLeft = CrossHair.HorizontalLeft
	local HorizontalRight = CrossHair.HorizontalRight
	VerticalTop.BackgroundColor3 = v1
	VerticalBottom.BackgroundColor3 = v1
	HorizontalLeft.BackgroundColor3 = v1
	HorizontalRight.BackgroundColor3 = v1
	delay(0.1, function()
		if p1.Int == v12 then
			VerticalTop.BackgroundColor3 = v2
			VerticalBottom.BackgroundColor3 = v2
			HorizontalLeft.BackgroundColor3 = v2
			HorizontalRight.BackgroundColor3 = v2
		end
	end)
end
local function ADS(p1, p2)
	p1.Spring:SetTarget(if p2 then 2 else 5)
end
local function EnableCrossHair(p1)
	UserInputService.MouseIconEnabled = false
	p1.Gui.Enabled = true
end
local function DisableCrossHair(p1)
	UserInputService.MouseIconEnabled = true
	p1.Gui.Enabled = false
end
local function DestroyCrossHair(p1)
	UserInputService.MouseIconEnabled = true
	p1.Gui.Enabled = false
	p1.Gui:Destroy()
	p1.Gui = nil
end
return {
	Make = function()
		local v1 = Logic.MakeSpring()
		v1.p = 0
		v1.v = 0
		v1.Target = 5
		v1.Freq = 20
		v1.Damp = 0.7
		local v2 = ReplicatedStorage.Resource.CrossHairGui:Clone()
		v2.Enabled = false
		local t = {
			Gui = v2,
			Spring = v1,
			Update = Update,
			Destroy = DestroyCrossHair,
			ADS = ADS,
			Flare = FlareCrossHair,
			Int = 1,
			Enable = EnableCrossHair,
			Disable = DisableCrossHair
		}
		UserInputService.MouseIconEnabled = false
		t.Gui.Enabled = true
		return t
	end
}
