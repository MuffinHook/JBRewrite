-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWIUdldExvY2FsVmVoaWNsZVBhY2tldEZvckN1c3RvbWl6ZQRNYWtlBFR5cGUFTW9kZWwETm9uZQtHZXRJbnN0YW5jZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQdWZWhpY2xlDFZlaGljbGVVdGlscw1TZWNvbmRUZXh0dXJlBEdhbWUGR2FyYWdlCUN1c3RvbWl6ZRZnZXREZWZhdWx0VmVoaWNsZU1vZGVsBnNjcmlwdAZQYXJlbnQHVGV4dHVyZQV0YWJsZQVjbG9uZQACBwEDAAAAIvsBAABNAQGmAAAAAJ8BAQL7AgEATQMBrQEAAABNBAERAgAAAJ8CAwLiAwQAMAIDOwMAAABNBAGtAQAAADAEA60BAAAATQQBEQIAAAAwBAMRAgAAAE0EAD8FAAAADgQFAPsEAgDGBQAAUgYDAJ8EAwGCAgIA+wQCAFIFAABSBgMAnwQDAYICAgAGAwEDAgMDAwQFAwMBAgMFAAcGARgAAAAAAQAAAAAAAQAAAAAAAAAAAAABAAABAAAAAAIAAAACCAAAAAAIAAABAgA0owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAjQYAAABNAgJtBwAAAJ8BAgKkAgUAAABAQE0EAL0JAAAATQQEKAoAAABNBAQ7CwAAAE0DBNYIAAAAnwICAqQDBQAAAEBATQQAvQkAAABNBAR2DAAAAJ8DAgKkBAUAAABAQKQFDgAAANBATQUFJA8AAABNBQVPEAAAAJ8EAgLABREAEgABABIAAwASAAIApAYUAABMIIFSBwQAnwYCAjAFBlEVAAAAggYCABYDBwQAAABAAwgDCQMKBAAAQEADCwMMAw0DDgMPAxADEQMSBAAA0EADEwMUBgADFQMWBABMIIEDBgEAAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAQAAAAAAAAAAAgAAAAwAAAABAAEBAAAAAAG96GfQBhiaPgMfFq7S8HN6zfBwpI8sDdE=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:28
-- Luau version 6, Types version 3
-- Time taken: 0.001756 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local SecondTexture_upvr = require(ReplicatedStorage.Game.Garage.Customize.SecondTexture)
local clone = table.clone(require(script.Parent.Texture))
function clone.GetInstance(arg1) -- Line 7
    --[[ Upvalues[3]:
        [1]: VehicleUtils_upvr (readonly)
        [2]: getDefaultVehicleModel_upvr (readonly)
        [3]: SecondTexture_upvr (readonly)
    ]]
    local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
    local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
    local tbl = {
        Model = getDefaultVehicleModel_upvr_result1;
        Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
        Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
    }
    if arg1.None then
        SecondTexture_upvr(nil, tbl)
        return getDefaultVehicleModel_upvr_result1
    end
    SecondTexture_upvr(arg1, tbl)
    return getDefaultVehicleModel_upvr_result1
end
return clone