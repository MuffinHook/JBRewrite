-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKCnJlY2VpdmVkQXQSbWlzc2luZyByZWNlaXZlZEF0BmFzc2VydBtzZXRTcGF3blNlbGVjdGlvblJlY2VpdmVkQXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgACBQIAAAAAC00DAREAAAAAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBEQAAAACCAgIABAMBAwIDAwQAACBAAAUEARgAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAjAMAAOIECQDABQoAMAUEEQgAAACfAgMAggIAAAsDBQQAAABAAwYDBwMIBAAAQEADCQMKAwQFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAABAAD/AAEAAAAAAaZBhZEjuPu2t/wgLRmMzBnWWZLllIXvkA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:58
-- Luau version 6, Types version 3
-- Time taken: 0.000808 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(0, {
    setSpawnSelectionReceivedAt = function(arg1, arg2) -- Line 5, Named "setSpawnSelectionReceivedAt"
        assert(arg2.receivedAt, "missing receivedAt")
        return arg2.receivedAt
    end;
})