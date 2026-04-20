local Basic_upvr = require(script.Parent.Basic)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.5, 0.80000, -1.5);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        Eat = {
            Springs = {
                ItemOffset = Vector3.new(0, 0.80000, -1.5);
                ItemRotation = Vector3.new(0.94247, 0, 0);
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
}
local var9_upvw
local module_upvr = {
    __ClassName = "Juice";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
local ShockwaveScreenFx_upvr = require(ReplicatedStorage.Game.ShockwaveScreenFx)
local RunService_upvr = game:GetService("RunService")
function module_upvr.Init(arg1) -- Line 39
    var9_upvw = arg1.Event
    arg1.em.t3rinfd5 = function() -- Line 44, Named "t3rinfd5"
        CharacterUtil_upvr.IsJuiced = true
        CharacterUtil_upvr.WalkSpeedSpring:Accelerate(20)
        local any_new_result1_upvr = ShockwaveScreenFx_upvr.new()
        any_new_result1_upvr._maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 48
            any_new_result1_upvr:Update()
        end))
        any_new_result1_upvr:SetActive(true)
        task.delay(3, function() -- Line 52
            any_new_result1_upvr:SetActive(false)
            CharacterUtil_upvr.IsJuiced = false
            task.wait(5)
            any_new_result1_upvr:Destroy()
        end)
    end
end
function module_upvr.new(arg1, arg2, arg3) -- Line 60
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
function module_upvr.UpdateArmIK(arg1) -- Line 68
    local IK = arg1.IK
    IK.RightArm = arg1.Model.Skeleton.RightArm.Position
    IK.RightAngle = arg1.Config.Motion.RightElbowAngle
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 74
    local var24 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var24 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var24 = false
            else
                var24 = true
            end
        end
    end
    if var24 then
        arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Eat.Springs.ItemOffset)
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Eat.Springs.ItemRotation)
        Audio_upvr.ObjectLocal(arg1.Character.PrimaryPart, 7209853095, {
            Volume = 0.3;
        })
        delay(0.3, function() -- Line 84
            arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
            arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
            if arg1.Local then
                local tick_result1 = tick()
                arg1.LastConsumed = tick_result1
                if tick_result1 - (arg1.LastConsumed or 0) < 5 then
                    return false
                end
                var9_upvw:FireServer('t'.."l3w4nir3qz":sub(5, 8):reverse().."".."".."y0dfo20":sub(3, 4):reverse():reverse():reverse()..""..'5')
            end
        end)
        if arg1.Local then
            arg1:BroadcastInputBegan(arg2)
        end
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 103
end
return module_upvr