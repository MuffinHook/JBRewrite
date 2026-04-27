local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Format = require(ReplicatedStorage.Module.Format)
require(ReplicatedStorage.Module.Localization)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local function PlayButtonClick()
	task.spawn(Audio.ObjectLocal, Players.LocalPlayer, 6105461542, {
		Volume = 0.15
	})
end
local function PlayUIOpen()
	task.spawn(Audio.ObjectLocal, Players.LocalPlayer, 131184732929614, {
		Volume = 0.15
	})
end
return function()
	local NewBuyVehicle = Instance.new("Frame")
	NewBuyVehicle.Name = "NewBuyVehicle"
	NewBuyVehicle.BackgroundColor3 = Color3.fromRGB(68, 194, 93)
	NewBuyVehicle.Position = UDim2.new(0.5, -125, 0.5, -75)
	NewBuyVehicle.Size = UDim2.fromOffset(250, 110)
	NewBuyVehicle.ZIndex = 5
	NewBuyVehicle.Visible = false
	local BuyCash = Instance.new("ImageButton")
	BuyCash.Name = "BuyCash"
	BuyCash.BackgroundTransparency = 1
	BuyCash.Image = "rbxassetid://723277512"
	BuyCash.Position = UDim2.fromOffset(-24, -24)
	BuyCash.Size = UDim2.fromOffset(64, 64)
	BuyCash.ZIndex = 6
	BuyCash.Parent = NewBuyVehicle
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = "TextLabel"
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TextLabel.Position = UDim2.fromOffset(30, 15)
	TextLabel.Size = UDim2.new(1, -60, 1, -40)
	TextLabel.TextColor3 = Color3.fromRGB(20, 59, 26)
	TextLabel.TextScaled = true
	TextLabel.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel.ZIndex = 6
	TextLabel.Parent = NewBuyVehicle
	local Money = Instance.new("TextLabel")
	Money.Name = "Money"
	Money.BackgroundTransparency = 1
	Money.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Money.Position = UDim2.new(0.48, -80, -0.007, -40)
	Money.Size = UDim2.fromOffset(173, 37)
	Money.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Money.TextScaled = true
	Money.TextStrokeTransparency = 0.4
	Money.TextXAlignment = Enum.TextXAlignment.Right
	Money.ZIndex = 6
	Money.Parent = NewBuyVehicle
	local OneTime = Instance.new("TextLabel")
	OneTime.Name = "OneTime"
	OneTime.BackgroundTransparency = 1
	OneTime.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	OneTime.Position = UDim2.new(0, 30, 1, -30)
	OneTime.Size = UDim2.new(1, -60, 0, 20)
	OneTime.Text = "* one time purchase"
	OneTime.TextColor3 = Color3.fromRGB(26, 76, 32)
	OneTime.TextScaled = true
	OneTime.TextTransparency = 0.6
	OneTime.TextYAlignment = Enum.TextYAlignment.Top
	OneTime.ZIndex = 6
	OneTime.Parent = NewBuyVehicle
	local UICorner = Instance.new("UICorner")
	UICorner.Name = "UICorner"
	UICorner.CornerRadius = UDim.new(0.2, 0)
	UICorner.Parent = NewBuyVehicle
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Name = "UIStroke"
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Center
	UIStroke.Color = Color3.fromRGB(57, 163, 76)
	UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
	UIStroke.Thickness = 0.03
	UIStroke.Parent = NewBuyVehicle
	local Buy = Instance.new("TextButton")
	Buy.Name = "Buy"
	Buy.BackgroundColor3 = Color3.fromRGB(74, 211, 99)
	Buy.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Buy.Position = UDim2.new(0, 10, 1.03636, 5)
	Buy.Size = UDim2.new(0.5, -15, 0, 40)
	Buy.Text = "Buy"
	Buy.TextColor3 = Color3.fromRGB(20, 59, 26)
	Buy.TextSize = 28
	Buy.ZIndex = 6
	local UICorner_2 = Instance.new("UICorner")
	UICorner_2.Name = "UICorner"
	UICorner_2.CornerRadius = UDim.new(1, 0)
	UICorner_2.Parent = Buy
	local UIStroke_2 = Instance.new("UIStroke")
	UIStroke_2.Name = "UIStroke"
	UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_2.Color = Color3.fromRGB(57, 163, 76)
	UIStroke_2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
	UIStroke_2.Thickness = 0.08
	UIStroke_2.Parent = Buy
	Buy.Parent = NewBuyVehicle
	local Cancel = Instance.new("TextButton")
	Cancel.Name = "Cancel"
	Cancel.BackgroundColor3 = Color3.fromRGB(68, 194, 93)
	Cancel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Cancel.Position = UDim2.new(0.5, 5, 1.03636, 5)
	Cancel.Size = UDim2.new(0.5, -15, 0, 40)
	Cancel.Text = "Cancel"
	Cancel.TextColor3 = Color3.fromRGB(20, 59, 26)
	Cancel.TextSize = 28
	Cancel.ZIndex = 6
	local UICorner_3 = Instance.new("UICorner")
	UICorner_3.Name = "UICorner"
	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = Cancel
	local UIStroke_3 = Instance.new("UIStroke")
	UIStroke_3.Name = "UIStroke"
	UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_3.Color = Color3.fromRGB(57, 163, 76)
	UIStroke_3.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
	UIStroke_3.Thickness = 0.08
	UIStroke_3.Parent = Cancel
	Cancel.Parent = NewBuyVehicle
	local BuyCash2 = Instance.new("TextButton")
	BuyCash2.Name = "BuyCash2"
	BuyCash2.AnchorPoint = Vector2.new(0, 0.5)
	BuyCash2.BackgroundColor3 = Color3.fromRGB(74, 211, 99)
	BuyCash2.Position = UDim2.fromScale(0.89, -0.203)
	BuyCash2.RichText = true
	BuyCash2.Size = UDim2.fromScale(0.108, 0.259481)
	BuyCash2.Text = "+"
	BuyCash2.TextScaled = true
	local UICorner_4 = Instance.new("UICorner")
	UICorner_4.Name = "UICorner"
	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = BuyCash2
	local UIStroke_4 = Instance.new("UIStroke")
	UIStroke_4.Name = "UIStroke"
	UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_4.BorderStrokePosition = Enum.BorderStrokePosition.Center
	UIStroke_4.Color = Color3.fromRGB(57, 163, 76)
	UIStroke_4.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
	UIStroke_4.Thickness = 0.05
	UIStroke_4.ZIndex = 0
	UIStroke_4.Parent = BuyCash2
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
	UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint.Parent = BuyCash2
	BuyCash2.Parent = NewBuyVehicle
	local Rent = Instance.new("TextButton")
	Rent.Name = "Rent"
	Rent.BackgroundColor3 = Color3.fromRGB(68, 194, 93)
	Rent.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Rent.Position = UDim2.new(0.02, 5, 1.52727, 5)
	Rent.Size = UDim2.new(0.98, -15, -0.145455, 40)
	Rent.Text = "Rent for 24 hours for ???"
	Rent.TextColor3 = Color3.fromRGB(20, 59, 26)
	Rent.TextScaled = true
	Rent.ZIndex = 6
	local UICorner_5 = Instance.new("UICorner")
	UICorner_5.Name = "UICorner"
	UICorner_5.CornerRadius = UDim.new(1, 0)
	UICorner_5.Parent = Rent
	local UIStroke_5 = Instance.new("UIStroke")
	UIStroke_5.Name = "UIStroke"
	UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_5.Color = Color3.fromRGB(57, 163, 76)
	UIStroke_5.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
	UIStroke_5.Thickness = 0.08
	UIStroke_5.Parent = Rent
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Name = "UIPadding"
	UIPadding.PaddingLeft = UDim.new(0, 8)
	UIPadding.PaddingRight = UDim.new(0, 8)
	UIPadding.Parent = Rent
	Rent.Parent = NewBuyVehicle
	local signal = Signal.new()
	local maid = Maid.new()
	local playerCash = 0
	local function bindButtonTo(button, action)
		maid:GiveTask(button.MouseButton1Click:Connect(function()
			signal:Fire(action)
		end))
	end
	task.spawn(function()
		if not Settings.FetchedMarketplace then
			Settings.OnProductsFetched:Wait()
		end
		local Robux = Settings.getFirstProductByType("Rent").Robux
		Rent.Text = "Rent for 24 hours for " .. utf8.char(57346) .. Robux
	end)
	return {
		Frame = NewBuyVehicle,
		BuyButton = Buy,
		onAction = signal,
		setEnabled = function(isEnabled)
			NewBuyVehicle.Visible = isEnabled
			maid:DoCleaning()
			if isEnabled then
				local actionCash = "Cash"
				maid:GiveTask(BuyCash.MouseButton1Click:Connect(function()
					signal:Fire(actionCash)
				end))
				local actionCash2 = "Cash"
				maid:GiveTask(BuyCash2.MouseButton1Click:Connect(function()
					signal:Fire(actionCash2)
				end))
				local actionBuy = "Buy"
				maid:GiveTask(Buy.MouseButton1Click:Connect(function()
					signal:Fire(actionBuy)
				end))
				local actionCancel = "Cancel"
				maid:GiveTask(Cancel.MouseButton1Click:Connect(function()
					signal:Fire(actionCancel)
				end))
				local actionRent = "Rent"
				maid:GiveTask(Rent.MouseButton1Click:Connect(function()
					signal:Fire(actionRent)
				end))
				task.spawn(Audio.ObjectLocal, Players.LocalPlayer, 131184732929614, {
					Volume = 0.15
				})
			end
		end,
		setCash = function(cash)
			playerCash = cash
			Money.Text = Format.Currency(cash)
		end,
		setVehicle = function(vehicleName, vehiclePrice, isRentable)
			TextLabel.Text = ("Buy %s for %s?"):format(vehicleName, Format.Currency(vehiclePrice))
			Rent.Visible = isRentable
			Money.TextColor3 = if vehiclePrice <= playerCash then Color3.new(255/255, 255/255, 255/255) else Color3.new(1, 0.262745, 0.262745)
		end
	}
end
