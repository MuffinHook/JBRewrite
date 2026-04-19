-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMlIUdldExvY2FsVmVoaWNsZVBhY2tldEZvckN1c3RvbWl6ZQRNYWtlBFR5cGUFTW9kZWwLR2V0SW5zdGFuY2UCb3MFY2xvY2sGQ0ZyYW1lBkFuZ2xlcwRtYXRoA2NvcwNzaW4DbmV3C0JvdW5kaW5nQm94BFNpemUJTWFnbml0dWRlBlVwZGF0ZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQdWZWhpY2xlDFZlaGljbGVVdGlscwpXaW5kb3dUaW50BnNjcmlwdAZQYXJlbnQJQ3VzdG9taXplBEdhbWUWZ2V0RGVmYXVsdFZlaGljbGVNb2RlbAROYW1lBVByaWNlBVZhbHVlAjgwAjYwAjQwAjIwBUl0ZW1zAAMHAQMAAAAa+wEAAE0BAaYAAAAAnwEBAvsCAQBNAwGtAQAAAE0EARECAAAAnwIDAuIDBAAwAgM7AwAAAE0EAa0BAAAAMAQDrQEAAABNBAERAgAAADAEAxECAAAA+wQCAFIFAABSBgMAnwQDAYICAgAFAwEDAgMDAwQFAwMBAgAGBQEYAAAAAAEAAAAAAAEAAAAAAAAAAAAAAQAAAAEHAAAAAA4CAAAAAC+kAgIAAAQAgJ8CAQI+AwIDIQQDBKQHBwAAGFCAjAgAAG8KCAC7CQQDUg0EAKQMDAAALKCAnwwCAlsLDAlDCQoLjAoAAJ8HBAKkCAcAABhQgLsYAwNSDAMApAsQAAA8oICfCwICWwoLDngJCg2MCgAAjAsAAJ8IBAIJBgcIpAcSAABEUICMCAAAjAkAAE0LAW8UAAAATQsLLxUAAABNCwuqFgAAAFsKCxOfBwQCCQUGBzAFAIUFAAAAggABABcDBgMHBAAEAIACAAAAAAAAAEACGC1EVPshGUADCAMJBAAYUIAC0iEzf3zZAkACmpmZmZmZuT8DCgMLBAAsoIACMzMzMzMz0z8CAAAAAAAA0D8DDAQAPKCAAw0EAERQgAIzMzMzMzPjPwMOAw8DEAAOEQEYAAAAAQEBAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAD+AAMPAAAAAAwAAAECAFujAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCNBgAAAE0CAm0HAAAAnwECAqQCBQAAAEBApAQKAAAAkEBNBAQkCwAAAE0EBCQLAAAATQQEOwwAAABNAwSGCAAAAJ8CAgKkAwUAAABAQE0EAL0NAAAATQQEdg4AAACfAwICwAQPABIAAQASAAMAEgACAMAFEAD/BgAABAAAAOIHFABvCBUAMAgHuhEAAACMCLgLMAgHJBIAAABvCBYAMAgH7BMAAADiCBQAbwkXADAJCLoRAAAAjAm4CzAJCCQSAAAAbwkYADAJCOwTAAAA4gkUAG8KGQAwCgm6EQAAAIwKuAswCgkkEgAAAG8KGgAwCgnsEwAAAOIKFABvCxsAMAsKuhEAAACMC7gLMAsKJBIAAABvCxwAMAsK7BMAAADFBgcFAQAAAOIHIAAwBgc4HQAAADAEB1EeAAAAMAUHJh8AAACCBwIAIQMSBAAAAEADEwMUAxUEAABAQAMWAxcDGAMZBAAAkEADGgMbAxwDHQYABgEDHgMfAyAFAxESEwMhApqZmZmZmek/AyICMzMzMzMz4z8DIwKamZmZmZnZPwMkApqZmZmZmck/AyUDBQMRBQMdHh8CAAEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAIAAAAICAABAQAAAQAAAQAAAgEAAAEAAAEAAAIBAAABAAABAAACAQAAAQAAAQAAAAADAQABAAEAAAEAAAAAAoJblRgdE2k2qconEq12bMbyQ4JssJ//GQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:35
-- Luau version 6, Types version 3
-- Time taken: 0.002008 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local WindowTint_upvr = require(script.Parent.Parent.Customize.WindowTint)
return {
    Items = {{
        Name = "80";
        Price = 3000;
        Value = 0.8;
    }, {
        Name = "60";
        Price = 3000;
        Value = 0.6;
    }, {
        Name = "40";
        Price = 3000;
        Value = 0.4;
    }, {
        Name = "20";
        Price = 3000;
        Value = 0.2;
    }};
    GetInstance = function(arg1) -- Line 6, Named "GetInstance"
        --[[ Upvalues[3]:
            [1]: VehicleUtils_upvr (readonly)
            [2]: getDefaultVehicleModel_upvr (readonly)
            [3]: WindowTint_upvr (readonly)
        ]]
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        WindowTint_upvr(arg1, {
            Model = getDefaultVehicleModel_upvr_result1;
            Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
            Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
        })
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 14, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, 2.356194490192345 + math.cos(var8 % (-math.pi*2)) * 0.1, 0) * CFrame.Angles(math.sin(var8) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.6)
    end;
}