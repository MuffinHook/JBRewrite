local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local PlayerDataConsts_upvr = require(ReplicatedStorage_upvr.PlayerData.PlayerDataConsts)
local SafesConsts_upvr = require(ReplicatedStorage_upvr.Safes.SafesConsts)
local StoreData_upvr = require(ReplicatedStorage_upvr.Game.Garage.StoreData)
local ConsumablesData_upvr = require(ReplicatedStorage_upvr.Consumables.ConsumablesData)
local OwnershipConsts_upvr = require(ReplicatedStorage_upvr.Ownership.OwnershipConsts)
local VehicleData_upvr = require(ReplicatedStorage_upvr.Game.Garage.VehicleData)
local function getVehicleDataForMake_upvr(arg1) -- Line 12, Named "getVehicleDataForMake"
    for _, v in ipairs(VehicleData_upvr) do
        if v.Make == arg1 then
            return v
        end
    end
end
local ItemSkinList_upvr = require(ReplicatedStorage_upvr.Game.ItemSkin.ItemSkinList)
local function getItemSkinForName_upvr(arg1) -- Line 21, Named "getItemSkinForName"
    for _, v_2 in ipairs(ItemSkinList_upvr) do
        if v_2.Name == arg1 then
            return v_2
        end
    end
end
local module_3_upvr = {
    createVehicleItemTable = function(arg1) -- Line 30, Named "createVehicleItemTable"
        local var20
        if typeof(arg1) ~= "string" then
            var20 = false
        else
            var20 = true
        end
        assert(var20, "Incorrect make type passed")
        local module_4 = {}
        var20 = PlayerDataConsts_upvr
        var20 = var20.VEHICLE_ITEM_TYPE
        module_4.ItemType = var20
        module_4.Make = arg1
        return module_4
    end;
    createVehicleCustomizationItemTable = function(arg1, arg2) -- Line 34, Named "createVehicleCustomizationItemTable"
        local var22
        if typeof(arg1) ~= "string" then
            var22 = "Incorrect categoryName type passed: "..tostring(arg1)..", "..typeof(arg1)
            error(var22)
        end
        if typeof(arg2) ~= "string" then
            var22 = false
        else
            var22 = true
        end
        assert(var22, "Incorrect itemName type passed")
        var22 = OwnershipConsts_upvr
        var22 = var22.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET
        if not var22[arg1] then
            var22 = "Tried to create vehicleCustomizationItemTable for category: "
            var22 = error
            var22(var22..arg1)
        end
        local module_2 = {}
        var22 = PlayerDataConsts_upvr
        var22 = var22.VEHICLE_CUSTOMIZATION_ITEM_TYPE
        module_2.ItemType = var22
        module_2.CategoryName = arg1
        module_2.ItemName = arg2
        return module_2
    end;
    createHomeItemItemTable = function(arg1) -- Line 50, Named "createHomeItemItemTable"
        local var24
        if typeof(arg1) ~= "string" then
            var24 = false
        else
            var24 = true
        end
        assert(var24, "Incorrect itemName type passed")
        local module_8 = {}
        var24 = PlayerDataConsts_upvr
        var24 = var24.HOME_ITEM_ITEM_TYPE
        module_8.ItemType = var24
        module_8.ItemName = arg1
        return module_8
    end;
    createItemSkinTable = function(arg1) -- Line 54, Named "createItemSkinTable"
        local var26
        if typeof(arg1) ~= "string" then
            var26 = false
        else
            var26 = true
        end
        assert(var26, "Incorrect skinName type passed")
        local module_9 = {}
        var26 = PlayerDataConsts_upvr
        var26 = var26.ITEM_SKIN_ITEM_TYPE
        module_9.ItemType = var26
        module_9.SkinName = arg1
        return module_9
    end;
    createSafeTable = function(arg1) -- Line 58, Named "createSafeTable"
        local var28
        if typeof(arg1) ~= "number" then
            var28 = false
        else
            var28 = true
        end
        assert(var28, "Incorrect typeEnum type passed")
        local module_7 = {}
        var28 = PlayerDataConsts_upvr
        var28 = var28.SAFE_ITEM_TYPE
        module_7.ItemType = var28
        module_7.TypeEnum = arg1
        return module_7
    end;
    createConsumableTable = function(arg1) -- Line 62, Named "createConsumableTable"
        local var30
        if typeof(arg1) ~= "string" then
            var30 = false
        else
            var30 = true
        end
        assert(var30, "Incorrect itemName type passed")
        local module = {}
        var30 = PlayerDataConsts_upvr
        var30 = var30.CONSUMABLE_ITEM_TYPE
        module.ItemType = var30
        module.ItemName = arg1
        return module
    end;
}
local SAFE_DATA_upvr = SafesConsts_upvr.SAFE_DATA
function module_3_upvr.getStoreData(arg1) -- Line 66
    local ItemType = arg1.ItemType
    if ItemType == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
        return getVehicleDataForMake_upvr(arg1.Make)
    end
    if ItemType == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
        return StoreData_upvr.GetItemByName(arg1.CategoryName, arg1.ItemName)
    end
    if ItemType == PlayerDataConsts_upvr.HOME_ITEM_ITEM_TYPE then
        local ItemName = arg1.ItemName
        local SOME = ReplicatedStorage_upvr.Resource.HomeItem:FindFirstChild(ItemName)
        if not SOME then
            warn("Missing homeItemModel for: "..ItemName)
            return nil
        end
        for _, v_3 in SOME:GetChildren() do
            if v_3:IsA("ValueBase") then
                ({})[v_3.Name] = v_3.Value
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end
    if ItemType == PlayerDataConsts_upvr.ITEM_SKIN_ITEM_TYPE then
        return getItemSkinForName_upvr(arg1.SkinName)
    end
    if ItemType == PlayerDataConsts_upvr.SAFE_ITEM_TYPE then
        return SAFE_DATA_upvr[arg1.TypeEnum]
    end
    if ItemType == PlayerDataConsts_upvr.CONSUMABLE_ITEM_TYPE then
        return ConsumablesData_upvr[arg1.ItemName]
    end
    error("Could not find store data for itemOwned, invalid itemType: "..tostring(ItemType))
end
function module_3_upvr.getItemTablesForItemType(arg1) -- Line 100
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local ItemType_3 = arg1.ItemType
    if ItemType_3 == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
        for _, v_4 in VehicleData_upvr do
            table.insert({}, module_3_upvr.createVehicleItemTable(v_4.Make))
            local var83
        end
        return var83
    end
    if ItemType_3 == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
        local CategoryName = arg1.CategoryName
        for _, v_5 in StoreData_upvr.GetCategoryByName(CategoryName).Items do
            table.insert({}, module_3_upvr.createVehicleCustomizationItemTable(CategoryName, v_5.Name))
            local var86
        end
        return var86
    end
    if ItemType_3 == PlayerDataConsts_upvr.HOME_ITEM_ITEM_TYPE then
        for _, v_6 in ReplicatedStorage_upvr.Resource.HomeItem:GetChildren() do
            v_5 = table.insert
            v_5({}, module_3_upvr.createHomeItemItemTable(v_6.Name))
            local var91
        end
        return var91
    end
    if ItemType_3 == PlayerDataConsts_upvr.ITEM_SKIN_ITEM_TYPE then
        for _, v_7 in ItemSkinList_upvr do
            v_5 = table.insert
            v_5({}, module_3_upvr.createItemSkinTable(v_7.Name))
            local var93
        end
        return var93
    end
    if ItemType_3 == PlayerDataConsts_upvr.SAFE_ITEM_TYPE then
        for i_8 in SafesConsts_upvr.TYPE_ENUM:GetEnumItems() do
            v_5 = table.insert
            v_5({}, module_3_upvr.createSafeTable(i_8))
            local var98
        end
        return var98
    end
    if ItemType_3 == PlayerDataConsts_upvr.CONSUMABLE_ITEM_TYPE then
        for i_9 in ConsumablesData_upvr do
            v_5 = table.insert
            v_5({}, module_3_upvr.createConsumableTable(i_9))
            local var100
        end
        return var100
    end
    error("Could not find item type data for itemOwned, invalid itemType: "..tostring(ItemType_3))
end
function module_3_upvr.isTradeable(arg1) -- Line 143
    local any_getStoreData_result1 = module_3_upvr.getStoreData(arg1)
    local var102
    if typeof(any_getStoreData_result1) ~= "table" then
        var102 = false
    else
        var102 = true
    end
    assert(var102, "itemData is not a table")
    var102 = any_getStoreData_result1.NoTrade
    return not var102
end
function module_3_upvr.validateItemTableFormat(arg1) -- Line 148
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var103
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if typeof(arg1.Make) ~= "string" then
        var103 = false
    else
        var103 = true
    end
    assert(var103, "Invalid make given for vehicle")
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_3_upvr.getStrippedItemTable(arg1) -- Line 175
    local ItemType_2 = arg1.ItemType
    local module_5 = {
        itemType = ItemType_2;
        uid = arg1.Id;
        created = arg1.CreationTime;
    }
    if ItemType_2 == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
        module_5.name = arg1.Make
        return module_5
    end
    if ItemType_2 == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
        module_5.subItemType = arg1.CategoryName
        module_5.name = arg1.ItemName
        return module_5
    end
    if ItemType_2 == PlayerDataConsts_upvr.HOME_ITEM_ITEM_TYPE then
        module_5.name = arg1.ItemName
        return module_5
    end
    if ItemType_2 == PlayerDataConsts_upvr.ITEM_SKIN_ITEM_TYPE then
        module_5.name = arg1.SkinName
        return module_5
    end
    if ItemType_2 == PlayerDataConsts_upvr.SAFE_ITEM_TYPE then
        module_5.name = SafesConsts_upvr.TYPE_ENUM:GetValueFromEnum(arg1.TypeEnum)
        return module_5
    end
    if ItemType_2 == PlayerDataConsts_upvr.CONSUMABLE_ITEM_TYPE then
        module_5.name = arg1.ItemName
    end
    return module_5
end
function module_3_upvr.getFullNameFromTable(arg1) -- Line 199
    local module_6 = {}
    module_3_upvr.validateItemTableFormat(arg1)
    local any_getStrippedItemTable_result1 = module_3_upvr.getStrippedItemTable(arg1)
    table.insert(module_6, any_getStrippedItemTable_result1.itemType)
    if any_getStrippedItemTable_result1.subItemType then
        table.insert(module_6, any_getStrippedItemTable_result1.subItemType)
    end
    table.insert(module_6, any_getStrippedItemTable_result1.name)
    return table.concat(module_6, '.'), any_getStrippedItemTable_result1
end
local Localization_upvr = require(ReplicatedStorage_upvr.Module.Localization)
function module_3_upvr.getTranslatedTitleFromItemTable(arg1) -- Line 210
    local any_getFullNameFromTable_result1, any_getFullNameFromTable_result2 = module_3_upvr.getFullNameFromTable(arg1)
    local ItemType_4 = arg1.ItemType
    if ItemType_4 == PlayerDataConsts_upvr.SAFE_ITEM_TYPE then
        return SafesConsts_upvr.SAFE_DATA[arg1.TypeEnum].Title
    end
    if ItemType_4 == PlayerDataConsts_upvr.HOME_ITEM_ITEM_TYPE or ItemType_4 == PlayerDataConsts_upvr.ITEM_SKIN_ITEM_TYPE or ItemType_4 == PlayerDataConsts_upvr.CONSUMABLE_ITEM_TYPE then
        return any_getFullNameFromTable_result2.name
    end
    return Localization_upvr:FormatByKey(any_getFullNameFromTable_result1)
end
return module_3_upvr