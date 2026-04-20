local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local VehicleData_upvr = require(ReplicatedStorage_upvr.Game.Garage.VehicleData)
local function _(arg1) -- Line 14, Named "getVehicleDataForMake"
    for _, v in ipairs(VehicleData_upvr) do
        if v.Make == arg1 then
            return v
        end
    end
end
local ItemSkinList_upvr = require(ReplicatedStorage_upvr.Game.ItemSkin.ItemSkinList)
local function _(arg1) -- Line 24, Named "getItemSkinForName"
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
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
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