-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBmFzc2VydBFFTkFCTEVEX0FUVFJfTkFNRQxTZXRBdHRyaWJ1dGUKc2V0RW5hYmxlZBBSQURJVVNfQVRUUl9OQU1FCXNldFJhZGl1cxNNQUdOSVRVREVfQVRUUl9OQU1FDHNldE1hZ25pdHVkZQdyZXF1aXJlF1Byb3hpbWl0eUNhbVNoYWtlQ29uc3RzBnNjcmlwdAZQYXJlbnQABAYCAQAAABBHAQIAAAAAgKkDAAGpAwEAuwEDAqQCAQAAAABAnwICAfsEAABNBASnAgAAAFIFAQC8AgAuAwAAAJ8CBAGCAAEABAMBBAAAAEADAgMDAAQEARgAAAAAAAAAAAEAAAAAAAABBQAAAAAGAgEAAAAQRwECAAAAAICpAwABqQMBALsBAwKkAgEAAAAAQJ8CAgH7BAAATQQEiQIAAABSBQEAvAIALgMAAACfAgQBggABAAQDAQQAAABAAwUDAwAIBgEYAAAAAAAAAAABAAAAAAAAAQkAAAAABgIBAAAAEEcBAgAAAACAqQMAAakDAQC7AQMCpAIBAAAAAECfAgIB+wQAAE0EBA4CAAAAUgUBALwCAC4DAAAAnwIEAYIAAQAEAwEEAAAAQAMHAwMADAgBGAAAAAAAAAAAAQAAAAAAAAENAAAAAAMAAAECABmjAAAApAABAAAAAECkAgQAAAAwQE0CAiQFAAAATQECkAIAAACfAAIC/wEDAAAAAADAAgYAEgAAADACAb4HAAAAwAIIABIAAAAwAgEeCQAAAMACCgASAAAAMAIBRgsAAACCAQIADAMJBAAAAEADCgMLBAAAMEADDAYAAwQGAQMGBgIDCAMAAQIBAAEYAAAAAAAAAAAAAAIAAQAAAAQAAAAEAAAABAEAAAAAA4YLBptisIYrxMn5ESH4o5j2ExHvtM9smg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:33
-- Luau version 6, Types version 3
-- Time taken: 0.001989 seconds

local ProximityCamShakeConsts_upvr = require(script.Parent.ProximityCamShakeConsts)
return {
    setEnabled = function(arg1, arg2) -- Line 4, Named "setEnabled"
        --[[ Upvalues[1]:
            [1]: ProximityCamShakeConsts_upvr (readonly)
        ]]
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME, arg2)
    end;
    setRadius = function(arg1, arg2) -- Line 8, Named "setRadius"
        --[[ Upvalues[1]:
            [1]: ProximityCamShakeConsts_upvr (readonly)
        ]]
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.RADIUS_ATTR_NAME, arg2)
    end;
    setMagnitude = function(arg1, arg2) -- Line 12, Named "setMagnitude"
        --[[ Upvalues[1]:
            [1]: ProximityCamShakeConsts_upvr (readonly)
        ]]
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.MAGNITUDE_ATTR_NAME, arg2)
    end;
}