-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMkA25ldwxzZXRtZXRhdGFibGUQU3ByaW5nSXRlbU9mZnNldAREYW1wBEZyZXETU3ByaW5nV2Fpc3RSb3RhdGlvbhJTcHJpbmdOZWNrUm90YXRpb24JU2V0VGFyZ2V0FURlZmF1bHREaXNhYmxlQ2FtTG9jawVMb2NhbAViYXNpYwpJbnB1dEJlZ2FuCklucHV0RW5kZWQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBnNjcmlwdAZQYXJlbnQHcmVxdWlyZQNBcHAMSGFwdGljRWZmZWN0BUJhc2ljA0hpcBJSaWdodFdyaXN0Um90YXRpb24RTGVmdFdyaXN0Um90YXRpb24HU3ByaW5ncwpJdGVtT2Zmc2V0DEl0ZW1Sb3RhdGlvbgxOZWNrUm90YXRpb24NV2Fpc3RSb3RhdGlvbgdWZWN0b3IzBkNGcmFtZQZNb3Rpb24GQ3VmZmVkC19fQ2xhc3NOYW1lB19faW5kZXgABAgDBAAAAEz7AwAATQMD7wAAAABSBAAAUgUBAPsGAQBSBwIAnwMFAvsGAgCePQMEBgAAAFIFAwCkBAIAAAAQQJ8EAwFNBAMdAwAAAG8FBAAwBQSIBQAAAE0EAx0DAAAAjAUHADAFBLUGAAAATQQDEgcAAABvBQQAMAUEiAUAAABNBAMSBwAAAIwFBwAwBQS1BgAAAE0EA4MIAAAAbwUEADAFBIgFAAAATQQDgwgAAACMBQcAMAUEtQYAAABNBAMdAwAAAG8GCQC8BASXCgAAAJ8EAwFNBAMSBwAAAG8GCwC8BASXCgAAAJ8EAwFNBAODCAAAAG8GCwC8BASXCgAAAJ8EAwG8BAO+DAAAAJ8EAgFNBAO7DQAAAA4EBgD7BAMATQQEKw4AAACMBQEAbwYPAJ8EAwGCAwIAEAMBAwIEAAAQQAMDAgAAAAAAAOA/AwQDBQMGAwcHAAAAAAAAAADNzEw+AAAAAAMIBwAAAL8AAAAAAAAAAAAAAAADCQMKAwsCmpmZmZmZyT8AGQEBGAAAAAAAAAAAAQAAAAAAAAIAAAAAAQAAAAABAAAAAAEAAAAAAQAAAAABAAAAAAIAAAAAAAEAAAAAAAEAAAAAAAIAAAIAAAEAAAAAAAMaAAAAAAQBAQEAAAijAQAA+wEAAE0BAYIAAAAAUgIAAN0DAACfAQABggABAAEDDAAwDAEYAAEAAAAAAAEwAAAAAAEBAAAAAAGCAAEAAAAzDQEYADMAAAAACQAAAQIAXqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0BASQGAAAApAIIAAAAcEBNAwDBCQAAAE0DA7wKAAAAnwICAqQDCAAAAHBATQQBywsAAACfAwIC/wQBAAAAAADiBQ8A4gYRAOIHFgBvCBcAMAgHgBIAAABMNgACpAgaAABkgIGfCAECMAgH5RMAAABMNgACpAgaAABkgIGfCAECMAgHjRQAAABMNgACpAgaAABkgIGfCAECMAgHXxUAAAAwBwaYEAAAADAGBb0MAAAApAYcAABksIGfBgECMAYFDg0AAACkBhwAAGSwgZ8GAQIwBgWFDgAAADAFBJcdAAAA/wUEAAAAAABvBh4AMAYF5R8AAAAwBQVuIAAAAJ49BQUDAAAAUgcFAFIIAwCkBiIAAAAQQp8GAwHABiMAEgADABIABAASAAUAEgACADAGBe8ZAAAAwAYkABIAAwAwBgWCJQAAAMAGJgAwBgWvJwAAAIIFAgAoAw4EAAAAQAMPAxADEQQAAEBAAxIDEwQAAHBAAxQDFQMWAxcDGAMZBQMMDQ4DGgUBEAMbAxwDHQMeBQQSExQVBwAAAAAAAAAAAACAvwAAAAADHwMBBABkgIEDIAQAZLCBAyEDIgMjAyQDAgQAABBCBgAGAQMMBgIDDQMAAQIBAAEYAAAAAAAAAAEAAAABAAAAAAAAAQAAAAACAAEBAQEAAAEAAAAAAAEAAAAAAAEAAAAAAPwA/wAJAAAAAAEAAAAA9QAOAAEAAAEAAQAAAAAAAAEAAAAAAAAXAAAAAwAAAgEAAAAAA9vSSrI724ycvhwt5IXUz/Kryl3G6RYgsw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:10
-- Luau version 6, Types version 3
-- Time taken: 0.002874 seconds

local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 0, -1);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
}
local module_upvr = {
    __ClassName = "Cuffed";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
local HapticEffect_upvr = require(game:GetService("ReplicatedStorage").App.HapticEffect)
function module_upvr.new(arg1, arg2, arg3) -- Line 25
    --[[ Upvalues[4]:
        [1]: Basic_upvr (readonly)
        [2]: tbl_upvr (readonly)
        [3]: module_upvr (readonly)
        [4]: HapticEffect_upvr (readonly)
    ]]
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.SpringItemOffset.Damp = 0.5
    any_new_result1.SpringItemOffset.Freq = 7
    any_new_result1.SpringWaistRotation.Damp = 0.5
    any_new_result1.SpringWaistRotation.Freq = 7
    any_new_result1.SpringNeckRotation.Damp = 0.5
    any_new_result1.SpringNeckRotation.Freq = 7
    any_new_result1.SpringItemOffset:SetTarget(Vector3.new(0, 0, 0.20000))
    any_new_result1.SpringWaistRotation:SetTarget(Vector3.new(-0.5, 0, 0))
    any_new_result1.SpringNeckRotation:SetTarget(Vector3.new(-0.5, 0, 0))
    any_new_result1:DefaultDisableCamLock()
    if any_new_result1.Local then
        HapticEffect_upvr.basic(1, 0.2)
    end
    return any_new_result1
end
function module_upvr.InputBegan(arg1, ...) -- Line 48
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 51
end
return module_upvr