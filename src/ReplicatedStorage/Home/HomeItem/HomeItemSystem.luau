-- Reviewed by Claude
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
local t = {
	_inventory = {},
	_maid = Maid.new(),
	onCustomizeStarted = Signal.new(),
	onCustomizeEnded = Signal.new(),
	onAttemptPlaceItem = Signal.new(),
	onAttemptDeleteItem = Signal.new()
}
function t.init()
	HomeItemBinder:Start()
	local t2 = {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 8
	}
	local t3 = {}
	local t5 = {}
	local t6 = {
		BackgroundTransparency = 1
	}
	t6.Size = if Utils.isSmallScreen() then UDim2.fromScale(0.7, 0.5) else UDim2.fromScale(0.6, 0.5)
	t6.Position = UDim2.fromScale(0.5, 0.08)
	t6.AnchorPoint = Vector2.new(0.5, 0)
	t5.HomeContainer = createElement("Frame", t6, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = 3
		}),
		HomeApp = createElement(HomeApp, {
			aspectRatio = 3,
			verticalPaddingRatio = 128,
			attemptPlaceItem = function(self)
				if self.module == "HomeItem" then
					t.onAttemptPlaceItem:Fire(self)
				else
					t.attemptEquip(self.module, self.name)
				end
			end,
			attemptPreviewItem = function(self)
				t.attemptPreview(self.module, self.name)
			end,
			attemptPurchaseItem = function(self)
				t.attemptPurchase(self.module, self.name)
			end,
			attemptDeleteItem = function()
				t.onAttemptDeleteItem:Fire()
			end,
			promptCashPurchase = function()
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
				CashBuyUI.Open()
			end,
			onSettingChanged = function(self, p2)
				HomeSystem.queryCurrentStandingHome():SetSavedSetting(self, p2)
			end,
			exit = function()
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
				local v1 = HomeSystem.queryCurrentStandingHome()
				if v1 then
					v1:ReplicateCustomizing(false)
					t.onCustomizeEnded:Fire(v1)
				end
			end
		})
	})
	t3[1] = Roact.createElement(RoactRodux.StoreProvider, {
		store = homeStore
	}, t5)
	local localPlayer = Roact.mount(createElement("ScreenGui", t2, t3), Players.LocalPlayer.PlayerGui, "HomeItemGui")
	t._maid:GiveTask(function()
		Roact.unmount(localPlayer)
	end)
	local t7 = {
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
			local v1 = not homeStore:getState().visible
			homeStore:dispatch({
				type = "setVisible",
				value = v1
			})
			local v2 = HomeSystem.queryCurrentStandingHome()
			if v2 then
				v2:ReplicateCustomizing(v1)
				if v1 then
					t.onCustomizeStarted:Fire()
					return
				end
				t.onCustomizeEnded:Fire(v2)
			end
		end
	}
	BigButtonService.add(t7)
	local function updateButtonVisibility(self)
		local v1 = HomeSystem.queryCurrentStandingHome()
		local localPlayer = (v1 and v1:HasPermissionToEdit(Players.LocalPlayer)) == true
		local enabled = t7.enabled
		if localPlayer ~= enabled then
			t7.enabled = localPlayer
			BigButtonService.triggerUpdate:Fire()
			if enabled and not localPlayer then
				self:ReplicateCustomizing(false)
				t.onCustomizeEnded:Fire(self)
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
			end
		end
	end
	local instance7 = Maid.new()
	HomeSystem.onEntered:Connect(function(self)
		instance7:DoCleaning()
		updateButtonVisibility(self)
		instance7:GiveTask(Interval.every(1):Connect(function()
			updateButtonVisibility(self)
		end))
	end)
	HomeSystem.onExited:Connect(function(self)
		instance7:DoCleaning()
		updateButtonVisibility(self)
	end)
	HomeSystem.onEntered:Connect(function(self)
		homeStore:dispatch({
			type = "setHome",
			value = self
		})
	end)
	HomeSystem.onExited:Connect(function()
		homeStore:dispatch({
			type = "setHome",
			value = nil
		})
	end)
	t.onCustomizeEnded:Connect(function(self)
		t.resetHomeCustomizationToEquipped(self)
	end)
	HomeSystem.onEntered:Connect(function(self)
		RxInstanceUtils.observeChildren(self._obj:FindFirstChild(HomeConsts.SETTINGS_FOLDER_NAME), function(self, p2)
			local function update()
				homeStore:dispatch({
					type = "setSavedSetting",
					key = self.Name,
					value = self.Value
				})
			end
			homeStore:dispatch({
				type = "setSavedSetting",
				key = self.Name,
				value = self.Value
			})
			p2:GiveTask(self:GetPropertyChangedSignal("Value"):Connect(update))
		end)
	end)
	waitForChild(ReplicatedStorage, HomeItemConsts.UPDATE_INVENTORY_REMOTE_NAME):andThen(function(self)
		self.OnClientEvent:Connect(function(self)
			homeStore:dispatch({
				type = "setInventory",
				value = self
			})
		end)
	end):catch(warn)
	waitForChild(ReplicatedStorage, HomeItemConsts.UPDATE_EQUIPPED_REMOTE_NAME):andThen(function(self)
		self.OnClientEvent:Connect(function(self)
			homeStore:dispatch({
				type = "setEquipped",
				value = self
			})
		end)
	end):catch(warn)
	local function updateQuantityPlaced()
		homeStore:dispatch({
			type = "setQuantityPlaced",
			value = t.getQuantityPlaced(Players.LocalPlayer)
		})
	end
	homeStore:dispatch({
		type = "setQuantityPlaced",
		value = t.getQuantityPlaced(Players.LocalPlayer)
	})
	HomeItemBinder:GetClassAddedSignal():Connect(function(self)
		homeStore:dispatch({
			type = "setQuantityPlaced",
			value = t.getQuantityPlaced(Players.LocalPlayer)
		})
		self._maid:GiveTask(updateQuantityPlaced)
	end)
end
function t.getQuantityPlaced(self)
	assert(self ~= nil)
	local t = {}
	for i, v in ipairs(HomeItemBinder:GetAll()) do
		if v:GetOwner() == self then
			local v2 = v._obj.Name
			t[v2] = (t[v2] or 0) + 1
		end
	end
	return t
end
function t.attemptPurchase(self, p2)
	ReplicatedStorage:FindFirstChild(HomeItemConsts.PURCHASE_HOME_ITEM_REMOTE_NAME):FireServer(self, p2)
end
local function getItem(self, p2)
	for v1, v2 in self do
		if v2.Name == p2 then
			return v2
		end
	end
	return nil
end
function t.attemptEquip(self, p2)
	ReplicatedStorage:FindFirstChild(HomeItemConsts.EQUIP_HOME_ITEM_REMOTE_NAME):FireServer(self, p2)
end
function t.attemptPreview(self, p2)
	assert(p2, "itemName is nil")
	assert(self, "moduleName is nil for itemName: " .. tostring(p2))
	local v2 = ReplicatedStorage.Home.HomeData:FindFirstChild(self)
	if v2 then
		assert(v2, "Module path does not exist")
		local localPlayer = require(v2)
		assert(localPlayer.getItems ~= nil, "Module does not have a getItems function")
		assert(localPlayer.apply ~= nil, "Module does not have an apply function")
		local var5 = nil
		for localPlayer, instance7 in localPlayer.getItems() do
			if instance7.Name == p2 then
				var5 = instance7
				break
			end
		end
		assert(var5 ~= nil, "Item does not exist")
		localPlayer.apply(var5, HomeSystem.queryCurrentStandingHome():GetObj())
	end
end
function t.resetHomeCustomizationToEquipped(self)
	local equipped = homeStore:getState().equipped
	for localPlayer, v4 in ReplicatedStorage.Home.HomeData:GetChildren() do
		local v1, v2
		assert(v4, "Module path does not exist")
		local var5 = require(v4)
		local localPlayer = equipped[v4.Name]
		v1 = var5.getItems ~= nil
		assert(v1, "Module does not have a getItems function")
		v2 = var5.apply ~= nil
		assert(v2, "Module does not have an apply function")
		local instance7 = nil
		for v8, v9 in var5.getItems() do
			if v9.Name == localPlayer then
				instance7 = v9
				break
			end
		end
		var5.apply(instance7, self:GetObj())
	end
end
function t.isCustomizing()
	return homeStore:getState().visible
end
return t
