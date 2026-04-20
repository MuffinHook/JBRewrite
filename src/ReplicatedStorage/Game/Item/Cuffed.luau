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
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 51
end
return module_upvr