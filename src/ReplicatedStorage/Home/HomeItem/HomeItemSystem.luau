local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BigButtonService = require(ReplicatedStorage.App.BigButtonService)
local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
local HomeConsts = require(ReplicatedStorage.Home.HomeConsts)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local HomeApp = require(ReplicatedStorage.Home.UI.HomeApp)
local homeStore = require(ReplicatedStorage.Home.homeStore)
require(ReplicatedStorage.Module.Confirmation)
require(ReplicatedStorage.Module.Format)
local Audio = require(ReplicatedStorage.Std.Audio)
local Utils = require(ReplicatedStorage.EzUi.Utils)
local Interval = require(ReplicatedStorage.Std.Interval)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local HomeItemBinder = require(script.Parent.HomeItemBinder)
local HomeSystem = require(script.Parent.Parent.HomeSystem)
local HomeItemConsts = require(script.Parent.HomeItemConsts)
local HomeItemSystem = {
	_inventory = {},
	_maid = Maid.new(),
	onCustomizeStarted = Signal.new(),
	onCustomizeEnded = Signal.new(),
	onAttemptPlaceItem = Signal.new(),
	onAttemptDeleteItem = Signal.new()
}
function HomeItemSystem.init()
	HomeItemBinder:Start()
	local screenGuiProps = {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 8
	}
	local roactChildren = {}
	local uiTree = {}
	local homeFrameProps = {
		BackgroundTransparency = 1
	}
	homeFrameProps.Size = if Utils.isSmallScreen() then UDim2.fromScale(0.7, 0.5) else UDim2.fromScale(0.6, 0.5)
	homeFrameProps.Position = UDim2.fromScale(0.5, 0.08)
	homeFrameProps.AnchorPoint = Vector2.new(0.5, 0)
	uiTree.HomeContainer = createElement("Frame", homeFrameProps, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = 3
		}),
		HomeApp = createElement(HomeApp, {
			aspectRatio = 3,
			verticalPaddingRatio = 128,
			attemptPlaceItem = function(self)
				if self.module == "HomeItem" then
					HomeItemSystem.onAttemptPlaceItem:Fire(self)
				else
					HomeItemSystem.attemptEquip(self.module, self.name)
				end
			end,
			attemptPreviewItem = function(self)
				HomeItemSystem.attemptPreview(self.module, self.name)
			end,
			attemptPurchaseItem = function(self)
				HomeItemSystem.attemptPurchase(self.module, self.name)
			end,
			attemptDeleteItem = function()
				HomeItemSystem.onAttemptDeleteItem:Fire()
			end,
			promptCashPurchase = function()
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
				CashBuyUI.Open()
			end,
			onSettingChanged = function(self, settingValue)
				HomeSystem.queryCurrentStandingHome():SetSavedSetting(self, settingValue)
			end,
			exit = function()
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
				local currentHome = HomeSystem.queryCurrentStandingHome()
				if currentHome then
					currentHome:ReplicateCustomizing(false)
					HomeItemSystem.onCustomizeEnded:Fire(currentHome)
				end
			end
		})
	})
	roactChildren[1] = Roact.createElement(RoactRodux.StoreProvider, {
		store = homeStore
	}, uiTree)
	local homeItemGui = Roact.mount(createElement("ScreenGui", screenGuiProps, roactChildren), Players.LocalPlayer.PlayerGui, "HomeItemGui")
	HomeItemSystem._maid:GiveTask(function()
		Roact.unmount(homeItemGui)
	end)
	local bigButtonConfig = {
		name = "Home",
		imageId = 13218368809,
		displayOrder = 100,
		enabled = false,
		onClick = function()
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
					Volume = 0.2
				})
			end
			local isVisible = not homeStore:getState().visible
			homeStore:dispatch({
				type = "setVisible",
				value = isVisible
			})
			local currentHome = HomeSystem.queryCurrentStandingHome()
			if currentHome then
				currentHome:ReplicateCustomizing(isVisible)
				if isVisible then
					HomeItemSystem.onCustomizeStarted:Fire()
					return
				end
				HomeItemSystem.onCustomizeEnded:Fire(currentHome)
			end
		end
	}
	BigButtonService.add(bigButtonConfig)
	local function updateButtonVisibility(home)
		local currentHome = HomeSystem.queryCurrentStandingHome()
		local canEdit = (currentHome and currentHome:HasPermissionToEdit(Players.LocalPlayer)) == true
		local isCurrentlyEnabled = bigButtonConfig.enabled
		if canEdit ~= isCurrentlyEnabled then
			bigButtonConfig.enabled = canEdit
			BigButtonService.triggerUpdate:Fire()
			if isCurrentlyEnabled and not canEdit then
				home:ReplicateCustomizing(false)
				HomeItemSystem.onCustomizeEnded:Fire(home)
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
			end
		end
	end
	local updateMaid = Maid.new()
	HomeSystem.onEntered:Connect(function(home)
		updateMaid:DoCleaning()
		updateButtonVisibility(home)
		updateMaid:GiveTask(Interval.every(1):Connect(function()
			updateButtonVisibility(home)
		end))
	end)
	HomeSystem.onExited:Connect(function(home)
		updateMaid:DoCleaning()
		updateButtonVisibility(home)
	end)
	HomeSystem.onEntered:Connect(function(home)
		homeStore:dispatch({
			type = "setHome",
			value = home
		})
	end)
	HomeSystem.onExited:Connect(function()
		homeStore:dispatch({
			type = "setHome",
			value = nil
		})
	end)
	HomeItemSystem.onCustomizeEnded:Connect(function(home)
		HomeItemSystem.resetHomeCustomizationToEquipped(home)
	end)
	HomeSystem.onEntered:Connect(function(home)
		RxInstanceUtils.observeChildren(home._obj:FindFirstChild(HomeConsts.SETTINGS_FOLDER_NAME), function(settingInstance, settingMaid)
			local function update()
				homeStore:dispatch({
					type = "setSavedSetting",
					key = settingInstance.Name,
					value = settingInstance.Value
				})
			end
			homeStore:dispatch({
				type = "setSavedSetting",
				key = settingInstance.Name,
				value = settingInstance.Value
			})
			settingMaid:GiveTask(settingInstance:GetPropertyChangedSignal("Value"):Connect(update))
		end)
	end)
	waitForChild(ReplicatedStorage, HomeItemConsts.UPDATE_INVENTORY_REMOTE_NAME):andThen(function(inventoryRemote)
		inventoryRemote.OnClientEvent:Connect(function(inventory)
			homeStore:dispatch({
				type = "setInventory",
				value = inventory
			})
		end)
	end):catch(warn)
	waitForChild(ReplicatedStorage, HomeItemConsts.UPDATE_EQUIPPED_REMOTE_NAME):andThen(function(equippedRemote)
		equippedRemote.OnClientEvent:Connect(function(equipped)
			homeStore:dispatch({
				type = "setEquipped",
				value = equipped
			})
		end)
	end):catch(warn)
	local function updateQuantityPlaced()
		homeStore:dispatch({
			type = "setQuantityPlaced",
			value = HomeItemSystem.getQuantityPlaced(Players.LocalPlayer)
		})
	end
	homeStore:dispatch({
		type = "setQuantityPlaced",
		value = HomeItemSystem.getQuantityPlaced(Players.LocalPlayer)
	})
	HomeItemBinder:GetClassAddedSignal():Connect(function(homeItem)
		homeStore:dispatch({
			type = "setQuantityPlaced",
			value = HomeItemSystem.getQuantityPlaced(Players.LocalPlayer)
		})
		homeItem._maid:GiveTask(updateQuantityPlaced)
	end)
end
function HomeItemSystem.getQuantityPlaced(player)
	assert(player ~= nil)
	local quantityTable = {}
	for i, homeItem in ipairs(HomeItemBinder:GetAll()) do
		if homeItem:GetOwner() == player then
			local itemName = homeItem._obj.Name
			quantityTable[itemName] = (quantityTable[itemName] or 0) + 1
		end
	end
	return quantityTable
end
function HomeItemSystem.attemptPurchase(moduleName, itemName)
	ReplicatedStorage:FindFirstChild(HomeItemConsts.PURCHASE_HOME_ITEM_REMOTE_NAME):FireServer(moduleName, itemName)
end
local function getItem(collection, itemName)
	for key, item in collection do
		if item.Name == itemName then
			return item
		end
	end
	return nil
end
function HomeItemSystem.attemptEquip(moduleName, itemName)
	ReplicatedStorage:FindFirstChild(HomeItemConsts.EQUIP_HOME_ITEM_REMOTE_NAME):FireServer(moduleName, itemName)
end
function HomeItemSystem.attemptPreview(moduleName, itemName)
	assert(itemName, "itemName is nil")
	assert(moduleName, "moduleName is nil for itemName: " .. tostring(itemName))
	local moduleFolder = ReplicatedStorage.Home.HomeData:FindFirstChild(moduleName)
	if moduleFolder then
		assert(moduleFolder, "Module path does not exist")
		local moduleScript = require(moduleFolder)
		assert(moduleScript.getItems ~= nil, "Module does not have a getItems function")
		assert(moduleScript.apply ~= nil, "Module does not have an apply function")
		local foundItem = nil
		for key, item in moduleScript.getItems() do
			if item.Name == itemName then
				foundItem = item
				break
			end
		end
		assert(foundItem ~= nil, "Item does not exist")
		moduleScript.apply(foundItem, HomeSystem.queryCurrentStandingHome():GetObj())
	end
end
function HomeItemSystem.resetHomeCustomizationToEquipped(home)
	local equipped = homeStore:getState().equipped
	for key, moduleFolder in ReplicatedStorage.Home.HomeData:GetChildren() do
		local hasGetItems, hasApply
		assert(moduleFolder, "Module path does not exist")
		local moduleScript = require(moduleFolder)
		local equippedItemName = equipped[moduleFolder.Name]
		hasGetItems = moduleScript.getItems ~= nil
		assert(hasGetItems, "Module does not have a getItems function")
		hasApply = moduleScript.apply ~= nil
		assert(hasApply, "Module does not have an apply function")
		local itemToApply = nil
		for key, item in moduleScript.getItems() do
			if item.Name == equippedItemName then
				itemToApply = item
				break
			end
		end
		moduleScript.apply(itemToApply, home:GetObj())
	end
end
function HomeItemSystem.isCustomizing()
	return homeStore:getState().visible
end
return HomeItemSystem
