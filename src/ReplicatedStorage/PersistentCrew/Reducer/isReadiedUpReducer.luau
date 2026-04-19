-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBXZhbHVlJmlzUmVhZGllZFVwIGNhbm5vdCBiZSBuaWw7IHRyeSBib29sZWFuBmFzc2VydA5zZXRJc1JlYWRpZWRVcARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eA1jcmVhdGVSZWR1Y2VyAAIFAgAAAAAPTQQBzAAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBzAAAAACCAgIABAMBAwIDAwQAACBAAAUEARgAAAAAAAAAAAAAAAABAAAGAAAAAAYAAAECABWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAKkDAADiBAkAwAUKADAFBNwIAAAAnwIDAIICAAALAwUEAAAAQAMGAwcDCAQAAEBAAwkDCgMEBQEIBgABAAEAARgAAAAAAAAAAQAAAAACAAAAAQAA/wABAAAAAAENzcAI8MLqTVhnVGmsXZmgfdXXfD8Jqgk=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:29
-- Luau version 6, Types version 3
-- Time taken: 0.000912 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setIsReadiedUp = function(arg1, arg2) -- Line 5, Named "setIsReadiedUp"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "isReadiedUp cannot be nil; try boolean")
        return arg2.value
    end;
})