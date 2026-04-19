-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPIHRyYW5zbGF0ZVRvSXRlbU93bmVkQ2F0ZWdvcnlOYW1lI2NyZWF0ZVZlaGljbGVDdXN0b21pemF0aW9uSXRlbVRhYmxlIGdldFZlaGljbGVDdXN0b21pemF0aW9uSXRlbU93bmVkFENPTE9SX0NBVEVHT1JZX1RZUEVTBUNvbG9yFlRFWFRVUkVfQ0FURUdPUllfVFlQRVMHVGV4dHVyZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNBcHAJSXRlbVV0aWxzCU93bmVyc2hpcA9Pd25lcnNoaXBDb25zdHMAAwYCAgAAAAz7AgAATQICDgAAAABSAwAAnwICAvsDAQBNAwOuAQAAAFIEAgBSBQEAnwMDAIIDAAACAwEDAgAGAwEYAAAAAAABAAAAAAAABwAAAAADAQEAAAAP+wIAAE0CAjYAAAAAhwECAA4BAgBvAQEAggECAPsCAABNAgIJAgAAAIcBAgAOAQIAbwEDAIIBAgCCAAIABAMEAwUDBgMHAAoBARgAAAAAAAEAAgAAAAABAAILAAAAAAUAAAECACGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgDBBgAAAE0CAi4HAAAAnwECAqQCBQAAAEBATQMAkAgAAABNAwOsCQAAAJ8CAgL/AwIAAAAAAMAECgASAAMAEgABADAEA+0LAAAAwAQMABIAAgAwBAMODQAAAIIDAgAOAwgEAAAAQAMJAwoDCwQAAEBAAwwDDQMOAw8GAAMDBgEDAQIAAQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAACAAEAAAAABAAAAAoBAAAAAALfpRm4+RZ/C0YSoUxsQzTkr70OzO1hc7k=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:12
-- Luau version 6, Types version 3
-- Time taken: 0.001396 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local ItemUtils_upvr = require(ReplicatedStorage.App.ItemUtils)
function module_upvr.getVehicleCustomizationItemOwned(arg1, arg2) -- Line 6
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: ItemUtils_upvr (readonly)
    ]]
    return ItemUtils_upvr.createVehicleCustomizationItemTable(module_upvr.translateToItemOwnedCategoryName(arg1), arg2)
end
local OwnershipConsts_upvr = require(ReplicatedStorage.Ownership.OwnershipConsts)
function module_upvr.translateToItemOwnedCategoryName(arg1) -- Line 10
    --[[ Upvalues[1]:
        [1]: OwnershipConsts_upvr (readonly)
    ]]
    if OwnershipConsts_upvr.COLOR_CATEGORY_TYPES[arg1] then
        return "Color"
    end
    if OwnershipConsts_upvr.TEXTURE_CATEGORY_TYPES[arg1] then
        return "Texture"
    end
    return arg1
end
return module_upvr