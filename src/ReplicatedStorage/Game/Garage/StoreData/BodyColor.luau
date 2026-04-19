-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMjIUdldExvY2FsVmVoaWNsZVBhY2tldEZvckN1c3RvbWl6ZQRNYWtlBFR5cGUEQm9keQ5GaW5kRmlyc3RDaGlsZAAJVGV4dHVyZUlEBU1vZGVsBE5vbmULR2V0SW5zdGFuY2UCb3MFY2xvY2sGQ0ZyYW1lBkFuZ2xlcwRtYXRoA3NpbgNuZXcOR2V0RXh0ZW50c1NpemUJTWFnbml0dWRlBlVwZGF0ZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQdWZWhpY2xlDFZlaGljbGVVdGlscwVDb2xvcgZzY3JpcHQGUGFyZW50CUJvZHlDb2xvcgRHYW1lBkdhcmFnZQlDdXN0b21pemUWZ2V0RGVmYXVsdFZlaGljbGVNb2RlbAVJdGVtcwADCAEDAAAAKvsBAABNAQGmAAAAAJ8BAQL7AgEATQMBrQEAAABNBAERAgAAAJ8CAwJvBQMAqQYBALwDAgMEAAAAnwMEAm8EBQAwBAOEBgAAAOIECAAwAgQ7BwAAAE0FAa0BAAAAMAUErQEAAABNBQERAgAAADAFBBECAAAATQUAPwkAAAAOBQUA+wUCAMYGAABSBwQAnwUDAYICAgD7BQIAUgYAAFIHBACfBQMBggICAAoDAQMCAwMDBAMFAwYDBwMIBQMHAQIDCQAHCgEYAAAAAAEAAAAAAAEAAAAAAQAAAQAAAAAAAAAAAAABAAABAAAAAAIAAAADCAAAAAANAgAAAAAnpAICAAAEAICfAgECPgMCAyEEAwSkBwcAABhQgIwIAABSCQQAjAoAAJ8HBAKkCAcAABhQgLsYAwNSDAMApAsMAAAsoICfCwICWwoLCXgJCgiMCgAAjAsAAJ8IBAIJBgcIpAcOAAA0UICMCAAAjAkAALwLAaUQAAAAnwsCAk0LC6oRAAAAWwoLD58HBAIJBQYHMAUAhQUAAACCAAEAEgMLAwwEAAQAgAIAAAAAAAAAQAIYLURU+yEZQAMNAw4EABhQgAIzMzMzMzPTPwIAAAAAAADQPwMPAxAEACyggAMRBAA0UIACMzMzMzMz4z8DEgMTABYUARgAAAABAQEAAAAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAD+AAMXAAAAAAkAAAECADijAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCNBgAAAE0CAm0HAAAAnwECAqQCBQAAAEBApAQKAAAAkEBNBAQkCwAAAE0DBKQIAAAAnwICAqQDBQAAAEBATQUAvQ0AAABNBQUoDgAAAE0FBTsPAAAATQQFygwAAACfAwICpAQFAAAAQEBNBQC9DQAAAE0FBXYQAAAAnwQCAsAFEQASAAEAEgAEABIAAwDABhIATQcCOBMAAADiCBYAMAcIOBMAAAAwBQhRFAAAADAGCCYVAAAAgggCABcDFQQAAABAAxYDFwMYBAAAQEADGQMaAxsDHAQAAJBAAx0DHgMfAyADIQMiBgAGAQMjAwoDFAUDExQVAgABAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAgAAAA8IAAEBAAEAAQAAAQAAAAACwZF6In2khYNEjeidNCWzirGJbVbzVRAj

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:19
-- Luau version 6, Types version 3
-- Time taken: 0.001733 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local BodyColor_upvr = require(ReplicatedStorage.Game.Garage.Customize.BodyColor)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        --[[ Upvalues[3]:
            [1]: VehicleUtils_upvr (readonly)
            [2]: getDefaultVehicleModel_upvr (readonly)
            [3]: BodyColor_upvr (readonly)
        ]]
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        getDefaultVehicleModel_upvr_result1:FindFirstChild("Body", true).TextureID = ""
        local tbl = {
            Model = getDefaultVehicleModel_upvr_result1;
            Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
            Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
        }
        if arg1.None then
            BodyColor_upvr(nil, tbl)
            return getDefaultVehicleModel_upvr_result1
        end
        BodyColor_upvr(arg1, tbl)
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 22, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var8 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var8) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2:GetExtentsSize().Magnitude * 0.6)
    end;
}