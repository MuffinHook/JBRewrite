-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
require(ReplicatedStorage.Inventory.InventoryItemSystem)
local module = {}
function module.init()
	module._button = {
		primary = true,
		priority = 1050,
		noSink = true,
		saturateTo = 0,
		image = "rbxassetid://10770151584",
		keyCodes = { Enum.KeyCode.E, Enum.KeyCode.ButtonY },
		onPressed = function()
			CircleAction.Press()
		end,
		onReleased = function()
			CircleAction.Release()
		end
	}
	ActionButtonService.add(module._button)
	CircleAction.onVisibilityChanged:Connect(function(visibilityState)
		if visibilityState and module._button._pressed then
			module._button.onPressed()
		end
	end)
	local function updateVisibility(forceUpdate)
		local equippedItem = ItemSystem.GetEquipped(Players.LocalPlayer)
		local isNotInVehicle = not VehicleUtils.GetLocalVehiclePacket()
		local shouldBeSecondary = not equippedItem
		if not shouldBeSecondary then
			shouldBeSecondary = equippedItem.ShootBegin == nil
		end
		if module._button.disabled == isNotInVehicle or forceUpdate then
			ActionButtonService.setButtonEnabled(module._button, isNotInVehicle)
		end
		ActionButtonService.setButtonPrimary(module._button, shouldBeSecondary)
		ActionButtonService.setButtonPriority(module._button, if shouldBeSecondary or equippedItem == nil then 1050 else 775)
	end
	updateVisibility(true)
	local function handleItem(inventoryItem)
		inventoryItem._maid:GiveTask(inventoryItem:GetEquippedSignal():Connect(function()
			if inventoryItem:GetOwner() == Players.LocalPlayer then
				updateVisibility()
			end
		end))
		if inventoryItem:GetOwner() == Players.LocalPlayer then
			inventoryItem._maid:GiveTask(function()
				updateVisibility()
			end)
		end
	end
	for itemIndex, item in InventoryItemBinder:GetAll() do
		handleItem(item)
	end
	InventoryItemBinder:GetClassAddedSignal():Connect(handleItem)
	VehicleUtils.OnVehicleEntered:Connect(function(vehicle)
		updateVisibility()
	end)
	VehicleUtils.OnVehicleExited:Connect(function(vehicle)
		updateVisibility()
	end)
end
return module
