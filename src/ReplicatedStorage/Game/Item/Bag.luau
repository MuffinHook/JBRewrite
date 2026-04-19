-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcA25ldwxzZXRtZXRhdGFibGUQU3ByaW5nSXRlbU9mZnNldAlTZXRUYXJnZXQSU3ByaW5nTmVja1JvdGF0aW9uE1NwcmluZ1dhaXN0Um90YXRpb24VRGVmYXVsdERpc2FibGVDYW1Mb2NrEkdldExlZnRBcm1Qb3NpdGlvbgpJbnB1dEJlZ2FuCklucHV0RW5kZWQGc2NyaXB0BlBhcmVudAdyZXF1aXJlBUJhc2ljA0hpcBJSaWdodFdyaXN0Um90YXRpb24RTGVmdFdyaXN0Um90YXRpb24HU3ByaW5ncwpJdGVtT2Zmc2V0DEl0ZW1Sb3RhdGlvbgxOZWNrUm90YXRpb24NV2Fpc3RSb3RhdGlvbgdWZWN0b3IzBkNGcmFtZQZNb3Rpb24DQmFnC19fQ2xhc3NOYW1lB19faW5kZXgABQgDAwAAACX7AwAATQMD7wAAAABSBAAAUgUBAPsGAQBSBwIAnwMFAvsGAgCePQMEBgAAAFIFAwCkBAIAAAAQQJ8EAwFNBAMdAwAAAG8GBAC8BASXBQAAAJ8EAwFNBAODBgAAAG8GBwC8BASXBQAAAJ8EAwFNBAMSCAAAAG8GCQC8BASXBQAAAJ8EAwG8BAO+CgAAAJ8EAgGCAwIACwMBAwIEAAAQQAMDBwAAgD8AAABAAAAAAAAAAAADBAMFBzMzsz4AAAAAAAAAAAAAAAADBgczM7O+AAAAAAAAAAAAAAAAAwcAFwEBGAAAAAAAAAAAAQAAAAAAAAIAAAAAAAEAAAAAAAEAAAAAAAIAAAIYAAAAAAIBAAAAAALGAQAAggECAAAAIwgBGAAAJAAAAAAEAQEBAAAIowEAAPsBAABNAQGCAAAAAFICAADdAwAAnwEAAYIAAQABAwkAJgkBGAABAAAAAAABJgAAAAABAQAAAAABggABAAAAKQoBGAApAAAAAAcAAAECAFOjAAAApAABAAAAAEBNAAAkAgAAAKQBBAAAADBATQIAywUAAACfAQIC/wIBAAAAAADiAwkA4gQLAOIFEABvBhEAMAYFgAwAAABMNgACpAYUAABMIIGfBgECMAYF5Q0AAABMNgACpAYUAABMIIGfBgECMAYFjQ4AAABMNgACpAYUAABMIIGfBgECMAYFXw8AAAAwBQSYCgAAADAEA70GAAAApAQWAABMUIGfBAECMAQDDgcAAACkBBYAAExQgZ8EAQIwBAOFCAAAADADApcXAAAA/wMEAAAAAABvBBgAMAQD5RkAAAAwAwNuGgAAAJ49AwUBAAAAUgUDAFIGAQCkBBwAAACwQZ8EAwHABB0AEgABABIAAgASAAMAMAQD7xMAAADABB4AMAQDkx8AAADABCAAEgABADAEA4IhAAAAwAQiADAEA68jAAAAggMCACQDCwQAAABAAwwDDQQAADBAAw4DDwMQAxEFAwYHCAMSBQEKAxMDFAMVAxYFBAwNDg8HAACAPwAAwD8AAIC/AAAAAAMXAwEEAEwggQMYBABMUIEDGQMaAxsDHAMCBAAAsEEGAAYBAwgGAgMJBgMDCgQAAQIDAQABGAAAAAAAAQAAAAACAAEBAQEAAAEAAAAAAAEAAAAAAAEAAAAAAPwA/wAJAAAAAAEAAAAA9QAOAAEAAAEAAQAAAAAAAAEAAAAAAAwAAAMAAAADAAACAQAAAAAEWgFs9Kl2cU47sjpdLt+Y9yoZe4BoxQb1

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:03
-- Luau version 6, Types version 3
-- Time taken: 0.002117 seconds

local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1, 1.5, -1);
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
    __ClassName = "Bag";
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
    any_new_result1.SpringItemOffset:SetTarget(Vector3.new(1, 2, 0))
    any_new_result1.SpringNeckRotation:SetTarget(Vector3.new(0.34999, 0, 0))
    any_new_result1.SpringWaistRotation:SetTarget(Vector3.new(-0.3499, 0, 0))
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 35
    return nil
end
function module_upvr.InputBegan(arg1, ...) -- Line 38
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 41
end
return module_upvr