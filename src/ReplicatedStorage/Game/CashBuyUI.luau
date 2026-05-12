local CollectionService = game:GetService("CollectionService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SubscriptionConsts = require(ReplicatedStorage.Gamepass.SubscriptionConsts)
local Format = require(ReplicatedStorage.Module.Format)
local Maid = require(ReplicatedStorage.Std.Maid)
local UI = require(ReplicatedStorage.Module.UI)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Localization = require(ReplicatedStorage.Module.Localization)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local GamepassData = require(ReplicatedStorage.Gamepass.GamepassData)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local Audio = require(ReplicatedStorage.Std.Audio)
local Signal = require(ReplicatedStorage.Std.Signal)
local cashDropEvent = nil
local eventManager = nil
local darkGrayColor = Color3.fromRGB(87, 87, 87)
local lightGrayColor = Color3.fromRGB(138, 138, 138)
local function PlayButtonClick()
	task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
		Volume = 0.15
	})
end
local t = {
	IsOpen = nil,
	Loaded = false,
	OnLoaded = Signal.new()
}
local vipSubscriptionPrice = nil
function t.Init(config)
	cashDropEvent = config.Event
	eventManager = config.em
	local CashGui = ReplicatedStorage.StarterGui:FindFirstChild("CashGui")
	CashGui.Parent = LocalPlayer.PlayerGui
	t.Gui = CashGui
	t.IsOpen = CashGui.Enabled
	CashGui.Container.Content.ContainerCash.ContainerDonate.Drop.TextLabel.Text = Localization:FormatByKey("Cash.DropCash")
	t.Maid = Maid.new()
	Settings.OnProductsFetched:Connect(function()
		t.UpdatePrices()
		t.Loaded = true
		t.OnLoaded:Fire()
	end)
	CashGui.Container.Close.MouseButton1Down:Connect(t.Close)
	CashGui.Container.Content.ContainerTop.ContainerLeft.Cash.MouseButton1Down:Connect(t.OpenTabCash)
	CashGui.Container.Content.ContainerTop.ContainerLeft.Passes.MouseButton1Down:Connect(t.OpenTabPasses)
	CashGui.Container.Content.ContainerTop.ContainerLeft.GiftPasses.MouseButton1Down:Connect(function()
		if Settings.FetchedMarketplace then
			if not CashGui.Container.Content.ContainerGiftPasses.Visible then
				t.OpenTabGiftPasses()
			end
		end
	end)
	t.SetupCashDrop()
	task.spawn(function()
		local success, vipInfo = pcall(function()
			return MarketplaceService:GetSubscriptionProductInfoAsync(SubscriptionConsts.VIP.SUBSCRIPTION_ID)
		end)
		if success and vipInfo then
			vipSubscriptionPrice = vipInfo.PriceInRobux or 100
		end
	end)
end
function t.OpenTabCash()
	local Gui = t.Gui
	Gui.Container.Content.ContainerCash.Visible = true
	Gui.Container.Content.ContainerPasses.Visible = false
	Gui.Container.Content.ContainerTop.ContainerRight.ContainerCash.Visible = true
	Gui.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = lightGrayColor
	Gui.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = darkGrayColor
	t.Maid.Gifting = nil
	task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
		Volume = 0.15
	})
end
function t.OpenTabPasses()
	local Gui = t.Gui
	Gui.Container.Content.ContainerCash.Visible = false
	Gui.Container.Content.ContainerPasses.Visible = true
	Gui.Container.Content.ContainerTop.ContainerRight.ContainerCash.Visible = false
	Gui.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = darkGrayColor
	Gui.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = lightGrayColor
	t.Maid.Gifting = nil
	task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
		Volume = 0.15
	})
end
function t.OpenTabGiftPasses()
	local Gui = t.Gui
	Gui.Container.Content.ContainerCash.Visible = false
	Gui.Container.Content.ContainerPasses.Visible = false
	Gui.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = darkGrayColor
	Gui.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = darkGrayColor
	task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
		Volume = 0.15
	})
	t.SetupGiftingUI()
end
function t.SetCash(amount)
	t.Gui.Container.Content.ContainerTop.ContainerRight.ContainerCash.TextLabel.Text = Format.Currency(amount)
end
function t.SetupCashDrop()
	function eventManager.gkw6n126(errorInfo)
		local errorMessage = nil
		if errorInfo.NotEnoughMoney then
			errorMessage = "You don\'t have that much money."
		elseif errorInfo.InvalidWorld then
			errorMessage = "Cannot drop cash in current world."
		elseif errorInfo.TooLittleQuantity then
			errorMessage = ("Drop more than %s."):format(Format.Currency(errorInfo.TooLittleQuantity))
		elseif errorInfo.TooMuchQuantity then
			errorMessage = ("Drop less than %s."):format(Format.Currency(errorInfo.TooMuchQuantity))
		elseif errorInfo.Debounce then
			errorMessage = ("Wait %d seconds."):format(errorInfo.Debounce)
		elseif errorInfo.Daily then
			errorMessage = ("Can only donate %s per day."):format(Format.Currency(errorInfo.Quantity))
		elseif errorInfo.SmallVIP then
			errorMessage = "Donations disabled in small private servers."
		end
		if errorMessage then
			eventManager.mq92d5a8({
				Title = "Donation",
				Text = errorMessage
			})
		end
	end
	local ContainerDonate = t.Gui.Container.Content.ContainerCash.ContainerDonate
	local Amount = ContainerDonate.ContainerAmount.Amount
	Amount:GetPropertyChangedSignal("Text"):Connect(function()
		Amount.Text = Amount.Text:gsub("[^%d]+", "")
	end)
	ContainerDonate.Drop.MouseButton1Down:connect(function()
		task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
		local dropAmount = tonumber(Amount.Text)
		if dropAmount then
			cashDropEvent:FireServer("dropCash", dropAmount)
		end
	end)
	local CircleAction = UI.CircleAction
	local function Action(dropModel, isConfirmed)
		local targetDrop = dropModel.Part.Parent
		if isConfirmed then
			cashDropEvent:FireServer("grabCash", targetDrop)
			return true
		end
	end
	local function AddedFun(dropInstance)
		local Amount = dropInstance:WaitForChild("Amount", 2)
		local PlayerName = dropInstance:WaitForChild("PlayerName", 2)
		CircleAction.Add({
			Part = dropInstance.PrimaryPart,
			ValidRoot = dropInstance,
			Name = ("Collect %s from %s"):format(Format.Currency(Amount.Value), PlayerName.Value),
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action
		}, dropInstance)
	end
	local function RemovedFun(dropInstance)
		CircleAction.Remove(dropInstance)
	end
	for i, v in ipairs(CollectionService:GetTagged("CashDrop")) do
		AddedFun(v)
	end
	CollectionService:GetInstanceAddedSignal("CashDrop"):Connect(AddedFun)
	CollectionService:GetInstanceRemovedSignal("CashDrop"):Connect(RemovedFun)
end
local function TransformPassIntoOwned(container)
	container.Product.ContainerCost.Amount.Text = "OWNED"
	container.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
end
local function ClickVIPSubscription()
	t.Maid.Subscription = nil
	local subscriptionMaid = Maid.new()
	t.Maid.Subscription = subscriptionMaid
	local Gui = t.Gui
	local VIPSubscription = Gui.VIPSubscription
	local Container = Gui.Container
	Container.Visible = false
	VIPSubscription.Visible = true
	subscriptionMaid:GiveTask(function()
		VIPSubscription.Visible = false
		Container.Visible = true
	end)
	local VIP = GamepassUtils.EnumGamepass.VIP
	local vipGamepass = GamepassUtils.GetGamepassFromEnum(VIP)
	local isVIPOwned = false
	local isSubscriptionActive = false
	subscriptionMaid:GiveTask(VIPSubscription.Close.MouseButton1Down:Connect(function()
		task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
		subscriptionMaid:DoCleaning()
	end))
	subscriptionMaid:GiveTask(VIPSubscription.Container.Gamepass.MouseButton1Down:Connect(function()
		if not isVIPOwned then
			task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
			GamepassUtils.PromptGamepass(VIP)
		end
	end))
	subscriptionMaid:GiveTask(VIPSubscription.Container.Subscription.MouseButton1Down:Connect(function()
		if not (isVIPOwned or isSubscriptionActive) then
			task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
			MarketplaceService:PromptSubscriptionPurchase(LocalPlayer, SubscriptionConsts.VIP.SUBSCRIPTION_ID)
		end
	end))
	local function updateOwned()
		isVIPOwned = LocalPlayer:GetAttribute(SubscriptionConsts.VIP.LIFETIME_ATTR_NAME)
		isSubscriptionActive = LocalPlayer:GetAttribute(SubscriptionConsts.VIP.SUBSCRIPTION_ATTR_NAME)
		local robuxIcon = utf8.char(57346)
		local subscriptionPriceText = robuxIcon .. if vipSubscriptionPrice then Format.Comma(vipSubscriptionPrice) else "N/A"
		local gamepassPriceText = robuxIcon .. Format.Comma(vipGamepass.PriceInRobux)
		if isVIPOwned then
			VIPSubscription.Container.Gamepass.Text = "OWNED"
			VIPSubscription.Container.Gamepass.AutoButtonColor = false
			VIPSubscription.Container.Subscription.Text = "N/A"
			VIPSubscription.Container.Subscription.AutoButtonColor = false
		elseif isSubscriptionActive then
			VIPSubscription.Container.Gamepass.Text = gamepassPriceText
			VIPSubscription.Container.Gamepass.AutoButtonColor = true
			VIPSubscription.Container.Subscription.Text = "ACTIVE"
			VIPSubscription.Container.Subscription.AutoButtonColor = false
		else
			VIPSubscription.Container.Gamepass.Text = gamepassPriceText
			VIPSubscription.Container.Gamepass.AutoButtonColor = true
			VIPSubscription.Container.Subscription.Text = subscriptionPriceText
			VIPSubscription.Container.Subscription.AutoButtonColor = true
		end
	end
	updateOwned()
	subscriptionMaid:GiveTask(LocalPlayer:GetAttributeChangedSignal(SubscriptionConsts.VIP.SUBSCRIPTION_ATTR_NAME):Connect(updateOwned))
	subscriptionMaid:GiveTask(LocalPlayer:GetAttributeChangedSignal(SubscriptionConsts.VIP.LIFETIME_ATTR_NAME):Connect(updateOwned))
end
function t.UpdatePrices()
	local Gui = t.Gui
	local productsByIndex = {}
	for i, v in ipairs(Settings.DevProduct) do
		if v.Type == "Cash" then
			productsByIndex[v.Index] = v
		end
	end
	for i = 1, 5 do
		if productsByIndex[i] == nil then
			error(("Missing product frame: %d"):format(i))
		end
	end
	local ContainerProducts = Gui.Container.Content.ContainerCash.ContainerProducts
	for j = 1, 5 do
		local containerName = ("ContainerProduct%d"):format(j)
		local containerFrame = ContainerProducts:FindFirstChild(containerName)
		local productData = productsByIndex[j]
		containerFrame.Product.ContainerAmount.Amount.Text = Format.Currency(productData.Cash)
		containerFrame.Product.ContainerCost.Amount.Text = utf8.char(57346) .. Format.Comma(productData.Robux)
		if productData.ImageId then
			containerFrame.Product.ContainerCash.Cash.Image = ("rbxassetid://%d"):format(productData.ImageId)
		end
		t.Maid[containerName] = containerFrame.Product.MouseButton1Down:Connect(function()
			task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
			MarketplaceService:PromptProductPurchase(LocalPlayer, productData.Id)
		end)
	end
	local ContainerProducts_2 = Gui.Container.Content.ContainerPasses.ContainerProducts
	for i, v in ipairs(ContainerProducts_2:GetChildren()) do
		if v:IsA("Frame") and v.Name ~= "ContainerPreset" then
			v:Destroy()
		end
	end
	local ContainerPreset = ContainerProducts_2.ContainerPreset
	local count = 0
	for i, v in ipairs(GamepassData) do
		local isVIPPass, layoutOrder, priceDisplay
		if v.PriceInRobux and not v.HideFromUI then
			isVIPPass = v.Title == "VIP"
			local containerName = ("ContainerProduct%d_%s"):format(i, v.Title)
			local containerFrame = ContainerPreset:Clone()
			layoutOrder = if isVIPPass then -1 else i
			containerFrame.LayoutOrder = layoutOrder
			containerFrame.Name = containerName
			containerFrame.Product.ContainerTitle.Title.Text = v.DisplayName or v.Title
			GamepassSystem.promiseImageId(v.PassId):andThen(function(imageId)
				containerFrame.Product.ContainerImage.Thumbnail.Image = ("rbxassetid://%d"):format(imageId)
			end)
			priceDisplay = if isVIPPass then "VIEW" else utf8.char(57346) .. Format.Comma(v.PriceInRobux)
			containerFrame.Product.ContainerCost.Amount.Text = priceDisplay
			if isVIPPass then
				local UIScale = Instance.new("UIScale")
				UIScale.Scale = 1.1
				UIScale.Parent = containerFrame
				containerFrame.Product.ContainerImage.ImageTransparency = 1
				containerFrame.Product.ContainerCost.ImageColor3 = Color3.fromRGB(255, 255, 255)
				local ImageLabel = Instance.new("ImageLabel")
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.Image = "rbxassetid://10046133665"
				ImageLabel.ImageColor3 = Color3.fromRGB(255, 206, 29)
				ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel.Size = UDim2.fromScale(1.3, 1.3)
				ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
				ImageLabel.ZIndex = 0
				Instance.new("UIAspectRatioConstraint").Parent = ImageLabel
				ImageLabel.Parent = containerFrame
			end
			containerFrame.Visible = true
			containerFrame.Parent = ContainerPreset.Parent
			count = count + 1
			local gamepassEnum = GamepassUtils.EnumGamepass[v.Title]
			t.Maid[containerName] = containerFrame.Product.MouseButton1Down:Connect(function()
				if containerFrame.Product.ContainerCost.Amount.Text == "OWNED" then
					return
				end
				task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
				if isVIPPass then
					ClickVIPSubscription()
				else
					GamepassUtils.PromptPurchase(v)
				end
			end)
			if not isVIPPass and GamepassSystem.DoesPlayerOwn(gamepassEnum) then
				containerFrame.Product.ContainerCost.Amount.Text = "OWNED"
				containerFrame.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
			end
			if not isVIPPass then
				t.Maid[containerName .. "Owned"] = GamepassSystem.GetGamepassOwnedSignal(gamepassEnum):Connect(function()
					local updatingFrame = containerFrame
					updatingFrame.Product.ContainerCost.Amount.Text = "OWNED"
					updatingFrame.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
				end)
			end
			if v.Title == "DuffelBag" then
				if LocalPlayer:GetAttribute("EffectivelyDuffelBag") then
					containerFrame.Product.ContainerCost.Amount.Text = "OWNED"
					containerFrame.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
				else
					LocalPlayer:GetAttributeChangedSignal("EffectivelyDuffelBag"):Connect(function(...)
						if LocalPlayer:GetAttribute("EffectivelyDuffelBag") then
							local updatingFrame = containerFrame
							updatingFrame.Product.ContainerCost.Amount.Text = "OWNED"
							updatingFrame.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
						end
					end)
				end
			end
		end
	end
	ContainerProducts_2.UIGridLayout.CellSize = UDim2.new(1 / count - 0.0001, 0, 1, 0)
end
local GetGiftProductInfoFromGamepass = GamepassUtils.GetGiftProductInfoFromGamepass
function t.SetupGiftingUI()
	t.Maid.Gifting = nil
	t.Maid.Gifting = Maid.new()
	local Gui = t.Gui
	local ContainerGiftPasses = Gui.Container.Content.ContainerGiftPasses
	local ContainerProducts = ContainerGiftPasses.ContainerProducts
	local GiftContainer = ContainerGiftPasses.GiftContainer
	ContainerGiftPasses.Visible = true
	local function clearInputs()
		GiftContainer.ContainerIcon.Icon.Image = ""
		GiftContainer.ContainerPlayerName.Text = ""
	end
	Gui.Container.Content.ContainerTop.ContainerLeft.GiftPasses.BackgroundColor3 = Color3.fromRGB(242, 187, 56)
	t.Maid.Gifting:GiveTask(function()
		ContainerGiftPasses.Visible = false
		GiftContainer.Visible = false
		Gui.Container.Content.ContainerTop.ContainerLeft.GiftPasses.BackgroundColor3 = Color3.fromRGB(179, 138, 41)
		GiftContainer.ContainerIcon.Icon.Image = ""
		GiftContainer.ContainerPlayerName.Text = ""
	end)
	local ContainerPreset = ContainerProducts.ContainerPreset
	local selectedPassTitle = nil
	local count = 0
	for i, v in ipairs(GamepassData) do
		local giftProductInfo = GetGiftProductInfoFromGamepass(v.Title)
		if v.PriceInRobux and (not v.HideFromUI and (giftProductInfo and giftProductInfo.Robux)) then
			local containerName = ("ContainerProduct%d_%s"):format(i, v.Title)
			local containerFrame = ContainerPreset:Clone()
			containerFrame.LayoutOrder = i
			containerFrame.Name = containerName
			containerFrame.Product.ContainerTitle.Title.Text = v.DisplayName or v.Title
			containerFrame.Product.ContainerImage.Thumbnail.Image = ("rbxassetid://%d"):format(giftProductInfo.ImageId or 0)
			containerFrame.Product.ContainerCost.Amount.Text = utf8.char(57346) .. Format.Comma(giftProductInfo.Robux)
			containerFrame.Visible = true
			containerFrame.Parent = ContainerPreset.Parent
			t.Maid.Gifting[containerName] = containerFrame
			t.Maid.Gifting[containerName .. "Button"] = containerFrame.Product.MouseButton1Down:Connect(function()
				local isPlayerAllowedToGift = LocalPlayer:GetAttribute(GamepassUtils.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME)
				task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
				t.Maid.Gifting.Unselect = nil
				if selectedPassTitle == v.Title then
					selectedPassTitle = nil
					GiftContainer.Visible = false
				else
					selectedPassTitle = v.Title
					containerFrame.Product.ContainerImage.SelectedFrame.Visible = true
					t.Maid.Gifting.Unselect = function()
						if containerFrame.Parent then
							containerFrame.Product.ContainerImage.SelectedFrame.Visible = false
						end
					end
					GiftContainer.ContainerIcon.Icon.Image = ""
					GiftContainer.ContainerPlayerName.Text = ""
					GiftContainer.Visible = isPlayerAllowedToGift
				end
			end)
			count = count + 1
		end
	end
	GiftContainer.ContainerIcon.Icon.Image = ""
	GiftContainer.ContainerPlayerName.Text = ""
	t.Maid.Gifting:GiveTask(LocalPlayer:GetAttributeChangedSignal(GamepassUtils.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME):Connect(function()
		GiftContainer.Visible = LocalPlayer:GetAttribute(GamepassUtils.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME) and selectedPassTitle ~= nil
		return true
	end))
	t.Maid.Gifting:GiveTask(GiftContainer.PurchaseButton.MouseButton1Down:Connect(function()
		task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
		assert(selectedPassTitle ~= nil)
		assert(GetGiftProductInfoFromGamepass(selectedPassTitle) ~= nil)
		local giftRemote = ReplicatedStorage:FindFirstChild(GamepassUtils.GIFT_REMOTE_NAME)
		local targetPlayerName = GiftContainer.ContainerPlayerName.Text
		if #targetPlayerName ~= 0 then
			giftRemote:FireServer(Players:GetUserIdFromNameAsync(targetPlayerName), GamepassUtils.EnumGamepass[selectedPassTitle])
			GiftContainer.ContainerIcon.Icon.Image = ""
			GiftContainer.ContainerPlayerName.Text = ""
		end
	end))
	local textChangeCounter = 0
	t.Maid.Gifting:GiveTask(GiftContainer.ContainerPlayerName:GetPropertyChangedSignal("Text"):Connect(function()
		textChangeCounter = textChangeCounter + 1
		local targetPlayerName = GiftContainer.ContainerPlayerName.Text
		local userId = nil
		local lookupSuccess = pcall(function()
			userId = Players:GetUserIdFromNameAsync(targetPlayerName)
		end)
		local thumbnailUrl
		if lookupSuccess then
			local url, thumbnailSize = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
			lookupSuccess = thumbnailSize
			thumbnailUrl = url
		else
			thumbnailUrl = nil
		end
		if textChangeCounter ~= textChangeCounter then
			return false
		end
		GiftContainer.ContainerIcon.Icon.Image = if lookupSuccess and thumbnailUrl then thumbnailUrl else ""
	end))
end
function t.Open()
	assert(t.IsOpen == false)
	t.Gui.Enabled = true
	t.IsOpen = true
	t.OpenTabCash()
end
function t.Close()
	assert(t.IsOpen == true)
	t.Gui.Enabled = false
	t.IsOpen = false
	t.Maid.Gifting = nil
	t.Maid.Subscription = nil
	task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
		Volume = 0.15
	})
end
return t
