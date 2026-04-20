local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1, 1, -1.5);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.Angles(0, (math.pi/2), 0);
        LeftWristRotation = CFrame.new();
    };
}
local var6_upvw
local module_upvr = {
    __ClassName = "Glider";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.Init(arg1) -- Line 25
    var6_upvw = arg1.Event
end
function module_upvr.new(arg1, arg2, arg3) -- Line 28
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    return any_new_result1
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 34
    return nil
end
function module_upvr.ShootBegin(arg1, arg2) -- Line 37
    var6_upvw:FireServer('l'.."".."ov5qey3":sub(2, 3):reverse().."".."".."rvu54akg":sub(3, 5):reverse():reverse():reverse().."".."54")
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 40
    local var10 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var10 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var10 = false
            else
                var10 = true
            end
        end
    end
    if var10 then
        arg1:ShootBegin(arg2)
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 50
end
return module_upvr