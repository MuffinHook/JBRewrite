-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKCmluUGh5c2ljYWwYbWlzc2luZyBpblBoeXNpY2FsIHZhbHVlBmFzc2VydA1zZXRJblBoeXNpY2FsBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAA9NBAFEAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgFEAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAqQMAAOIECQDABQoAMAUEWwgAAACfAgMAggIAAAsDBQQAAABAAwYDBwMIBAAAQEADCQMKAwQFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAAU2PCYn+Rl2LtliIQsEK+ZY9lx79f0tjiA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:21
-- Luau version 6, Types version 3
-- Time taken: 0.001191 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setInPhysical = function(arg1, arg2) -- Line 5, Named "setInPhysical"
        local var2
        if arg2.inPhysical == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing inPhysical value")
        return arg2.inPhysical
    end;
})