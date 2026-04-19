-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRCGNhdGVnb3J5EG1pc3NpbmcgY2F0ZWdvcnkGYXNzZXJ0BG5hbWUMbWlzc2luZyBuYW1lCWZhdm9yaXRlZBFtaXNzaW5nIGZhdm9yaXRlZAVwYWlycxhzZXRDYXRlZ29yeUl0ZW1GYXZvcml0ZWQXbWlzc2luZyBmYXZvcml0ZWQgdGFibGUPc2V0RmF2b3JpdGVkUmF3BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAwgCAAAAAEBNBAFrAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNBAFaBAAAAEcEAgAAAACAqQMAAakDAQCBAQMEBQAAAG8EBQCkAgMAAAAgQJ8CAwFNBAFQBgAAAEcEAgAAAACAqQMAAakDAQCBAQMEBwAAAG8EBwCkAgMAAAAgQJ8CAwH/AgAAAAAAAKQDCQAAAIBAUgQAAJ8DAgQXAwEAagcCBm4D/v8CAAAATQQBawAAAACHAwIEKwMFAE0DAWsAAAAA/wQAAAAAAABqBAIDTQQBawAAAACHAwIETQQBWgQAAABNBQFQBgAAAGoFAwSCAgIACgMBAwIDAwQAACBAAwQDBQMGAwcDCAQAAIBAAAUJARgAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAACAAEAAAAAAf8AAwAAAAEAAAAAAgAAAAAAAAABBgAAAAAFAgAAAAAPTQQBUAAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBUAAAAACCAgIABAMGAwoDAwQAACBAABQLARgAAAAAAAAAAAAAAAABAAAVAAAAAAYAAAECABmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQKAMAFCwAwBQR9CAAAAMAFDAAwBQRzCQAAAJ8CAwCCAgAADQMMBAAAAEADDQMOAw8EAABAQAMQAxEDCQMLBQIICQYABgECAAEBAAEYAAAAAAAAAAEAAAAAAgAAAAABAAAPAADwAAEAAAAAAiVn4Fc6+HxBKjqP0koE1iJVf/cjF6OKVg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:19
-- Luau version 6, Types version 3
-- Time taken: 0.002835 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCategoryItemFavorited = function(arg1, arg2) -- Line 5, Named "setCategoryItemFavorited"
        -- KONSTANTERROR: [0] 1. Error Block 28 start (CF ANALYSIS FAILED)
        local var6
        if arg2.category == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "missing category")
        if arg2.name == nil then
            var6 = false
            -- KONSTANTWARNING: GOTO [18] #13
        end
        -- KONSTANTERROR: [0] 1. Error Block 28 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [17] 12. Error Block 30 start (CF ANALYSIS FAILED)
        var6 = true
        assert(var6, "missing name")
        if arg2.favorited == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "missing favorited")
        var6 = pairs(arg1)
        local pairs_result1, pairs_result2, pairs_result3 = pairs(arg1)
        for i, v in pairs_result1, pairs_result2, pairs_result3 do
            ({})[i] = v
            local var11
        end
        pairs_result1 = var11[arg2.category]
        if not pairs_result1 then
            pairs_result1 = arg2.category
            var11[pairs_result1] = {}
        end
        pairs_result1 = var11[arg2.category]
        pairs_result1[arg2.name] = arg2.favorited
        do
            return var11
        end
        -- KONSTANTERROR: [17] 12. Error Block 30 end (CF ANALYSIS FAILED)
    end;
    setFavoritedRaw = function(arg1, arg2) -- Line 20, Named "setFavoritedRaw"
        local var12
        if arg2.favorited == nil then
            var12 = false
        else
            var12 = true
        end
        assert(var12, "missing favorited table")
        return arg2.favorited
    end;
})