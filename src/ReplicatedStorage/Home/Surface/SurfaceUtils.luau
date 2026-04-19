-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMIBkNGcmFtZQNuZXcBWQFYAVoHVmVjdG9yMxFnZXRQbGFjZW1lbnRQcmlzbRBnZXRTdGFuZGluZ1ByaXNtAAMJAgAAAAAVpAMCAAAEAICMBAAATQgBeAUAAABbBwgElQYHA3gFBgOMBgAAnwMEAgkCAANNBAF5BgAAAG8FBwBNBgF7CAAAAEw2AAKkAwoAAASQgJ8DBAKCAgMACwMBAwIEAAQAgAKamZmZmZmpPwIAAAAAAADgPwMDAwQCmpmZmZmZyT8DBQMGBAAEkIAAAwcBGAAAAAAAAAAAAAAAAQAAAAAAAAAAAQYAAAAACQIAAAAAFaQDAgAABACAjAQAAE0IAXgGAAAAWwcIBZUGBwR4BQYDjAYAAJ8DBAIJAgADTQQBeQcAAABvBQgATQYBewkAAABMNgACpAMLAAAEoICfAwQCggIDAAwDAQMCBAAEAIACmpmZmZmZqT8CAAAAAAAAHkACAAAAAAAA4D8DAwMEAjMzMzMzMy5AAwUDBgQABKCAAAsIARgAAAAAAAAAAAAAAAEAAAAAAAAAAAEOAAAAAAIAAAECAAqjAAAA/wACAAAAAADAAQAAMAEAwwEAAADAAQIAMAEALQMAAACCAAIABAYAAwcGAQMIAgABAQABGAAAAAIAAAgAAAgBAAAAAAJ/Lk5O6jCNb1bPqBZ09WjMDzZZOk3qJE8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:22
-- Luau version 6, Types version 3
-- Time taken: 0.000958 seconds

return {
    getPlacementPrism = function(arg1, arg2) -- Line 3, Named "getPlacementPrism"
        return arg1 * CFrame.new(0, arg2.Y * 0.5 + 0.05 - 0.05, 0), Vector3.new(arg2.X, 0.2, arg2.Z)
    end;
    getStandingPrism = function(arg1, arg2) -- Line 11, Named "getStandingPrism"
        return arg1 * CFrame.new(0, arg2.Y * 0.5 + 7.5 - 0.05, 0), Vector3.new(arg2.X, 15.1, arg2.Z)
    end;
}