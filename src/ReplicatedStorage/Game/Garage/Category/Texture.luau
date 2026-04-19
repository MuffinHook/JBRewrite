-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMDBU1vZGVsBEJvZHkORmluZEZpcnN0Q2hpbGQAAgYBAAAAAApNAQA7AAAAACsBAQCCAAEAbwQBAKkFAQC8AgEDAgAAAJ8CBACCAgAAAwMBAwIDAwABAAEYAAABAQIAAAAAAAIAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAAEAAQABGAAAAAEAAAAAAQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:50
-- Luau version 6, Types version 3
-- Time taken: 0.000517 seconds

return function(arg1) -- Line 1
    local Model = arg1.Model
    if not Model then return end
    return Model:FindFirstChild("Body", true)
end