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
function t.init() --[[ Line: 33 | Upvalues: HomeItemBinder (copy), Roact (copy), createElement (copy), RoactRodux (copy), homeStore (copy), Utils (copy), HomeApp (copy), t (copy), CashBuyUI (copy), HomeSystem (copy), Players (copy), Audio (copy), BigButtonService (copy), Maid (copy), Interval (copy), HomeConsts (copy), RxInstanceUtils (copy), waitForChild (copy), ReplicatedStorage (copy), HomeItemConsts (copy) ]]
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
			attemptPlaceItem = function(p1) --[[ Name: attemptPlaceItem | Line: 58 | Upvalues: t (ref) ]]
				if p1.module == "HomeItem" then
					t.onAttemptPlaceItem:Fire(p1)
				else
					t.attemptEquip(p1.module, p1.name)
				end
			end,
			attemptPreviewItem = function(p1) --[[ Name: attemptPreviewItem | Line: 65 | Upvalues: t (ref) ]]
				t.attemptPreview(p1.module, p1.name)
			end,
			attemptPurchaseItem = function(p1) --[[ Name: attemptPurchaseItem | Line: 68 | Upvalues: t (ref) ]]
				t.attemptPurchase(p1.module, p1.name)
			end,
			attemptDeleteItem = function() --[[ Name: attemptDeleteItem | Line: 71 | Upvalues: t (ref) ]]
				t.onAttemptDeleteItem:Fire()
			end,
			promptCashPurchase = function() --[[ Name: promptCashPurchase | Line: 74 | Upvalues: homeStore (ref), CashBuyUI (ref) ]]
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
				CashBuyUI.Open()
			end,
			onSettingChanged = function(p1, p2) --[[ Name: onSettingChanged | Line: 83 | Upvalues: HomeSystem (ref) ]]
				HomeSystem.queryCurrentStandingHome():SetSavedSetting(p1, p2)
			end,
			exit = function() --[[ Name: exit | Line: 87 | Upvalues: homeStore (ref), HomeSystem (ref), t (ref) ]]
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
	local v6 = Roact.mount(createElement("ScreenGui", t2, t3), Players.LocalPlayer.PlayerGui, "HomeItemGui")
	t._maid:GiveTask(function() --[[ Line: 105 | Upvalues: Roact (ref), v6 (copy) ]]
		Roact.unmount(v6)
	end)
	local t7 = {
		name = "Home",
		imageId = 13218368809,
		displayOrder = 100,
		enabled = false,
		onClick = function() --[[ Name: onClick | Line: 114 | Upvalues: Players (ref), Audio (ref), homeStore (ref), HomeSystem (ref), t (ref) ]]
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
	local function updateButtonVisibility(p1) --[[ Line: 137 | Upvalues: HomeSystem (ref), Players (ref), t7 (copy), BigButtonService (ref), t (ref), homeStore (ref) ]]
		local v1 = HomeSystem.queryCurrentStandingHome()
		local v3 = (v1 and v1:HasPermissionToEdit(Players.LocalPlayer)) == true
		local enabled = t7.enabled
		if v3 ~= enabled then
			t7.enabled = v3
			BigButtonService.triggerUpdate:Fire()
			if enabled and not v3 then
				p1:ReplicateCustomizing(false)
				t.onCustomizeEnded:Fire(p1)
				homeStore:dispatch({
					type = "setVisible",
					value = false
				})
			end
		end
	end
	local v7 = Maid.new()
	HomeSystem.onEntered:Connect(function(p1) --[[ Line: 162 | Upvalues: v7 (copy), updateButtonVisibility (copy), Interval (ref) ]]
		v7:DoCleaning()
		updateButtonVisibility(p1)
		v7:GiveTask(Interval.every(1):Connect(function() --[[ Line: 165 | Upvalues: updateButtonVisibility (ref), p1 (copy) ]]
			updateButtonVisibility(p1)
		end))
	end)
	HomeSystem.onExited:Connect(function(p1) --[[ Line: 169 | Upvalues: v7 (copy), updateButtonVisibility (copy) ]]
		v7:DoCleaning()
		updateButtonVisibility(p1)
	end)
	HomeSystem.onEntered:Connect(function(p1) --[[ Line: 174 | Upvalues: homeStore (ref) ]]
		homeStore:dispatch({
			type = "setHome",
			value = p1
		})
	end)
	HomeSystem.onExited:Connect(function() --[[ Line: 180 | Upvalues: homeStore (ref) ]]
		homeStore:dispatch({
			type = "setHome",
			value = nil
		})
	end)
	t.onCustomizeEnded:Connect(function(p1) --[[ Line: 187 | Upvalues: t (ref) ]]
		t.resetHomeCustomizationToEquipped(p1)
	end)
	HomeSystem.onEntered:Connect(function(p1) --[[ Line: 192 | Upvalues: HomeConsts (ref), RxInstanceUtils (ref), homeStore (ref) ]]
		RxInstanceUtils.observeChildren(p1._obj:FindFirstChild(HomeConsts.SETTINGS_FOLDER_NAME), function(p1, p2) --[[ Line: 195 | Upvalues: homeStore (ref) ]]
			local function update() --[[ Line: 196 | Upvalues: homeStore (ref), p1 (copy) ]]
				homeStore:dispatch({
					type = "setSavedSetting",
					key = p1.Name,
					value = p1.Value
				})
			end
			homeStore:dispatch({
				type = "setSavedSetting",
				key = p1.Name,
				value = p1.Value
			})
			p2:GiveTask(p1:GetPropertyChangedSignal("Value"):Connect(update))
		end)
	end)
	waitForChild(ReplicatedStorage, HomeItemConsts.UPDATE_INVENTORY_REMOTE_NAME):andThen(function(p1) --[[ Line: 209 | Upvalues: homeStore (ref) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 210 | Upvalues: homeStore (ref) ]]
			homeStore:dispatch({
				type = "setInventory",
				value = p1
			})
		end)
	end):catch(warn)
	waitForChild(ReplicatedStorage, HomeItemConsts.UPDATE_EQUIPPED_REMOTE_NAME):andThen(function(p1) --[[ Line: 220 | Upvalues: homeStore (ref) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 221 | Upvalues: homeStore (ref) ]]
			homeStore:dispatch({
				type = "setEquipped",
				value = p1
			})
		end)
	end):catch(warn)
	local function updateQuantityPlaced() --[[ Line: 230 | Upvalues: t (ref), Players (ref), homeStore (ref) ]]
		homeStore:dispatch({
			type = "setQuantityPlaced",
			value = t.getQuantityPlaced(Players.LocalPlayer)
		})
	end
	homeStore:dispatch({
		type = "setQuantityPlaced",
		value = t.getQuantityPlaced(Players.LocalPlayer)
	})
	HomeItemBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 239 | Upvalues: t (ref), Players (ref), homeStore (ref), updateQuantityPlaced (copy) ]]
		homeStore:dispatch({
			type = "setQuantityPlaced",
			value = t.getQuantityPlaced(Players.LocalPlayer)
		})
		p1._maid:GiveTask(updateQuantityPlaced)
	end)
end
function t.getQuantityPlaced(p1) --[[ Line: 245 | Upvalues: HomeItemBinder (copy) ]]
	assert(p1 ~= nil)
	local t = {}
	for i, v in ipairs(HomeItemBinder:GetAll()) do
		if v:GetOwner() == p1 then
			local v2 = v._obj.Name
			t[v2] = (t[v2] or 0) + 1
		end
	end
	return t
end
function t.attemptPurchase(p1, p2) --[[ Line: 256 | Upvalues: ReplicatedStorage (copy), HomeItemConsts (copy) ]]
	ReplicatedStorage:FindFirstChild(HomeItemConsts.PURCHASE_HOME_ITEM_REMOTE_NAME):FireServer(p1, p2)
end
local function getItem(p1, p2) --[[ Line: 260 ]]
	for v1, v2 in p1 do
		if v2.Name == p2 then
			return v2
		end
	end
	return nil
end
function t.attemptEquip(p1, p2) --[[ Line: 268 | Upvalues: ReplicatedStorage (copy), HomeItemConsts (copy) ]]
	ReplicatedStorage:FindFirstChild(HomeItemConsts.EQUIP_HOME_ITEM_REMOTE_NAME):FireServer(p1, p2)
end
function t.attemptPreview(p1, p2) --[[ Line: 272 | Upvalues: ReplicatedStorage (copy), HomeSystem (copy) ]]
	assert(p2, "itemName is nil")
	assert(p1, "moduleName is nil for itemName: " .. tostring(p2))
	local v2 = ReplicatedStorage.Home.HomeData:FindFirstChild(p1)
	if v2 then
		assert(v2, "Module path does not exist")
		local v3 = require(v2)
		assert(v3.getItems ~= nil, "Module does not have a getItems function")
		assert(v3.apply ~= nil, "Module does not have an apply function")
		local v5 = nil
		for v6, v7 in v3.getItems() do
			if v7.Name == p2 then
				v5 = v7
				break
			end
		end
		assert(v5 ~= nil, "Item does not exist")
		v3.apply(v5, HomeSystem.queryCurrentStandingHome():GetObj())
	end
end
function t.resetHomeCustomizationToEquipped(p1) --[[ Line: 292 | Upvalues: homeStore (copy), ReplicatedStorage (copy) ]]
	local equipped = homeStore:getState().equipped
	for v3, v4 in ReplicatedStorage.Home.HomeData:GetChildren() do
		local v1, v2
		assert(v4, "Module path does not exist")
		local v5 = require(v4)
		local v6 = equipped[v4.Name]
		v1 = v5.getItems ~= nil
		assert(v1, "Module does not have a getItems function")
		v2 = v5.apply ~= nil
		assert(v2, "Module does not have an apply function")
		local v7 = nil
		for v8, v9 in v5.getItems() do
			if v9.Name == v6 then
				v7 = v9
				break
			end
		end
		v5.apply(v7, p1:GetObj())
	end
end
function t.isCustomizing() --[[ Line: 311 | Upvalues: homeStore (copy) ]]
	return homeStore:getState().visible
end
return t