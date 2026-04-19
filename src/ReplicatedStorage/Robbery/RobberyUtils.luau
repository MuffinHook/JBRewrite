-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVEFNUQVRVU19BVFRSX05BTUUMR2V0QXR0cmlidXRlCWdldFN0YXR1cxNvYmogbXVzdCBub3QgYmUgbmlsBmFzc2VydAZ0eXBlb2YGbnVtYmVyFnZhbHVlIG11c3QgYmUgYSBudW1iZXIMU2V0QXR0cmlidXRlCXNldFN0YXR1cxlHZXRBdHRyaWJ1dGVDaGFuZ2VkU2lnbmFsFmdldFN0YXR1c0NoYW5nZWRTaWduYWwbRElTQUJMRV9BVVRPX09QRU5fQVRUUl9OQU1FEmdldERpc2FibGVBdXRvT3BlbhJzZXREaXNhYmxlQXV0b09wZW4EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUHUm9iYmVyeQ1Sb2JiZXJ5Q29uc3RzAAYEAQEAAAAH+wMAAE0DA+IAAAAAvAEAEgEAAACfAQMAggEAAAIDAQMCAAUDARgAAAAAAAAABgAAAAAGAgEAAAcEAAAFAg8CIUcAAgAAAACAqQMAAakDAQCBAQMEAAAAAG8EAACkAgIAAAAQQJ8CAwG7LAEDUgUBAKQEBAAAADBAnwQCAvAEAgAFAAAAqQMAAakDAQCBAQMEBgAAAG8EBgCkAgIAAAAQQJ8CAwH7BAAATQQE4gcAAABSBQEAvAIALggAAACfAgQBggABAAkDBAMFBAAAEEADBgQAADBAAwcDCAMBAwkACAoBGAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAABAAAAAAAAAQkAAAAABAEBAAAAB/sDAABNAwPiAAAAALwBABYBAAAAnwEDAIIBAAACAwEDCwANDAEYAAAAAAAAAA4AAAAABQEBAAAAC/sEAABNBASrAAAAALwCABIBAAAAnwIDAioCAgABAAAAqQEAAakBAQCCAQIAAgMNAwIAEA4BGAAAAAAAAAAAAAAAEQAAAAAGAgEAAAAJ+wQAAE0EBKsAAAAAUgUBALwCAC4BAAAAnwIEAakCAQCCAgIAAgMNAwkAEw8BGAAAAAAAAAABABQAAAAABAAAAQIAJaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAAQGAAAATQICWAcAAACfAQIC/wIEAAAAAADAAwgAEgABADADAv0JAAAAwAMKABIAAQAwAwLxCwAAAMADDAASAAEAMAMC2Q0AAADAAw4AEgABADADAqEPAAAAwAMQABIAAQAwAwKVEQAAAIICAgASAxAEAAAAQAMRAxIDEwQAAEBAAxQDFQYAAwMGAQMKBgIDDAYDAw4GBAMPBQABAgMEAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAwAAAAUAAAADAAAAAwAAAAQBAAAAAAU5UQi3yDyBStHRYQEpZIXDSUkfwwuVYrY=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:31
-- Luau version 6, Types version 3
-- Time taken: 0.002189 seconds

local RobberyConsts_upvr = require(game:GetService("ReplicatedStorage").Robbery.RobberyConsts)
return {
    getStatus = function(arg1) -- Line 5, Named "getStatus"
        --[[ Upvalues[1]:
            [1]: RobberyConsts_upvr (readonly)
        ]]
        return arg1:GetAttribute(RobberyConsts_upvr.STATUS_ATTR_NAME)
    end;
    setStatus = function(arg1, arg2) -- Line 8, Named "setStatus"
        --[[ Upvalues[1]:
            [1]: RobberyConsts_upvr (readonly)
        ]]
        if arg1 == nil then
        else
        end
        assert(true, "obj must not be nil")
        if typeof(arg2) ~= "number" then
        else
        end
        assert(true, "value must be a number")
        arg1:SetAttribute(RobberyConsts_upvr.STATUS_ATTR_NAME, arg2)
    end;
    getStatusChangedSignal = function(arg1) -- Line 13, Named "getStatusChangedSignal"
        --[[ Upvalues[1]:
            [1]: RobberyConsts_upvr (readonly)
        ]]
        return arg1:GetAttributeChangedSignal(RobberyConsts_upvr.STATUS_ATTR_NAME)
    end;
    getDisableAutoOpen = function(arg1) -- Line 16, Named "getDisableAutoOpen"
        --[[ Upvalues[1]:
            [1]: RobberyConsts_upvr (readonly)
        ]]
        local var3
        if arg1:GetAttribute(RobberyConsts_upvr.DISABLE_AUTO_OPEN_ATTR_NAME) ~= true then
            var3 = false
        else
            var3 = true
        end
        return var3
    end;
    setDisableAutoOpen = function(arg1, arg2) -- Line 19, Named "setDisableAutoOpen"
        --[[ Upvalues[1]:
            [1]: RobberyConsts_upvr (readonly)
        ]]
        arg1:SetAttribute(RobberyConsts_upvr.DISABLE_AUTO_OPEN_ATTR_NAME, arg2)
        return true
    end;
}