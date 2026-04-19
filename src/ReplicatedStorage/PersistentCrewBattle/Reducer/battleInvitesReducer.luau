-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQBGxpc3QMbWlzc2luZyBsaXN0BmFzc2VydBBiYXR0bGVJbnZpdGVzU2V0BWluZGV4DW1pc3NpbmcgaW5kZXgFdGFibGUFY2xvbmUGcmVtb3ZlGmJhdHRsZUludml0ZXNSZW1vdmVCeUluZGV4BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAwUCAAAAAA9NBAELAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgELAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgIAAAAAF00EAQIAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAaQCBgAAFECAUgMAAJ8CAgKkAwgAABxAgFIEAgBNBQECAAAAAJ8DAwGCAgIACQMFAwYDAwQAACBAAwcDCAQAFECAAwkEABxAgAAJCgEYAAAAAAAAAAAAAAAAAQAAAAEAAAAAAAEKAAAAAAYAAAECABmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQKAMAFCwAwBQQjCAAAAMAFDAAwBQRkCQAAAJ8CAwCCAgAADQMLBAAAAEADDAMNAw4EAABAQAMPAxADBAMKBQIICQYABgECAAEBAAEYAAAAAAAAAAEAAAAAAgAAAAABAAAEAAD7AAEAAAAAAujObN8ocQlxSZ64Ny5VdKyY1nur2goG3g==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:49
-- Luau version 6, Types version 3
-- Time taken: 0.001526 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    battleInvitesSet = function(arg1, arg2) -- Line 5, Named "battleInvitesSet"
        local var2
        if arg2.list == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing list")
        return arg2.list
    end;
    battleInvitesRemoveByIndex = function(arg1, arg2) -- Line 9, Named "battleInvitesRemoveByIndex"
        local var3
        if arg2.index == nil then
            var3 = false
        else
            var3 = true
        end
        assert(var3, "missing index")
        var3 = arg1
        local clone = table.clone(var3)
        var3 = table.remove
        var3(clone, arg2.index)
        return clone
    end;
})