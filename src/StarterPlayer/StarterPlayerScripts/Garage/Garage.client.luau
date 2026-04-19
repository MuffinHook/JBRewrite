-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMmBXBhaXJzEkN1c3RvbWl6YXRpb25TbG90cxRDT0xPUl9DQVRFR09SWV9UWVBFUwVDb2xvchZURVhUVVJFX0NBVEVHT1JZX1RZUEVTB1RleHR1cmUEdHlwZQVvd25lZAtzZXRPd25lZFJhdwhkaXNwYXRjaAVzYXZlcwtzZXRTYXZlc1JhdwhlcXVpcHBlZA5zZXRFcXVpcHBlZFJhdwlmYXZvcml0ZWQPc2V0RmF2b3JpdGVkUmF3CmluUGh5c2ljYWwNc2V0SW5QaHlzaWNhbAZzZXRSYXcEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGR2FyYWdlDEdhcmFnZUNvbnN0cwlPd25lcnNoaXAPT3duZXJzaGlwQ29uc3RzA0FwcAVzdG9yZRhVUERBVEVfT1dORURfUkVNT1RFX05BTUUMV2FpdEZvckNoaWxkDU9uQ2xpZW50RXZlbnQHQ29ubmVjdBtVUERBVEVfRVFVSVBQRURfUkVNT1RFX05BTUUcVVBEQVRFX0ZBVk9SSVRFRF9SRU1PVEVfTkFNRRtTRVRfSU5fUEhZU0lDQUxfUkVNT1RFX05BTUULUG9wdWxhclNvcnQdRklMTF9QT1BVTEFSX1NPUlRfUkVNT1RFX05BTUUABggBAgAAAD7/AQAAAAAAAKQCAQAAAABAUgMAAJ8CAgQXAgMA8AUCAAIAAABqBgEFbgL8/wIAAACkAgEAAAAAQPsDAABNAwM2AwAAAJ8CAgQXAgMATQcBpAQAAABqBwEFbgL8/wEAAADGAgAAMAIBpAQAAACkAgEAAAAAQPsDAABNAwMJBQAAAJ8CAgQXAgMATQcBTwYAAABqBwEFbgL8/wEAAAD7AgEA4gQJAG8FCgAwBQRxBwAAADABBOQIAAAAvAICTAsAAACfAgMB+wIBAOIEDQBvBQ4AMAUEcQcAAABNBQC3AgAAADAFBOsMAAAAvAICTAsAAACfAgMBggABAA8DAQQAAABAAwIDAwMEAwUDBgMHAwgFAgcIAwkDCgMLBQIHDAMMAAgAARgAAAEAAAAAAQAB/gAFAAAAAAAAAQAA/wADAAABAAAAAAAAAQAA/wAEAAEAAAEA/gAABAABAAABAAAA/gAABAkAAAAABQEBAAAAC/sBAADiAwIAbwQDADAEA3EAAAAAMAADLgEAAAC8AQFMBAAAAJ8BAwGCAAEABQMHAw0FAgABAw4DCgAiAAEYAAABAAABAP4AAAQjAAAAAAUBAQAAAAv7AQAA4gMCAG8EAwAwBANxAAAAADAAA1ABAAAAvAEBTAQAAACfAQMBggABAAUDBwMPBQIAAQMQAwoAKgABGAAAAQAAAQD+AAAEKwAAAAAFAQEAAAAL+wEAAOIDAgBvBAMAMAQDcQAAAAAwAANEAQAAALwBAUwEAAAAnwEDAYIAAQAFAwcDEQUCAAEDEgMKADIAARgAAAEAAAEA/gAABDMAAAAAAwEBAAAABvsBAABNAQE7AAAAAFICAACfAQIBggABAAEDEwA7AAEYAAAAAAABPAAAAAANAAABAgBhowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAKAYAAABNAgK5BwAAAJ8BAgKkAgUAAABAQE0DAJAIAAAATQMDrAkAAACfAgICpAMFAAAAQEBNBADBCgAAAE0EBH4LAAAAnwMCAk0GAV8MAAAAvAQA0w0AAACfBAMCTQUEjA4AAADABw8AEgACABIAAwC8BQXHEAAAAJ8FAwFNBwFBEQAAALwFANMNAAAAnwUDAk0GBYwOAAAAwAgSABIAAwC8BgbHEAAAAJ8GAwFNCAG9EwAAALwGANMNAAAAnwYDAk0HBowOAAAAwAkUABIAAwC8BwfHEAAAAJ8HAwFNCQEMFQAAALwHANMNAAAAnwcDAk0IB4wOAAAAwAoWABIAAwC8CAjHEAAAAJ8IAwGkCAUAAABAQE0JACgGAAAATQkJXhcAAACfCAICTQsBORgAAAC8CQDTDQAAAJ8JAwJNCgmMDgAAAMAMGQASAAgAvAoKxxAAAACfCgMBggABABoDFAQAAABAAxUDFgMXBAAAQEADGAMZAxoDGwMcAx0DHgMfAyAGAAMhAyIGAQMjBgIDJAYDAyUDJgYEBQABAgMEAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAIAAAAAAAACAAAAAAEAAAAAAAAAGQAAAAABAAAAAAAABwAAAAABAAAAAAAABwAAAAABAAAAAAAABwAAAAAAAAEAAAAAAQAAAAAAAAMBAAAAAAUzhG+uZxYYXgayqvbxwpS4Q5x42gFABa8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:41
-- Luau version 6, Types version 3
-- Time taken: 0.003516 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local store_upvr = require(ReplicatedStorage.App.store)
local OwnershipConsts_upvr = require(ReplicatedStorage.Ownership.OwnershipConsts)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_OWNED_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 8
    --[[ Upvalues[2]:
        [1]: OwnershipConsts_upvr (readonly)
        [2]: store_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local tbl_3 = {}
    for i, v in pairs(arg1) do
        if i ~= "CustomizationSlots" then
            tbl_3[i] = v
        end
    end
    for i_2 in pairs(OwnershipConsts_upvr.COLOR_CATEGORY_TYPES) do
        tbl_3[i_2] = tbl_3.Color
    end
    tbl_3.Color = nil
    for i_3 in pairs(OwnershipConsts_upvr.TEXTURE_CATEGORY_TYPES) do
        tbl_3[i_3] = tbl_3.Texture
    end
    store_upvr:dispatch({
        type = "setOwnedRaw";
        owned = tbl_3;
    })
    store_upvr:dispatch({
        type = "setSavesRaw";
        saves = arg1.CustomizationSlots;
    })
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_EQUIPPED_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 34
    --[[ Upvalues[1]:
        [1]: store_upvr (readonly)
    ]]
    local tbl = {
        type = "setEquippedRaw";
    }
    tbl.equipped = arg1
    store_upvr:dispatch(tbl)
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_FAVORITED_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 42
    --[[ Upvalues[1]:
        [1]: store_upvr (readonly)
    ]]
    local tbl_2 = {
        type = "setFavoritedRaw";
    }
    tbl_2.favorited = arg1
    store_upvr:dispatch(tbl_2)
end)
ReplicatedStorage:WaitForChild(GarageConsts.SET_IN_PHYSICAL_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 50
    --[[ Upvalues[1]:
        [1]: store_upvr (readonly)
    ]]
    local tbl_4 = {
        type = "setInPhysical";
    }
    tbl_4.inPhysical = arg1
    store_upvr:dispatch(tbl_4)
end)
local PopularSort_upvr = require(ReplicatedStorage.Garage.PopularSort)
ReplicatedStorage:WaitForChild(GarageConsts.FILL_POPULAR_SORT_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 59
    --[[ Upvalues[1]:
        [1]: PopularSort_upvr (readonly)
    ]]
    PopularSort_upvr.setRaw(arg1)
end)