-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYBG1hdGgFZmxvb3IOZ2V0TWlsZXN0b25lSWQEaW5pdAR0YXNrBXNwYXduCEN1cnJlbmN5A25ldwRUZXh0BVN0eWxlBnN0cmluZwZmb3JtYXQfWW91IHJlYWNoZWQgJXMKQ29uZ3JhdHVsYXRpb25zIQRHaWZ0CnBsYXlFZmZlY3QKY2FzaFVwZGF0ZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQRHYW1lDE5vdGlmaWNhdGlvbgZNb2R1bGUGRm9ybWF0AAUDAQAAAAAVbwEAAH0BBwAAAAAAPgIAALsMAgKkAQMAAAgQgJ8BAgKCAQIAbwEEAH0BAwAAAAAAbwEFAIIBAgBvAQYAfQEDAAAAAABvAQcAggECAIwBAACCAQIACAIAAAAAgIQuQQMBAwIEAAgQgAIAAAAAgIQeQQIAAAAAAADgPwIAAAAAAGr4QAKamZmZmZm5PwAJAwEYAAAAAQAAAAAAAQAAAQABAAABAAIACgAAAAABAQEAAAAC3gAAAIIAAQAAABQEARgAARUAAAAABwEDAAAAHPsBAAAOAQUApAECAAAEAID7AgAAjAMMAJ8BAwH7AQEATQEBCQMAAABbAgAEnwECAvsCAgBNAgLvBQAAAOIDCACkBAsAACiQgG8FDABSBgEAnwQDAjAEA/UGAAAAbwQNADAEA7oHAAAAnwICAYIAAQAOAwUDBgQABACAAwcCAAAAAICELkEDCAMJAwoFAgYHAwsDDAQAKJCAAw0DDgAYDwEYAAABAAAAAAIAAAAAAQAAAAAAAAAAAAAAAAAAARkAAAAABAECAAAGAwAABQECNfsBAABHARcAAAAAgG8CAAB9AgcAAAAAAD4CAAC7DAICpAEDAAAIEICfAQICZQALAG8CBAB9AgMAAAAAAG8BBQBlAAYAbwIGAH0CAwAAAAAAbwEHAGUAAQCMAQAA3gEAAIIAAQBvAgAAfQIHAAAAAAA+AgAAuwwCAqQBAwAACBCAnwECAmUACwBvAgQAfQIDAAAAAABvAQUAZQAGAG8CBgB9AgMAAAAAAG8BBwBlAAEAjAEAAPsCAABgAgUAAQAAAN4BAAD7AgEAUgMBAJ8CAgGCAAEACAIAAAAAgIQuQQMBAwIEAAgQgAIAAAAAgIQeQQIAAAAAAADgPwIAAAAAAGr4QAKamZmZmZm5PwAgEAEYGAAA6AAAAQAAAAAAAQAAAQABAAABAAISAeYAAAEAAAAAAAEAAAEAAQAAAQACFwAAAQEAAAIKAAAAAAkAAAECACmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgC9BgAAAE0CAkkHAAAAnwECAqQCBQAAAEBATQMAQAgAAABNAwOtCQAAAJ8CAgL/AwIAAAAAAMYEAADGBQAAwAYKANkHAQASAQX/MAcDEwsAAADZBwIAEgEF/xIAAgASAAEA2QgDABIBBP8SAAcAMAgDhwwAAADBBAAAggMCAA0DEQQAAABAAxIDEwMUBAAAQEADFQMWAxcDGAYAAwQDEAQAAQIDAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAgECCwAAAAQAAAAIAAAAAA4AAQAAAAAEDL4lsVJNNVHzIIg9FO4ROHymMsU+ek+w

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:22
-- Luau version 6, Types version 3
-- Time taken: 0.002168 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local var3_upvw
local function _(arg1) -- Line 9, Named "getMilestoneId"
    if 1000000 <= arg1 then
        return math.floor(arg1 / 1000000)
    end
    if 500000 <= arg1 then
        return 0.5
    end
    if 100000 <= arg1 then
        return 0.1
    end
    return 0
end
function module.init(arg1) -- Line 20
    --[[ Upvalues[1]:
        [1]: var3_upvw (read and write)
    ]]
    var3_upvw = arg1
end
local Format_upvr = require(ReplicatedStorage.Module.Format)
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
local function playEffect_upvr(arg1) -- Line 24, Named "playEffect"
    --[[ Upvalues[3]:
        [1]: var3_upvw (read and write)
        [2]: Format_upvr (readonly)
        [3]: Notification_upvr (readonly)
    ]]
    if var3_upvw then
        task.spawn(var3_upvw, 12)
    end
    Notification_upvr.new({
        Text = string.format("You reached %s\nCongratulations!", Format_upvr.Currency(arg1 * 1000000));
        Style = "Gift";
    })
end
local var7_upvw
function module.cashUpdate(arg1) -- Line 32
    --[[ Upvalues[2]:
        [1]: var7_upvw (read and write)
        [2]: playEffect_upvr (readonly)
    ]]
    -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [3] 3. Error Block 39 start (CF ANALYSIS FAILED)
    if 1000000 <= arg1 then
        -- KONSTANTWARNING: GOTO [23] #19
    end
    -- KONSTANTERROR: [3] 3. Error Block 39 end (CF ANALYSIS FAILED)
end
return module