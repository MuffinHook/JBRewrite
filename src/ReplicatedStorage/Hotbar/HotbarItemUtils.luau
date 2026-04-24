-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HotbarItemConsts = require(ReplicatedStorage.Hotbar.HotbarItemConsts)
local InventoryItemConsts = require(ReplicatedStorage.Inventory.InventoryItemConsts)
return {
	calculateNewIndex = function(p1, p2, p3)
		if p1 == p2 then
			return p3
		elseif p2 < p3 then
			if p2 < p1 and p1 <= p3 then
				return p1 - 1
			else
				return p1
			end
		elseif p3 < p2 and (p1 < p2 and p3 <= p1) then
			return p1 + 1
		else
			return p1
		end
	end,
	getOnHotbar = function(p1)
		assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not an InventoryItem")
		return CollectionService:HasTag(p1, HotbarItemConsts.TAG_NAME)
	end,
	setOnHotbar = function(p1, p2)
		assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not an InventoryItem")
		assert(typeof(p2) == "boolean", "value must be a boolean")
		if p2 then
			CollectionService:AddTag(p1, HotbarItemConsts.TAG_NAME)
		else
			CollectionService:RemoveTag(p1, HotbarItemConsts.TAG_NAME)
		end
	end,
	getDisplayOrder = function(p1)
		assert(CollectionService:HasTag(p1, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		return p1:GetAttribute(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME)
	end,
	setDisplayOrder = function(p1, p2)
		assert(CollectionService:HasTag(p1, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		assert(typeof(p2) == "number", "value must be a string")
		p1:SetAttribute(HotbarItemConsts.DISPLAY_ORDER_ATTR_NAME, p2)
	end,
	getImageSrc = function(p1)
		assert(CollectionService:HasTag(p1, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		return p1:GetAttribute(HotbarItemConsts.IMAGE_SRC_ATTR_NAME)
	end,
	setImageSrc = function(p1, p2)
		assert(CollectionService:HasTag(p1, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		assert(typeof(p2) == "string", "value must be a string")
		p1:SetAttribute(HotbarItemConsts.IMAGE_SRC_ATTR_NAME, p2)
	end,
	setBind = function(p1, p2)
		assert(CollectionService:HasTag(p1, HotbarItemConsts.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
		assert(typeof(p2) == "string", "value must be a string")
		p1:SetAttribute(HotbarItemConsts.IMAGE_SRC_ATTR_NAME, p2)
	end
}
