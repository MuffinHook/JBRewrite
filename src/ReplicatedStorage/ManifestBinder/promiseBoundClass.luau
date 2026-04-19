-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZA0dldA9PYnNlcnZlSW5zdGFuY2UIR2l2ZVRhc2sHRGVzdHJveQlnZXRTdGF0dXMGU3RhdHVzB1N0YXJ0ZWQEd2FybkJbcHJvbWlzZUJvdW5kQ2xhc3NdIC0gSW5maW5pdGUgeWllbGQgcG9zc2libGUgb24gJXEgZm9yIGJpbmRlciAlcQoLR2V0RnVsbE5hbWUGR2V0VGFnBmZvcm1hdAdyZXNvbHZlA25ldwVkZWZlcgdmaW5hbGx5BHRhc2sFZGVsYXkEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkB1Byb21pc2UETWFpZAAGAwEBAAAABPsBAABSAgAAnwECAYIAAQAAABEAARgAAAABEgAAAAAIAQMAAAAW+wEAAPsDAQC8AQF/AAAAAJ8BAwIOAQQAUgIAAFIDAQCfAgIBggABAPsCAgD7BAAA+wYBANkHAAASAAAAvAQEzAEAAACfBAQAvAIC/QIAAACfAgABggABAAMDAQMCAwMBAAwAARgAAAAAAAEBAAAAAgAAAAAAAAAAAAAEDQAAAAACAAEAAAAF+wAAALwAAFAAAAAAnwACAYIAAQABAwQAFgABGAAAAAABFwAAAAAGAAQAAAcAAAEDARYCG/sAAAC8AAD9AAAAAJ8AAgL7AQEATQEB7AEAAABNAQGzAgAAAJoAEAABAAAApAAEAAAAMEBvAQUA+wMCALwDA7IGAAAAnwMCAvsEAwC8BAS3BwAAAJ8EAgC8AQGNCAAAAJ8BAACfAAABggABAAkDBQMGAwcDCAQAADBAAwkDCgMLAwwAGQABGAAAAAAAAAAAAAAAAQABAQAAAAEAAAD+AAD/BxoAAAAACAICAAAAJlIEAQC8AgB/AAAAAJ8CAwIOAgYA+wMAAE0DAx0BAAAAUgQCAJ8DAgCCAwAA+wMBAE0DA+8CAAAAnwMBAvsEAABNBARoAwAAANkFAAASAAAAEgABABIAAwCfBAIC2QcBABIAAwC8BQRCBAAAAJ8FAwGkBQcAABhQgIwGBQDZBwIAEgAEABICAAASAAEAEgAAAJ8FAwGCBAIACAMBAw0DDgMPAxADEQMSBAAYUIADAQIDBgABGAAAAAABAQAAAAAAAgAAAAEAAAAAAAAACgAAAAADAAAAAAAAAAAKBwAAAAAEAAABAgAZowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJyBwAAAJ8BAgKkAgUAAABAQE0DAKEGAAAATQMDdggAAACfAgICwAMJABIAAQASAAIAggMCAAoDEwQAAABAAxQDFQMWBAAAQEADFwMYAxkGBAEEAQABGAAAAAAAAAACAAAAAAAAAQAAAAAAAAIAAAABAAAAAAWqA8IP0IOp451kNXzEK36E2hvVe5jHqA4=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:30:34
-- Luau version 6, Types version 3
-- Time taken: 0.002011 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
return function(arg1, arg2) -- Line 6
    --[[ Upvalues[2]:
        [1]: Promise_upvr (readonly)
        [2]: Maid_upvr (readonly)
    ]]
    local any_Get_result1_2 = arg1:Get(arg2)
    if any_Get_result1_2 then
        return Promise_upvr.resolve(any_Get_result1_2)
    end
    local any_new_result1_upvr = Maid_upvr.new()
    local any_defer_result1_upvr = Promise_upvr.defer(function(arg1_2) -- Line 12
        --[[ Upvalues[3]:
            [1]: arg1 (readonly)
            [2]: arg2 (readonly)
            [3]: any_new_result1_upvr (readonly)
        ]]
        local any_Get_result1 = arg1:Get(arg2)
        if any_Get_result1 then
            arg1_2(any_Get_result1)
        else
            any_new_result1_upvr:GiveTask(arg1:ObserveInstance(arg2, function(arg1_3) -- Line 17
                --[[ Upvalues[1]:
                    [1]: arg1_2 (readonly)
                ]]
                arg1_2(arg1_3)
            end))
        end
    end)
    any_defer_result1_upvr:finally(function() -- Line 22
        --[[ Upvalues[1]:
            [1]: any_new_result1_upvr (readonly)
        ]]
        any_new_result1_upvr:Destroy()
    end)
    task.delay(5, function() -- Line 25
        --[[ Upvalues[4]:
            [1]: any_defer_result1_upvr (readonly)
            [2]: Promise_upvr (copied, readonly)
            [3]: arg2 (readonly)
            [4]: arg1 (readonly)
        ]]
        if any_defer_result1_upvr:getStatus() == Promise_upvr.Status.Started then
            warn("[promiseBoundClass] - Infinite yield possible on %q for binder %q\n":format(arg2:GetFullName(), arg1:GetTag()))
        end
    end)
    return any_defer_result1_upvr
end