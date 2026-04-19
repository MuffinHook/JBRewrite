-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMhIUdldExvY2FsVmVoaWNsZVBhY2tldEZvckN1c3RvbWl6ZQRNYWtlBFR5cGUFTW9kZWwETm9uZQtHZXRJbnN0YW5jZQJvcwVjbG9jawZDRnJhbWUGQW5nbGVzBG1hdGgDY29zA3NpbgNuZXcLQm91bmRpbmdCb3gEU2l6ZQlNYWduaXR1ZGUGVXBkYXRlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlB1ZlaGljbGUMVmVoaWNsZVV0aWxzBUNvbG9yBnNjcmlwdAZQYXJlbnQLV2luZG93Q29sb3IER2FtZQZHYXJhZ2UJQ3VzdG9taXplFmdldERlZmF1bHRWZWhpY2xlTW9kZWwFSXRlbXMAAwcBAwAAACL7AQAATQEBpgAAAACfAQEC+wIBAE0DAa0BAAAATQQBEQIAAACfAgMC4gMEADACAzsDAAAATQQBrQEAAAAwBAOtAQAAAE0EARECAAAAMAQDEQIAAABNBAA/BQAAAA4EBQD7BAIAxgUAAFIGAwCfBAMBggICAPsEAgBSBQAAUgYDAJ8EAwGCAgIABgMBAwIDAwMEBQMDAQIDBQAHBgEYAAAAAAEAAAAAAAEAAAAAAAAAAAAAAQAAAQAAAAACAAAAAggAAAAADgIAAAAAL6QCAgAABACAnwIBAj4DAgMhBAMEpAcHAAAYUICMCAAAbwoIALsJBANSDQQApAwMAAAsoICfDAICWwsMCUMJCguMCgAAnwcEAqQIBwAAGFCAuxgDA1IMAwCkCxAAADyggJ8LAgJbCgsOeAkKDYwKAACMCwAAnwgEAgkGBwikBxIAAERQgIwIAACMCQAATQsBbxQAAABNCwsvFQAAAE0LC6oWAAAAWwoLE58HBAIJBQYHMAUAhQUAAACCAAEAFwMHAwgEAAQAgAIAAAAAAAAAQAIYLURU+yEZQAMJAwoEABhQgALSITN/fNkCQAKamZmZmZm5PwMLAwwEACyggAIzMzMzMzPTPwIAAAAAAADQPwMNBAA8oIADDgQARFCAAjMzMzMzM+M/Aw8DEAMRABMSARgAAAABAQEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAP4AAxQAAAAACQAAAQIAOKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAI0GAAAATQICbQcAAACfAQICpAIFAAAAQECkBAoAAACQQE0EBCQLAAAATQMEpAgAAACfAgICpAMFAAAAQEBNBQC9DQAAAE0FBSgOAAAATQUFOw8AAABNBAWDDAAAAJ8DAgKkBAUAAABAQE0FAL0NAAAATQUFdhAAAACfBAICwAURABIAAQASAAQAEgADAMAGEgBNBwI4EwAAAOIIFgAwBwg4EwAAADAFCFEUAAAAMAYIJhUAAACCCAIAFwMTBAAAAEADFAMVAxYEAABAQAMXAxgDGQMaBAAAkEADGwMcAx0DHgMfAyAGAAYBAyEDBgMSBQMTFBUCAAEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAAABAAAAAAAAAAAAAAEAAAAAAAACAAAADAgAAQEAAQABAAABAAAAAAKAKZ/l63T8ZtTRC5BWkeTc8DGIkbLt9eQ=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:34
-- Luau version 6, Types version 3
-- Time taken: 0.001699 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local WindowColor_upvr = require(ReplicatedStorage.Game.Garage.Customize.WindowColor)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        --[[ Upvalues[3]:
            [1]: VehicleUtils_upvr (readonly)
            [2]: getDefaultVehicleModel_upvr (readonly)
            [3]: WindowColor_upvr (readonly)
        ]]
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        local tbl = {
            Model = getDefaultVehicleModel_upvr_result1;
            Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
            Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
        }
        if arg1.None then
            WindowColor_upvr(nil, tbl)
            return getDefaultVehicleModel_upvr_result1
        end
        WindowColor_upvr(arg1, tbl)
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 19, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, 2.356194490192345 + math.cos(var8 % (-math.pi*2)) * 0.1, 0) * CFrame.Angles(math.sin(var8) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.6)
    end;
}