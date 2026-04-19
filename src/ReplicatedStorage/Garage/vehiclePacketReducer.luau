-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBnBhY2tldA5taXNzaW5nIFBhY2tldAZhc3NlcnQVc2V0TG9jYWxWZWhpY2xlUGFja2V0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAA9NBAF0AAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgF0AAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAxgMAAOIECQDABQoAMAUEswgAAACfAgMAggIAAAsDBQQAAABAAwYDBwMIBAAAQEADCQMKAwQFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAAT2ZDondxJHQF7LaW/q1nMVNgRn9D11kiA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:28
-- Luau version 6, Types version 3
-- Time taken: 0.001200 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setLocalVehiclePacket = function(arg1, arg2) -- Line 5, Named "setLocalVehiclePacket"
        local var2
        if arg2.packet == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing Packet")
        return arg2.packet
    end;
})