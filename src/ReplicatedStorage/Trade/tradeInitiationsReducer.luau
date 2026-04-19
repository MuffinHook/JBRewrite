-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQBGxpc3QMbWlzc2luZyBsaXN0BmFzc2VydBN0cmFkZUluaXRpYXRpb25zU2V0BWluZGV4DW1pc3NpbmcgaW5kZXgFdGFibGUFY2xvbmUGcmVtb3ZlHXRyYWRlSW5pdGlhdGlvbnNSZW1vdmVCeUluZGV4BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAwUCAAAAAA9NBAELAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgELAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgIAAAAAF00EAQIAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAaQCBgAAFECAUgMAAJ8CAgKkAwgAABxAgFIEAgBNBQECAAAAAJ8DAwGCAgIACQMFAwYDAwQAACBAAwcDCAQAFECAAwkEABxAgAAJCgEYAAAAAAAAAAAAAAAAAQAAAAEAAAAAAAEKAAAAAAYAAAECABmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQKAMAFCwAwBQRTCAAAAMAFDAAwBQR+CQAAAJ8CAwCCAgAADQMLBAAAAEADDAMNAw4EAABAQAMPAxADBAMKBQIICQYABgECAAEBAAEYAAAAAAAAAAEAAAAAAgAAAAABAAAEAAD7AAEAAAAAAkLyyDC+G+3OfdU0OjQTsxEy6t9EcDaiMQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:21
-- Luau version 6, Types version 3
-- Time taken: 0.001428 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    tradeInitiationsSet = function(arg1, arg2) -- Line 5, Named "tradeInitiationsSet"
        local var2
        if arg2.list == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing list")
        return arg2.list
    end;
    tradeInitiationsRemoveByIndex = function(arg1, arg2) -- Line 9, Named "tradeInitiationsRemoveByIndex"
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