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
        sword_lunge = 3772602113;
    };
    ReloadTime = 0.5;
}
local var9_upvw
local module_upvr = {
    __ClassName = "Sword";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Melee_upvr)
function module_upvr.Init(arg1) -- Line 31
    var9_upvw = arg1.Event
end
function module_upvr.new(arg1, arg2, arg3) -- Line 34
    local any_new_result1 = Melee_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.TrailLengthTime = 0
    return any_new_result1
end
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
function module_upvr.SwingLunge(arg1) -- Line 42
    Audio_upvr.ObjectLocal(arg1.Center, arg1.Config.Sound.sword_lunge, {
        TimePosition = 0.1;
        Volume = 0.3;
    })
    arg1.SpringItemOffset:SetTarget(Vector3.new(0, 2, 0.5))
    arg1.SpringItemRotation:SetTarget(Vector3.new(-1.4137, 0, 0))
    delay(0.25, function() -- Line 46
        arg1.SpringWaistRotation:Accelerate(Vector3.new(-6.2831, 9.42477, 0))
        arg1.SpringItemOffset:Accelerate(Vector3.new(0, 0, -30))
        if arg1.Local then
            CharacterUtil_upvr.WalkSpeedSpring:Accelerate(35)
            var9_upvw:FireServer('p'.."".."e11q":sub(3, 3):reverse().."".."".."l3wv01i":sub(4, 6):reverse():reverse():reverse():reverse():reverse().."".."".."ngr63r0":sub(5, 5):reverse().."".."v6", 2)
        end
    end)
    delay(0.45, function() -- Line 55
        arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
    end)
    arg1.TrailLengthTime = 0.45
end
function module_upvr.SwingSwoosh(arg1) -- Line 61
    Audio_upvr.ObjectLocal(arg1.Center, arg1.Config.Sound.sword_swoosh, {
        Volume = 0.75;
    })
    arg1.SpringItemOffset:Accelerate(Vector3.new(10, 30, 5))
    arg1.SpringItemRotation:Accelerate(Vector3.new(-31.415, 23.5619, 0))
    arg1.SpringWaistRotation:Accelerate(Vector3.new(-3.1415, 15.7079, 0))
    arg1.SpringNeckRotation:Accelerate(Vector3.new(1.25663, -3.1415, 0))
    arg1.TrailLengthTime = 0.1
    if arg1.Local then
        var9_upvw:FireServer('p'.."fe11jv":sub(3, 4):reverse():reverse():reverse():reverse():reverse().."".."".."nwr0ftck":sub(4, 4):reverse():reverse():reverse().."".."".."n3vqqq":sub(2, 3):reverse():reverse():reverse().."".."v6", 1)
    end
end
function module_upvr.Stepped(arg1) -- Line 74
    local var17
    if workspace:GetServerTimeNow() - arg1:_getLastUse() >= arg1.TrailLengthTime then
        var17 = false
    else
        var17 = true
    end
    arg1.Model.Trail.Trail.Enabled = var17
    var17 = arg1
    Melee_upvr.Stepped(var17)
end
return module_upvr