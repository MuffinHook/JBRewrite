local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local VehicleData_upvr = require(ReplicatedStorage_upvr.Game.Garage.VehicleData)
local function getVehicleDataForMake(arg1) -- Line 14, Named "getVehicleDataForMake"
    for _, v in ipairs(VehicleData_upvr) do
        if v.Make == arg1 then
            return v
        end
    end
end
local ItemSkinList_upvr = require(ReplicatedStorage_upvr.Game.ItemSkin.ItemSkinList)
local function getItemSkinForName(arg1) -- Line 24, Named "getItemSkinForName"
    for _, v_2 in ipairs(ItemSkinList_upvr) do
        if v_2.Name == arg1 then
            return v_2
        end
    end
end
local module_upvr = {}
local PopularSort_upvr = require(ReplicatedStorage_upvr.Garage.PopularSort)
local TradePopularSortData_upvr = require(script.Parent.TradePopularSortData)
local ItemUtils_upvr = require(ReplicatedStorage_upvr.App.ItemUtils)
local getViewportProps_upvr = require(ReplicatedStorage_upvr.App.getViewportProps)
local PlayerDataConsts_upvr = require(ReplicatedStorage_upvr.PlayerData.PlayerDataConsts)
local StoreData_upvr = require(ReplicatedStorage_upvr.Game.Garage.StoreData)
local GarageTranslationUtils_upvr = require(ReplicatedStorage_upvr.Garage.GarageTranslationUtils)
local String_upvr = require(ReplicatedStorage_upvr.Std.String)
local PlayerUtils_upvr = require(ReplicatedStorage_upvr.Std.PlayerUtils)
function module_upvr.buildItemProps(arg1) -- Line 37
    if not arg1 or not arg1.ItemType then
        return nil
    end

    local itemType = arg1.ItemType
    local function makeId()
        if arg1.Id ~= nil then
            return arg1.Id
        end
        if itemType == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
            return string.format("%s.%s.%s", itemType, tostring(arg1.CategoryName), tostring(arg1.ItemName))
        end
        if itemType == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
            return string.format("%s.%s", itemType, tostring(arg1.Make))
        end
        if itemType == PlayerDataConsts_upvr.ITEM_SKIN_ITEM_TYPE then
            return string.format("%s.%s", itemType, tostring(arg1.SkinName))
        end
        if itemType == PlayerDataConsts_upvr.HOME_ITEM_TYPE then
            return string.format("%s.%s", itemType, tostring(arg1.ItemName))
        end
        if itemType == PlayerDataConsts_upvr.SAFE_ITEM_TYPE then
            return string.format("%s.%s", itemType, tostring(arg1.TypeEnum))
        end
        return string.format("%s.%s", itemType, tostring(arg1.ItemName))
    end

    local props = {
        id = makeId();
        itemOwnedId = arg1.Id;
        itemOwned = arg1;
        itemType = itemType;
        created = arg1.CreationTime;
        cash = arg1.Cash;
        isOriginalOwner = arg1.IsOriginalOwner == true;
    }

    if itemType == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
        local categoryName = arg1.CategoryName
        local itemName = arg1.ItemName
        if not categoryName or not itemName then
            return nil
        end

        local itemData = StoreData_upvr.GetItemByName(categoryName, itemName)
        if not itemData then
            return nil
        end

        props.categoryName = categoryName
        props.name = itemName
        props.title = itemData.DisplayName or itemData.Name or itemName
        props.categoryTitle = GarageTranslationUtils_upvr.getCategoryTitle(categoryName)
        props.price = itemData.Price
        props.level = itemData.Level
        props.season = itemData.Season
        props.topPct = itemData.TopPct
        props.rarityIndex = itemData.RarityIndex or arg1.RarityId or 0

        local ok, viewportProps = pcall(getViewportProps_upvr, arg1)
        if ok and viewportProps then
            for key, value in pairs(viewportProps) do
                props[key] = value
            end
        end

        return props
    end

    if itemType == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
        local vehicleData = getVehicleDataForMake(arg1.Make)
        if not vehicleData then
            return nil
        end

        props.name = arg1.Make
        props.title = vehicleData.Name or arg1.Make
        props.categoryTitle = "Vehicle"
        props.price = vehicleData.Price
        props.level = vehicleData.Level
        props.season = vehicleData.Season
        props.rarityIndex = arg1.RarityId or 0

        return props
    end

    if itemType == PlayerDataConsts_upvr.ITEM_SKIN_ITEM_TYPE then
        local itemSkin = getItemSkinForName(arg1.SkinName)
        if not itemSkin then
            return nil
        end

        props.name = arg1.SkinName
        props.title = arg1.SkinName
        props.categoryTitle = "Item Skin"
        props.rarityIndex = arg1.RarityId or 0
        return props
    end

    if itemType == PlayerDataConsts_upvr.HOME_ITEM_TYPE then
        props.name = arg1.ItemName
        props.title = arg1.ItemName
        props.categoryTitle = "Home Item"
        props.rarityIndex = arg1.RarityId or 0
        return props
    end

    if itemType == PlayerDataConsts_upvr.SAFE_ITEM_TYPE then
        props.name = tostring(arg1.TypeEnum)
        props.title = tostring(arg1.TypeEnum)
        props.categoryTitle = "Safe"
        props.rarityIndex = arg1.RarityId or 0
        return props
    end

    if itemType == PlayerDataConsts_upvr.CONSUMABLE_ITEM_TYPE then
        props.name = arg1.ItemName
        props.title = arg1.ItemName
        props.categoryTitle = "Consumable"
        props.rarityIndex = arg1.RarityId or 0
        return props
    end

    return nil
end
function module_upvr.getDefaults() -- Line 243
    return {
        userId = nil;
        displayName = nil;
        ready = false;
        accepted = false;
        offerItems = {};
    }
end
function module_upvr.update(arg1, arg2) -- Line 252
    local var29
    if arg2.reset == true then
        var29 = module_upvr.getDefaults()
    else
        var29 = table.clone(arg1)
    end
    if arg2.userId ~= nil then
        var29.userId = arg2.userId
    end
    if arg2.displayName ~= nil then
        var29.displayName = arg2.displayName
    end
    if arg2.ready ~= nil then
        var29.ready = arg2.ready
    end
    if arg2.accepted ~= nil then
        var29.accepted = arg2.accepted
    end
    if arg2.itemsOwnedOffering ~= nil then
        for _, v_3 in ipairs(arg2.itemsOwnedOffering) do
            local any_buildItemProps_result1 = module_upvr.buildItemProps(v_3)
            if any_buildItemProps_result1 then
                table.insert({}, any_buildItemProps_result1)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var29.offerItems = {}
    end
    return var29
end
function module_upvr.addItem(arg1, arg2) -- Line 283
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var35
    if arg2.item == nil then
        var35 = false
    else
        var35 = true
    end
    assert(var35, "missing item")
    var35 = ipairs(arg1.offerItems)
    local ipairs_result1, ipairs_result2, ipairs_result3_2 = ipairs(arg1.offerItems)
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [27.9]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [27.2147483650]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.removeItem(arg1, arg2) -- Line 301
    local item = arg2.item
    local var42
    if item == nil then
        var42 = false
    else
        var42 = true
    end
    assert(var42, "missing item")
    var42 = -1
    for i_4 = #arg1.offerItems, 1, var42 do
        if arg1.offerItems[i_4].id == item.id then
            local clone_2 = table.clone(arg1)
            table.remove(clone_2.offerItems, i_4)
            return clone_2
        end
    end
    return arg1
end
function module_upvr.removeItemByIndex(arg1, arg2) -- Line 315
    local var44
    if arg2.index == nil then
        var44 = false
    else
        var44 = true
    end
    assert(var44, "missing item id")
    var44 = arg1
    local clone = table.clone(var44)
    var44 = table.remove
    var44(clone.offerItems, arg2.index)
    return clone
end
return module_upvr
