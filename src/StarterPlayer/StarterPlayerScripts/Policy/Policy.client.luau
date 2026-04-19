-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLGXNldENhY2hlZFBsYXllclBvbGljeUluZm8EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB1BsYXllcnMHcmVxdWlyZQZQb2xpY3kacHJvbWlzZVBvbGljeUluZm9Gb3JQbGF5ZXINUG9saWN5U2VydmljZQtMb2NhbFBsYXllcgdhbmRUaGVuAAIEAQIAAAAH+wEAAE0BAbMAAAAA+wIBAFIDAACfAQMBggABAAEDAQAIAAEYAAAAAAAAAQkAAAAACAAAAQIAJ6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAIUHAAAATQMDTAgAAACfAgICpAMGAAAAUEBNBACFBwAAAE0EBMUJAAAAnwMCAk0EATEKAAAAUgUCAFIGBACfBQICwAcLABIAAwASAAQAvAUFtQwAAACfBQMBggABAA0DAgQAAABAAwMDBAMFAwYEAABQQAMHAwgDCQMKBgADCwEAAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAgAAAAAAAAIAAQAAAAAAAAAAAwEAAAAAAdRR3mfCN73ctKYYwFFJgqGkSckT5pW0Zg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:49
-- Luau version 6, Types version 3
-- Time taken: 0.000710 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local PolicyService_upvr = require(ReplicatedStorage.Policy.PolicyService)
require(ReplicatedStorage.Policy.promisePolicyInfoForPlayer)(LocalPlayer_upvr):andThen(function(arg1) -- Line 8
    --[[ Upvalues[2]:
        [1]: PolicyService_upvr (readonly)
        [2]: LocalPlayer_upvr (readonly)
    ]]
    PolicyService_upvr.setCachedPlayerPolicyInfo(LocalPlayer_upvr, arg1)
end)