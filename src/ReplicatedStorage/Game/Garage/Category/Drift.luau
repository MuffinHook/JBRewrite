-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMEBU1vZGVsBlByZXNldA5GaW5kRmlyc3RDaGlsZAVEcmlmdAACBwEAAAAAFU0BADsAAAAAKwECAKkCAACCAgIAbwQBALwCAQMCAAAAnwIDAisCAgCpAwAAggMCAG8GAwC8BAIDAgAAAJ8EAwJHBAIAAAAAgKkDAAGpAwEAggMCAAQDAQMCAwMDBAABAAEYAAABAQACAAAAAQEAAgAAAAAAAAAAAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAAAAQAAAAAB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:42
-- Luau version 6, Types version 3
-- Time taken: 0.000950 seconds

return function(arg1) -- Line 1
    local Model = arg1.Model
    local var3
    if not Model then
        return false
    end
    local Preset = Model:FindFirstChild("Preset")
    if not Preset then
        var3 = false
        return var3
    end
    if Preset:FindFirstChild("Drift") == nil then
        var3 = false
    else
        var3 = true
    end
    return var3
end