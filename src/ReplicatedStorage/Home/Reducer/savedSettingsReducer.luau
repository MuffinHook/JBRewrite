-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLA2tleQV2YWx1ZQV0YWJsZQVjbG9uZQ9zZXRTYXZlZFNldHRpbmcEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgACBQIAAAAAEk0DAUoAAAAAhwIAA00DAcwBAAAAmgICAAMAAACCAAIApAIEAAAMIIBSAwAAnwICAk0DAUoAAAAATQQBzAEAAABqBAIDggICAAUDAQMCAwMDBAQADCCAAAYFARgAAAAAAAAAAQIAAAABAAAAAAEIAAAAAAYAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQJAMAFCgAwBQRlCAAAAJ8CAwCCAgAACwMGBAAAAEADBwMIAwkEAABAQAMKAwsDBQUBCAYAAQABAAEYAAAAAAAAAAIAAAAAAgAAAAABAAD/AAEAAAAAARzo7havnVkZeu8xDZSo3c1s8PliLiyEFw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:17
-- Luau version 6, Types version 3
-- Time taken: 0.001172 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setSavedSetting = function(arg1, arg2) -- Line 6, Named "setSavedSetting"
        if arg1[arg2.key] == arg2.value then
            return arg1
        end
        local clone = table.clone(arg1)
        clone[arg2.key] = arg2.value
        return clone
    end;
})