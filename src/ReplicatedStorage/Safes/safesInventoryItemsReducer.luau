-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaCml0ZW1zT3duZWQSbWlzc2luZyBpdGVtc093bmVkBmFzc2VydAJJZAptaXNzaW5nIElkCFR5cGVFbnVtFG1pc3Npbmcgc2FmZVRpZXJEYXRhBG5hbWUIdHlwZUVudW0HaW1hZ2VJZAtpdGVtT3duZWRJZAUlc18lcwZmb3JtYXQHSW1hZ2VJZAV0YWJsZQZpbnNlcnQWc2V0U2FmZXNJbnZlbnRvcnlJdGVtcwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eAVTYWZlcwtTYWZlc0NvbnN0cwlTQUZFX0RBVEENY3JlYXRlUmVkdWNlcgACEQIBAAAHAAABAw0tAkVNBAGlAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwH/AgAAAAAAAE0DAaUAAAAAxgQAAMYFAABkAy8ATQkHlAQAAACBAQkEBQAAAG8KBQCkCAMAAAAgQJ8IAwFNCAeKBgAAAPsKAACHCQoIRwkCAAAAAICpCwABqQsBAIEBCwQHAAAAbwwHAKQKAwAAACBAnwoDAeIMDABvDQ0AUg8IAFIQBgC8DQ2NDgAAAJ8NBAIwDQxaCAAAADAIDGoJAAAATQ0Jlg8AAAAwDQy2CgAAAE0NB5QEAAAAMA0MtQsAAACeNAIEDAAAAFILAgCkChIAAEQAgZ8KAwFuA9D/AgAAAIICAgATAwEDAgMDBAAAIEADBAMFAwYDBwMIAwkDCgMLBQQICQoLAwwDDQMOAw8DEAQARACBAAgRARgAAAAAAAAAAAAAAAABAAEAAAAAAQAAAAAAAAABAAEAAQAAAAAAAAAAAAECAAAAAAAAAAEAAQAAAAEAAAAAAAD7AAD7AA0JAAAAAAgAAAECACCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgKkAgUAAABAQE0DACIHAAAATQMDcwgAAACfAgICTQMCHQkAAABNBAHWCgAAAP8FAAAAAAAA4gYMAMAHDQASAAMAMAcGMgsAAACfBAMAggQAAA4DEgQAAABAAxMDFAMVBAAAQEADFgMXAxgDGQMaAxEFAQsGAAEAAQABGAAAAAAAAAABAAAAAAIAAAAAAAABAAIAAAAAAQAAAP8AAQAAAAABr65pUFbpg/7mCg/HIEPZS9+2fiSdagNR

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:39
-- Luau version 6, Types version 3
-- Time taken: 0.002334 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local SAFE_DATA_upvr = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
function module.setSafesInventoryItems(arg1, arg2) -- Line 8
    --[[ Upvalues[1]:
        [1]: SAFE_DATA_upvr (readonly)
    ]]
    local var8
    if arg2.itemsOwned == nil then
        var8 = false
    else
        var8 = true
    end
    assert(var8, "missing itemsOwned")
    local module_2 = {}
    var8 = arg2.itemsOwned
    for i, v in var8 do
        assert(v.Id, "missing Id")
        local TypeEnum = v.TypeEnum
        local var11 = SAFE_DATA_upvr[TypeEnum]
        local var12
        if var11 == nil then
            var12 = false
        else
            var12 = true
        end
        assert(var12, "missing safeTierData")
        var12 = module_2
        table.insert(var12, {
            name = "%s_%s":format(TypeEnum, i);
            typeEnum = TypeEnum;
            imageId = var11.ImageId;
            itemOwnedId = v.Id;
        })
    end
    return module_2
end
return require(ReplicatedStorage.Rodux).createReducer({}, module)