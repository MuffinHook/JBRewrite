-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBXRhYmxlBWNsb25lBXZhbHVlFG90aGVyVHJhZGVTZXJ2ZXJJbmZvF3NldE90aGVyVHJhZGVTZXJ2ZXJJbmZvB3Zpc2libGUec2V0T3RoZXJUcmFkZVNlcnZlckxpc3RWaXNpYmxlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAwQCAAAAAAmkAgIAAAQAgFIDAACfAgICTQMBzAMAAAAwAwLIBAAAAIICAgAFAwEDAgQABACAAwMDBAAFBQEYAAAAAAEAAAABBgAAAAAEAgAAAAAJpAICAAAEAIBSAwAAnwICAk0DAcwDAAAAMAMCoAQAAACCAgIABQMBAwIEAAQAgAMDAwYACgcBGAAAAAABAAAAAQsAAAAABgAAAQIAGaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAA/wMAAAAAAADiBAoAwAULADAFBG4IAAAAwAUMADAFBNQJAAAAnwIDAIICAAANAwgEAAAAQAMJAwoDCwQAAEBAAwwDDQMFAwcFAggJBgAGAQIAAQEAARgAAAAAAAAAAQAAAAACAAAAAAEAAAUAAPoAAQAAAAACuGrixOwO1hlBSQt2//rAL8hy9bCKrojF

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:27
-- Luau version 6, Types version 3
-- Time taken: 0.000944 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setOtherTradeServerInfo = function(arg1, arg2) -- Line 5, Named "setOtherTradeServerInfo"
        local clone_2 = table.clone(arg1)
        clone_2.otherTradeServerInfo = arg2.value
        return clone_2
    end;
    setOtherTradeServerListVisible = function(arg1, arg2) -- Line 10, Named "setOtherTradeServerListVisible"
        local clone = table.clone(arg1)
        clone.visible = arg2.value
        return clone
    end;
})