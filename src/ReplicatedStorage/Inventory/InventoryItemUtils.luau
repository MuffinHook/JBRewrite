-- Reviewed / fixed
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local InventoryItemConsts = require(script.Parent.InventoryItemConsts)

local InventoryItemUtil = {}

local function getEquippedAttrName(itemObj)
	if RunService:IsServer() then
		return InventoryItemConsts.EQUIPPED_ATTR_NAME
	end

	if InventoryItemUtil.getOwner(itemObj) == Players.LocalPlayer then
		return InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME
	end

	return InventoryItemConsts.EQUIPPED_ATTR_NAME
end

function InventoryItemUtil.getEquipped(itemObj)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")

	return (itemObj:GetAttribute(getEquippedAttrName(itemObj)) or 0) % 2 == 1
end

function InventoryItemUtil.setEquipped(itemObj, isEquipped)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(isEquipped) == "boolean", "value must be a boolean")

	local attrName = getEquippedAttrName(itemObj)
	local currentValue = itemObj:GetAttribute(attrName) or 0
	local equippedValue = if isEquipped then 1 else 0
	local newValue = currentValue + (currentValue % 2 - equippedValue + 2)

	itemObj:SetAttribute(attrName, newValue)
end

function InventoryItemUtil.getEquippedSignal(itemObj)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")

	return itemObj:GetAttributeChangedSignal(getEquippedAttrName(itemObj))
end

function InventoryItemUtil.getLocked(itemObj)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")

	return itemObj:GetAttribute(InventoryItemConsts.LOCKED_ATTR_NAME)
end

function InventoryItemUtil.setLocked(itemObj, isLocked)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(isLocked) == "boolean", "value must be a boolean")

	itemObj:SetAttribute(InventoryItemConsts.LOCKED_ATTR_NAME, isLocked)
end

function InventoryItemUtil.getPriority(itemObj)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")

	return itemObj:GetAttribute(InventoryItemConsts.PRIORITY_ATTR_NAME)
end

function InventoryItemUtil.setPriority(itemObj, priority)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(priority) == "number", "value must be a number")

	itemObj:SetAttribute(InventoryItemConsts.PRIORITY_ATTR_NAME, priority)
end

function InventoryItemUtil.getName(itemObj)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")

	return itemObj.Name
end

function InventoryItemUtil.setName(itemObj, newName)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(newName) == "string", "value must be a string")

	itemObj.Name = newName
end

function InventoryItemUtil.getAttr(itemObj, attrName)
	return itemObj:GetAttribute(attrName)
end

function InventoryItemUtil.setAttr(itemObj, attrName, value)
	itemObj:SetAttribute(attrName, value)
end

function InventoryItemUtil.getOwner(itemObj)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")

	local owner = itemObj.Parent.Parent

	if owner.Parent == Players then
		return owner
	end

	return nil
end

return InventoryItemUtil