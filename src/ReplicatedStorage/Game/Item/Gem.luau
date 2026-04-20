local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 2, -1.8999);
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
    __ClassName = "Gem";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 23
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.SpringNeckRotation:SetTarget(Vector3.new(-0.4000, 0, 0))
    any_new_result1.SpringWaistRotation:SetTarget(Vector3.new(0.40000, 0, 0))
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
function module_upvr.InputBegan(arg1, ...) -- Line 34
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 37
end
return module_upvr