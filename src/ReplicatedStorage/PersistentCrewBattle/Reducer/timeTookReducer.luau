-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBmNsYW5JZA5taXNzaW5nIGNsYW5JZAZhc3NlcnQFdGFibGUFY2xvbmUFdmFsdWULc2V0VGltZVRvb2sEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgACBQIAAAAAFk0EARsAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAaQCBgAAFECAUgMAAJ8CAgJNAwEbAAAAAE0EAcwHAAAAagQCA4ICAgAIAwEDAgMDBAAAIEADBAMFBAAUQIADBgAFBwEYAAAAAAAAAAAAAAAAAQAAAAEAAAAAAQYAAAAABgAAAQIAFqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAA/wMAAAAAAADiBAkAwAUKADAFBHwIAAAAnwIDAIICAAALAwgEAAAAQAMJAwoDCwQAAEBAAwwDDQMHBQEIBgABAAEAARgAAAAAAAAAAQAAAAACAAAAAAEAAP8AAQAAAAABZuyeGw50tnJwEcG0V0MPXhb0iW9UKPQa

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:56
-- Luau version 6, Types version 3
-- Time taken: 0.001257 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setTimeTook = function(arg1, arg2) -- Line 5, Named "setTimeTook"
        local var2
        if arg2.clanId == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing clanId")
        var2 = arg1
        local clone = table.clone(var2)
        var2 = arg2.clanId
        clone[var2] = arg2.value
        return clone
    end;
})