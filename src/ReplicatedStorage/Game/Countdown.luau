-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdDEdldFJlbWFpbmluZwZvblRpY2sERmlyZQhmaW5pc2hlZApvbkZpbmlzaGVkBG1haWQMdGlja0ludGVydmFsFE1pc3NpbmcgZGVhZGxpbmVVbml4BmFzc2VydANuZXcMc2V0bWV0YXRhYmxlDGRlYWRsaW5lVW5peAhHaXZlVGFzawVldmVyeQdDb25uZWN0CERhdGVUaW1lA25vdw1Vbml4VGltZXN0YW1wCkdldE5vd1VuaXgKSXNGaW5pc2hlZARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQKQmFzZU9iamVjdAZTaWduYWwISW50ZXJ2YWwHX19pbmRleAAGBAABAAAALPsAAAC8AAAdAAAAAJ8AAgKMAQAAfQAeAAEAAAD7AQAATQEB4gEAAABSAwAAvAEB3QIAAACfAQMB+wEAAE0BAfEDAAAAKwEHAPsBAABNAQFjBAAAAFIDAAC8AQHdAgAAAJ8BAwH7AQAAqQIBADACAfEDAAAA+wEAAE0BARYFAAAAxgIAADACAf4GAAAAggABAPsBAABNAQHiAQAAAFIDAAC8AQHdAgAAAJ8BAwGCAAEABwMBAwIDAwMEAwUDBgMHABYAARgAAAAAAQAAAQAAAAAAAAEAAAABAAAAAAAAAgAAAAEAAAAAAAACAAAAAAAAAhcAAAAABgEEAAAGAwAABQECREcAAgAAAACAqQIAAakCAQCBAQIEAAAAAG8DAACkAQIAAAAQQJ8BAwH7AQAATQEB7wMAAADGAgAAnwECAvsEAQCePQEEBAAAAFIDAQCkAgUAAABAQJ8CAwEwAAFzBgAAAPsCAgBNAgLvAwAAAJ8CAQIwAgHiBwAAAE0CARYIAAAATQQB4gcAAAC8AgL9CQAAAJ8CAwH7AgIATQIC7wMAAACfAgECMAIBYwoAAABNAgEWCAAAAE0EAWMKAAAAvAIC/QkAAACfAgMBqQIAADACAfELAAAATQIBFggAAAD7AwMATQMDxAwAAACMBAEAnwMCAtkFAAASAAEAvAMDxw0AAACfAwMCMAMC/g4AAACCAQIADwMIAwkEAAAQQAMKAwsEAABAQAMMAwIDBgMNAwUDBAMOAw8DBwEACgoBGAAAAAAAAAAAAAABAAAAAAEAAAAAAAACAAEAAAAAAAEAAAAAAAABAAAAAAABAAAAAAAAAQAAAgAAAAAAAAAAAAAAAAAOCwAAAAACAQAAAAAGpAECAAAEAICfAQECTQEBtwMAAACCAQIABAMQAxEEAAQAgAMSACYTARgAAAAAAAAnAAAAAAUBAAAAAAdNAgBzAAAAALwDAK8BAAAAnwMCAiYBAgOCAQIAAgMMAxMAKQEBGAAAAAAAAAAqAAAAAAIBAAAAAANNAQDxAAAAAIIBAgABAwQALBQBGAAAAC0AAAAACAAAAQIAOKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICSwcAAACfAQICpAIFAAAAQEBNAwChBgAAAE0DAx8IAAAAnwICAqQDBQAAAEBATQQAoQYAAABNBASsCQAAAJ8DAgL/BAQAAAAAADAEBG4KAAAAnj0EBQEAAABSBgQAUgcBAKQFDAAAALBAnwUDAcAFDQASAAEAEgAEABIAAgASAAMAMAUE7w4AAADABQ8AMAUErxAAAADABREAMAUEHRIAAADABRMAMAUEoRQAAACCBAIAFQMVBAAAAEADFgMXAxgEAABAQAMZAxoDGwMcAx0DCwQAALBABgEDCgYCAxMGAwMBBgQDFAQBAgMEAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAACAAEAAQAAAAAAAAIAAAAAAAAcAAADAAADAAAEAQAAAAAF138iH8wo/zzzdpQZkD2oyqdnNWvlu0ge

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:14
-- Luau version 6, Types version 3
-- Time taken: 0.002518 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.new(arg1) -- Line 10
    --[[ Upvalues[4]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: Signal_upvr (readonly)
        [4]: Interval_upvr (readonly)
    ]]
    if arg1 == nil then
    else
    end
    assert(true, "Missing deadlineUnix")
    local any_new_result1_upvr = BaseObject_upvr.new(nil)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.deadlineUnix = arg1
    any_new_result1_upvr.onTick = Signal_upvr.new()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.onTick)
    any_new_result1_upvr.onFinished = Signal_upvr.new()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.onFinished)
    any_new_result1_upvr.finished = false
    any_new_result1_upvr.maid.tickInterval = Interval_upvr.every(1):Connect(function() -- Line 22
        --[[ Upvalues[1]:
            [1]: any_new_result1_upvr (readonly)
        ]]
        local any_GetRemaining_result1 = any_new_result1_upvr:GetRemaining()
        if any_GetRemaining_result1 <= 0 then
            any_new_result1_upvr.onTick:Fire(any_GetRemaining_result1)
            if not any_new_result1_upvr.finished then
                any_new_result1_upvr.onFinished:Fire(any_GetRemaining_result1)
            end
            any_new_result1_upvr.finished = true
            any_new_result1_upvr.maid.tickInterval = nil
        else
            any_new_result1_upvr.onTick:Fire(any_GetRemaining_result1)
        end
    end)
    return any_new_result1_upvr
end
function module_upvr.GetNowUnix(arg1) -- Line 38
    return DateTime.now().UnixTimestamp
end
function module_upvr.GetRemaining(arg1) -- Line 41
    return arg1.deadlineUnix - arg1:GetNowUnix()
end
function module_upvr.IsFinished(arg1) -- Line 44
    return arg1.finished
end
return module_upvr