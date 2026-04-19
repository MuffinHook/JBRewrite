-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBXZhbHVlDW1pc3NpbmcgdmFsdWUGYXNzZXJ0G3NldENyZXdzSW5TZXJ2ZXJEaXNwbGF5SW5mbwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eA1jcmVhdGVSZWR1Y2VyAAIFAgAAAAAPTQQBzAAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBzAAAAACCAgIABAMBAwIDAwQAACBAAAUEARgAAAAAAAAAAAAAAAABAAAGAAAAAAYAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQJAMAFCgAwBQQJCAAAAJ8CAwCCAgAACwMFBAAAAEADBgMHAwgEAABAQAMJAwoDBAUBCAYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAABAAD/AAEAAAAAAW/hz4ZudUxYjh2fhx/vuRIf+djyXSWlhw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:51
-- Luau version 6, Types version 3
-- Time taken: 0.000884 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCrewsInServerDisplayInfo = function(arg1, arg2) -- Line 5, Named "setCrewsInServerDisplayInfo"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing value")
        return arg2.value
    end;
})