local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 0.80000, -1.5);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        Eat = {
            Springs = {
                ItemOffset = Vector3.new(0, 1.20000, -1.2999);
                ItemRotation = Vector3.new(0.94247, 0, 0);
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
}
local var8_upvw
local module_upvr = {
    __ClassName = "Donut";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.Init(arg1) -- Line 33
    var8_upvw = arg1.Event
end
function module_upvr.new(arg1, arg2, arg3) -- Line 36
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 44
    local var14 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var14 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var14 = false
            else
                var14 = true
            end
        end
    end
    if var14 then
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Eat.Springs.ItemRotation)
        delay(0.3, function() -- Line 52
            arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
            if arg1.Local then
                local tick_result1_2 = tick()
                arg1.LastConsumed = tick_result1_2
                if tick_result1_2 - (arg1.LastConsumed or 0) < 5 then
                    return false
                end
                var8_upvw:FireServer('y'.."tvmqzvp":sub(4, 4):reverse().."".."".."hmdvcz":sub(5, 5):reverse().."".."".."bgkywdju":sub(2, 4):reverse().."".."".."zk4dbh0":sub(3, 3):reverse():reverse():reverse()..""..'0')
            end
        end)
        if arg1.Local then
            arg1:BroadcastInputBegan(arg2)
        end
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 70
end
return module_upvr