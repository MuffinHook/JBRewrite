local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local SaleConsts_upvr = require(ReplicatedStorage_upvr.Sale.SaleConsts)
local SaleUtils_upvr = require(ReplicatedStorage_upvr.Sale.SaleUtils)
local GarageUtils_upvr = require(ReplicatedStorage_upvr.Garage.GarageUtils)
local module_2_upvr = {
    onSaleRefresh = require(ReplicatedStorage_upvr.Std.Signal).new();
}
local any_getNextSaleTime_result1_2_upvw = SaleUtils_upvr.getNextSaleTime()
require(ReplicatedStorage_upvr.Std.Interval).every(1):Connect(function() -- Line 17
    local any_getNextSaleTime_result1 = SaleUtils_upvr.getNextSaleTime()
    if any_getNextSaleTime_result1_2_upvw + 0.01 < any_getNextSaleTime_result1 then
        any_getNextSaleTime_result1_2_upvw = any_getNextSaleTime_result1
        module_2_upvr.onSaleRefresh:Fire()
    end
end)
local function _(arg1) -- Line 26, Named "canVehicleCustomizationGoOnSale"
    local var10 = not GarageUtils_upvr.isVehicleCustomizationLimited(arg1)
    if var10 then
        var10 = not arg1.None
        if var10 then
            if arg1.Price then
                var10 = false
                if arg1.Price < 1000000 then
                    if 0 >= arg1.Price then
                        var10 = false
                    else
                        var10 = true
                    end
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            else
                var10 = false
            end
            if var10 then
                var10 = not arg1.NoGarageUI
            end
        end
    end
    return var10
end
local function _(arg1) -- Line 32, Named "canVehicleGoOnSale"
    local var12 = not GarageUtils_upvr.isVehicleLimited(arg1)
    if var12 then
        var12 = not arg1.None
        if var12 then
            if arg1.Price then
                var12 = false
                if arg1.Price < 1000000 then
                    if 0 >= arg1.Price then
                        var12 = false
                    else
                        var12 = true
                    end
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            else
                var12 = false
            end
            if var12 then
                var12 = not arg1.NoGarageUI
                if var12 then
                    var12 = not arg1.NoMainWorldGarageSpawn
                    if var12 then
                        var12 = not arg1.ExcludeFromSale
                    end
                end
            end
        end
    end
    return var12
end
local function applySeededSort_upvr(arg1, arg2) -- Line 40, Named "applySeededSort"
    table.sort(arg1, function(arg1_2, arg2_2) -- Line 42
        local var18
        if arg1_2.Pointer[arg2] >= arg2_2.Pointer[arg2] then
            var18 = false
        else
            var18 = true
        end
        return var18
    end)
    local random_state = Random.new(SaleUtils_upvr.getNumSalesPassed())
    for _, v in arg1 do
        v.SortNumber = random_state:NextNumber()
    end
    table.sort(arg1, function(arg1_3, arg2_3) -- Line 52
        local var21
        if arg1_3.SortNumber >= arg2_3.SortNumber then
            var21 = false
        else
            var21 = true
        end
        return var21
    end)
end
local VehicleConf_upvr = require(ReplicatedStorage_upvr.Game.Garage.VehicleConf)
local OwnershipConsts_upvr = require(ReplicatedStorage_upvr.Ownership.OwnershipConsts)
local function _getOnSaleVehicleCustomizations_upvr() -- Line 56, Named "_getOnSaleVehicleCustomizations"
    local tbl = {}
    for _, v_2 in VehicleConf_upvr.CATEGORIES do
        if v_2 ~= SaleConsts_upvr.CATEGORY_NAME and not OwnershipConsts_upvr.COLOR_CATEGORY_TYPES[v_2] and not OwnershipConsts_upvr.TEXTURE_CATEGORY_TYPES[v_2] then
            for _, v_3 in require(ReplicatedStorage_upvr.Game.Garage.StoreData:FindFirstChild(v_2)).Items do
                table.insert(tbl, {
                    CategoryName = v_2;
                    Pointer = v_3;
                })
            end
            ;({})[v_2] = true
        end
    end
    for _, _ in {} do
        local var66
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    end
    applySeededSort_upvr(tbl, "Name")
    local module = {}
    local module_4 = {}
    local tbl_6 = {}
    for _, v_5 in tbl do
        local CategoryName = v_5.CategoryName
        local Pointer_3 = v_5.Pointer
        if not GarageUtils_upvr.isVehicleCustomizationLimited(Pointer_3) then
            if not Pointer_3.None then
                if Pointer_3.Price then
                    if Pointer_3.Price < 1000000 then
                        if 0 >= Pointer_3.Price then
                        else
                        end
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                else
                end
                if false then
                end
            end
        end
        if not Pointer_3.NoGarageUI then
            if not tbl_6[CategoryName] then
                local clone = table.clone(v_5.Pointer)
                clone.CategoryName = CategoryName
                table.insert(module, clone)
                if not module_4[CategoryName] then
                    module_4[CategoryName] = {}
                end
                module_4[CategoryName][v_5.Pointer.Name] = true
                tbl_6[CategoryName] = true
            end
        end
        if SaleConsts_upvr.NUM_VEHICLE_CUSTOMIZATIONS <= #module then break end
    end
    return module, module_4
end
local VehicleData_upvr = require(ReplicatedStorage_upvr.Game.Garage.VehicleData)
local function _getOnSaleVehicles_upvr() -- Line 113, Named "_getOnSaleVehicles"
    local tbl_2 = {}
    for _, v_6 in VehicleData_upvr do
        local tbl_5 = {
            Pointer = v_6;
        }
        table.insert(tbl_2, tbl_5)
    end
    applySeededSort_upvr(tbl_2, "Make")
    local module_5 = {}
    for _, v_7 in tbl_2 do
        local Pointer = v_7.Pointer
        tbl_5 = not GarageUtils_upvr.isVehicleLimited(Pointer)
        local var99 = tbl_5
        if var99 then
            var99 = not Pointer.None
            if var99 then
                if Pointer.Price then
                    var99 = false
                    if Pointer.Price < 1000000 then
                        if 0 >= Pointer.Price then
                            var99 = false
                        else
                            var99 = true
                        end
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                else
                    var99 = false
                end
                if var99 then
                    var99 = not Pointer.NoGarageUI
                    if var99 then
                        var99 = not Pointer.NoMainWorldGarageSpawn
                        if var99 then
                            var99 = not Pointer.ExcludeFromSale
                        end
                    end
                end
            end
        end
        if var99 then
            table.insert(module_5, v_7.Pointer)
            ;({})[v_7.Pointer.Make] = true
        end
        if SaleConsts_upvr.NUM_VEHICLES <= #module_5 then break end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return module_5, {}
end
module_2_upvr._cachedOnSaleVehicleCustomizations = nil
module_2_upvr._cachedOnSaleVehicleCustomizationsMap = nil
local function cacheOnSaleVehicleCustomizationsIfNeeded_upvr() -- Line 139, Named "cacheOnSaleVehicleCustomizationsIfNeeded"
    if module_2_upvr._cachedOnSaleVehicleCustomizations == nil then
        local _getOnSaleVehicleCustomizations_result1, _getOnSaleVehicleCustomizations_result2 = _getOnSaleVehicleCustomizations_upvr()
        module_2_upvr._cachedOnSaleVehicleCustomizations = _getOnSaleVehicleCustomizations_result1
        module_2_upvr._cachedOnSaleVehicleCustomizationsMap = _getOnSaleVehicleCustomizations_result2
        task.delay(math.min(60, SaleUtils_upvr.getTimeToNextSale() - 1), function() -- Line 144
            module_2_upvr._cachedOnSaleVehicleCustomizations = nil
            module_2_upvr._cachedOnSaleVehicleCustomizationsMap = nil
        end)
    end
end
function module_2_upvr.getOnSaleVehicleCustomizations() -- Line 150
    cacheOnSaleVehicleCustomizationsIfNeeded_upvr()
    return module_2_upvr._cachedOnSaleVehicleCustomizations
end
function module_2_upvr.isVehicleCustomizationOnSale(arg1, arg2) -- Line 154
    if arg1 == nil then
    else
    end
    assert(true, "categoryName must not be nil")
    if arg2 == nil then
    else
    end
    assert(true, "itemName must not be nil")
    cacheOnSaleVehicleCustomizationsIfNeeded_upvr()
    if module_2_upvr._cachedOnSaleVehicleCustomizationsMap[arg1] ~= nil then
        if module_2_upvr._cachedOnSaleVehicleCustomizationsMap[arg1][arg2] ~= true then
        else
        end
    end
    return true
end
module_2_upvr._cachedOnSaleVehicles = nil
module_2_upvr._cachedOnSaleVehiclesMap = nil
local function cacheOnSaleVehiclesIfNeeded_upvr() -- Line 163, Named "cacheOnSaleVehiclesIfNeeded"
    if module_2_upvr._cachedOnSaleVehicles == nil then
        local _getOnSaleVehicles_upvr_result1, _getOnSaleVehicles_upvr_result2 = _getOnSaleVehicles_upvr()
        module_2_upvr._cachedOnSaleVehicles = _getOnSaleVehicles_upvr_result1
        module_2_upvr._cachedOnSaleVehiclesMap = _getOnSaleVehicles_upvr_result2
        task.delay(math.min(60, SaleUtils_upvr.getTimeToNextSale() - 1), function() -- Line 167
            module_2_upvr._cachedOnSaleVehicles = nil
            module_2_upvr._cachedOnSaleVehiclesMap = nil
        end)
    end
end
function module_2_upvr.getOnSaleVehicles() -- Line 173
    cacheOnSaleVehiclesIfNeeded_upvr()
    return module_2_upvr._cachedOnSaleVehicles
end
function module_2_upvr.isVehicleOnSale(arg1) -- Line 177
    if arg1 == nil then
    else
    end
    assert(true, "vehicleMake must not be nil")
    cacheOnSaleVehiclesIfNeeded_upvr()
    if module_2_upvr._cachedOnSaleVehiclesMap[arg1] ~= true then
    else
    end
    return true
end
return module_2_upvr