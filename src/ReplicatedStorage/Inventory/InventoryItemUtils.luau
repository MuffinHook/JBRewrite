local CollectionService_upvr = game:GetService("CollectionService")
local Players_upvr = game:GetService("Players")
local RunService_upvr = game:GetService("RunService")
local InventoryItemConsts_upvr = require(script.Parent.InventoryItemConsts)
local module_upvr = {}
local function _(arg1) -- Line 8, Named "getEquippedAttrName"
    if RunService_upvr:IsServer() then
        return InventoryItemConsts_upvr.EQUIPPED_ATTR_NAME
    end
    if module_upvr.getOwner(arg1) ~= Players_upvr.LocalPlayer then
        return InventoryItemConsts_upvr.EQUIPPED_ATTR_NAME
    end
    return InventoryItemConsts_upvr.EQUIPPED_LOCAL_ATTR_NAME
end
function module_upvr.getEquipped(arg1) -- Line 18
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
    if RunService_upvr:IsServer() then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr.getOwner(arg1) ~= Players_upvr.LocalPlayer then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.setEquipped(arg1, arg2) -- Line 27
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local any_HasTag_result1_3 = CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME)
    assert(any_HasTag_result1_3, "provided inventoryItemValue is not a InventoryItem")
    if typeof(arg2) ~= "boolean" then
        any_HasTag_result1_3 = false
    else
        any_HasTag_result1_3 = true
    end
    assert(any_HasTag_result1_3, "value must be a boolean")
    if RunService_upvr:IsServer() then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr.getOwner(arg1) ~= Players_upvr.LocalPlayer then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.getEquippedSignal(arg1) -- Line 46
    local var7 = "provided inventoryItemValue is not a InventoryItem"
    assert(CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME), var7)
    if RunService_upvr:IsServer() then
        var7 = InventoryItemConsts_upvr
        var7 = var7.EQUIPPED_ATTR_NAME
    elseif module_upvr.getOwner(arg1) ~= Players_upvr.LocalPlayer then
        var7 = InventoryItemConsts_upvr
        var7 = var7.EQUIPPED_ATTR_NAME
    else
        var7 = InventoryItemConsts_upvr
        var7 = var7.EQUIPPED_LOCAL_ATTR_NAME
    end
    return arg1:GetAttributeChangedSignal(var7)
end
function module_upvr.getLocked(arg1) -- Line 53
    assert(CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
    return arg1:GetAttribute(InventoryItemConsts_upvr.LOCKED_ATTR_NAME)
end
function module_upvr.setLocked(arg1, arg2) -- Line 60
    local any_HasTag_result1_2 = CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME)
    assert(any_HasTag_result1_2, "provided inventoryItemValue is not a InventoryItem")
    if typeof(arg2) ~= "boolean" then
        any_HasTag_result1_2 = false
    else
        any_HasTag_result1_2 = true
    end
    assert(any_HasTag_result1_2, "value must be a boolean")
    arg1:SetAttribute(InventoryItemConsts_upvr.LOCKED_ATTR_NAME, arg2)
end
function module_upvr.getPriority(arg1) -- Line 68
    assert(CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
    return arg1:GetAttribute(InventoryItemConsts_upvr.PRIORITY_ATTR_NAME)
end
function module_upvr.setPriority(arg1, arg2) -- Line 75
    local any_HasTag_result1_4 = CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME)
    assert(any_HasTag_result1_4, "provided inventoryItemValue is not a InventoryItem")
    if typeof(arg2) ~= "number" then
        any_HasTag_result1_4 = false
    else
        any_HasTag_result1_4 = true
    end
    assert(any_HasTag_result1_4, "value must be a number")
    arg1:SetAttribute(InventoryItemConsts_upvr.PRIORITY_ATTR_NAME, arg2)
end
function module_upvr.getName(arg1) -- Line 83
    assert(CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
    return arg1.Name
end
function module_upvr.setName(arg1, arg2) -- Line 90
    local any_HasTag_result1 = CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME)
    assert(any_HasTag_result1, "provided inventoryItemValue is not a InventoryItem")
    if typeof(arg2) ~= "string" then
        any_HasTag_result1 = false
    else
        any_HasTag_result1 = true
    end
    assert(any_HasTag_result1, "value must be a string")
    arg1.Name = arg2
end
function module_upvr.getAttr(arg1, arg2) -- Line 98
    return arg1:GetAttribute(arg2)
end
function module_upvr.setAttr(arg1, arg2, arg3) -- Line 101
    arg1:SetAttribute(arg2, arg3)
end
function module_upvr.getOwner(arg1) -- Line 104
    assert(CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME), "provided inventoryItemValue is not a InventoryItem")
    local Parent = arg1.Parent.Parent
    if Parent.Parent ~= game:GetService("Players") then
        return nil
    end
    return Parent
end
return module_upvr