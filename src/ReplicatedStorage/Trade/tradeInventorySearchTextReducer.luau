-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBXZhbHVlDW1pc3NpbmcgdmFsdWUGYXNzZXJ0G3NldFRyYWRlSW52ZW50b3J5U2VhcmNoVGV4dARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eA1jcmVhdGVSZWR1Y2VyAAACBQIAAAAAD00EAcwAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0CAcwAAAAAggICAAQDAQMCAwMEAAAgQAAFBAEYAAAAAAAAAAAAAAAAAQAABgAAAAAGAAABAgAVowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICTQIB1gcAAABvAwgA4gQKAMAFCwAwBQRBCQAAAJ8CAwCCAgAADAMFBAAAAEADBgMHAwgEAABAQAMJAwoDCwMEBQEJBgABAAEAARgAAAAAAAAAAQAAAAACAAAAAQAA/wABAAAAAAGPRqpRV9rBUGAmp13sefrE/169Jb2CwFA=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:23
-- Luau version 6, Types version 3
-- Time taken: 0.000882 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer("", {
    setTradeInventorySearchText = function(arg1, arg2) -- Line 5, Named "setTradeInventorySearchText"
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