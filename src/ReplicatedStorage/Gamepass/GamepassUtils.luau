-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMkDlByb21wdFB1cmNoYXNlBmFzc2VydARJbml0BmlwYWlycwVUaXRsZQxFbnVtR2FtZXBhc3MTR2V0R2FtZXBhc3NGcm9tRW51bQ5Qcm9tcHRHYW1lcGFzcwZQYXNzSWQVR2V0R2FtZXBhc3NGcm9tUGFzc0lkCkRldlByb2R1Y3QEVHlwZQxHaWZ0R2FtZXBhc3METmFtZR5HZXRHaWZ0UHJvZHVjdEluZm9Gcm9tR2FtZXBhc3MEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkBkVudW1lcgxHYW1lcGFzc0RhdGEIR2FtZXBhc3MIUmVzb3VyY2UIU2V0dGluZ3MFdGFibGUGaW5zZXJ0EUxpc3RHYW1lcGFzc1RpdGxlEkdpZnRHYW1lcGFzc1JlbW90ZRBHSUZUX1JFTU9URV9OQU1FEEdhbWVQYXNzR2lmdERhdGEcR0FNRV9QQVNTX0dJRlRfREFUQVNUT1JFX0tFWRxBbGxvd2VkVG9BdHRlbXB0R2FtZVBhc3NHaWZ0MlBMQVlFUl9BTExPV0VEX1RPX0FUVEVNUFRfR0FNRV9QQVNTX0dJRlRfQVRUUl9OQU1FGkdhbWVQYXNzR2lmdFJlY2VpdmVyVXNlcklkOFBMQVlFUl9HQU1FX1BBU1NfR0lGVF9BVFRFTVBUX1JFQ0VJVkVSX1VTRVJfSURfQVRUUl9OQU1FAAYEAQEAAAAK+wEAAE0DAGEAAAAAuwEDAqQCAgAAABBAnwICAjACAWEAAAAAggABAAMDAQMCBAAAEEAAFQMBGAAAAAAAAAAAAAEWAAAAAAkBAgAAABGkAQEAAAAAQPsCAACfAQIEUQEJAE0GBboCAAAA+wgBAE0ICI0DAAAAhwcIBpoHAgAAAAAAggUCAG4B9v8CAACAggABAAQDBAQAAABAAwUDBgAYBwEYAAAAAAABAAEAAAAAAAH9AAYZAAAAAAQBAQAAABD7AQAATQEBrgAAAABSAgAAnwECArsBAQNSAwEApAICAAAAEECfAgIB+wIAAE0CAmEDAAAAUgMBAJ8CAgGCAAEABAMHAwIEAAAQQAMBACAIARgAAAAAAAEAAAAAAQAAAAABIQAAAAAHAQEAAAANpAEBAAAAAED7AgAAnwECBFEBBQBNBgWQAgAAAJoGAgAAAAAAggUCAG4B+v8CAACAggABAAMDBAQAAABAAwkAJQoBGAAAAAAAAQAAAAH+AAUmAAAAAAcBAQAAABOkAQEAAAAAQPsCAABNAgItAgAAAJ8BAgRRAQkATQYFEQMAAADwBgYABAAAgE0GBboFAAAAmgYCAAAAAACCBQIAbgH2/wIAAICCAAEABgMEBAAAAEADCwMMAw0DDgAsDwEYAAAAAAAAAAEAAAAAAAAAAf4ABS0AAAAADQAAAQAAWKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICVwcAAACfAQICpAIFAAAAQEBNBAC9CQAAAE0DBIUIAAAAnwICAqQDBQAAAEBATQQAYgoAAABNBATKCwAAAJ8DAgL/BAAAAAAAAKQFDQAAAMBAUgYCAJ8FAgRRBQgATQwJug4AAACeNAQEDAAAAFILBACkChEAAEDwgJ8KAwFuBff/AgAAgP8FBQAAAAAAMAQFeBIAAABSBgEAUgcEAJ8GAgIwBgWNEwAAAG8GFAAwBgUaFQAAAG8GFgAwBgXKFwAAAG8GGAAwBgXhGQAAAG8GGgAwBgXdGwAAAMAGHAASAAUAMAYFcx0AAADABh4AEgACABIABQAwBgWuHwAAAMAGIAASAAUAMAYF8CEAAADABiIAEgACADAGBR4jAAAAwAYkABIAAwAwBgUbJQAAAIIFAgAmAxAEAAAAQAMRAxIDEwQAAEBAAxQDFQMWAxcDGAMZAwQEAADAQAMFAxoDGwQAQPCAAxwDBgMdAx4DHwMgAyEDIgMjAyQGAAMDBgEDBwYCAwgGAwMKBgQDDwUAAQIDBAEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAgABAAAAAAEAAAAAAAAA/wAEAAEAAQAAAAADAAABAAABAAABAAACAAAAAwAAAAAIAAAABQAAAAcAAAAHAQAAAAAFFoxg0vic/KTCUV0rVVW4zmaUd6YkSArT

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:10
-- Luau version 6, Types version 3
-- Time taken: 0.003831 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassData_upvr = require(ReplicatedStorage.Gamepass.GamepassData)
local tbl = {}
for _, v in ipairs(GamepassData_upvr) do
    table.insert(tbl, v.Title)
end
local module_upvr = {
    ListGamepassTitle = tbl;
    EnumGamepass = require(ReplicatedStorage.Std.Enumer)(tbl);
    GIFT_REMOTE_NAME = "GiftGamepassRemote";
    GAME_PASS_GIFT_DATASTORE_KEY = "GamePassGiftData";
    PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME = "AllowedToAttemptGamePassGift";
    PLAYER_GAME_PASS_GIFT_ATTEMPT_RECEIVER_USER_ID_ATTR_NAME = "GamePassGiftReceiverUserId";
}
function module_upvr.Init(arg1) -- Line 21
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    module_upvr.PromptPurchase = assert(arg1.PromptPurchase)
end
function module_upvr.GetGamepassFromEnum(arg1) -- Line 24
    --[[ Upvalues[2]:
        [1]: GamepassData_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    for _, v_2 in ipairs(GamepassData_upvr) do
        if module_upvr.EnumGamepass[v_2.Title] == arg1 then
            return v_2
        end
    end
end
function module_upvr.PromptGamepass(arg1) -- Line 32
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local any_GetGamepassFromEnum_result1 = module_upvr.GetGamepassFromEnum(arg1)
    assert(any_GetGamepassFromEnum_result1)
    module_upvr.PromptPurchase(any_GetGamepassFromEnum_result1)
end
function module_upvr.GetGamepassFromPassId(arg1) -- Line 37
    --[[ Upvalues[1]:
        [1]: GamepassData_upvr (readonly)
    ]]
    for _, v_3 in ipairs(GamepassData_upvr) do
        if v_3.PassId == arg1 then
            return v_3
        end
    end
end
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module_upvr.GetGiftProductInfoFromGamepass(arg1) -- Line 44
    --[[ Upvalues[1]:
        [1]: Settings_upvr (readonly)
    ]]
    for _, v_4 in ipairs(Settings_upvr.DevProduct) do
        if v_4.Type == "GiftGamepass" and v_4.Name == arg1 then
            return v_4
        end
    end
end
return module_upvr