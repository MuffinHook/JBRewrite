-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMiCGRlZXBDb3B5B2dldEF0dHIKSXRlbU9mZnNldAZNb3Rpb24DSGlwB1NwcmluZ3MDbmV3B2dldE5hbWULX19DbGFzc05hbWUMc2V0bWV0YXRhYmxlFURlZmF1bHREaXNhYmxlQ2FtTG9jaxJHZXRMZWZ0QXJtUG9zaXRpb24KSW5wdXRCZWdhbgpJbnB1dEVuZGVkBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQZzY3JpcHQGUGFyZW50B3JlcXVpcmUJSW52ZW50b3J5EkludmVudG9yeUl0ZW1VdGlscwNTdGQKVGFibGVVdGlscwVCYXNpYxJSaWdodFdyaXN0Um90YXRpb24RTGVmdFdyaXN0Um90YXRpb24MSXRlbVJvdGF0aW9uDE5lY2tSb3RhdGlvbg1XYWlzdFJvdGF0aW9uB1ZlY3RvcjMGQ0ZyYW1lBkN1c3RvbQdfX2luZGV4AAUKAwUAAAAu+wMAAE0DA+UAAAAA+wQBAJ8DAgL7BAIATQQEWwEAAABSBQEAbwYCAJ8EAwIOBAgATQUDlwMAAABNBQW9BAAAAE0FBZgFAAAAMAQFgAIAAAD7BQMATQUF7wYAAABSBgAAUgcBAFIIAwBSCQIAnwUFAvsGAgBNBga2BwAAAFIHAQCfBgICMAYF5QgAAAD7CAQAnj0FBAgAAABSBwUApAYKAAAAkECfBgMBvAYFvgsAAACfBgIBggUCAAwDAQMCAwMDBAMFAwYDBwMIAwkDCgQAAJBAAwsAGgcBGAAAAAAAAQAAAAAAAQEAAAAAAAAAAwAAAAAAAAABAAAAAAAAAQAAAAAAAAIAAAIbAAAAAAIBAAAAAALGAQAAggECAAAAKQwBGAAAKgAAAAAEAQEBAAAIowEAAPsBAABNAQGCAAAAAFICAADdAwAAnwEAAYIAAQABAw0ALA0BGAABAAAAAAABLAAAAAABAQAAAAABggABAAAALw4BGAAvAAAAAAoAAAECAGyjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAQEkBgAAAKQCCAAAAHBATQMAYAkAAABNAwN3CgAAAJ8CAgKkAwgAAABwQE0EAKELAAAATQQEGAwAAACfAwICpAQIAAAAcEBNBQHLDQAAAJ8EAgL/BQEAAAAAAOIGEQDiBxMA4ggYAEw2AAKkCRsAAGiQgZ8JAQIwCQiAFAAAAEw2AAKkCRsAAGiQgZ8JAQIwCQjlFQAAAEw2AAKkCRsAAGiQgZ8JAQIwCQiNFgAAAEw2AAKkCRsAAGiQgZ8JAQIwCQhfFwAAADAIB5gSAAAAMAcGvQ4AAACkBx0AAGjAgZ8HAQIwBwYODwAAAKQHHQAAaMCBnwcBAjAHBoUQAAAAMAYFlx4AAAD/BgQAAAAAAG8HHwAwBwblIAAAADAGBm4hAAAAnj0GBQQAAABSCAYAUgkEAKQHIwAAACBCnwcDAcAHJAASAAMAEgAFABIAAgASAAQAEgAGADAHBu8aAAAAwAclADAHBpMmAAAAwAcnABIABAAwBwaCKAAAAMAHKQAwBwavKgAAAIIGAgArAw8EAAAAQAMQAxEDEgQAAEBAAxMDFAQAAHBAAxUDFgMXAxgDGQMFAxoDGwUDDg8QAwYFARIDAwMcAx0DHgUEFBUWFwMfAwcEAGiQgQMgBABowIEDBAMhAwkDIgMKBAAAIEIGAAYBAwwGAgMNBgMDDgQAAQIDAQABGAAAAAAAAAABAAAAAQAAAAAAAAEAAAAAAAABAAAAAAIAAQEBAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAA/AD/AAkAAAAAAQAAAAD1AA4AAQAAAQABAAAAAAAAAQAAAAAAAAAPAAADAAAAAwAAAgEAAAAABCC51DwikdGaGGOsIv7g3uJQocNIEn2+PQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:11
-- Luau version 6, Types version 3
-- Time taken: 0.003133 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new();
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
    __ClassName = "Custom";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local InventoryItemUtils_upvr = require(ReplicatedStorage.Inventory.InventoryItemUtils)
function module_upvr.new(arg1, arg2, arg3) -- Line 26
    --[[ Upvalues[5]:
        [1]: TableUtils_upvr (readonly)
        [2]: tbl_upvr (readonly)
        [3]: InventoryItemUtils_upvr (readonly)
        [4]: Basic_upvr (readonly)
        [5]: module_upvr (readonly)
    ]]
    local any_deepCopy_result1 = TableUtils_upvr.deepCopy(tbl_upvr)
    local any_getAttr_result1 = InventoryItemUtils_upvr.getAttr(arg2, "ItemOffset")
    if any_getAttr_result1 then
        any_deepCopy_result1.Motion.Hip.Springs.ItemOffset = any_getAttr_result1
    end
    local any_new_result1 = Basic_upvr.new(arg1, arg2, any_deepCopy_result1, arg3)
    any_new_result1.__ClassName = InventoryItemUtils_upvr.getName(arg2)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 41
    return nil
end
function module_upvr.InputBegan(arg1, ...) -- Line 44
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 47
end
return module_upvr