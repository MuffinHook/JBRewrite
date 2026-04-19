-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPCGF0Mnk0bHdzDU9uQ2xpZW50RXZlbnQHQ29ubmVjdAJlbRdGSVJFV09SS19GWF9SRU1PVEVfTkFNRQdhbmRUaGVuBGluaXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkDHdhaXRGb3JDaGlsZAdBaXJEcm9wDUFpckRyb3BDb25zdHMABAIAAQAAAAb7AAAATQAAvgAAAACMAQoAnwACAYIAAQABAwEACQABGAAAAAAAAQoAAAAABAEBAAAACE0BAIwAAAAA2QMAABICAAC8AQHHAQAAAJ8BAwGCAAEAAgMCAwMBAAgAARgAAAAAAAAAAwkAAAAABQEDAAAADk0BAN8AAAAA+wIAAPsDAQD7BAIATQQEKgEAAACfAgMC2QQAABIAAQC8AgK1AgAAAJ8CAwGCAAEAAwMEAwUDBgEBBgcBGAAAAQAAAAAAAAAAAAAFBwAAAAAFAAABAgAeowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgLzBwAAAJ8BAgKkAgUAAABAQE0DAIMIAAAATQMDSQkAAACfAgIC/wMBAAAAAADABAoAEgABABIAAAASAAIAMAQDEwsAAACCAwIADAMIBAAAAEADCQMKAwsEAABAQAMMAw0DDgMPBgIDBwECAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAIAAQAAAAAACQEAAAAAAy9ZUflVlnHYbBn+rZvDVUhfQUaNHZ07+A==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:04
-- Luau version 6, Types version 3
-- Time taken: 0.001051 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local AirDropConsts_upvr = require(ReplicatedStorage_upvr.AirDrop.AirDropConsts)
function module.init(arg1) -- Line 6
    --[[ Upvalues[3]:
        [1]: waitForChild_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: AirDropConsts_upvr (readonly)
    ]]
    local em_upvr = arg1.em
    waitForChild_upvr(ReplicatedStorage_upvr, AirDropConsts_upvr.FIREWORK_FX_REMOTE_NAME):andThen(function(arg1_2) -- Line 8
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