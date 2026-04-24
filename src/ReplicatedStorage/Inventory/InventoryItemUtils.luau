-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InventoryItemConsts = require(script.Parent.InventoryItemConsts)
local t = {}
local function getEquippedAttrName(itemObj)
	if RunService:IsServer() then
		return InventoryItemConsts.EQUIPPED_ATTR_NAME
	elseif t.getOwner(p1) == Players.LocalPlayer then
		return InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME
	else
		return InventoryItemConsts.EQUIPPED_ATTR_NAME
	end
end
function t.getEquipped(itemObj)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return (p1:GetAttribute(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(p1) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0) % 2 == 1
end
function t.setEquipped(itemObj, isEquipped)
	assert(CollectionService:HasTag(itemObj, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(isEquipped) == "boolean", "value must be a boolean")
	local currentValue = itemObj:GetAttribute(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(itemObj) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
	local newValue = currentValue + (currentValue % 2 - if isEquipped then 1 else 0 + 2)
	if newValue % 2 ~= currentValue % 2 then
		itemObj:SetAttribute(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(itemObj) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME, newValue)
	end
end
function t.getEquippedSignal(itemObj)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1:GetAttributeChangedSignal(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(p1) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME)
end
function t.getLocked(itemObj)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1:GetAttribute(InventoryItemConsts.LOCKED_ATTR_NAME)
end
function t.setLocked(itemObj, isLocked)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(p2) == "boolean", "value must be a boolean")
	p1:SetAttribute(InventoryItemConsts.LOCKED_ATTR_NAME, p2)
end
function t.getPriority(itemObj)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1:GetAttribute(InventoryItemConsts.PRIORITY_ATTR_NAME)
end
function t.setPriority(itemObj, priority)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(p2) == "number", "value must be a number")
	p1:SetAttribute(InventoryItemConsts.PRIORITY_ATTR_NAME, p2)
end
function t.getName(itemObj)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1.Name
end
function t.setName(itemObj, newName)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(p2) == "string", "value must be a string")
	p1.Name = p2
end
function t.getAttr(itemObj, attrName)
	return p1:GetAttribute(p2)
end
function t.setAttr(p1, p2, p3)
	p1:SetAttribute(p2, p3)
end
function t.getOwner(p1)
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	local v2 = p1.Parent.Parent
	if v2.Parent == game:GetService("Players") then
		return v2
	else
		return nil
	end
end
return t
