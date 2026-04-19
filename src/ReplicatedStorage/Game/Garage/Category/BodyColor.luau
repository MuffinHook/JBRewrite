-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMFBU1vZGVsBEJvZHkORmluZEZpcnN0Q2hpbGQETWFrZQVTbG9vcAACBgEAAAAAEU0BADsAAAAAKwEBAIIAAQBvBAEAqQUBALwCAQMCAAAAnwIEAisCBgBNAwCtAwAAAPADAgAEAAAAqQIAAakCAQCCAgIABQMBAwIDAwMEAwUAAQABGAAAAQECAAAAAAAAAAAAAAAAAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAAAAQAAAAAB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:40
-- Luau version 6, Types version 3
-- Time taken: 0.000817 seconds

return function(arg1) -- Line 1
    local Model = arg1.Model
    if not Model then return end
    local Body = Model:FindFirstChild("Body", true)
    if not Body then
        if arg1.Make ~= "Sloop" then
            Body = false
        else
            Body = true
        end
    end
    return Body
end