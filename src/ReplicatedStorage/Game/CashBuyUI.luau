-- Reviewed by Claude
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
local v1 = nil
local v2 = nil
local v3 = Color3.fromRGB(87, 87, 87)
local v4 = Color3.fromRGB(138, 138, 138)
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
local v5 = nil
function t.Init(p1)
	v1 = p1.Event
	v2 = p1.em
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
		local v1, v2 = pcall(function()
			return MarketplaceService:GetSubscriptionProductInfoAsync(SubscriptionConsts.VIP.SUBSCRIPTION_ID)
		end)
		if v1 and v2 then
			v5 = v2.PriceInRobux or 100
		end
	end)
end
function t.OpenTabCash()
	local Gui = t.Gui
	Gui.Container.Content.ContainerCash.Visible = true
	Gui.Container.Content.ContainerPasses.Visible = false
	Gui.Container.Content.ContainerTop.ContainerRight.ContainerCash.Visible = true
	Gui.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = v4
	Gui.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = v3
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
	Gui.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = v3
	Gui.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = v4
	t.Maid.Gifting = nil
	task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
		Volume = 0.15
	})
end
function t.OpenTabGiftPasses()
	local Gui = t.Gui
	Gui.Container.Content.ContainerCash.Visible = false
	Gui.Container.Content.ContainerPasses.Visible = false
	Gui.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = v3
	Gui.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = v3
	task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
		Volume = 0.15
	})
	t.SetupGiftingUI()
end
function t.SetCash(p1)
	t.Gui.Container.Content.ContainerTop.ContainerRight.ContainerCash.TextLabel.Text = Format.Currency(p1)
end
function t.SetupCashDrop()
	function v2.gkw6n126(p1)
		local v1 = nil
		if p1.NotEnoughMoney then
			v1 = "You don\'t have that much money."
		elseif p1.InvalidWorld then
			v1 = "Cannot drop cash in current world."
		elseif p1.TooLittleQuantity then
			v1 = ("Drop more than %s."):format(Format.Currency(p1.TooLittleQuantity))
		elseif p1.TooMuchQuantity then
			v1 = ("Drop less than %s."):format(Format.Currency(p1.TooMuchQuantity))
		elseif p1.Debounce then
			v1 = ("Wait %d seconds."):format(p1.Debounce)
		elseif p1.Daily then
			v1 = ("Can only donate %s per day."):format(Format.Currency(p1.Quantity))
		elseif p1.SmallVIP then
			v1 = "Donations disabled in small private servers."
		end
		if v1 then
			v2.mq92d5a8({
				Title = "Donation",
				Text = v1
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
		local v12 = tonumber(Amount.Text)
		if v12 then
			v1:FireServer("h" .. ("b4xm"):sub(2, 2):reverse() .. "ogv4dl", v12)
		end
	end)
	local CircleAction = UI.CircleAction
	local function Action(p1, p2)
		local v12 = p1.Part.Parent
		if p2 then
			v1:FireServer("x" .. ("jqs2gh59"):sub(3, 4):reverse():reverse():reverse() .. "" .. "" .. ("y1mga"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("mpcvuogh5"):sub(5, 7):reverse():reverse():reverse():reverse():reverse() .. "q", v12)
			return true
		end
	end
	local function AddedFun(p1)
		local Amount = p1:WaitForChild("Amount", 2)
		local PlayerName = p1:WaitForChild("PlayerName", 2)
		CircleAction.Add({
			Part = p1.PrimaryPart,
			ValidRoot = p1,
			Name = ("Collect %s from %s"):format(Format.Currency(Amount.Value), PlayerName.Value),
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action
		}, p1)
	end
	local function RemovedFun(p1)
		CircleAction.Remove(p1)
	end
	for i, v in ipairs(CollectionService:GetTagged("CashDrop")) do
		AddedFun(v)
	end
	CollectionService:GetInstanceAddedSignal("CashDrop"):Connect(AddedFun)
	CollectionService:GetInstanceRemovedSignal("CashDrop"):Connect(RemovedFun)
end
local function TransformPassIntoOwned(p1)
	p1.Product.ContainerCost.Amount.Text = "OWNED"
	p1.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
end
local function ClickVIPSubscription()
	t.Maid.Subscription = nil
	local v1 = Maid.new()
	t.Maid.Subscription = v1
	local Gui = t.Gui
	local VIPSubscription = Gui.VIPSubscription
	local Container = Gui.Container
	Container.Visible = false
	VIPSubscription.Visible = true
	v1:GiveTask(function()
		VIPSubscription.Visible = false
		Container.Visible = true
	end)
	local VIP = GamepassUtils.EnumGamepass.VIP
	local v2 = GamepassUtils.GetGamepassFromEnum(VIP)
	local v3 = false
	local v4 = false
	v1:GiveTask(VIPSubscription.Close.MouseButton1Down:Connect(function()
		task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
		v1:DoCleaning()
	end))
	v1:GiveTask(VIPSubscription.Container.Gamepass.MouseButton1Down:Connect(function()
		if not v3 then
			task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
			GamepassUtils.PromptGamepass(VIP)
		end
	end))
	v1:GiveTask(VIPSubscription.Container.Subscription.MouseButton1Down:Connect(function()
		if not (v3 or v4) then
			task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
			MarketplaceService:PromptSubscriptionPurchase(LocalPlayer, SubscriptionConsts.VIP.SUBSCRIPTION_ID)
		end
	end))
	local function updateOwned()
		v3 = LocalPlayer:GetAttribute(SubscriptionConsts.VIP.LIFETIME_ATTR_NAME)
		v4 = LocalPlayer:GetAttribute(SubscriptionConsts.VIP.SUBSCRIPTION_ATTR_NAME)
		local v1 = utf8.char(57346)
		local v32 = v1 .. if v5 then Format.Comma(v5) else "N/A"
		local v42 = utf8.char(57346) .. Format.Comma(v2.PriceInRobux)
		if v3 then
			VIPSubscription.Container.Gamepass.Text = "OWNED"
			VIPSubscription.Container.Gamepass.AutoButtonColor = false
			VIPSubscription.Container.Subscription.Text = "N/A"
			VIPSubscription.Container.Subscription.AutoButtonColor = false
		elseif v4 then
			VIPSubscription.Container.Gamepass.Text = v42
			VIPSubscription.Container.Gamepass.AutoButtonColor = true
			VIPSubscription.Container.Subscription.Text = "ACTIVE"
			VIPSubscription.Container.Subscription.AutoButtonColor = false
		else
			VIPSubscription.Container.Gamepass.Text = v42
			VIPSubscription.Container.Gamepass.AutoButtonColor = true
			VIPSubscription.Container.Subscription.Text = v32
			VIPSubscription.Container.Subscription.AutoButtonColor = true
		end
	end
	updateOwned()
	v1:GiveTask(LocalPlayer:GetAttributeChangedSignal(SubscriptionConsts.VIP.SUBSCRIPTION_ATTR_NAME):Connect(updateOwned))
	v1:GiveTask(LocalPlayer:GetAttributeChangedSignal(SubscriptionConsts.VIP.LIFETIME_ATTR_NAME):Connect(updateOwned))
end
function t.UpdatePrices()
	local Gui = t.Gui
	local t2 = {}
	for i, v in ipairs(Settings.DevProduct) do
		if v.Type == "Cash" then
			t2[v.Index] = v
		end
	end
	for i = 1, 5 do
		if t2[i] == nil then
			error(("Missing product frame: %d"):format(i))
		end
	end
	local ContainerProducts = Gui.Container.Content.ContainerCash.ContainerProducts
	for j = 1, 5 do
		local v1 = ("ContainerProduct%d"):format(j)
		local v2 = ContainerProducts:FindFirstChild(v1)
		local v3 = t2[j]
		v2.Product.ContainerAmount.Amount.Text = Format.Currency(v3.Cash)
		v2.Product.ContainerCost.Amount.Text = utf8.char(57346) .. Format.Comma(v3.Robux)
		if v3.ImageId then
			v2.Product.ContainerCash.Cash.Image = ("rbxassetid://%d"):format(v3.ImageId)
		end
		t.Maid[v1] = v2.Product.MouseButton1Down:Connect(function()
			task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
			MarketplaceService:PromptProductPurchase(LocalPlayer, v3.Id)
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
		local v4, v5, v6
		if v.PriceInRobux and not v.HideFromUI then
			v4 = v.Title == "VIP"
			local v7 = ("ContainerProduct%d_%s"):format(i, v.Title)
			local v8 = ContainerPreset:Clone()
			v5 = if v4 then -1 else i
			v8.LayoutOrder = v5
			v8.Name = v7
			v8.Product.ContainerTitle.Title.Text = v.DisplayName or v.Title
			GamepassSystem.promiseImageId(v.PassId):andThen(function(p1)
				v8.Product.ContainerImage.Thumbnail.Image = ("rbxassetid://%d"):format(p1)
			end)
			v6 = if v4 then "VIEW" else utf8.char(57346) .. Format.Comma(v.PriceInRobux)
			v8.Product.ContainerCost.Amount.Text = v6
			if v4 then
				local UIScale = Instance.new("UIScale")
				UIScale.Scale = 1.1
				UIScale.Parent = v8
				v8.Product.ContainerImage.ImageTransparency = 1
				v8.Product.ContainerCost.ImageColor3 = Color3.fromRGB(255, 255, 255)
				local ImageLabel = Instance.new("ImageLabel")
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.Image = "rbxassetid://10046133665"
				ImageLabel.ImageColor3 = Color3.fromRGB(255, 206, 29)
				ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel.Size = UDim2.fromScale(1.3, 1.3)
				ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
				ImageLabel.ZIndex = 0
				Instance.new("UIAspectRatioConstraint").Parent = ImageLabel
				ImageLabel.Parent = v8
			end
			v8.Visible = true
			v8.Parent = ContainerPreset.Parent
			count = count + 1
			local v10 = GamepassUtils.EnumGamepass[v.Title]
			t.Maid[v7] = v8.Product.MouseButton1Down:Connect(function()
				if v8.Product.ContainerCost.Amount.Text == "OWNED" then
					return
				end
				task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
				if v4 then
					ClickVIPSubscription()
				else
					GamepassUtils.PromptPurchase(v)
				end
			end)
			if not v4 and GamepassSystem.DoesPlayerOwn(v10) then
				v8.Product.ContainerCost.Amount.Text = "OWNED"
				v8.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
			end
			if not v4 then
				t.Maid[v7 .. "Owned"] = GamepassSystem.GetGamepassOwnedSignal(v10):Connect(function()
					local v1 = v8
					v1.Product.ContainerCost.Amount.Text = "OWNED"
					v1.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
				end)
			end
			if v.Title == "DuffelBag" then
				if LocalPlayer:GetAttribute("EffectivelyDuffelBag") then
					v8.Product.ContainerCost.Amount.Text = "OWNED"
					v8.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
				else
					LocalPlayer:GetAttributeChangedSignal("EffectivelyDuffelBag"):Connect(function(...)
						if LocalPlayer:GetAttribute("EffectivelyDuffelBag") then
							local v1 = v8
							v1.Product.ContainerCost.Amount.Text = "OWNED"
							v1.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
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
	local v1 = nil
	local count = 0
	for i, v in ipairs(GamepassData) do
		local v2 = GetGiftProductInfoFromGamepass(v.Title)
		if v.PriceInRobux and (not v.HideFromUI and (v2 and v2.Robux)) then
			local v3 = ("ContainerProduct%d_%s"):format(i, v.Title)
			local v4 = ContainerPreset:Clone()
			v4.LayoutOrder = i
			v4.Name = v3
			v4.Product.ContainerTitle.Title.Text = v.DisplayName or v.Title
			v4.Product.ContainerImage.Thumbnail.Image = ("rbxassetid://%d"):format(v2.ImageId or 0)
			v4.Product.ContainerCost.Amount.Text = utf8.char(57346) .. Format.Comma(v2.Robux)
			v4.Visible = true
			v4.Parent = ContainerPreset.Parent
			t.Maid.Gifting[v3] = v4
			t.Maid.Gifting[v3 .. "Button"] = v4.Product.MouseButton1Down:Connect(function()
				local v12 = LocalPlayer:GetAttribute(GamepassUtils.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME)
				task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
				t.Maid.Gifting.Unselect = nil
				if v1 == v.Title then
					v1 = nil
					GiftContainer.Visible = false
				else
					v1 = v.Title
					v4.Product.ContainerImage.SelectedFrame.Visible = true
					t.Maid.Gifting.Unselect = function()
						if v4.Parent then
							v4.Product.ContainerImage.SelectedFrame.Visible = false
						end
					end
					GiftContainer.ContainerIcon.Icon.Image = ""
					GiftContainer.ContainerPlayerName.Text = ""
					GiftContainer.Visible = v12
				end
			end)
			count = count + 1
		end
	end
	GiftContainer.ContainerIcon.Icon.Image = ""
	GiftContainer.ContainerPlayerName.Text = ""
	t.Maid.Gifting:GiveTask(LocalPlayer:GetAttributeChangedSignal(GamepassUtils.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME):Connect(function()
		GiftContainer.Visible = LocalPlayer:GetAttribute(GamepassUtils.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME) and v1 ~= nil
		return true
	end))
	t.Maid.Gifting:GiveTask(GiftContainer.PurchaseButton.MouseButton1Down:Connect(function()
		task.spawn(Audio.ObjectLocal, LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
		assert(v1 ~= nil)
		assert(GetGiftProductInfoFromGamepass(v1) ~= nil)
		local v3 = ReplicatedStorage:FindFirstChild(GamepassUtils.GIFT_REMOTE_NAME)
		local Text = GiftContainer.ContainerPlayerName.Text
		if #Text ~= 0 then
			v3:FireServer(Players:GetUserIdFromNameAsync(Text), GamepassUtils.EnumGamepass[v1])
			GiftContainer.ContainerIcon.Icon.Image = ""
			GiftContainer.ContainerPlayerName.Text = ""
		end
	end))
	local v6 = 0
	t.Maid.Gifting:GiveTask(GiftContainer.ContainerPlayerName:GetPropertyChangedSignal("Text"):Connect(function()
		v6 = v6 + 1
		local Text = GiftContainer.ContainerPlayerName.Text
		local v2 = nil
		local v3 = pcall(function()
			v2 = Players:GetUserIdFromNameAsync(Text)
		end)
		local v4
		if v3 then
			local v5, v62 = Players:GetUserThumbnailAsync(v2, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
			v3 = v62
			v4 = v5
		else
			v4 = nil
		end
		if v6 ~= v6 then
			return false
		end
		GiftContainer.ContainerIcon.Icon.Image = if v3 and v4 then v4 else ""
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
