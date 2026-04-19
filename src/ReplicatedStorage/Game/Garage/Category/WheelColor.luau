-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMGBFR5cGUHQ2hhc3NpcwlEdW5lQnVnZ3kKTW90b3JjeWNsZQRNYWtlBFRhbmsAAgMBAAAAABapAQEATQIAEQAAAADwAhEAAQAAAKkBAQBNAgARAAAAAPACDAACAAAAqQEBAE0CABEAAAAA8AIHAAMAAABNAgCtBAAAAPACAgAFAAAAqQEAAakBAQCCAQIABgMBAwIDAwMEAwUDBgABAAEYAAAAAAAAAQAAAAABAAAAAQAAAAAAAAIAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAAEAAQABGAAAAAEAAAAAAQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:51
-- Luau version 6, Types version 3
-- Time taken: 0.001888 seconds

return function(arg1) -- Line 1
    local var4 = true
    if arg1.Type ~= "Chassis" then
        var4 = true
        if arg1.Type ~= "DuneBuggy" then
            var4 = true
            if arg1.Type ~= "Motorcycle" then
                if arg1.Make ~= "Tank" then
                    var4 = false
                else
                    var4 = true
                end
            end
        end
    end
    return var4
end