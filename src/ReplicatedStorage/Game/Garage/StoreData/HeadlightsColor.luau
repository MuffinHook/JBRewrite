-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMjIUdldExvY2FsVmVoaWNsZVBhY2tldEZvckN1c3RvbWl6ZQRNYWtlBFR5cGUKSGVhZGxpZ2h0cwVNb2RlbAxUcmFuc3BhcmVuY3kIR2V0Q29sb3IETmFtZQVDb2xvcgtHZXRJbnN0YW5jZQJvcwVjbG9jawZDRnJhbWUGQW5nbGVzBG1hdGgDY29zA3NpbgNuZXcLQm91bmRpbmdCb3gEU2l6ZQlNYWduaXR1ZGUGVXBkYXRlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlB1ZlaGljbGUMVmVoaWNsZVV0aWxzBnNjcmlwdAZQYXJlbnQFUGFpbnQER2FtZQZHYXJhZ2UWZ2V0RGVmYXVsdFZlaGljbGVNb2RlbAVJdGVtcwADBgEDAAAAGvsBAABNAQGmAAAAAJ8BAQL7AgEATQMBrQEAAABNBAERAgAAAJ8CAwJNBAI7BAAAAE0DBJ0DAAAAjAQAADAEA9kFAAAA+wQCAE0EBAsGAAAATQUAugcAAACfBAICMAQDpAgAAACCAgIACQMBAwIDAwMEAwUDBgMHAwgDCQAHCgEYAAAAAAEAAAAAAAEAAAABAAABAAAAAAAAAAEIAAAAAA4CAAAAAC+kAgIAAAQAgJ8CAQI+AwIDIQQDBKQHBwAAGFCAjAgAAG8KCAC7CQQDUg0EAKQMDAAALKCAnwwCAlsLDAlDCQoLjAoAAJ8HBAKkCAcAABhQgLsYAwNSDAMApAsPAAA4oICfCwICWwoLCXgJCg2MCgAAjAsAAJ8IBAIJBgcIpAcRAABAUICMCAAAjAkAAE0LAW8TAAAATQsLLxQAAABNCwuqFQAAAFsKCxKfBwQCCQUGBzAFAIUFAAAAggABABYDCwMMBAAEAIACAAAAAAAAAEACGC1EVPshGUADDQMOBAAYUIACGC1EVPshCUACmpmZmZmZuT8DDwMQBAAsoIACmpmZmZmZqT8DEQQAOKCAAxIEAEBQgAJmZmZmZmbmPwMTAxQDFQAQFgEYAAAAAQEBAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAD+AAMRAAAAAAkAAAECADajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCNBgAAAE0CAm0HAAAAnwECAqQCBQAAAEBApAQKAAAAkEBNBAQkCwAAAE0DBKQIAAAAnwICAqQDBQAAAEBATQUAvQ0AAABNBQUoDgAAAE0EBVEMAAAAnwMCAqQEBQAAAEBATQUAvQ0AAABNBQV2DwAAAJ8EAgLABRAAEgABABIABAASAAMAwAYRAE0HAjgSAAAA4ggVADAHCDgSAAAAMAUIURMAAAAwBggmFAAAAIIIAgAWAxcEAAAAQAMYAxkDGgQAAEBAAxsDHAMJAx0EAACQQAMeAx8DIAMhAyIGAAYBAyMDCgMWBQMSExQCAAEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAgAAAAkIAAEBAAEAAQAAAQAAAAACOq2+lL0aDpDoY3cTkH6rMUq1qeAIadSV

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:24
-- Luau version 6, Types version 3
-- Time taken: 0.001852 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local Paint_upvr = require(ReplicatedStorage.Game.Garage.Paint)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        --[[ Upvalues[3]:
            [1]: VehicleUtils_upvr (readonly)
            [2]: getDefaultVehicleModel_upvr (readonly)
            [3]: Paint_upvr (readonly)
        ]]
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        local Headlights = getDefaultVehicleModel_upvr_result1.Model.Headlights
        Headlights.Transparency = 0
        Headlights.Color = Paint_upvr.GetColor(arg1.Name)
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 16, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, math.pi + math.cos(var8 % (-math.pi*2)) * 0.1, 0) * CFrame.Angles(math.sin(var8) * 0.1 - 0.05, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.7)
    end;
}