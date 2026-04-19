-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMODV5odHRwcz86Ly8uKyQFbWF0Y2goVVJMcyBtdXN0IGJlZ2luIHdpdGggaHR0cDovLyBvciBodHRwczovLwhWYWxpZGF0ZQVQYXJzZQN1cmwMUmVnaXN0ZXJUeXBlBHVybHMQTWFrZUxpc3RhYmxlVHlwZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQGU2hhcmVkBFV0aWwABAQBAAAAAApvAwAAvAEA5wEAAACfAQMCDgECAKkBAQCCAQIAqQEAAG8CAgCCAQMAAwMBAwIDAwAEBAEYAAAAAAABAAMAAAUAAAAAAQEAAAAAAYIAAgAAAAwFARgADQAAAAAGAQIAAAAPbwMAAPsEAAC8AQDdAQAAAJ8BBAFvAwIA+wQBAE0EBCQDAAAA+wUAAJ8EAgC8AQDdAQAAAJ8BAAGCAAEABAMGAwcDCAMJABEAARgAAAAAAAEAAAAAAAAAAAESAAAAAAMAAAECABmjAAAApAABAAAAAECkAQMAAAAgQE0BASQEAAAATQEBJAQAAABNAQESBQAAAE0BAZ4GAAAAnwACAuIBCQDAAgoAMAIBdgcAAADAAgsAMAIBmwgAAADAAgwAEgABABIAAACCAgIADQMKBAAAAEADCwQAACBAAwwDDQMOAwQDBQUCBwgGAAYBBgIDAAECAQABGAAAAAAAAAAAAAAAAAAAAgEAAAgAAAUAAAABAAAAAAOVRl0K6mtdRs18HAcX7aP85V5KfqeCNws=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:51
-- Luau version 6, Types version 3
-- Time taken: 0.001042 seconds

local tbl_upvr = {
    Validate = function(arg1) -- Line 4, Named "Validate"
        if arg1:match("^https?://.+$") then
            return true
        end
        return false, "URLs must begin with http:// or https://"
    end;
    Parse = function(arg1) -- Line 12, Named "Parse"
        return arg1
    end;
}
local Util_upvr = require(script.Parent.Parent.Shared.Util)
return function(arg1) -- Line 17
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Util_upvr (readonly)
    ]]
    arg1:RegisterType("url", tbl_upvr)
    arg1:RegisterType("urls", Util_upvr.MakeListableType(tbl_upvr))
end