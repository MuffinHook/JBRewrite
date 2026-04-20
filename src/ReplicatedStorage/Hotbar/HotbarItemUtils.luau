local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HotbarItemConsts_upvr = require(ReplicatedStorage.Hotbar.HotbarItemConsts)
local InventoryItemConsts_upvr = require(ReplicatedStorage.Inventory.InventoryItemConsts)
return {
    calculateNewIndex = function(arg1, arg2, arg3) -- Line 9, Named "calculateNewIndex"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        do
            return arg3
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    getOnHotbar = function(arg1) -- Line 27, Named "getOnHotbar"
        assert(CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME), "provided inventoryItemValue is not an InventoryItem")
        return CollectionService_upvr:HasTag(arg1, HotbarItemConsts_upvr.TAG_NAME)
    end;
    setOnHotbar = function(arg1, arg2) -- Line 34, Named "setOnHotbar"
        local any_HasTag_result1_2 = CollectionService_upvr:HasTag(arg1, InventoryItemConsts_upvr.TAG_NAME)
        assert(any_HasTag_result1_2, "provided inventoryItemValue is not an InventoryItem")
        if typeof(arg2) ~= "boolean" then
            any_HasTag_result1_2 = false
        else
            any_HasTag_result1_2 = true
        end
        assert(any_HasTag_result1_2, "value must be a boolean")
        if arg2 then
            CollectionService_upvr:AddTag(arg1, HotbarItemConsts_upvr.TAG_NAME)
        else
            CollectionService_upvr:RemoveTag(arg1, HotbarItemConsts_upvr.TAG_NAME)
        end
    end;
    getDisplayOrder = function(arg1) -- Line 46, Named "getDisplayOrder"
        assert(CollectionService_upvr:HasTag(arg1, HotbarItemConsts_upvr.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
        return arg1:GetAttribute(HotbarItemConsts_upvr.DISPLAY_ORDER_ATTR_NAME)
    end;
    setDisplayOrder = function(arg1, arg2) -- Line 53, Named "setDisplayOrder"
        local any_HasTag_result1_3 = CollectionService_upvr:HasTag(arg1, HotbarItemConsts_upvr.TAG_NAME)
        assert(any_HasTag_result1_3, "provided hotbarItemValue is not a HotbarItem")
        if typeof(arg2) ~= "number" then
            any_HasTag_result1_3 = false
        else
            any_HasTag_result1_3 = true
        end
        assert(any_HasTag_result1_3, "value must be a string")
        arg1:SetAttribute(HotbarItemConsts_upvr.DISPLAY_ORDER_ATTR_NAME, arg2)
    end;
    getImageSrc = function(arg1) -- Line 62, Named "getImageSrc"
        assert(CollectionService_upvr:HasTag(arg1, HotbarItemConsts_upvr.TAG_NAME), "provided hotbarItemValue is not a HotbarItem")
        return arg1:GetAttribute(HotbarItemConsts_upvr.IMAGE_SRC_ATTR_NAME)
    end;
    setImageSrc = function(arg1, arg2) -- Line 69, Named "setImageSrc"
        local any_HasTag_result1 = CollectionService_upvr:HasTag(arg1, HotbarItemConsts_upvr.TAG_NAME)
        assert(any_HasTag_result1, "provided hotbarItemValue is not a HotbarItem")
        if typeof(arg2) ~= "string" then
            any_HasTag_result1 = false
        else
            any_HasTag_result1 = true
        end
        assert(any_HasTag_result1, "value must be a string")
        arg1:SetAttribute(HotbarItemConsts_upvr.IMAGE_SRC_ATTR_NAME, arg2)
    end;
    setBind = function(arg1, arg2) -- Line 78, Named "setBind"
        local any_HasTag_result1_4 = CollectionService_upvr:HasTag(arg1, HotbarItemConsts_upvr.TAG_NAME)
        assert(any_HasTag_result1_4, "provided hotbarItemValue is not a HotbarItem")
        if typeof(arg2) ~= "string" then
            any_HasTag_result1_4 = false
        else
            any_HasTag_result1_4 = true
        end
        assert(any_HasTag_result1_4, "value must be a string")
        arg1:SetAttribute(HotbarItemConsts_upvr.IMAGE_SRC_ATTR_NAME, arg2)
    end;
}