game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Inventory.InventoryItemSystem)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local uiModule = nil
local t = {}
function t.Init(serverEvent)
	local serverEvent = serverEvent.Event
	uiModule = require(ReplicatedStorage.Game.ItemSkin.UI.UI)
	function serverEvent.em.efbs1qej(skinData)
		assert(skinData)
		t.ItemSkinsOwned = skinData
		uiModule.UpdateOwned()
	end
	uiModule.OnSkinClick:Connect(function(skinName)
		local equippedItem = ItemSystem.GetLocalEquipped()
		if equippedItem == nil then
			error("Player has no item equipped.")
		end
		if equippedItem.ApplySkin == nil then
			error(("Item %s does not suppory skins."):format(equippedItem.__ClassName))
		end
		if t.DoesPlayerOwn(skinName.Name) then
			equippedItem:ApplySkin(skinName.Name)
		else
			equippedItem:ApplySkinLocal(skinName.Name)
		end
		Audio.ObjectLocal(equippedItem.Model.Skeleton.BoundingBox, 4761679152)
	end)
	uiModule.OnSkinBuyClick:Connect(function(skinName)
		local equippedItem = ItemSystem.GetLocalEquipped()
		if equippedItem == nil then
			error("Player has no item equipped.")
		end
		if equippedItem.ApplySkin == nil then
			error(("Item %s does not suppory skins."):format(equippedItem.__ClassName))
		end
		serverEvent:FireServer("ojf6ns2g", equippedItem.inventoryItemValue, skinName.Name)
		Audio.ObjectLocal(equippedItem.Model.Skeleton.BoundingBox, 4761679547)
	end)
	uiModule.OnClosed:Connect(function()
		local equippedItem = ItemSystem.GetLocalEquipped()
		if equippedItem ~= nil then
			if equippedItem.ApplySkin == nil then
				error(("Item %s does not suppory skins."):format(equippedItem.__ClassName))
			end
			equippedItem:ApplySkinLocal((InventoryItemUtils.getAttr(equippedItem.inventoryItemValue, "SkinName")))
		end
	end)
end
function t.DoesPlayerOwn(skinName)
	if skinName == "None" then
		return true
	else
		if t.ItemSkinsOwned == nil then
			error("Item skins have not been synced on client yet.")
		end
		return t.ItemSkinsOwned[skinName]
	end
end
return t
