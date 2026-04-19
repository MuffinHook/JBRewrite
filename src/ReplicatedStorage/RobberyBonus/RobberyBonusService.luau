-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQCGF0Mnk0bHdzDU9uQ2xpZW50RXZlbnQHQ29ubmVjdAJlbRdGSVJFV09SS19GWF9SRU1PVEVfTkFNRQdhbmRUaGVuBGluaXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudBJSb2JiZXJ5Qm9udXNDb25zdHMDU3RkDHdhaXRGb3JDaGlsZAAEAgABAAAABvsAAABNAAC+AAAAAIwBCgCfAAIBggABAAEDAQAJAAEYAAAAAAABCgAAAAAEAQEAAAAITQEAjAAAAADZAwAAEgIAALwBAccBAAAAnwEDAYIAAQACAwIDAwEACAABGAAAAAAAAAADCQAAAAAFAQMAAAAOTQEA3wAAAAD7AgAA+wMBAPsEAgBNBAQqAQAAAJ8CAwLZBAAAEgABALwCArUCAAAAnwIDAYIAAQADAwQDBQMGAQEGBwEYAAABAAAAAAAAAAAAAAUHAAAAAAUAAAECACCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQIChwkAAACfAQICpAIFAAAAQEBNAwChCgAAAE0DA/MLAAAAnwICAv8DAQAAAAAAwAQMABIAAgASAAAAEgABADAEAxMNAAAAggMCAA4DCAQAAABAAwkDCgMLBAAAQEADDAQAAGBAAw0DDgMPAxAGAgMHAQIBAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAACAAEAAAAAAAgBAAAAAANQn6bqm51lKpOLpK+W8H4bIIexnmJbzOs=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:33
-- Luau version 6, Types version 3
-- Time taken: 0.001284 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local RobberyBonusConsts_upvr = require(script.Parent.RobberyBonusConsts)
function module.init(arg1) -- Line 6
    --[[ Upvalues[3]:
        [1]: waitForChild_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RobberyBonusConsts_upvr (readonly)
    ]]
    local em_upvr = arg1.em
    waitForChild_upvr(ReplicatedStorage_upvr, RobberyBonusConsts_upvr.FIREWORK_FX_REMOTE_NAME):andThen(function(arg1_2) -- Line 8
        --[[ Upvalues[1]:
            [1]: em_upvr (readonly)
        ]]
        arg1_2.OnClientEvent:Connect(function() -- Line 9
            --[[ Upvalues[1]:
                [1]: em_upvr (copied, readonly)
            ]]
            em_upvr.at2y4lws(10)
        end)
    end)
end
return module