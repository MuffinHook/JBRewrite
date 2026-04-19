-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQCGNhdGVnb3J5EG1pc3NpbmcgY2F0ZWdvcnkGYXNzZXJ0BG5hbWUMbWlzc2luZyBuYW1lBXBhaXJzFHNldENhdGVnb3J5SXRlbU93bmVkBW93bmVkE21pc3Npbmcgb3duZWQgdGFibGULc2V0T3duZWRSYXcEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgADCAIAAAAAM00EAWsAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0EAVoEAAAARwQCAAAAAICpAwABqQMBAIEBAwQFAAAAbwQFAKQCAwAAACBAnwIDAf8CAAAAAAAApAMHAAAAYEBSBAAAnwMCBBcDAQBqBwIGbgP+/wIAAABNBAFrAAAAAIcDAgQrAwUATQMBawAAAAD/BAAAAAAAAGoEAgNNBAFrAAAAAIcDAgRNBAFaBAAAAKkFAQBqBQMEggICAAgDAQMCAwMEAAAgQAMEAwUDBgQAAGBAAAUHARgAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAACAAEAAAAAAf8AAwAAAAEAAAAAAgAAAAAAAAEGAAAAAAUCAAAAAA9NBAHkAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgHkAAAAAIICAgAEAwgDCQMDBAAAIEAAEwoBGAAAAAAAAAAAAAAAAAEAABQAAAAABgAAAQIAGaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAA/wMAAAAAAADiBAoAwAULADAFBDgIAAAAwAUMADAFBBgJAAAAnwIDAIICAAANAwsEAAAAQAMMAw0DDgQAAEBAAw8DEAMHAwoFAggJBgAGAQIAAQEAARgAAAAAAAAAAQAAAAACAAAAAAEAAA4AAPEAAQAAAAACe2i383hbUY5STyzs7SekQgtwoIdJrN3y

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:23
-- Luau version 6, Types version 3
-- Time taken: 0.002080 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCategoryItemOwned = function(arg1, arg2) -- Line 5, Named "setCategoryItemOwned"
        local var6
        if arg2.category == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "missing category")
        if arg2.name == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "missing name")
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
        pairs_result1[arg2.name] = true
        return var11
    end;
    setOwnedRaw = function(arg1, arg2) -- Line 19, Named "setOwnedRaw"
        local var12
        if arg2.owned == nil then
            var12 = false
        else
            var12 = true
        end
        assert(var12, "missing owned table")
        return arg2.owned
    end;
})