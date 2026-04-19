-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUCmFsbFBsYXllcnMSbWlzc2luZyBhbGxQbGF5ZXJzBmFzc2VydA5zZWxlY3RlZFBsYXllchNzZXRJbnZlbnRvcnlQbGF5ZXJzFm1pc3Npbmcgc2VsZWN0ZWRQbGF5ZXIjVVBEQVRFX0lOVkVOVE9SWV9QTEFZRVJfUkVNT1RFX05BTUUORmluZEZpcnN0Q2hpbGQKRmlyZVNlcnZlchJzZXRJbnZlbnRvcnlQbGF5ZXIEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFVHJhZGULVHJhZGVDb25zdHMFUm9kdXgHUGxheWVycw1jcmVhdGVSZWR1Y2VyC0xvY2FsUGxheWVyAAMFAgAAAAAWTQQBdAAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMB4gIFAE0DAEsEAAAAMAMCSwQAAABNAwF0AAAAADADAnQAAAAAggICAAYDAQMCAwMEAAAgQAMEBQIEAAAHBQEYAAAAAAAAAAAAAAAAAQAAAAAAAAAAAQgAAAAACAICAAAAI00EAUsAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAeICBQBNAwB0BAAAADADAnQEAAAATQMBSwAAAAAwAwJLAAAAAPsDAAD7BQEATQUF4AYAAAC8AwMDBwAAAJ8DAwJNBgFLAAAAAKkHAQC8BANrCAAAAJ8EBAGCAgIACQMEAwYDAwQAACBAAwEFAgQAAwcDCAMJAAwKARgAAAAAAAAAAAAAAAABAAAAAAAAAAADAAAAAAAAAQAAAAAAAQ0AAAAACAAAAQIAL6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CALsGAAAATQICkQcAAACfAQICpAIFAAAAQEBNAwCnCAAAAJ8CAgKkAwEAAAAAQG8FCQC8AwMWAwAAAJ8DAwJNBALWCgAAAOIFDQBNBgMxDgAAADAGBUsLAAAA/wYAAAAAAAAwBgV0DAAAAOIGEQDABxIAMAcG7Q8AAADABxMAEgAAABIAAQAwBwZPEAAAAJ8EAwCCBAAAFAMLBAAAAEADDAMNAw4EAABAQAMPAxADEQMSAxMDBAMBBQILDAMUAwUDCgUCDxAGAAYBAgABAQABGAAAAAAAAAABAAAAAAAAAQAAAAABAAAAAAACAAAAAAAAAAAAAAABAAAFAAAAAPoAAQAAAAACZNbqjmrqvWq2gc4VbXfLzBTO/fpWEoCP

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:18
-- Luau version 6, Types version 3
-- Time taken: 0.001871 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_2 = {
    setInventoryPlayers = function(arg1, arg2) -- Line 7, Named "setInventoryPlayers"
        local var4
        if arg2.allPlayers == nil then
            var4 = false
        else
            var4 = true
        end
        assert(var4, "missing allPlayers")
        local module_3 = {}
        var4 = arg1.selectedPlayer
        module_3.selectedPlayer = var4
        var4 = arg2.allPlayers
        module_3.allPlayers = var4
        return module_3
    end;
}
local TradeConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeConsts)
function module_2.setInventoryPlayer(arg1, arg2) -- Line 12
    --[[ Upvalues[2]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: TradeConsts_upvr (readonly)
    ]]
    local var7
    if arg2.selectedPlayer == nil then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "missing selectedPlayer")
    local module = {}
    var7 = arg1.allPlayers
    module.allPlayers = var7
    var7 = arg2.selectedPlayer
    module.selectedPlayer = var7
    var7 = ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.UPDATE_INVENTORY_PLAYER_REMOTE_NAME)
    var7:FireServer(arg2.selectedPlayer, true)
    return module
end
return require(ReplicatedStorage_upvr.Rodux).createReducer({
    selectedPlayer = game:GetService("Players").LocalPlayer;
    allPlayers = {};
}, module_2)