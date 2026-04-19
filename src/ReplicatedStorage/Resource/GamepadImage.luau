-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVBHR5cGUIdXNlcmRhdGEIdG9zdHJpbmcGc3RyaW5nA3N1YgdYYm94T25lBHdhcm4WQ291bGQgbm90IGZpbmQgc3R5bGU6IAlHZXRTcHJpdGUQZ2V0SW1hZ2VJbnN0YW5jZQpJbWFnZUxhYmVsDUdldEltYWdlTGFiZWwLSW1hZ2VCdXR0b24OR2V0SW1hZ2VCdXR0b24FcGFpcnMGc2NyaXB0DFNwcml0ZXNoZWV0cwtHZXRDaGlsZHJlbgROYW1lB3JlcXVpcmUDbmV3AAQIAwEAAAAluygBA1IEAQCkAwEAAAAAQJ8DAgLwAw0AAgAAgLs/AQNSBQEApAQEAAAAMECfBAICgS0EBAUAAABvBQUApAMIAAAcYICfAwMCUgEDAPsFAABNBAV5CQAAAIcDBAIrAwcApAQLAAAAoEBvBgwAUgcCAHMFBgefBAIBggABAFIGAABSBwEAvAQD7Q0AAACfBAQCggQCAA4DAQQAAABAAwIDAwQAADBAAgAAAAAAACxAAwQDBQQAHGCAAwYDBwQAAKBAAwgDCQALCgEYAAAAAAAAAAEAAAAAAAAAAAAAAAIAAAABAQAAAAAAAQIAAAAAAQ0AAAAACQQBAAAAB/sEAABvBQAAUgYBAFIHAgBSCAMAnwQFAIIEAAABAwsAGQwBGAAAAAAAAAAaAAAAAAkEAQAAAAf7BAAAbwUAAFIGAQBSBwIAUggDAJ8EBQCCBAAAAQMNAB0OARgAAAAAAAAAHgAAAAAQAAABAAA4owAAAP8AAgAAAAAA/wEAAAAAAACkAgEAAAAAQKQDAwAAACBATQMDHQQAAAC8AwNoBQAAAJ8DAgCfAgAEFwIbAE0HBroGAAAA/wgAAAAAAABqCAEHpAcBAAAAAEC8CAZoBQAAAJ8IAgCfBwAEFwcNAE0NBroGAAAAhwwBDU0NC7oGAAAApA4IAAAAcEBSDwsAnw4CAk0ODu8JAAAAnw4BAmoODA1uB/L/AgAAAG4C5P8CAAAAwAIKABIAAQDAAwsAEgACADADAIEMAAAAwAMNABIAAgAwAwCODgAAAIIAAgAPAw8EAAAAQAMQBAAAIEADEQMSAxMDFAQAAHBAAxUGAAYBAwwGAgMOAwABAgEAARgAAAACAAEAAAAAAAAAAAAAAQAAAAABAAAAAAAAAQAAAAAAAAAAAAAAAP8A/gAHAA4AAAAEAAAABAEAAAAAA/u77ET7CWao0ZUHd6T34SeLo/swyX+GRQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:20
-- Luau version 6, Types version 3
-- Time taken: 0.002193 seconds

local module = {}
local tbl_upvr = {}
for _, v in pairs(script.Spritesheets:GetChildren()) do
    tbl_upvr[v.Name] = {}
    for _, v_2 in pairs(v:GetChildren()) do
        tbl_upvr[v.Name][v_2.Name] = require(v_2).new()
    end
end
local function getImageInstance_upvr(arg1, arg2, arg3) -- Line 11, Named "getImageInstance"
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    local var17
    if type(arg2) == "userdata" then
        var17 = string.sub(tostring(var17), 14)
    end
    local var18 = tbl_upvr.XboxOne[arg3]
    if not var18 then
        warn("Could not find style: "..arg3)
        return
    end
    return var18:GetSprite(arg1, var17)
end
function module.GetImageLabel(arg1, arg2, arg3, arg4) -- Line 25
    --[[ Upvalues[1]:
        [1]: getImageInstance_upvr (readonly)
    ]]
    return getImageInstance_upvr("ImageLabel", arg2, arg3, arg4)
end
function module.GetImageButton(arg1, arg2, arg3, arg4) -- Line 29
    --[[ Upvalues[1]:
        [1]: getImageInstance_upvr (readonly)
    ]]
    return getImageInstance_upvr("ImageButton", arg2, arg3, arg4)
end
return module