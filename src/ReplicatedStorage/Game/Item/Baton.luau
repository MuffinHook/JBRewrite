local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Melee_upvr = require(script.Parent.Melee)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 0.5, 0);
                ItemRotation = Vector3.new(0.18849, 0, -0.1570);
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new(-0.1570, 0, 0);
            };
        };
    };
    Sound = {
        sword_swoosh = 3772601178;
        sword_lunge = 3772601178;
    };
    ReloadTime = 0.5;
}
local var9_upvw
local module_upvr = {
    __ClassName = "Baton";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Melee_upvr)
function module_upvr.Init(arg1) -- Line 31
    var9_upvw = arg1.Event
end
function module_upvr.new(arg1, arg2, arg3) -- Line 34
    local any_new_result1 = Melee_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    return any_new_result1
end
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
function module_upvr.SwingLunge(arg1) -- Line 40
    arg1.SpringWaistRotation:Accelerate(Vector3.new(4, -7, 0))
    arg1.SpringNeckRotation:Accelerate(Vector3.new(-2, 4, 0))
    delay(0.05, function() -- Line 43
        arg1.SpringItemOffset:Accelerate(Vector3.new(0, 2, 5))
        arg1.SpringItemRotation:Accelerate(Vector3.new(-30, 0, 0))
        arg1.SpringWaistRotation:Accelerate(Vector3.new(-3, 7, 0))
        arg1.SpringNeckRotation:Accelerate(Vector3.new(2, -4, 0))
        Audio_upvr.ObjectLocal(arg1.Center, arg1.Config.Sound.sword_lunge, {
            TimePosition = 0.1;
            Volume = 0.3;
        })
        if arg1.Local then
            CharacterUtil_upvr.WalkSpeedSpring:Accelerate(35)
            var9_upvw:FireServer('p'.."uv3v011q4s":sub(2, 7):reverse():reverse():reverse()..""..'6', 2)
        end
    end)
end
function module_upvr.SwingSwoosh(arg1) -- Line 56
    Audio_upvr.ObjectLocal(arg1.Center, arg1.Config.Sound.sword_swoosh, {
        Volume = 0.75;
    })
    arg1.SpringItemOffset:Accelerate(Vector3.new(10, 30, 5))
    arg1.SpringItemRotation:Accelerate(Vector3.new(-31.415, 23.5619, 0))
    arg1.SpringWaistRotation:Accelerate(Vector3.new(-3.1415, 15.7079, 0))
    arg1.SpringNeckRotation:Accelerate(Vector3.new(1.25663, -3.1415, 0))
    if arg1.Local then
        var9_upvw:FireServer('p'.."".."c61k0":sub(3, 3):reverse().."".."".."wqp1g":sub(4, 4):reverse():reverse():reverse().."".."".."vis9v3v0ed":sub(5, 8):reverse()..""..'6', 1)
    end
end
return module_upvr