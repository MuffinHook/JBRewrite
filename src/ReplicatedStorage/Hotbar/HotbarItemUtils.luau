local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HotbarItemConsts = require(ReplicatedStorage.Hotbar.HotbarItemConsts)
local InventoryItemConsts = require(ReplicatedStorage.Inventory.InventoryItemConsts)
return {
	calculateNewIndex = function(currentIndex, oldIndex, newIndex)
		if currentIndex == oldIndex then
			return newIndex
		elseif oldIndex < newIndex then
			if oldIndex < currentIndex and currentIndex <= newIndex then
				return currentIndex - 1
			else
				return currentIndex
			end
		elseif newIndex < oldIndex and (currentIndex < oldIndex and newIndex <= currentIndex) then
			return currentIndex + 1
		else
			return currentIndex
		end
	end,
	getOnHotbar = function(inventoryItem)
		assert(CollectionService:HasTag(inventoryItem, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not an InventoryItem")
		return CollectionService:HasTag(inventoryItem, HotbarItemConsts.TAG_NAME)
	end,
	setOnHotbar = function(inventoryItem, isOnHotbar)
		assert(CollectionService:HasTag(inventoryItem, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not an InventoryItem")
		assert(typeof(isOnHotbar) == "boolean", "value must be a boolean")
		if isOnHotbar then
			CollectionService:AddTag(inventoryItem, HotbarItemConsts.TAG_NAME)
		else
			CollectionService:RemoveTag(inventoryItem, HotbarItemConsts.TAG_NAME)
		end
	end,
	getDisplayOrder = function(hotbarItem)
		assert(CollectionService:HasTag(hotbarItem, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		return hotbarItem:GetAttribute(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME)
	end,
	setDisplayOrder = function(hotbarItem, displayOrder)
		assert(CollectionService:HasTag(hotbarItem, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		assert(typeof(displayOrder) == "number", "value must be a string")
		hotbarItem:SetAttribute(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME, displayOrder)
	end,
	getImageSrc = function(hotbarItem)
		assert(CollectionService:HasTag(hotbarItem, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		return hotbarItem:GetAttribute(HotbarItemConsts.IMAGE_SRC_ATTR_NAME)
	end,
	setImageSrc = function(hotbarItem, imageSrc)
		assert(CollectionService:HasTag(hotbarItem, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		assert(typeof(imageSrc) == "string", "value must be a string")
		hotbarItem:SetAttribute(HotbarItemConsts.IMAGE_SRC_ATTR_NAME, imageSrc)
	end,
	setBind = function(hotbarItem, bindKey)
		assert(CollectionService:HasTag(hotbarItem, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		assert(typeof(bindKey) == "string", "value must be a string")
		hotbarItem:SetAttribute(HotbarItemConsts.IMAGE_SRC_ATTR_NAME, bindKey)
	end
}
