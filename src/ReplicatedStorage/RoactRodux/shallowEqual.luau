-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMCBXBhaXJzDHNoYWxsb3dFcXVhbAACCAIAAAAAKEcABgAAAACARwECAAAAAACpAgABqQIBAIICAgBHAQYAAAAAgEcAAgAAAAAAqQIAAakCAQCCAgIApAIBAAAAAEBSAwAAnwICBBcCBQCHBwEF8QYDAAcAAACpBwAAggcCAG4C+v8CAAAApAIBAAAAAEBSAwEAnwICBBcCBQCHBwAF8QYDAAcAAACpBwAAggcCAG4C+v8CAAAAqQIBAIICAgACAwEEAAAAQAABAgEYAAABAAAAAAEAAQAAAAADAAAAAAEAAAEA/gAGAAAAAAEAAAEA/gAGAAIAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAAEAAQABGAAAFgEAAAAAAUf6OkJ6HUPeJ/d5U88hvDE34i02dT5QQw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:42
-- Luau version 6, Types version 3
-- Time taken: 0.001834 seconds

return function(arg1, arg2) -- Line 1, Named "shallowEqual"
    if arg1 == nil then
        if arg2 ~= nil then
        else
        end
        do
            return true
        end
        local var9
    end
    if arg2 == nil then
        if arg1 ~= nil then
            var9 = false
        else
            var9 = true
        end
        return var9
    end
    for i, v in pairs(arg1) do
        if v ~= arg2[i] then
            return false
        end
    end
    for i_2, v_2 in pairs(arg2) do
        if v_2 ~= arg1[i_2] then
            return false
        end
    end
    return true
end