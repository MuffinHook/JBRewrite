-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBXZhbHVlJ21lbWJlcnMgY2Fubm90IGJlIG5pbDsgdHJ5IGJsYW5rIHRhYmxlPwZhc3NlcnQKc2V0TWVtYmVycwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eA1jcmVhdGVSZWR1Y2VyAAIFAgAAAAAPTQQBzAAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBzAAAAACCAgIABAMBAwIDAwQAACBAAAUEARgAAAAAAAAAAAAAAAABAAAGAAAAAAYAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQJAMAFCgAwBQRdCAAAAJ8CAwCCAgAACwMFBAAAAEADBgMHAwgEAABAQAMJAwoDBAUBCAYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAABAAD/AAEAAAAAASlrFhyzGzZjOyflbaaipntZcwFoG698HQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:31
-- Luau version 6, Types version 3
-- Time taken: 0.001157 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setMembers = function(arg1, arg2) -- Line 5, Named "setMembers"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "members cannot be nil; try blank table?")
        return arg2.value
    end;
})