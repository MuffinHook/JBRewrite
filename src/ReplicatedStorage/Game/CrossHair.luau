local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Logic = require(ReplicatedStorage.Module.Logic)
local function Update(crosshairConfig, overrideMousePos)
	local springOffset = crosshairConfig.Spring:Update()
	local CrossHair = crosshairConfig.Gui.CrossHair
	local mousePos = overrideMousePos or UserInputService:GetMouseLocation()
	local AbsoluteSize = CrossHair.AbsoluteSize
	CrossHair.Position = UDim2.new(0, mousePos.X - AbsoluteSize.X * 0.5, 0, mousePos.Y - AbsoluteSize.Y * 0.5)
	CrossHair.VerticalTop.Position = UDim2.new(0.5, 0, 0, -springOffset)
	CrossHair.VerticalBottom.Position = UDim2.new(0.5, 0, 0.5, springOffset)
	CrossHair.HorizontalLeft.Position = UDim2.new(0, -springOffset, 0.5, -1)
	CrossHair.HorizontalRight.Position = UDim2.new(0.5, springOffset, 0.5, -1)
end
local redColor = Color3.new(255/255, 0/255, 0/255)
local whiteColor = Color3.new(255/255, 255/255, 255/255)
local function FlareCrossHair(crosshairConfig)
	local updateCounter = crosshairConfig.Int + 1
	crosshairConfig.Int = updateCounter
	local Gui = crosshairConfig.Gui
	if not Gui then
		return false
	end
	local CrossHair = Gui.CrossHair
	local VerticalTop = CrossHair.VerticalTop
	local VerticalBottom = CrossHair.VerticalBottom
	local HorizontalLeft = CrossHair.HorizontalLeft
	local HorizontalRight = CrossHair.HorizontalRight
	VerticalTop.BackgroundColor3 = redColor
	VerticalBottom.BackgroundColor3 = redColor
	HorizontalLeft.BackgroundColor3 = redColor
	HorizontalRight.BackgroundColor3 = redColor
	delay(0.1, function()
		if crosshairConfig.Int == updateCounter then
			VerticalTop.BackgroundColor3 = whiteColor
			VerticalBottom.BackgroundColor3 = whiteColor
			HorizontalLeft.BackgroundColor3 = whiteColor
			HorizontalRight.BackgroundColor3 = whiteColor
		end
	end)
end
local function ADS(crosshairConfig, isAiming)
	crosshairConfig.Spring:SetTarget(if isAiming then 2 else 5)
end
local function EnableCrossHair(crosshairConfig)
	UserInputService.MouseIconEnabled = false
	crosshairConfig.Gui.Enabled = true
end
local function DisableCrossHair(crosshairConfig)
	UserInputService.MouseIconEnabled = true
	crosshairConfig.Gui.Enabled = false
end
local function DestroyCrossHair(crosshairConfig)
	UserInputService.MouseIconEnabled = true
	crosshairConfig.Gui.Enabled = false
	crosshairConfig.Gui:Destroy()
	crosshairConfig.Gui = nil
end
return {
	Make = function()
		local spring = Logic.MakeSpring()
		spring.p = 0
		spring.v = 0
		spring.Target = 5
		spring.Freq = 20
		spring.Damp = 0.7
		local guiClone = ReplicatedStorage.Resource.CrossHairGui:Clone()
		guiClone.Enabled = false
		local crosshairModule = {
			Gui = guiClone,
			Spring = spring,
			Update = Update,
			Destroy = DestroyCrossHair,
			ADS = ADS,
			Flare = FlareCrossHair,
			Int = 1,
			Enable = EnableCrossHair,
			Disable = DisableCrossHair
		}
		UserInputService.MouseIconEnabled = false
		crosshairModule.Gui.Enabled = true
		return crosshairModule
	end
}
