-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaA25ldwxzZXRtZXRhdGFibGUSU3ByaW5nTmVja1JvdGF0aW9uCVNldFRhcmdldBNTcHJpbmdXYWlzdFJvdGF0aW9uFURlZmF1bHREaXNhYmxlQ2FtTG9jawpJbnB1dEJlZ2FuCklucHV0RW5kZWQGc2NyaXB0BlBhcmVudAdyZXF1aXJlBUJhc2ljA0hpcBJSaWdodFdyaXN0Um90YXRpb24RTGVmdFdyaXN0Um90YXRpb24HU3ByaW5ncwpJdGVtT2Zmc2V0DEl0ZW1Sb3RhdGlvbgxOZWNrUm90YXRpb24NV2Fpc3RSb3RhdGlvbgdWZWN0b3IzBkNGcmFtZQZNb3Rpb24FQ3JhdGULX19DbGFzc05hbWUHX19pbmRleAAECAMDAAAAH/sDAABNAwPvAAAAAFIEAABSBQEA+wYBAFIHAgCfAwUC+wYCAJ49AwQGAAAAUgUDAKQEAgAAABBAnwQDAU0EA4MDAAAAbwYEALwEBJcFAAAAnwQDAU0EAxIGAAAAbwYHALwEBJcFAAAAnwQDAbwEA74IAAAAnwQCAYIDAgAJAwEDAgQAABBAAwMHzcxMvgAAAAAAAAAAAAAAAAMEAwUHzcxMPgAAAAAAAAAAAAAAAAMGABcBARgAAAAAAAAAAAEAAAAAAAACAAAAAAABAAAAAAACAAACGAAAAAAEAQEBAAAIowEAAPsBAABNAQGCAAAAAFICAADdAwAAnwEAAYIAAQABAwcAIgcBGAABAAAAAAABIgAAAAABAQAAAAABggABAAAAJQgBGAAlAAAAAAcAAAECAE2jAAAApAABAAAAAEBNAAAkAgAAAKQBBAAAADBATQIAywUAAACfAQIC/wIBAAAAAADiAwkA4gQLAOIFEABvBhEAMAYFgAwAAABvBhIAMAYF5Q0AAABMNgACpAYVAABQMIGfBgECMAYFjQ4AAABMNgACpAYVAABQMIGfBgECMAYFXw8AAAAwBQSYCgAAADAEA70GAAAApAQXAABQYIGfBAECMAQDDgcAAACkBBcAAFBggZ8EAQIwBAOFCAAAADADApcYAAAA/wMEAAAAAABvBBkAMAQD5RoAAAAwAwNuGwAAAJ49AwUBAAAAUgUDAFIGAQCkBB0AAADAQZ8EAwHABB4AEgABABIAAgASAAMAMAQD7xQAAADABB8AEgABADAEA4IgAAAAwAQhADAEA68iAAAAggMCACMDCQQAAABAAwoDCwQAADBAAwwDDQMOAw8FAwYHCAMQBQEKAxEDEgMTAxQFBAwNDg8HAAAAAM3MzL4AAMC/AAAAAAfNzMy9AAAAAAAAAAAAAAAAAxUDAQQAUDCBAxYEAFBggQMXAxgDGQMaAwIEAADAQQYABgEDBwYCAwgDAAECAQABGAAAAAAAAQAAAAACAAEBAQEAAAEAAAEAAAAAAAEAAAAAAPwA/wAJAAAAAAEAAAAA9QAOAAEAAAEAAQAAAAAAAAEAAAAAAAsAAAADAAACAQAAAAAD5v6w6CuLl3dujyq78keff5bmp5zUOtrp

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:08
-- Luau version 6, Types version 3
-- Time taken: 0.002157 seconds

local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, -0.4000, -1.5);
                ItemRotation = Vector3.new(-0.1000, 0, 0);
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
}
local module_upvr = {
    __ClassName = "Crate";
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
    any_new_result1.SpringNeckRotation:SetTarget(Vector3.new(-0.2000, 0, 0))
    any_new_result1.SpringWaistRotation:SetTarget(Vector3.new(0.20000, 0, 0))
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
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