-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBXZhbHVlDW1pc3NpbmcgdmFsdWUGYXNzZXJ0DHNldFNhZmVzT3Blbg90b2dnbGVTYWZlc09wZW4EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgADBQIAAAAAD00EAcwAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0CAcwAAAAAggICAAQDAQMCAwMEAAAgQAAFBAEYAAAAAAAAAAAAAAAAAQAABgAAAAACAQAAAAACVgEAAIIBAgAAAAkFARgAAAoAAAAABgAAAQIAGKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAqQMAAOIECgDABQsAMAUEywgAAADABQwAMAUEDgkAAACfAgMAggIAAA0DBgQAAABAAwcDCAMJBAAAQEADCgMLAwQDBQUCCAkGAAYBAgABAQABGAAAAAAAAAABAAAAAAIAAAABAAAEAAD7AAEAAAAAAnFy7mgQdJKpELf4NxFjzQMBavkcQ7aEaQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:41
-- Luau version 6, Types version 3
-- Time taken: 0.001232 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setSafesOpen = function(arg1, arg2) -- Line 5, Named "setSafesOpen"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing value")
        return arg2.value
    end;
    toggleSafesOpen = function(arg1) -- Line 9, Named "toggleSafesOpen"
        return not arg1
    end;
})