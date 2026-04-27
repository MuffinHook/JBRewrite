local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Format = require(ReplicatedStorage.Module.Format)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local RobberyMoneyUI = {
	Formatter = {},
	CurrentTier = 1
}
local function Cash(currentAmount, maxAmount)
	return ("%s / %s"):format(Format.Currency(currentAmount), Format.Currency(maxAmount))
end
RobberyMoneyUI.Formatter.Cash = Cash
local function CashNoMax(currentAmount)
	return ("%s Cash"):format(Format.Currency(currentAmount))
end
RobberyMoneyUI.Formatter.CashNoMax = CashNoMax
local function Weight(currentWeight, maxWeight)
	return ("%d kg / %d kg"):format(currentWeight, maxWeight)
end
RobberyMoneyUI.Formatter.Weight = Weight
RobberyMoneyUI.SelectedFormatter = RobberyMoneyUI.Formatter.Cash
function RobberyMoneyUI.Init()
	local RobberyMoneyGui = ReplicatedStorage.StarterGui:FindFirstChild("RobberyMoneyGui")
	RobberyMoneyGui.Parent = LocalPlayer.PlayerGui
	RobberyMoneyUI.Gui = RobberyMoneyGui.Frame
end
function RobberyMoneyUI.GetMaxSizeForTier(tierNumber)
	assert(tierNumber ~= nil)
	assert(tierNumber >= 1)
	return RobberyMoneyUI.Gui.Container.Bottom.Progress.Tiers:FindFirstChild("Tier" .. tierNumber).Position.X.Scale
end
local guiTween = nil
local showTweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local hideTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
function RobberyMoneyUI.Show()
	if RobberyMoneyUI.Maid ~= nil then
		return false
	end
	local Gui = RobberyMoneyUI.Gui
	local maidInstance = Maid.new()
	RobberyMoneyUI.Maid = maidInstance
	if guiTween then
		guiTween:Cancel()
	end
	Gui.Position = UDim2.fromScale(1, 0)
	Gui.Visible = true
	guiTween = TweenService:Create(Gui, showTweenInfo, {
		Position = UDim2.fromScale(0, 0)
	})
	guiTween:Play()
	maidInstance:GiveTask(function()
		if guiTween then
			guiTween:Cancel()
		end
		guiTween = TweenService:Create(Gui, hideTweenInfo, {
			Position = UDim2.fromScale(1, 0)
		})
		guiTween:Play()
		guiTween.Completed:Once(function(playbackState)
			if playbackState == Enum.PlaybackState.Completed then
				Gui.Visible = false
			end
		end)
	end)
	Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(0, 0, 1, 0)
	maidInstance:GiveTask(function()
		Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(0, 0, 1, 0)
	end)
end
function RobberyMoneyUI.getUpgradeButton()
	return RobberyMoneyUI.Gui.Container.Top.Upgrade
end
function RobberyMoneyUI.SetFormatter(formatter)
	RobberyMoneyUI.SelectedFormatter = formatter
end
function RobberyMoneyUI.SetTime(secondsRemaining)
	local Gui = RobberyMoneyUI.Gui
	Gui.Container.Time.Visible = secondsRemaining ~= nil
	if secondsRemaining ~= nil then
		if secondsRemaining > 60 then
			local minutes = math.floor(secondsRemaining / 60)
			local seconds = math.floor(secondsRemaining % 60)
			Gui.Container.Time.Text = ("%d:%02d"):format(math.max(minutes, 0), (math.max(seconds, 0)))
			return
		end
		Gui.Container.Time.Text = ("%d"):format((math.max(secondsRemaining, 0)))
	end
end
function RobberyMoneyUI.SetTier(tierIndex, isVisible)
	assert(tierIndex ~= nil)
	assert(tierIndex >= 1)
	assert(isVisible ~= nil)
	local Gui = RobberyMoneyUI.Gui
	local Tiers = Gui.Container.Bottom.Progress.Tiers
	local count = 0
	for _, tierInstance in ipairs(Tiers:GetChildren()) do
		if tierInstance:IsA("Frame") then
			count = count + 1
		end
	end
	assert(tierIndex <= count)
	for i = 1, count do
		local tierFrame = Tiers:FindFirstChild("Tier" .. i)
		if i == tierIndex then
			tierFrame.BackgroundTransparency = 0
			tierFrame.Circle.Tier.UIGradient.Enabled = false
		else
			tierFrame.BackgroundTransparency = 0.7
			tierFrame.Circle.Tier.UIGradient.Enabled = true
		end
		tierFrame.Visible = isVisible
	end
	local Top = Gui.Container.Top
	local shouldShowUpgrade = if tierIndex < count then if RobberyMoneyUI.SelectedFormatter == RobberyMoneyUI.Formatter.CashNoMax then false else isVisible else false
	Top.Upgrade.Visible = shouldShowUpgrade
	Top.Alternative.Visible = not shouldShowUpgrade
	if shouldShowUpgrade then
		Top.Upgrade.Title.Text = ("Unlock Tier %d"):format(tierIndex + 1)
	end
	RobberyMoneyUI.CurrentTier = isVisible and tierIndex or count
end
local moneySliderTween = nil
local moneySliderTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
function RobberyMoneyUI.SetMoney(currentAmount, maxAmount, isInstant)
	assert(currentAmount)
	assert(maxAmount)
	local Gui = RobberyMoneyUI.Gui
	Gui.Container.Bottom.Progress.Amount.Text = RobberyMoneyUI.SelectedFormatter(currentAmount, maxAmount)
	if moneySliderTween then
		moneySliderTween:Cancel()
	end
	if RobberyMoneyUI.SelectedFormatter == RobberyMoneyUI.Formatter.CashNoMax then
		if isInstant then
			Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(1, 0, 1, 0)
		else
			Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(0, 0, 1, 0)
			moneySliderTween = TweenService:Create(Gui.Container.Bottom.Progress.Slider.Value, moneySliderTweenInfo, {
				Size = UDim2.new(1, 0, 1, 0)
			})
			moneySliderTween:Play()
		end
		Gui.Container.Bottom.Progress.Tiers.Visible = false
	else
		local targetSize = UDim2.new(RobberyMoneyUI.GetMaxSizeForTier(RobberyMoneyUI.CurrentTier) * currentAmount / maxAmount, 0, 1, 0)
		if isInstant then
			Gui.Container.Bottom.Progress.Slider.Value.Size = targetSize
		else
			moneySliderTween = TweenService:Create(Gui.Container.Bottom.Progress.Slider.Value, moneySliderTweenInfo, {
				Size = targetSize
			})
			moneySliderTween:Play()
		end
		Gui.Container.Bottom.Progress.Tiers.Visible = true
	end
end
function RobberyMoneyUI.SetMessage(messageText)
	local Gui = RobberyMoneyUI.Gui
	if messageText == nil then
		Gui.Container.Message.Visible = false
	else
		Gui.Container.Message.Visible = true
		Gui.Container.Message.Text = messageText
	end
end
local function setColor(instance, color)
	if instance:IsA("Frame") then
		instance.BackgroundColor3 = color
	elseif instance:IsA("TextLabel") or instance:IsA("TextButton") then
		instance.BackgroundColor3 = color
		instance.TextColor3 = color
	elseif instance:IsA("UIStroke") then
		instance.Color = color
	elseif instance:IsA("UIGradient") then
		instance.Color = ColorSequence.new(color)
	end
end
local function changeColor(container, baseColor)
	local saturatedColor = ColorUtils.saturateBy(ColorUtils.brightenBy(baseColor, -0.455), 0.093)
	if baseColor == Color3.fromRGB(194, 248, 117) then
		saturatedColor = ColorUtils.hueBy(saturatedColor, 0.102)
	end
	local brightColor = ColorUtils.brightenTo(baseColor, 1)
	for _, baseElement in container:QueryDescendants("[$baseColor]") do
		setColor(baseElement, baseColor)
	end
	for _, darkElement in container:QueryDescendants("[$darkColor]") do
		setColor(darkElement, saturatedColor)
	end
	for _, brightElement in container:QueryDescendants("[$brightColor]") do
		setColor(brightElement, brightColor)
	end
end
function RobberyMoneyUI.SetRobbery(robberyType)
	local Container = RobberyMoneyUI.Gui.Container
	local frameData = RobberyConsts.DATA_ROBBERY[robberyType].frameData or {}
	changeColor(Container, frameData.color or Color3.fromRGB(194, 248, 117))
	Container.Icon.Image = "rbxassetid://" .. (frameData.topImageId or 83554444602066)
	Container.Bottom.Progress.Icon.Image = "rbxassetid://" .. (frameData.cashImageId or 4912231216)
	Container.Top.Alternative.Title.Text = frameData.alternativeText or "COLLECTING..."
end
function RobberyMoneyUI.Hide()
	if RobberyMoneyUI.Maid == nil then
		return false
	end
	RobberyMoneyUI.Maid:Destroy()
	RobberyMoneyUI.Maid = nil
end
return RobberyMoneyUI
