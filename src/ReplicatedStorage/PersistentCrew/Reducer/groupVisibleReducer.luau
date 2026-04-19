-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJEnRvZ2dsZUdyb3VwVmlzaWJsZQV2YWx1ZQ9zZXRHcm91cFZpc2libGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgADAgEAAAAAAlYBAACCAQIAAAAFAQEYAAAGAAAAAAMCAAAAAANNAgHMAAAAAIICAgABAwIACAMBGAAAAAkAAAAABgAAAQIAGKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAqQMAAOIECgDABQsAMAUElggAAADABQwAMAUEKwkAAACfAgMAggIAAA0DBAQAAABAAwUDBgMHBAAAQEADCAMJAwEDAwUCCAkGAAYBAgABAQABGAAAAAAAAAABAAAAAAIAAAABAAADAAD8AAEAAAAAAjKmaSq7SUNb2KM0snxmnAlCvn5eAGIDKw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:28
-- Luau version 6, Types version 3
-- Time taken: 0.000985 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    toggleGroupVisible = function(arg1) -- Line 5, Named "toggleGroupVisible"
        return not arg1
    end;
    setGroupVisible = function(arg1, arg2) -- Line 8, Named "setGroupVisible"
        return arg2.value
    end;
})