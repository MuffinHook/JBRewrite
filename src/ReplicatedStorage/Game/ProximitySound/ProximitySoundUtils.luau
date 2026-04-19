-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMOBmFzc2VydBFFTkFCTEVEX0FUVFJfTkFNRQxTZXRBdHRyaWJ1dGUKc2V0RW5hYmxlZBBSQURJVVNfQVRUUl9OQU1FCXNldFJhZGl1cwZ0eXBlb2YGbnVtYmVyDElEX0FUVFJfTkFNRQVzZXRJZAdyZXF1aXJlFFByb3hpbWl0eVNvdW5kQ29uc3RzBnNjcmlwdAZQYXJlbnQABAYCAQAAABhHAAIAAAAAgKkDAAGpAwEAuwEDAqQCAQAAAABAnwICAUcBAgAAAACAqQMAAakDAQC7AQMCpAIBAAAAAECfAgIB+wQAAE0EBKcCAAAAUgUBALwCAC4DAAAAnwIEAYIAAQAEAwEEAAAAQAMCAwMABAQBGAAAAAAAAAAAAQAAAAAAAAABAAAAAAAAAQUAAAAABgIBAAAAGEcAAgAAAACAqQMAAakDAQC7AQMCpAIBAAAAAECfAgIBRwECAAAAAICpAwABqQMBALsBAwKkAgEAAAAAQJ8CAgH7BAAATQQEiQIAAABSBQEAvAIALgMAAACfAgQBggABAAQDAQQAAABAAwUDAwAJBgEYAAAAAAAAAAABAAAAAAAAAAEAAAAAAAABCgAAAAAGAgEAAAAdRwACAAAAAICpAwABqQMBALsBAwKkAgEAAAAAQJ8CAgG7LAEDUgUBAKQEAwAAACBAnwQCAvAEAgAEAAAAqQMAAakDAQC7AQMCpAIBAAAAAECfAgIB+wQAAE0EBMEFAAAAUgUBALwCAC4GAAAAnwIEAYIAAQAHAwEEAAAAQAMHBAAAIEADCAMJAwMADgoBGAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAABDwAAAAADAAABAgAZowAAAKQAAQAAAABApAIEAAAAMEBNAgIkBQAAAE0BApgCAAAAnwACAv8BAwAAAAAAwAIGABIAAAAwAgG+BwAAAMACCAASAAAAMAIBHgkAAADAAgoAEgAAADACAUILAAAAggECAAwDCwQAAABAAwwDDQQAADBAAw4GAAMEBgEDBgYCAwoDAAECAQABGAAAAAAAAAAAAAACAAEAAAAFAAAABQAAAAUBAAAAAAMkI0Xyps44yY3+hfekO0YxVDtShhbnL/M=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:37
-- Luau version 6, Types version 3
-- Time taken: 0.002298 seconds

local ProximitySoundConsts_upvr = require(script.Parent.ProximitySoundConsts)
return {
    setEnabled = function(arg1, arg2) -- Line 4, Named "setEnabled"
        --[[ Upvalues[1]:
            [1]: ProximitySoundConsts_upvr (readonly)
        ]]
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximitySoundConsts_upvr.ENABLED_ATTR_NAME, arg2)
    end;
    setRadius = function(arg1, arg2) -- Line 9, Named "setRadius"
        --[[ Upvalues[1]:
            [1]: ProximitySoundConsts_upvr (readonly)
        ]]
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximitySoundConsts_upvr.RADIUS_ATTR_NAME, arg2)
    end;
    setId = function(arg1, arg2) -- Line 14, Named "setId"
        --[[ Upvalues[1]:
            [1]: ProximitySoundConsts_upvr (readonly)
        ]]
        if arg1 == nil then
        else
        end
        assert(true)
        if typeof(arg2) ~= "number" then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximitySoundConsts_upvr.ID_ATTR_NAME, arg2)
    end;
}