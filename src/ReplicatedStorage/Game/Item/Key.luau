-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYA25ldwxzZXRtZXRhdGFibGUVRGVmYXVsdERpc2FibGVDYW1Mb2NrEkdldExlZnRBcm1Qb3NpdGlvbgpJbnB1dEJlZ2FuCklucHV0RW5kZWQGc2NyaXB0BlBhcmVudAdyZXF1aXJlBUJhc2ljA0hpcBJSaWdodFdyaXN0Um90YXRpb24RTGVmdFdyaXN0Um90YXRpb24HU3ByaW5ncwpJdGVtT2Zmc2V0DEl0ZW1Sb3RhdGlvbgxOZWNrUm90YXRpb24NV2Fpc3RSb3RhdGlvbgdWZWN0b3IzBkNGcmFtZQZNb3Rpb24DS2V5C19fQ2xhc3NOYW1lB19faW5kZXgABQgDAwAAABP7AwAATQMD7wAAAABSBAAAUgUBAPsGAQBSBwIAnwMFAvsGAgCePQMEBgAAAFIFAwCkBAIAAAAQQJ8EAwG8BAO+AwAAAJ8EAgGCAwIABAMBAwIEAAAQQAMDABcBARgAAAAAAAAAAAEAAAAAAAACAAACGAAAAAACAQAAAAACxgEAAIIBAgAAAB8EARgAACAAAAAABAEBAQAACKMBAAD7AQAATQEBggAAAABSAgAA3QMAAJ8BAAGCAAEAAQMFACIFARgAAQAAAAAAASIAAAAAAQEAAAAAAYIAAQAAACUGARgAJQAAAAAHAAABAgBTowAAAKQAAQAAAABATQAAJAIAAACkAQQAAAAwQE0CAMsFAAAAnwECAv8CAQAAAAAA4gMJAOIECwDiBRAAbwYRADAGBYAMAAAATDYAAqQGFAAATCCBnwYBAjAGBeUNAAAATDYAAqQGFAAATCCBnwYBAjAGBY0OAAAATDYAAqQGFAAATCCBnwYBAjAGBV8PAAAAMAUEmAoAAAAwBAO9BgAAAKQEFgAATFCBnwQBAjAEAw4HAAAApAQWAABMUIGfBAECMAQDhQgAAAAwAwKXFwAAAP8DBAAAAAAAbwQYADAEA+UZAAAAMAMDbhoAAACePQMFAQAAAFIFAwBSBgEApAQcAAAAsEGfBAMBwAQdABIAAQASAAIAEgADADAEA+8TAAAAwAQeADAEA5MfAAAAwAQgABIAAQAwBAOCIQAAAMAEIgAwBAOvIwAAAIIDAgAkAwcEAAAAQAMIAwkEAAAwQAMKAwsDDAMNBQMGBwgDDgUBCgMPAxADEQMSBQQMDQ4PBwAAgD+amRk/AADAvwAAAAADEwMBBABMIIEDFAQATFCBAxUDFgMXAxgDAgQAALBBBgAGAQMEBgIDBQYDAwYEAAECAwEAARgAAAAAAAEAAAAAAgABAQEBAAABAAAAAAABAAAAAAABAAAAAAD8AP8ACQAAAAABAAAAAPUADgABAAABAAEAAAAAAAABAAAAAAAIAAADAAAAAwAAAgEAAAAABANaoKw5XWmXQB/E4AnrIgZzQrfYMZ7KrQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:20
-- Luau version 6, Types version 3
-- Time taken: 0.001735 seconds

local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1, 0.60000, -1.5);
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
    __ClassName = "Key";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 23
    --[[ Upvalues[3]:
        [1]: Basic_upvr (readonly)
        [2]: tbl_upvr (readonly)
        [3]: module_upvr (readonly)
    ]]
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 31
    return nil
end
function module_upvr.InputBegan(arg1, ...) -- Line 34
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 37
end
return module_upvr