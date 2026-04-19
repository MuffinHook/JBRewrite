-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKB3ByZW1pdW0VbWlzc2luZyBwcmVtaXVtIHZhbHVlBmFzc2VydApzZXRQcmVtaXVtBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAA9NBAGMAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgGMAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAqQMAAOIECQDABQoAMAUE8wgAAACfAgMAggIAAAsDBQQAAABAAwYDBwMIBAAAQEADCQMKAwQFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAAaC3MZFBn55W5t/+TQ7znjjQryblknNbkA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:25
-- Luau version 6, Types version 3
-- Time taken: 0.001101 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setPremium = function(arg1, arg2) -- Line 5, Named "setPremium"
        local var2
        if arg2.premium == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing premium value")
        return arg2.premium
    end;
})