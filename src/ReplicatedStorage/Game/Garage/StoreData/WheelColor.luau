-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfIUdldExvY2FsVmVoaWNsZVBhY2tldEZvckN1c3RvbWl6ZQRNYWtlBFR5cGUFTW9kZWwLR2V0SW5zdGFuY2UCb3MFY2xvY2sGQ0ZyYW1lBkFuZ2xlcwRtYXRoA3NpbgNuZXcLQm91bmRpbmdCb3gEU2l6ZQlNYWduaXR1ZGUGVXBkYXRlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlB1ZlaGljbGUMVmVoaWNsZVV0aWxzBUNvbG9yBnNjcmlwdAZQYXJlbnQKV2hlZWxDb2xvcgRHYW1lBkdhcmFnZQlDdXN0b21pemUWZ2V0RGVmYXVsdFZlaGljbGVNb2RlbAVJdGVtcwADBwEDAAAAGvsBAABNAQGmAAAAAJ8BAQL7AgEATQMBrQEAAABNBAERAgAAAJ8CAwLiAwQAMAIDOwMAAABNBAGtAQAAADAEA60BAAAATQQBEQIAAAAwBAMRAgAAAPsEAgBSBQAAUgYDAJ8EAwGCAgIABQMBAwIDAwMEBQMDAQIABwUBGAAAAAABAAAAAAABAAAAAAAAAAAAAAEAAAABCAAAAAANAgAAAAAopAICAAAEAICfAgECPgMCAyEEAwSkBwcAABhQgIwIAABSCQQAjAoAAJ8HBAKkCAcAABhQgLsYAwNSDAMApAsMAAAsoICfCwICWwoLCXgJCgiMCgAAjAsAAJ8IBAIJBgcIpAcOAAA0UICMCAAAjAkAAE0LAW8QAAAATQsLLxEAAABNCwuqEgAAAFsKCw+fBwQCCQUGBzAFAIUFAAAAggABABMDBgMHBAAEAIACAAAAAAAAAEACGC1EVPshGUADCAMJBAAYUIACMzMzMzMz0z8CAAAAAAAA0D8DCgMLBAAsoIADDAQANFCAAmZmZmZmZuY/Aw0DDgMPAA8QARgAAAABAQEAAAAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA/gADEAAAAAAJAAABAgA4owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAjQYAAABNAgJtBwAAAJ8BAgKkAgUAAABAQKQECgAAAJBATQQEJAsAAABNAwSkCAAAAJ8CAgKkAwUAAABAQE0FAL0NAAAATQUFKA4AAABNBQU7DwAAAE0EBWQMAAAAnwMCAqQEBQAAAEBATQUAvQ0AAABNBQV2EAAAAJ8EAgLABREAEgABABIABAASAAMAwAYSAE0HAjgTAAAA4ggWADAHCDgTAAAAMAUIURQAAAAwBggmFQAAAIIIAgAXAxEEAAAAQAMSAxMDFAQAAEBAAxUDFgMXAxgEAACQQAMZAxoDGwMcAx0DHgYABgEDHwMFAxAFAxMUFQIAAQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAIAAAAICAABAQABAAEAAAEAAAAAAmVldnRmQPWYdv2QUsrt9rcVfWEAV6EcdQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:33
-- Luau version 6, Types version 3
-- Time taken: 0.002059 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local WheelColor_upvr = require(ReplicatedStorage.Game.Garage.Customize.WheelColor)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        --[[ Upvalues[3]:
            [1]: VehicleUtils_upvr (readonly)
            [2]: getDefaultVehicleModel_upvr (readonly)
            [3]: WheelColor_upvr (readonly)
        ]]
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        WheelColor_upvr(arg1, {
            Model = getDefaultVehicleModel_upvr_result1;
            Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
            Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
        })
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 15, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var8 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var8) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.7)
    end;
}