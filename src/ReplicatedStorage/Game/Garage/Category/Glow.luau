-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMDBU1vZGVsBEdsb3cORmluZEZpcnN0Q2hpbGQAAgYBAAAAAA5NAQA7AAAAACsBAQCCAAEAbwQBAKkFAQC8AgEDAgAAAJ8CBAJHAgIAAAAAgKkDAAGpAwEAggMCAAMDAQMCAwMAAQABGAAAAQECAAAAAAEAAAAAAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAAAAQAAAAAB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:42
-- Luau version 6, Types version 3
-- Time taken: 0.001100 seconds

return function(arg1) -- Line 1
    local Model = arg1.Model
    local var3
    if not Model then return end
    if Model:FindFirstChild("Glow", true) == nil then
        var3 = false
    else
        var3 = true
    end
    return var3
end