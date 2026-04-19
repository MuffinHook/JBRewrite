-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBXZhbHVlDW1pc3NpbmcgdmFsdWUGYXNzZXJ0FXNldFRyYWRlSW52ZW50b3J5T3BlbgRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eA1jcmVhdGVSZWR1Y2VyAAIFAgAAAAAPTQQBzAAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBzAAAAACCAgIABAMBAwIDAwQAACBAAAUEARgAAAAAAAAAAAAAAAABAAAGAAAAAAYAAAECABWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAKkDAADiBAkAwAUKADAFBE8IAAAAnwIDAIICAAALAwUEAAAAQAMGAwcDCAQAAEBAAwkDCgMEBQEIBgABAAEAARgAAAAAAAAAAQAAAAACAAAAAQAA/wABAAAAAAG/qOQ+1/uMj6f94VaxqKKRz7DzSo1sjj8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:22
-- Luau version 6, Types version 3
-- Time taken: 0.001182 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setTradeInventoryOpen = function(arg1, arg2) -- Line 5, Named "setTradeInventoryOpen"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing value")
        return arg2.value
    end;
})