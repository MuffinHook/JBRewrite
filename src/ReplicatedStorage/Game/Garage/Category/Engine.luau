-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMEBFR5cGUHQ2hhc3NpcwlEdW5lQnVnZ3kKTW90b3JjeWNsZQACAwEAAAAAEakBAQBNAgARAAAAAPACDAABAAAAqQEBAE0CABEAAAAA8AIHAAIAAABNAgARAAAAAPACAgADAAAAqQEAAakBAQCCAQIABAMBAwIDAwMEAAEAARgAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAAEAAQABGAAAAAEAAAAAAQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:41
-- Luau version 6, Types version 3
-- Time taken: 0.001076 seconds

return function(arg1) -- Line 1
    local var3 = true
    if arg1.Type ~= "Chassis" then
        var3 = true
        if arg1.Type ~= "DuneBuggy" then
            if arg1.Type ~= "Motorcycle" then
                var3 = false
            else
                var3 = true
            end
        end
    end
    return var3
end