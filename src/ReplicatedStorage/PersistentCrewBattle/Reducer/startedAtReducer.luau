-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBmNsYW5JZA5taXNzaW5nIGNsYW5JZAZhc3NlcnQFdGFibGUFY2xvbmUFdmFsdWUMc2V0U3RhcnRlZEF0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAABZNBAEbAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwGkAgYAABRAgFIDAACfAgICTQMBGwAAAABNBAHMBwAAAGoEAgOCAgIACAMBAwIDAwQAACBAAwQDBQQAFECAAwYABQcBGAAAAAAAAAAAAAAAAAEAAAABAAAAAAEGAAAAAAYAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQJAMAFCgAwBQRaCAAAAJ8CAwCCAgAACwMIBAAAAEADCQMKAwsEAABAQAMMAw0DBwUBCAYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAABAAD/AAEAAAAAAaApJevteX5vlFsI3tggyUrQMTKfku1P6g==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:55
-- Luau version 6, Types version 3
-- Time taken: 0.001419 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setStartedAt = function(arg1, arg2) -- Line 5, Named "setStartedAt"
        local var2
        if arg2.clanId == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing clanId")
        var2 = arg1
        local clone = table.clone(var2)
        var2 = arg2.clanId
        clone[var2] = arg2.value
        return clone
    end;
})