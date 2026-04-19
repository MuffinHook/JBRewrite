-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXBHR5cGUHdmlzaWJsZQxjb3VudGRvd25UaWwTc2V0TGlrZVByb21wdENvbmZpZwl3b3Jrc3BhY2UQR2V0U2VydmVyVGltZU5vdxhMSUtFX1BST01QVF9WSVNJQkxFX1RJTUUIZGlzcGF0Y2gcU0hPV19MSUtFX1BST01QVF9SRU1PVEVfTkFNRQxXYWl0Rm9yQ2hpbGQNT25DbGllbnRFdmVudAdDb25uZWN0BGluaXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClJ1blNlcnZpY2UHcmVxdWlyZQNBcHAFc3RvcmUGc2NyaXB0BlBhcmVudBBMaWtlUHJvbXB0Q29uc3RzAAMGAAIAAAAX+wAAAOICAwBvAwQAMAMCcQAAAACpAwEAMAMCoAEAAACkBAYAAABQQLwEBLcHAAAAnwQCAvsFAQBNBQVyCAAAAEMDBAUwAwLzAgAAALwAAEwJAAAAnwADAYIAAQAKAwEDAgMDBQMAAQIDBAMFBAAAUEADBgMHAwgACQABGAAAAQAAAQAAAQAAAAAAAAAAAAD9AAAFCgAAAAAEAAMAAAAQ+wAAAPsCAQBNAgIdAAAAALwAANMBAAAAnwADAk0BAIwCAAAAwAMDABICAgASAgEAvAEBxwQAAACfAQMBggABAAUDCQMKAwsGAAMMAQAHDQEYAAAAAAAAAAEAAAAAAAAABwgAAAAABgAAAQIAJqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAMEHAAAATQMDfggAAACfAgICpAMGAAAAUECkBAoAAACQQE0EBCQLAAAATQQEhwwAAACfAwIC/wQBAAAAAADABQ0AEgAAABIAAwASAAIAMAUEEw4AAACCBAIADwMOBAAAAEADDwMQAxEDEgQAAFBAAxMDFAMVBAAAkEADFgMXBgEDDQEBAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAQAAAAAAAAAAAgABAAAAAAAKAQAAAAACiCVPPNmAhKTqi1lDelR1u/g9WEi64SU9

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:48
-- Luau version 6, Types version 3
-- Time taken: 0.001357 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local LikePromptConsts_upvr = require(script.Parent.LikePromptConsts)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
function module.init() -- Line 7
    --[[ Upvalues[3]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: LikePromptConsts_upvr (readonly)
        [3]: store_upvr (readonly)
    ]]
    ReplicatedStorage_upvr:WaitForChild(LikePromptConsts_upvr.SHOW_LIKE_PROMPT_REMOTE_NAME).OnClientEvent:Connect(function() -- Line 9
        --[[ Upvalues[2]:
            [1]: store_upvr (copied, readonly)
            [2]: LikePromptConsts_upvr (copied, readonly)
        ]]
        store_upvr:dispatch({
            type = "setLikePromptConfig";
            visible = true;
            countdownTil = workspace:GetServerTimeNow() + LikePromptConsts_upvr.LIKE_PROMPT_VISIBLE_TIME;
        })
    end)
end
return module