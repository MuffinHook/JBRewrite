-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUBW1lcmdlBHR5cGUWc2V0UmV3YXJkU3Bpbm5lckNvbmZpZwhkaXNwYXRjaA1PbkNsaWVudEV2ZW50B0Nvbm5lY3QQU1BJTl9SRU1PVEVfTkFNRQdhbmRUaGVuBGluaXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkCkRpY3Rpb25hcnkNUmV3YXJkU3Bpbm5lchNSZXdhcmRTcGlubmVyQ29uc3RzDHdhaXRGb3JDaGlsZANBcHAFc3RvcmUABAYBAgAAAA77AQAA+wMBAE0DAx8AAAAA4gQCAG8FAwAwBQRxAQAAAFIFAACfAwMAvAEBTAQAAACfAQABggABAAUDAQMCBQEBAwMDBAAKAAEYAAAAAAABAAAB/gAAAAMLAAAAAAQBAgAAAAlNAQCMAAAAAMADAQASAgAAEgIBALwBAccCAAAAnwEDAYIAAQADAwUGAAMGAQAJAAEYAAAAAAAAAAAFCgAAAAADAAUAAAAN+wAAAPsBAQD7AgIATQICSQAAAACfAAMCwAIBABICAwASAgQAvAAAtQIAAACfAAMBggABAAMDBwYBAwgBAQgJARgAAAAAAAAAAAAAAAAHCQAAAAAHAAABAgAuowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgKpBwAAAJ8BAgKkAgUAAABAQE0DALcIAAAATQMDZwkAAACfAgICpAMFAAAAQEBNBAChBgAAAE0EBPMKAAAAnwMCAqQEBQAAAEBATQUAwQsAAABNBQV+DAAAAJ8EAgL/BQEAAAAAAMAGDQASAAMAEgAAABIAAgASAAQAEgABADAGBRMOAAAAggUCAA8DCgQAAABAAwsDDAMNBAAAQEADDgMPAxADEQMSAxMDFAYCAwkBAgEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAIAAQAAAAAAAAAJAQAAAAADa2pvIHsxOl1/AhlPAQwGGRtyeFRZrgUh

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:26
-- Luau version 6, Types version 3
-- Time taken: 0.001329 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local RewardSpinnerConsts_upvr = require(ReplicatedStorage_upvr.RewardSpinner.RewardSpinnerConsts)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local Dictionary_upvr = require(ReplicatedStorage_upvr.Std.Dictionary)
function module.init() -- Line 8
    --[[ Upvalues[5]:
        [1]: waitForChild_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RewardSpinnerConsts_upvr (readonly)
        [4]: store_upvr (readonly)
        [5]: Dictionary_upvr (readonly)
    ]]
    waitForChild_upvr(ReplicatedStorage_upvr, RewardSpinnerConsts_upvr.SPIN_REMOTE_NAME):andThen(function(arg1) -- Line 9
        --[[ Upvalues[2]:
            [1]: store_upvr (copied, readonly)
            [2]: Dictionary_upvr (copied, readonly)
        ]]
        arg1.OnClientEvent:Connect(function(arg1_2) -- Line 10
            --[[ Upvalues[2]:
                [1]: store_upvr (copied, readonly)
                [2]: Dictionary_upvr (copied, readonly)
            ]]
            store_upvr:dispatch(Dictionary_upvr.merge({
                type = "setRewardSpinnerConfig";
            }, arg1_2))
        end)
    end)
end
return module