-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKB3Zpc2libGUPbWlzc2luZyB2aXNpYmxlBmFzc2VydBZzZXRDYXNpbm9LZXlwYWRWaXNpYmxlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAA9NBAGgAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgGgAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAqQMAAOIECQDABQoAMAUERAgAAACfAgMAggIAAAsDBQQAAABAAwYDBwMIBAAAQEADCQMKAwQFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAAQoAQSukqrEtmaywKGW1Mhx6GFZfOMQrKg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:07
-- Luau version 6, Types version 3
-- Time taken: 0.001188 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setCasinoKeypadVisible = function(arg1, arg2) -- Line 5, Named "setCasinoKeypadVisible"
        local var2
        if arg2.visible == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing visible")
        return arg2.visible
    end;
})