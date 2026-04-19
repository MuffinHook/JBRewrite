-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWA25ldwxzZXRtZXRhdGFibGUKSW5wdXRCZWdhbgpJbnB1dEVuZGVkBnNjcmlwdAZQYXJlbnQHcmVxdWlyZQVCYXNpYwNIaXASUmlnaHRXcmlzdFJvdGF0aW9uEUxlZnRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uDVdhaXN0Um90YXRpb24HVmVjdG9yMwZDRnJhbWUGTW90aW9uClNoaWVsZFNXQVQLX19DbGFzc05hbWUHX19pbmRleAAECAMDAAAAEPsDAABNAwPvAAAAAFIEAABSBQEA+wYBAFIHAgCfAwUC+wYCAJ49AwQGAAAAUgUDAKQEAgAAABBAnwQDAYIDAgADAwEDAgQAABBAABcBARgAAAAAAAAAAAEAAAAAAAACGAAAAAAEAQEBAAAIowEAAPsBAABNAQGCAAAAAFICAADdAwAAnwEAAYIAAQABAwMAHQMBGAABAAAAAAABHQAAAAABAQAAAAABggABAAAAIAQBGAAgAAAAAAcAAAECAFCjAAAApAABAAAAAEBNAAAkAgAAAKQBBAAAADBATQIAywUAAACfAQIC/wIBAAAAAADiAwkA4gQLAOIFEABvBhEAMAYFgAwAAABMNgACpAYUAABMIIGfBgECMAYF5Q0AAABMNgACpAYUAABMIIGfBgECMAYFjQ4AAABMNgACpAYUAABMIIGfBgECMAYFXw8AAAAwBQSYCgAAADAEA70GAAAApAQWAABMUIGfBAECMAQDDgcAAACkBBYAAExQgZ8EAQIwBAOFCAAAADADApcXAAAA/wMEAAAAAABvBBgAMAQD5RkAAAAwAwNuGgAAAJ49AwUBAAAAUgUDAFIGAQCkBBwAAACwQZ8EAwHABB0AEgABABIAAgASAAMAMAQD7xMAAADABB4AEgABADAEA4IfAAAAwAQgADAEA68hAAAAggMCACIDBQQAAABAAwYDBwQAADBAAwgDCQMKAwsFAwYHCAMMBQEKAw0DDgMPAxAFBAwNDg8HAAAAAJqZGT8AAMC/AAAAAAMRAwEEAEwggQMSBABMUIEDEwMUAxUDFgMCBAAAsEEGAAYBAwMGAgMEAwABAgEAARgAAAAAAAEAAAAAAgABAQEBAAABAAAAAAABAAAAAAABAAAAAAD8AP8ACQAAAAABAAAAAPUADgABAAABAAEAAAAAAAABAAAAAAAGAAAAAwAAAgEAAAAAA7hZDT+kmVQr9TyBzkEw1sjIQRpLip1nPg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:31
-- Luau version 6, Types version 3
-- Time taken: 0.001563 seconds

local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 0.60000, -1.5);
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
    __ClassName = "ShieldSWAT";
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
    return any_new_result1
end
function module_upvr.InputBegan(arg1, ...) -- Line 29
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 32
end
return module_upvr