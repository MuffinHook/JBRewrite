-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBXZhbHVlLWpvaW4gcmVxdWVzdHMgY2Fubm90IGJlIG5pbDsgdHJ5IGJsYW5rIHRhYmxlPwZhc3NlcnQPc2V0Sm9pblJlcXVlc3RzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAA9NBAHMAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgHMAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAA/wMAAAAAAADiBAkAwAUKADAFBC0IAAAAnwIDAIICAAALAwUEAAAAQAMGAwcDCAQAAEBAAwkDCgMEBQEIBgABAAEAARgAAAAAAAAAAQAAAAACAAAAAAEAAP8AAQAAAAABRjF8NoqeQrp0gDM2a3uYRzYpa0J09RY3

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:30
-- Luau version 6, Types version 3
-- Time taken: 0.000889 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setJoinRequests = function(arg1, arg2) -- Line 5, Named "setJoinRequests"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "join requests cannot be nil; try blank table?")
        return arg2.value
    end;
})