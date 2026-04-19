-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKCGNhbGxiYWNrEG1pc3NpbmcgY2FsbGJhY2sGYXNzZXJ0F3NldENhc2lub0tleXBhZENhbGxiYWNrBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAA9NBAGmAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgGmAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAxgMAAOIECQDABQoAMAUEfAgAAACfAgMAggIAAAsDBQQAAABAAwYDBwMIBAAAQEADCQMKAwQFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAARkiynn2uBXoRqOOu5SW9IxpOt0NK+ageA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:06
-- Luau version 6, Types version 3
-- Time taken: 0.000880 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setCasinoKeypadCallback = function(arg1, arg2) -- Line 5, Named "setCasinoKeypadCallback"
        local var2
        if arg2.callback == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing callback")
        return arg2.callback
    end;
})