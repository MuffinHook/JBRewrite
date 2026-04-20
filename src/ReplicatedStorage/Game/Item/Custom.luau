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
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 47
end
return module_upvr