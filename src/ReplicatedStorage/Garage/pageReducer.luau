-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLCHBhZ2VOYW1lEW1pc3NpbmcgcGFnZSBOYW1lBmFzc2VydAdzZXRQYWdlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIJQ3VzdG9taXplAAIFAgAAAAAPTQQB6QAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIB6QAAAACCAgIABAMBAwIDAwQAACBAAAUEARgAAAAAAAAAAAAAAAABAAEGAAAAAAYAAAECABWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAG8DCADiBAoAwAULADAFBDgJAAAAnwIDAIICAAAMAwUEAAAAQAMGAwcDCAQAAEBAAwkDCgMLAwQFAQkGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAAXA4CHTp0IDcVCwIrfOxmRgAIB8AQvxidQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:24
-- Luau version 6, Types version 3
-- Time taken: 0.001120 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer("Customize", {
    setPage = function(arg1, arg2) -- Line 5, Named "setPage"
        local var2
        if arg2.pageName == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing page Name")
        return arg2.pageName
    end;
})