-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNFHZlcnRpY2FsUGFkZGluZ1JhdGlvBW1lcmdlDHBhZGRpbmdSYXRpbwthc3BlY3RSYXRpbwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQRFelVpCkRpY3Rpb25hcnkNU2Nyb2xsaW5nR3JpZAVSb2FjdA1jcmVhdGVFbGVtZW50AAIJAQMAAAAUTQEAxgAAAADGAgAAMAIAxgAAAAD7AgAA+wMBAPsEAgBNBAQfAQAAAFIFAADiBgMATQgAiQQAAAAJBwEIMAcGKAIAAACfBAMAnwIAAIICAAAFAwEDAgMDBQECAwQABwABGAAAAQAAAQEBAAAAAAEAAAAA//4ACAAAAAAGAAABAgAhowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIALQYAAABNAgKpBwAAAJ8BAgKkAgUAAABAQE0DAC0GAAAATQMDVggAAACfAgICpAMFAAAAQEBNBAAhCQAAAJ8DAgJNBAPKCgAAAMAFCwASAAQAEgACABIAAQCCBQIADAMFBAAAAEADBgMHAwgEAABAQAMJAwoDCwMMAw0GAAEAAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAQACAAAAAAEAAAAAAc0LtTc8AGqhEc4jmsoqsEq9E6JD/8/fNg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:47
-- Luau version 6, Types version 3
-- Time taken: 0.001042 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement_upvr = require(ReplicatedStorage.Roact).createElement
local ScrollingGrid_upvr = require(ReplicatedStorage.EzUi.ScrollingGrid)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
return function(arg1) -- Line 7
    --[[ Upvalues[3]:
        [1]: createElement_upvr (readonly)
        [2]: ScrollingGrid_upvr (readonly)
        [3]: Dictionary_upvr (readonly)
    ]]
    arg1.verticalPaddingRatio = nil
    return createElement_upvr(ScrollingGrid_upvr, Dictionary_upvr.merge(arg1, {
        paddingRatio = arg1.verticalPaddingRatio * arg1.aspectRatio;
    }))
end