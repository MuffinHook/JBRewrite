local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
require(ReplicatedStorage.Gamepass.GamepassUtils)
local GunShopSystem = require(script.Parent.GunShopSystem)
local GunShopSlider = require(script.Parent.GunShopSlider)
local GunShopItem = require(script.Parent.GunShopItem)
local GunShopUtils = require(script.Parent.GunShopUtils)
local eventSignal = nil
local eventManager = nil
local function SelectIfGamepad(guiElement)
	EzUtils.selectIfGamepad(guiElement)
end
local GunShopUI = {
	maid = nil,
	currentSlider = nil
}
function GunShopUI.init(configData)
	eventSignal = configData.Event
	eventManager = configData.em
	local GunShopGui = ReplicatedStorage.StarterGui:FindFirstChild("GunShopGui")
	GunShopGui.Parent = LocalPlayer.PlayerGui
	GunShopUI.gui = GunShopGui
end
function GunShopUI.isOpen()
	return GunShopUI.maid ~= nil
end
function GunShopUI.open()
	assert(not GunShopUI.isOpen())
	local uiMaid = Maid.new()
	GunShopUI.maid = uiMaid
	local gui = GunShopUI.gui
	gui.Enabled = true
	uiMaid:GiveTask(function()
		gui.Enabled = false
	end)
	local Sidebar = gui.Container.Container.Sidebar
	local list = {}
	for i, v in ipairs(Sidebar:GetChildren()) do
		if v:IsA("ImageButton") then
			table.insert(list, v)
		end
	end
	local function onButtonClick(categoryButton)
		assert(categoryButton)
		for i, v in ipairs(list) do
			v.Image = "rbxassetid://5834230837"
		end
		categoryButton.Image = "rbxassetid://5834230671"
		local categoryName = categoryButton.Name
		local categoryData = GunShopUtils.getCategoryData(categoryName)
		if not categoryData then
			error(("No data for gun shop category: %s"):format(categoryName))
		end
		GunShopUI.displayList(categoryData)
	end
	for i, v in ipairs(list) do
		uiMaid:GiveTask(v.MouseButton1Down:Connect(function()
			onButtonClick(v)
		end))
	end
	onButtonClick(Sidebar.Held)
	EzUtils.selectIfGamepad(Sidebar.Held)
	uiMaid:GiveTask(gui.Container.Close.MouseButton1Down:Connect(function()
		GunShopUI.close()
	end))
end
function GunShopUI.displayList(itemList)
	local sliderInstance = GunShopSlider.new(itemList)
	GunShopUI.maid.currentSlider = sliderInstance
	sliderInstance:SetParent(GunShopUI.gui.Container.Container.Main.Container)
	for i, v in ipairs(itemList) do
		local shouldDisplay
		local itemName = v.Name
		local itemConfig = ItemSystem.GetConfig(itemName)
		if not itemConfig then
			error(("Missing item config for item: %s"):format(itemName))
		end
		if not itemConfig.Price then
			error(("Missing price data for item: %s"):format(itemName))
		end
		if not itemConfig.ImageId then
			error(("Missing image asset for item: %s"):format(itemName))
		end
		local isPlayerOwned = GunShopSystem.doesPlayerOwn(itemName)
		shouldDisplay = not itemConfig.ShopHidden or isPlayerOwned
		if shouldDisplay then
			local gunShopItem = GunShopItem.new()
			gunShopItem:SetName(itemName, GunShopUtils.getTranslatedTitleFromName(itemName))
			gunShopItem:SetPrice(itemConfig.Price)
			if not itemConfig.ImageId then
				error(("Missing image asset for item: %s"):format(itemName))
			end
			gunShopItem:SetImageId(itemConfig.ImageId)
			if itemConfig.ImageColor then
				gunShopItem:SetImageColor(itemConfig.ImageColor)
			end
			gunShopItem:SetLevel(itemConfig.Level)
			gunShopItem._maid:GiveTask(gunShopItem.onMouseButton1Down:Connect(function()
				if gunShopItem:GetEquipped() then
					eventSignal:FireServer("yhameqcz", itemName)
				elseif GunShopSystem.doesPlayerOwn(itemName) then
					eventSignal:FireServer("t2ley62p", itemName)
				else
					eventSignal:FireServer("tlcucis3", itemName)
				end
			end))
			if itemConfig.RequireAnyGamepass then
				for i2, gampassId in ipairs(itemConfig.RequireAnyGamepass) do
					gunShopItem:AddRequiredGamepass(gampassId)
				end
			end
			if isPlayerOwned then
				gunShopItem:SetOwned(true)
			end
			sliderInstance:AddItem(gunShopItem)
			gunShopItem:SetLayoutOrder((itemConfig.SortOrderPage or 0) * 100000 + itemConfig.Price * 10)
		end
	end
	sliderInstance._maid:GiveTask(GunShopSystem.onAnyOwned:Connect(function(ownedItemName)
		for i, v in ipairs(sliderInstance._listItem) do
			if v:GetName() == ownedItemName then
				v:SetOwned(true)
				return
			end
		end
	end))
	local function handleInventoryItemAdded(inventoryItem)
		if inventoryItem:GetOwner() == LocalPlayer then
			for i, v in ipairs(sliderInstance._listItem) do
				if v:GetName() == inventoryItem:GetName() then
					v:SetEquipped(true)
					return
				end
			end
		end
	end
	local function handleInventoryItemRemoved(inventoryItem)
		if inventoryItem:GetOwner() == LocalPlayer then
			for i, v in ipairs(sliderInstance._listItem) do
				if v:GetName() == inventoryItem:GetName() then
					v:SetEquipped(false)
					return
				end
			end
		end
	end
	sliderInstance._maid:GiveTask(InventoryItemBinder:GetClassAddedSignal():Connect(handleInventoryItemAdded))
	for i, v in ipairs(InventoryItemBinder:GetAll()) do
		handleInventoryItemAdded(v)
	end
	sliderInstance._maid:GiveTask(InventoryItemBinder:GetClassRemovingSignal():Connect(handleInventoryItemRemoved))
end
function GunShopUI.close()
	assert(GunShopUI.isOpen())
	local maid = GunShopUI.maid
	GunShopUI.maid = nil
	maid:Destroy()
end
return GunShopUI
