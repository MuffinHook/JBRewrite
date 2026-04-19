-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBHRleHQVbWlzc2luZyBkaWFsb2d1ZSB0ZXh0BmFzc2VydA9zZXREaWFsb2d1ZVRleHQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgAAAgUCAAAAAA9NBAHVAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNAgHVAAAAAIICAgAEAwEDAgMDBAAAIEAABQQBGAAAAAAAAAAAAAAAAAEAAAYAAAAABgAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAdYHAAAAbwMIAOIECgDABQsAMAUEZQkAAACfAgMAggIAAAwDBQQAAABAAwYDBwMIBAAAQEADCQMKAwsDBAUBCQYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAEAAP8AAQAAAAABGSZGkEGbj/ZAoe2E/nZ5X2k+UeQr4iyR

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:04
-- Luau version 6, Types version 3
-- Time taken: 0.001183 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer("", {
    setDialogueText = function(arg1, arg2) -- Line 5, Named "setDialogueText"
        local var2
        if arg2.text == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing dialogue text")
        return arg2.text
    end;
})