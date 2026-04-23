local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InventoryItemConsts = require(script.Parent.InventoryItemConsts)
local t = {}
local function getEquippedAttrName(p1) --[[ Line: 8 | Upvalues: RunService (copy), InventoryItemConsts (copy), t (copy), Players (copy) ]]
	if RunService:IsServer() then
		return InventoryItemConsts.EQUIPPED_ATTR_NAME
	elseif t.getOwner(p1) == Players.LocalPlayer then
		return InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME
	else
		return InventoryItemConsts.EQUIPPED_ATTR_NAME
	end
end
function t.getEquipped(p1) --[[ Line: 18 | Upvalues: CollectionService (copy), InventoryItemConsts (copy), RunService (copy), t (copy), Players (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return (p1:GetAttribute(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(p1) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0) % 2 == 1
end
function t.setEquipped(p1, p2) --[[ Line: 27 | Upvalues: CollectionService (copy), InventoryItemConsts (copy), RunService (copy), t (copy), Players (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(p2) == "boolean", "value must be a boolean")
	local v4 = p1:GetAttribute(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(p1) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME) or 0
	local v6 = v4 + (v4 % 2 - if p2 then 1 else 0 + 2)
	if v6 % 2 ~= v4 % 2 then
		p1:SetAttribute(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(p1) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME, v6)
	end
end
function t.getEquippedSignal(p1) --[[ Line: 46 | Upvalues: CollectionService (copy), InventoryItemConsts (copy), RunService (copy), t (copy), Players (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1:GetAttributeChangedSignal(if RunService:IsServer() then InventoryItemConsts.EQUIPPED_ATTR_NAME elseif t.getOwner(p1) == Players.LocalPlayer then InventoryItemConsts.EQUIPPED_LOCAL_ATTR_NAME else InventoryItemConsts.EQUIPPED_ATTR_NAME)
end
function t.getLocked(p1) --[[ Line: 53 | Upvalues: CollectionService (copy), InventoryItemConsts (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1:GetAttribute(InventoryItemConsts.LOCKED_ATTR_NAME)
end
function t.setLocked(p1, p2) --[[ Line: 60 | Upvalues: CollectionService (copy), InventoryItemConsts (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(p2) == "boolean", "value must be a boolean")
	p1:SetAttribute(InventoryItemConsts.LOCKED_ATTR_NAME, p2)
end
function t.getPriority(p1) --[[ Line: 68 | Upvalues: CollectionService (copy), InventoryItemConsts (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1:GetAttribute(InventoryItemConsts.PRIORITY_ATTR_NAME)
end
function t.setPriority(p1, p2) --[[ Line: 75 | Upvalues: CollectionService (copy), InventoryItemConsts (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(p2) == "number", "value must be a number")
	p1:SetAttribute(InventoryItemConsts.PRIORITY_ATTR_NAME, p2)
end
function t.getName(p1) --[[ Line: 83 | Upvalues: CollectionService (copy), InventoryItemConsts (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	return p1.Name
end
function t.setName(p1, p2) --[[ Line: 90 | Upvalues: CollectionService (copy), InventoryItemConsts (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	assert(typeof(p2) == "string", "value must be a string")
	p1.Name = p2
end
function t.getAttr(p1, p2) --[[ Line: 98 ]]
	return p1:GetAttribute(p2)
end
function t.setAttr(p1, p2, p3) --[[ Line: 101 ]]
	p1:SetAttribute(p2, p3)
end
function t.getOwner(p1) --[[ Line: 104 | Upvalues: CollectionService (copy), InventoryItemConsts (copy) ]]
	assert(CollectionService:HasTag(p1, InventoryItemConsts.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
	local v2 = p1.Parent.Parent
	if v2.Parent == game:GetService("Players") then
		return v2
	else
		return nil
	end
end
return t