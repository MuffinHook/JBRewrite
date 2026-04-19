-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMOB3VubW91bnQHcmVxdWlyZQlDb3VudGRvd24Gc2NyaXB0BlBhcmVudAVtb3VudAdlbmRUaW1lCXdvcmtzcGFjZRBHZXRTZXJ2ZXJUaW1lTm93BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdA1jcmVhdGVFbGVtZW50AAMCAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMBAA4AARgAAAAAAAEPAAAAAAkBAgAAAB6kAQEAAAAAQKQDBAAAADBATQMDJAUAAABNAgM4AgAAAJ8BAgL7AgAATQIC5AYAAAD7AwEAUgQBAOIFCACkBwsAAACgQLwHB7cMAAAAnwcCApUGBwkwBgXUBwAAAJ8DAwJSBAAAnwIDAtkDAAASAgAAEgACAIIDAgANAwIEAAAAQAMDAwQEAAAwQAMFAwYDBwUBBwIAAAAAAECPQAMIBAAAoEADCQEABgABGAAAAAAAAAAAAAEAAAEAAAEAAAAAAAAA/wP8BgAAAAcAAAAABAAAAQIAEqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAk0CAcoHAAAAwAMIABIAAQASAAIAggMCAAkDCgQAAABAAwsDDAMCBAAAQEADDQMOBgEBAQEAARgAAQAAAAAAAQAAAAACAAEAAAABAAAAAALKie8KsRZpKR4uTi7gp0uKupH4fvhNhQs=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:38
-- Luau version 6, Types version 3
-- Time taken: 0.001153 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 6
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr(require(script.Parent.Countdown), {
        endTime = workspace:GetServerTimeNow() + 1000;
    }), arg1)
    return function() -- Line 14
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end