local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
require(ReplicatedStorage.Inventory.InventoryItemSystem)
local t = {}
function t.init() --[[ Line: 12 | Upvalues: t (copy), CircleAction (copy), ActionButtonService (copy), ItemSystem (copy), Players (copy), VehicleUtils (copy), InventoryItemBinder (copy) ]]
	t._button = {
		primary = true,
		priority = 1050,
		noSink = true,
		saturateTo = 0,
		image = "rbxassetid://10770151584",
		keyCodes = { Enum.KeyCode.E, Enum.KeyCode.ButtonY },
		onPressed = function() --[[ Name: onPressed | Line: 22 | Upvalues: CircleAction (ref) ]]
			CircleAction.Press()
		end,
		onReleased = function() --[[ Name: onReleased | Line: 25 | Upvalues: CircleAction (ref) ]]
			CircleAction.Release()
		end
	}
	ActionButtonService.add(t._button)
	CircleAction.onVisibilityChanged:Connect(function(p1) --[[ Line: 32 | Upvalues: t (ref) ]]
		if p1 and t._button._pressed then
			t._button.onPressed()
		end
	end)
	local function updateVisibility(p1) --[[ Line: 39 | Upvalues: ItemSystem (ref), Players (ref), VehicleUtils (ref), t (ref), ActionButtonService (ref) ]]
		local v1 = ItemSystem.GetEquipped(Players.LocalPlayer)
		local v2 = not VehicleUtils.GetLocalVehiclePacket()
		local v3 = not v1
		if not v3 then
			v3 = v1.ShootBegin == nil
		end
		if t._button.disabled == v2 or p1 then
			ActionButtonService.setButtonEnabled(t._button, v2)
		end
		ActionButtonService.setButtonPrimary(t._button, v3)
		ActionButtonService.setButtonPriority(t._button, if v3 or v1 == nil then 1050 else 775)
	end
	updateVisibility(true)
	local function handleItem(p1) --[[ Line: 61 | Upvalues: Players (ref), updateVisibility (copy) ]]
		p1._maid:GiveTask(p1:GetEquippedSignal():Connect(function() --[[ Line: 62 | Upvalues: p1 (copy), Players (ref), updateVisibility (ref) ]]
			if p1:GetOwner() == Players.LocalPlayer then
				updateVisibility()
			end
		end))
		if p1:GetOwner() == Players.LocalPlayer then
			p1._maid:GiveTask(function() --[[ Line: 69 | Upvalues: updateVisibility (ref) ]]
				updateVisibility()
			end)
		end
	end
	for v1, v2 in InventoryItemBinder:GetAll() do
		handleItem(v2)
	end
	InventoryItemBinder:GetClassAddedSignal():Connect(handleItem)
	VehicleUtils.OnVehicleEntered:Connect(function(p1) --[[ Line: 78 | Upvalues: updateVisibility (copy) ]]
		updateVisibility()
	end)
	VehicleUtils.OnVehicleExited:Connect(function(p1) --[[ Line: 81 | Upvalues: updateVisibility (copy) ]]
		updateVisibility()
	end)
end
return t