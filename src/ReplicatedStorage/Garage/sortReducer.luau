-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMOAmlkCm1pc3NpbmcgaWQGYXNzZXJ0B3NldFNvcnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgGc2NyaXB0BlBhcmVudAhFbnVtU29ydA1jcmVhdGVSZWR1Y2VyB1BvcHVsYXIAAgUCAAAAAA9NBAH0AAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgH0AAAAAIICAgAEAwEDAgMDBAAAIEAABwQBGAAAAAAAAAAAAAAAAAEAAAgAAAAABwAAAQIAH6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAqQCBQAAAEBApAMIAAAAcEBNAwMkCQAAAE0DAxwKAAAAnwICAk0DAdYLAAAATQQCSgwAAADiBQ4AwAYPADAGBdQNAAAAnwMDAIIDAAAQAwUEAAAAQAMGAwcDCAQAAEBAAwkDCgQAAHBAAwsDDAMNAw4DBAUBDQYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAAAAAAAAgAAAAABAAD/AAEAAAAAAZ6toBjh2JWbdSJMeEPQEVXutbdsrGnKGQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:27
-- Luau version 6, Types version 3
-- Time taken: 0.001330 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(require(script.Parent.EnumSort).Popular, {
    setSort = function(arg1, arg2) -- Line 7, Named "setSort"
        local var2
        if arg2.id == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing id")
        return arg2.id
    end;
})