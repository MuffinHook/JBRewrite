-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKCHR5cGVFbnVtEG1pc3NpbmcgdHlwZUVudW0GYXNzZXJ0HHNldFNhZmVzU2VsZWN0ZWRTYWZlVHlwZUVudW0EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgACBQIAAAAAD00EAWoAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0CAWoAAAAAggICAAQDAQMCAwMEAAAgQAAFBAEYAAAAAAAAAAAAAAAAAQAABgAAAAAGAAABAgAVowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICTQIB1gcAAACMAwEA4gQJAMAFCgAwBQRaCAAAAJ8CAwCCAgAACwMFBAAAAEADBgMHAwgEAABAQAMJAwoDBAUBCAYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAEAAP8AAQAAAAABZcgNR+JYx5c+hWvQyzdPnxXQGjNXDGdG

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:41
-- Luau version 6, Types version 3
-- Time taken: 0.000869 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(1, {
    setSafesSelectedSafeTypeEnum = function(arg1, arg2) -- Line 5, Named "setSafesSelectedSafeTypeEnum"
        local var2
        if arg2.typeEnum == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing typeEnum")
        return arg2.typeEnum
    end;
})