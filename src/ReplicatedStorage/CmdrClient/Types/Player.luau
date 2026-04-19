-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMhD01ha2VGdXp6eUZpbmRlcgpHZXRQbGF5ZXJzCVRyYW5zZm9ybShObyBwbGF5ZXIgd2l0aCB0aGF0IG5hbWUgY291bGQgYmUgZm91bmQuCFZhbGlkYXRlCEdldE5hbWVzDEF1dG9jb21wbGV0ZQVQYXJzZQROYW1lB0RlZmF1bHQGcGxheWVyDFJlZ2lzdGVyVHlwZQdwbGF5ZXJzEE1ha2VMaXN0YWJsZVR5cGUIUHJlZml4ZXMNJSB0ZWFtUGxheWVycwdyZXF1aXJlBnNjcmlwdAZQYXJlbnQGU2hhcmVkBFV0aWwEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2UXQXJndW1lbnRPcGVyYXRvckFsaWFzZXMCbWUDYWxsBm90aGVycwZyYW5kb20BLgEqAioqAT8ABwQBAgAAAAz7AQAATQEBPQAAAAD7AgEAvAICqwEAAACfAgIAnwEAAlICAQBSAwAAnwICAIICAAACAwEDAgAFAwEYAAAAAAAAAAACAAAABgAAAAAEAQAAAAAIHAIAAIwDAAC3AwIAAgAAAKkBAAGpAQEAbwIAAIIBAwABAwQACwUBGAAAAAAAAAAADAAAAAADAQEAAAAG+wEAAE0BAccAAAAAUgIAAJ8BAgCCAQAAAQMGAA8HARgAAAAAAAAQAAAAAAIBAAAAAAITAQAAggECAAAAEwgBGAAAFAAAAAACAQAAAAADTQEAugAAAACCAQIAAQMJABcKARgAAAAYAAAAAAgBAgAAABNvAwAA+wQAALwBAN0BAAAAnwEEAW8DAgD7BAEATQQEJAMAAAD7BQAA4gYFAG8HBgAwBwY/BAAAAJ8EAwC8AQDdAQAAAJ8BAAGCAAEABwMLAwwDDQMOAw8FAQQDEAAjAAEYAAAAAAACAQAAAAABAAD//gAABiQAAAAABQAAAQIAOqMAAACkAAEAAAAAQKQBAwAAACBATQEBJAQAAABNAQEkBAAAAE0BARIFAAAATQEBngYAAACfAAICpAEIAAAAcEBvAwkAvAEBFgoAAACfAQMC4gIRAMADEgASAAAAEgABADADAiELAAAAwAMTADADAnYMAAAAwAMUABIAAAAwAwKrDQAAAMADFQAwAwKbDgAAAMADFgAwAwI6DwAAAOIDGwBvBBwAMAQD0RcAAABvBB0AMAQDvRgAAABvBB4AMAQDghkAAABvBB8AMAQDThoAAAAwAwJpEAAAAMADIAASAAIAEgAAAIIDAgAhAxEEAAAAQAMSBAAAIEADEwMUAxUDFgQAAHBAAxcDGAMDAwUDBwMIAwoDGQUGCwwNDg8QBgAGAQYCBgMGBAMaAxsDHAMdBQQXGBkaAx4DHwMgAyEGBQYAAQIDBAUBAAEYAAAAAAAAAAAAAAAAAAABAAAAAAACAQAAAAAGAAAEAAAABAAABAAABAEAAAEAAAEAAAEAAPwACAAAAAEAAAAABrGpLivP2Xs/JTQQho8aEH7BsTlfg21EKg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:47
-- Luau version 6, Types version 3
-- Time taken: 0.002486 seconds

local Util_upvr = require(script.Parent.Parent.Shared.Util)
local tbl_upvr = {}
local Players_upvr = game:GetService("Players")
function tbl_upvr.Transform(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Util_upvr (readonly)
        [2]: Players_upvr (readonly)
    ]]
    return Util_upvr.MakeFuzzyFinder(Players_upvr:GetPlayers())(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 11
    local var4
    if 0 >= #arg1 then
        var4 = false
    else
        var4 = true
    end
    return var4, "No player with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 15
    --[[ Upvalues[1]:
        [1]: Util_upvr (readonly)
    ]]
    return Util_upvr.GetNames(arg1)
end
function tbl_upvr.Parse(arg1) -- Line 19
    return arg1[1]
end
function tbl_upvr.Default(arg1) -- Line 23
    return arg1.Name
end
tbl_upvr.ArgumentOperatorAliases = {
    me = '.';
    all = '*';
    others = "**";
    random = '?';
}
return function(arg1) -- Line 35
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Util_upvr (readonly)
    ]]
    arg1:RegisterType("player", tbl_upvr)
    arg1:RegisterType("players", Util_upvr.MakeListableType(tbl_upvr, {
        Prefixes = "% teamPlayers";
    }))
end