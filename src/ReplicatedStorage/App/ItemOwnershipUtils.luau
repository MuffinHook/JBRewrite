local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store_upvr = require(ReplicatedStorage.App.store)
local module = {
    isVehicleOwned = function(arg1) -- Line 8, Named "isVehicleOwned"
        local var4
        if type(arg1) ~= "string" then
            return false
        end
        local garageOwned = store_upvr:getState().garageOwned
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var4 = garageOwned.Vehicles
            return var4
        end
        if not garageOwned or not decompInlinedCondition() then
            var4 = false
            return var4
        end
        if garageOwned.Vehicles[arg1] ~= true then
            var4 = false
        else
            var4 = true
        end
        return var4
    end;
    isVehicleCustomizationOwned = function(arg1, arg2) -- Line 20, Named "isVehicleCustomizationOwned"
        local var6
        if type(arg1) ~= "string" or type(arg2) ~= "string" then
            return false
        end
        local garageOwned_2 = store_upvr:getState().garageOwned
        if not garageOwned_2 then
            return false
        end
        local var8 = garageOwned_2[arg1]
        if not var8 then
            var6 = false
            return var6
        end
        if var8[arg2] ~= true then
            var6 = false
        else
            var6 = true
        end
        return var6
    end;
}
local homeStore_upvr = require(ReplicatedStorage.Home.homeStore)
function module.isHomeItemOwned(arg1) -- Line 36
    local var10
    if type(arg1) ~= "string" then
        return false
    end
    local any_getState_result1 = homeStore_upvr:getState()
    if not any_getState_result1 or not any_getState_result1.inventory then
        return false
    end
    var10 = any_getState_result1.inventory
    local HomeItem = var10.HomeItem
    if not HomeItem then
        var10 = false
        return var10
    end
    if 0 >= (HomeItem[arg1] or 0) then
        var10 = false
    else
        var10 = true
    end
    return var10
end
return module