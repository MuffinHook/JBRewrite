-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMODGNhdGVnb3J5TmFtZRVtaXNzaW5nIGNhdGVnb3J5IE5hbWUGYXNzZXJ0C3NldENhdGVnb3J5B3NldFBhZ2UEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgEU2FsZQpTYWxlQ29uc3RzDWNyZWF0ZVJlZHVjZXINQ0FURUdPUllfTkFNRQADBQIAAAAAD00EAb4AAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0CAb4AAAAAggICAAQDAQMCAwMEAAAgQAAGBAEYAAAAAAAAAAAAAAAAAQABBwAAAAADAgAAAAAHTQIBvgAAAAAOAgMATQIBvgAAAACCAgIAggACAAEDAQALBQEYAAAAAQAAAgwAAAAABwAAAQIAIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAqQCBQAAAEBATQMA+AcAAABNAwMNCAAAAJ8CAgJNAwHWCQAAAE0EApgKAAAA4gUNAMAGDgAwBgVECwAAAMAGDwAwBgU4DAAAAJ8DAwCCAwAAEAMGBAAAAEADBwMIAwkEAABAQAMKAwsDDAMNAw4DBAMFBQILDAYABgECAAEBAAEYAAAAAAAAAAEAAAAAAQAAAAAAAAIAAAAAAQAABQAA+gABAAAAAALunrVPy0AbxjCu+zcuFThvnoaiO9xa304=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:17
-- Luau version 6, Types version 3
-- Time taken: 0.001540 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(require(ReplicatedStorage.Sale.SaleConsts).CATEGORY_NAME, {
    setCategory = function(arg1, arg2) -- Line 6, Named "setCategory"
        local var3
        if arg2.categoryName == nil then
            var3 = false
        else
            var3 = true
        end
        assert(var3, "missing category Name")
        return arg2.categoryName
    end;
    setPage = function(arg1, arg2) -- Line 11, Named "setPage"
        if arg2.categoryName then
            return arg2.categoryName
        end
        return arg1
    end;
})