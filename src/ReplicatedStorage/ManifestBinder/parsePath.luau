-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMHBnN0cmluZwVzcGxpdAEvAAV0YWJsZQZyZW1vdmUJcGFyc2VQYXRoAAIIAQAAAAATpAECAAAEAIBSAgAAbwMDAJ8BAwIcBAEAjAIBAIwD//+oAgkAhwUBBPAFBgAEAACApAUHAAAYUIBSBgEAUgcEAJ8FAwGLAvf/ggECAAgDAQMCBAAEAIADAwMEAwUDBgQAGFCAAAEHARgAAAAAAAEAAAABAAABAAAAAP4FAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAAJAQAAAAAB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:30:33
-- Luau version 6, Types version 3
-- Time taken: 0.000668 seconds

return function(arg1) -- Line 1, Named "parsePath"
    local string_split_result1 = string.split(arg1, '/')
    for i = #string_split_result1, 1, -1 do
        if string_split_result1[i] == "" then
            table.remove(string_split_result1, i)
        end
    end
    return string_split_result1
end