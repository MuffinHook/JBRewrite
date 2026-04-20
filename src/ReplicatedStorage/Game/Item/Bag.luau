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
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 41
end
return module_upvr