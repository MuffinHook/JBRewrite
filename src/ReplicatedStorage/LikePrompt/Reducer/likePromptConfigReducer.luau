-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBXRhYmxlBWNsb25lB3Zpc2libGUMY291bnRkb3duVGlsE3NldExpa2VQcm9tcHRDb25maWcEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgACBAIAAAAADaQCAgAABACAUgMAAJ8CAgJNAwGgAwAAADADAqADAAAATQMB8wQAAAAwAwLzBAAAAIICAgAFAwEDAgQABACAAwMDBAAIBQEYAAAAAAEAAAABAAAAAQkAAAAABgAAAQIAG6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAA4gMKAKkEAAAwBAOgCAAAAIwEAAAwBAPzCQAAAOIEDADABQ0AMAUERgsAAACfAgMAggIAAA4DBgQAAABAAwcDCAMJBAAAQEADCgMLAwMDBAUCCAkDBQUBCwYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAQAAAQAAAQEAAPwAAQAAAAABvE3tgg9VYqGy0JnpSFaONcxV+vaOiYeD

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:49
-- Luau version 6, Types version 3
-- Time taken: 0.000761 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({
    visible = false;
    countdownTil = 0;
}, {
    setLikePromptConfig = function(arg1, arg2) -- Line 8, Named "setLikePromptConfig"
        local clone = table.clone(arg1)
        clone.visible = arg2.visible
        clone.countdownTil = arg2.countdownTil
        return clone
    end;
})