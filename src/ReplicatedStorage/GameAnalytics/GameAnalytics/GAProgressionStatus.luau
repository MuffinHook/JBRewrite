-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBWVycm9yI0F0dGVtcHQgdG8gbW9kaWZ5IHJlYWQtb25seSB0YWJsZTogBiwga2V5PQgsIHZhbHVlPQpfX25ld2luZGV4B19faW5kZXgLX19tZXRhdGFibGUMc2V0bWV0YXRhYmxlDXJlYWRvbmx5dGFibGUFU3RhcnQIQ29tcGxldGUERmFpbAADCwMAAAAAC6QDAQAAAABAbwUCAFIGAABvBwMAUggBAG8JBABSCgIAcwQFCp8DAgGCAAEABQMBBAAAAEADAgMDAwQABQUBGAAAAAAAAAAAAAABBgAAAAAFAQAAAAAR/wIAAAAAAADiAwMAMAADbgAAAACpBAAAMAQDFQEAAADABAQAMAQDzgIAAACePQIDAwAAAKQBBgAAAFBAnwEDAoIBAgAHAwYDBwMFBQMAAQIGAAMIBAAAUEABAAEJARgAAAABAAEAAAEAAAAA/QAAAAIAAAAABAAAAQIAD6MAAADAAAAAUgEAAOICBABvAwEAMAMCHAEAAABvAwIAMAMCZwIAAABvAwMAMAMCFwMAAACfAQICggECAAUGAQMKAwsDDAUDAQIDAQEBAAEYAAAKAAEAAAEAAAEAAP0AAQAAAAAC303oc837+rzLHYNjDW7Rna9V/wftiYJy

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:30:01
-- Luau version 6, Types version 3
-- Time taken: 0.000861 seconds

return (function(arg1) -- Line 1, Named "readonlytable"
    local module = {}
    module.__index = arg1
    module.__metatable = false
    function module.__newindex(arg1_2, arg2, arg3) -- Line 5
        error("Attempt to modify read-only table: "..arg1_2..", key="..arg2..", value="..arg3)
    end
    return setmetatable({}, module)
end)({
    Start = "Start";
    Complete = "Complete";
    Fail = "Fail";
})