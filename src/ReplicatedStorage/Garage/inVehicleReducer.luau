-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKCWluVmVoaWNsZRdtaXNzaW5nIGluVmVoaWNsZSB2YWx1ZQZhc3NlcnQMc2V0SW5WZWhpY2xlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAA9NBAHLAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgHLAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAqQMAAOIECQDABQoAMAUEMwgAAACfAgMAggIAAAsDBQQAAABAAwYDBwMIBAAAQEADCQMKAwQFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAARn7hxsu4iVHWlER9Kbdl1Fp45BvKz/tGg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:21
-- Luau version 6, Types version 3
-- Time taken: 0.000914 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setInVehicle = function(arg1, arg2) -- Line 5, Named "setInVehicle"
        local var2
        if arg2.inVehicle == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing inVehicle value")
        return arg2.inVehicle
    end;
})