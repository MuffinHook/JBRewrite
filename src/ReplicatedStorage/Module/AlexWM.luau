-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPB1dpbmRvd3MPTWFrZVdpbmRvd0dyb3VwBXRhYmxlBmluc2VydAVHcm91cA5XaW5kb3dHcm91cEFkZARuZXh0EE1ha2VXaW5kb3dHcm91cEEGSXNPcGVuB09wZW5GdW4IQ2xvc2VGdW4KTWFrZVdpbmRvdwtXaW5kb3dDbG9zZQpXaW5kb3dPcGVuDFdpbmRvd1RvZ2dsZQAIAgAAAAAABuIAAQD/AQAAAAAAADABACwAAAAAggACAAIDAQUBAAABAgEYAAEAAAAAAgAAAAAFAgAAAAALTQMALAAAAACeNAMEAQAAAFIEAQCkAgMAAAgQgJ8CAwEwAAHEBAAAAIIAAQAFAwEDAwMEBAAIEIADBQAGBgEYAAAAAAAAAAABAAEHAAAAAAkAAAEAAByjAAAA4gABAP8BAAAAAAAAMAEALAAAAACkAQMAAAAgQP8CAAAAAAAA3QQAAMUCBAABAAAAxgMAABcBCgBNBwAsAAAAAJ40BwQFAAAAUggFAKQGBgAAFECAnwYDATAABcQHAAAAbgH1/wIAAACCAAEACAMBBQEAAwcEAAAgQAMDAwQEABRAgAMFAAoIARgI+AEAAAAJAAAAAAAAAAD7AAAAAAAAAAEABAADAgAAAAACAAAAAAAO4gAEAKkBAAAwAQAxAAAAAMYBAAAwAQDkAQAAAMYBAAAwAQBMAgAAAMYBAAAwAQDEAwAAAIIAAgAFAwkDCgMLAwUFBAABAgMAEAwBGAABAAABAAABAAABAAAAEQAAAAACAQAAAAAHqQEAADABADEAAAAATQEATAEAAACfAQEBggABAAIDCQMLABgNARgAAAABAAABGQAAAAAIAQAAAAAdTQEAxAAAAAAOARMApAICAAAAEEBNAwEsAwAAAMYEAAAXAgsA8QYKAAAAAABNBwYxBAAAAA4HBgCpBwAAMAcGMQQAAABNBwZMBQAAAJ8HAQFuAvT/AgAAAKkCAQAwAgAxBAAAAE0CAOQGAAAAnwIBAYIAAQAHAwUDBwQAABBAAwEDCQMLAwoAHA4BGAQAAQEAAAAAAAEAAQAA+AAAAQAABQAIAAABAAABGQAAAAADAQEAAAATTQIAMQAAAABWAQIAMAEAMQAAAABNAQAxAAAAAA4BBAD7AQAAUgIAAJ8BAgGCAAEAqQEAADABADEAAAAATQEATAEAAACfAQEBggABAAIDCQMLACoPARgSAAAAAAEAAAEAAADsAAABAAAXGQAAAAAIAAABAgAZowAAAMAAAADAAQEAwAICAMADAwDABAQAwAUFAMAGBgASAAUA4gcOADAAB8MHAAAAMAEHjggAAAAwAgfuCQAAADADB7kKAAAAMAUHWAsAAAAwBAdNDAAAADAGB2gNAAAAggcCAA8GAAYBBgIGAwYEBgUGBgMCAwYDCAMMAw4DDQMPBQcHCAkKCwwNBwABAgMEBQYBAAEYAAAFBAYIBA4ACAEAAQABAAEAAQABAAEAAAEAAAAABw3JiBAxTPGsT83gYwYB9YV90Z9kPw3iEQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:21
-- Luau version 6, Types version 3
-- Time taken: 0.002816 seconds

local function WindowOpen_upvr(arg1) -- Line 28, Named "WindowOpen"
    local Group = arg1.Group
    if Group then
        for _, v_2 in next, Group.Windows do
            if v_2 ~= arg1 and v_2.IsOpen then
                v_2.IsOpen = false
                v_2.CloseFun()
            end
        end
    end
    arg1.IsOpen = true
    arg1.OpenFun()
end
return {
    MakeWindowGroup = function() -- Line 1, Named "MakeWindowGroup"
        return {
            Windows = {};
        }
    end;
    WindowGroupAdd = function(arg1, arg2) -- Line 6, Named "WindowGroupAdd"
        table.insert(arg1.Windows, arg2)
        arg2.Group = arg1
    end;
    MakeWindowGroupA = function(...) -- Line 10, Named "MakeWindowGroupA"
        local tbl = {
            Windows = {};
        }
        for _, v in next, {...} do
            table.insert(tbl.Windows, v)
            v.Group = tbl
        end
    end;
    MakeWindow = function() -- Line 16, Named "MakeWindow"
        return {
            IsOpen = false;
            OpenFun = nil;
            CloseFun = nil;
            Group = nil;
        }
    end;
    WindowOpen = WindowOpen_upvr;
    WindowClose = function(arg1) -- Line 24, Named "WindowClose"
        arg1.IsOpen = false
        arg1.CloseFun()
    end;
    WindowToggle = function(arg1) -- Line 42, Named "WindowToggle"
        --[[ Upvalues[1]:
            [1]: WindowOpen_upvr (readonly)
        ]]
        arg1.IsOpen = not arg1.IsOpen
        if arg1.IsOpen then
            WindowOpen_upvr(arg1)
        else
            arg1.IsOpen = false
            arg1.CloseFun()
        end
    end;
}