-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBHR5cGUGc3RyaW5nCGdldFN0YXRlC2dhcmFnZU93bmVkCFZlaGljbGVzDmlzVmVoaWNsZU93bmVkG2lzVmVoaWNsZUN1c3RvbWl6YXRpb25Pd25lZAlpbnZlbnRvcnkISG9tZUl0ZW0PaXNIb21lSXRlbU93bmVkBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA0FwcAVzdG9yZQRIb21lCWhvbWVTdG9yZQAEBgEBAAAAHbsoAANSAgAApAEBAAAAAECfAQIC8AEDAAIAAACpAQAAggECAPsBAAC8AQEWAwAAAJ8BAgJNAgEtBAAAAA4CAwBNAwKiBQAAACsDAgCpAwAAggMCAE0FAqIFAAAAhwQFACoEAgABAAAAqQMAAakDAQCCAwIABgMBBAAAAEADAgMDAwQDBQAIBgEYAAAAAAAAAAEAAgAAAAEAAQAAAAEAAgAAAAAAAAAJAAAAAAcCAQAAACO7KAADUgMAAKQCAQAAAABAnwICAvACCAACAACAuygBA1IDAQCkAgEAAAAAQJ8CAgLwAgMAAgAAAKkCAACCAgIA+wIAALwCAhYDAAAAnwICAk0DAi0EAAAAKwMCAKkEAACCBAIAhwQDACsEAgCpBQAAggUCAIcGBAEqBgIAAQAAAKkFAAGpBQEAggUCAAUDAQQAAABAAwIDAwMEABQHARgAAAAAAAAAAAAAAAAAAAEAAgAAAAEAAQEAAgEBAAIAAAAAABUAAAAABgEBAAAAIrsoAANSAgAApAEBAAAAAECfAQIC8AEDAAIAAACpAQAAggECAPsBAAC8AQEWAwAAAJ8BAgIOAQMATQIBgAQAAAArAgIAqQIAAIICAgBNAwGABAAAAE0CA+kFAAAAKwICAKkDAACCAwIAhwUCAJAEBQaMBQAAtwUCAAQAAACpAwABqQMBAIIDAgAHAwEEAAAAQAMCAwMDCAMJAgAAAAAAAAAAACQKARgAAAAAAAAAAQACAAAAAQAAAAEAAgAAAAEBAAIAAAAAAAAAJQAAAAAFAAABAgAkowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAwQYAAABNAgJ+BwAAAJ8BAgKkAgUAAABAQE0DAGoIAAAATQMDggkAAACfAgIC/wMDAAAAAADABAoAEgABADAEA9QLAAAAwAQMABIAAQAwBAO1DQAAAMAEDgASAAIAMAQDiQ8AAACCAwIAEAMLBAAAAEADDAMNAw4EAABAQAMPAxADEQMSBgADBgYBAwcGAgMKAwABAgEAARgAAAAAAAAAAgAAAAAAAAEAAAAAAAACAAIAAAAMAAAAEAAAAA8BAAAAAANvupQjN/v7s/SqObdIq6iMH6KDV11+/iI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:19
-- Luau version 6, Types version 3
-- Time taken: 0.003642 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store_upvr = require(ReplicatedStorage.App.store)
local module = {
    isVehicleOwned = function(arg1) -- Line 8, Named "isVehicleOwned"
        --[[ Upvalues[1]:
            [1]: store_upvr (readonly)
        ]]
        local var4
        if type(arg1) ~= "string" then
            return false
        end
        local garageOwned = store_upvr:getState().garageOwned
        local function INLINED() -- Internal function, doesn't exist in bytecode
            var4 = garageOwned.Vehicles
            return var4
        end
        if not garageOwned or not INLINED() then
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
        --[[ Upvalues[1]:
            [1]: store_upvr (readonly)
        ]]
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
    --[[ Upvalues[1]:
        [1]: homeStore_upvr (readonly)
    ]]
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