-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXOEludmFsaWQgb3IgbWlzc2luZyBudW1iZXIgYXQgcG9zaXRpb24gJWQgaW4gVmVjdG9yIHR5cGUuBmZvcm1hdA52YWxpZGF0ZVZlY3Rvcgd2ZWN0b3IzDFJlZ2lzdGVyVHlwZQh2ZWN0b3IzcxBNYWtlTGlzdGFibGVUeXBlB3ZlY3RvcjIIdmVjdG9yMnMHcmVxdWlyZQZzY3JpcHQGUGFyZW50BlNoYXJlZARVdGlsEE1ha2VTZXF1ZW5jZVR5cGUMVmFsaWRhdGVFYWNoDVRyYW5zZm9ybUVhY2gLQ29uc3RydWN0b3IGTGVuZ3RoCHRvbnVtYmVyB1ZlY3RvcjMDbmV3B1ZlY3RvcjIAAwYCAAAABwAAAQMDBQILRwAIAAAAAICpAgAAbwMAAFIFAQC8AwONAQAAAJ8DAwCCAgAAqQIBAIICAgACAwEDAgADAwEYAAABAAAAAAAAAwAEAAAAAAYBAwAAAB1vAwAA+wQAALwBAN0BAAAAnwEEAW8DAgD7BAEATQQEJAMAAAD7BQAAnwQCALwBAN0BAAAAnwEAAW8DBAD7BAIAvAEA3QEAAACfAQQBbwMFAPsEAQBNBAQkAwAAAPsFAgCfBAIAvAEA3QEAAACfAQABggABAAYDBAMFAwYDBwMIAwkAGQABGAAAAAAAAQAAAAAAAAAAAgAAAAABAAAAAAAAAAABGgAAAAAGAAABAgA2owAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BASQEAAAATQEBEgUAAABNAQGeBgAAAJ8AAgLAAQcATQIAIwgAAADiAw0AMAEDkQkAAACkBA8AAADgQDAEA00KAAAApAQSAABEAIEwBAO3CwAAAIwEAwAwBAOtDAAAAJ8CAgJNAwAjCAAAAOIEDQAwAQSRCQAAAKQFDwAAAOBAMAUETQoAAACkBRQAAEQwgTAFBLcLAAAAjAUCADAFBK0MAAAAnwMCAsAEFQASAAIAEgAAABIAAwCCBAIAFgMKBAAAAEADCwQAACBAAwwDDQMOBgADDwMQAxEDEgMTBQQJCgsMAxQEAADgQAMVAxYEAEQAgQMXBABEMIEGAQIAAQEAARgAAAAAAAAAAAAAAAAAAAIIAAABAAEAAAABAAAAAQAA/AcAAAEAAQAAAAEAAAABAAD8BwAAAAABAAAAAAJRraobQlq/xYXRdIW3BkvhIbW9b2NpwBo=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:53
-- Luau version 6, Types version 3
-- Time taken: 0.001374 seconds

local Util_upvr = require(script.Parent.Parent.Shared.Util)
local function validateVector(arg1, arg2) -- Line 3
    if arg1 == nil then
        return false, "Invalid or missing number at position %d in Vector type.":format(arg2)
    end
    return true
end
local any_MakeSequenceType_result1_upvr = Util_upvr.MakeSequenceType({
    ValidateEach = validateVector;
    TransformEach = tonumber;
    Constructor = Vector3.new;
    Length = 3;
})
local any_MakeSequenceType_result1_upvr_2 = Util_upvr.MakeSequenceType({
    ValidateEach = validateVector;
    TransformEach = tonumber;
    Constructor = Vector2.new;
    Length = 2;
})
return function(arg1) -- Line 25
    --[[ Upvalues[3]:
        [1]: any_MakeSequenceType_result1_upvr (readonly)
        [2]: Util_upvr (readonly)
        [3]: any_MakeSequenceType_result1_upvr_2 (readonly)
    ]]
    arg1:RegisterType("vector3", any_MakeSequenceType_result1_upvr)
    arg1:RegisterType("vector3s", Util_upvr.MakeListableType(any_MakeSequenceType_result1_upvr))
    arg1:RegisterType("vector2", any_MakeSequenceType_result1_upvr_2)
    arg1:RegisterType("vector2s", Util_upvr.MakeListableType(any_MakeSequenceType_result1_upvr_2))
end