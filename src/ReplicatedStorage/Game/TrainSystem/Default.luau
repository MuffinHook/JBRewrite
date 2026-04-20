local function SetVelocity_upvr(arg1, arg2, arg3) -- Line 8, Named "SetVelocity"
    for _, v in next, arg1:GetChildren() do
        if v:IsA("BasePart") then
            v.Velocity = arg2
            v.RotVelocity = arg3
        end
        SetVelocity_upvr(v, arg2, arg3)
    end
    return true
end
local Joint_upvr = require(game:GetService("ReplicatedStorage").Std.Joint)
local TweenService_upvr = game:GetService("TweenService")
local RunService_upvr = game:GetService("RunService")
local TrainSystemUtils_upvr = require(script.Parent.TrainSystemUtils)
return {
    MakeCar = function(arg1) -- Line 19, Named "MakeCar"
        local Model = arg1.Model
        local Base_upvr = arg1.Base
        local Length = arg1.Length
        Joint_upvr.WeldAllTo(Model.Model, Base_upvr)
        Joint_upvr.Weld(Model.FrontBogeyRoot, Base_upvr)
        Joint_upvr.Weld(Model.BackBogeyRoot, Base_upvr)
        Model.FrontBogeyRoot.Anchored = false
        Model.BackBogeyRoot.Anchored = false
        Model.FrontBogey.Anchored = false
        Model.BackBogey.Anchored = false
        Base_upvr.Anchored = true
        arg1.BogeyMotorFront = Joint_upvr.BlankMotor(Model.FrontBogey, Model.FrontBogeyRoot)
        arg1.BogeyMotorBack = Joint_upvr.BlankMotor(Model.BackBogey, Model.BackBogeyRoot)
        arg1.BogeyOffsetFront = (Model.FrontBogeyRoot.Position - Base_upvr.CFrame * Vector3.new(0, 0, -Length * 0.5)).Magnitude
        arg1.BogeyOffsetBack = (Model.BackBogeyRoot.Position - Base_upvr.CFrame * Vector3.new(0, 0, Length * 0.5)).Magnitude
        local Skeleton_upvr = Model:FindFirstChild("Skeleton")
        if Skeleton_upvr then
            arg1.DoorOpenFuncs = {}
            local function setupDoor(arg1_2) -- Line 48
                local SOME_upvr = Skeleton_upvr:FindFirstChild("Door"..tostring(arg1_2))
                if not SOME_upvr then
                else
                    Joint_upvr.WeldAllTo(SOME_upvr, SOME_upvr.PrimaryPart)
                    SOME_upvr.PrimaryPart.Anchored = false
                    local any_Motor_result1_upvr = Joint_upvr.Motor(SOME_upvr.PrimaryPart, Base_upvr)
                    arg1.DoorOpenFuncs[arg1_2] = function() -- Line 56
                        local tick_result1_upvr = tick()
                        local var16_upvw
                        var16_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 60, Named "Heartbeat"
                            local var17 = (tick() - tick_result1_upvr) / 1
                            if 1 <= var17 then
                                var16_upvw:Disconnect()
                                var17 = 1
                            end
                            any_Motor_result1_upvr.C1 = CFrame.new(SOME_upvr.PrimaryPart.Size.X * TweenService_upvr:GetValue(var17, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 0, 0)
                        end)
                    end
                end
            end
            setupDoor(1)
            setupDoor(2)
        end
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 78, Named "MoveCar"
        local any_CalculatePosition_result1, any_CalculatePosition_result2_2 = TrainSystemUtils_upvr.CalculatePosition(arg2, arg2.Offset + arg4 + arg1.BogeyOffsetBack)
        local any_CalculatePosition_result1_2, any_CalculatePosition_result2 = TrainSystemUtils_upvr.CalculatePosition(arg2, arg2.Offset + arg4 + arg1.Length - arg1.BogeyOffsetFront)
        local cframe = CFrame.new(Vector3.new(), (any_CalculatePosition_result1_2 - any_CalculatePosition_result1).Unit)
        arg1.Base.CFrame = cframe + (any_CalculatePosition_result1 + any_CalculatePosition_result1_2) * 0.5
        local any_toObjectSpace_result1 = any_CalculatePosition_result2:toObjectSpace(cframe)
        local any_toObjectSpace_result1_2 = any_CalculatePosition_result2_2:toObjectSpace(cframe)
        if arg1.InvertBogey then
            any_toObjectSpace_result1 = any_toObjectSpace_result1:inverse()
            any_toObjectSpace_result1_2 = any_toObjectSpace_result1_2:inverse()
        end
        arg1.BogeyMotorFront.C0 = arg1.BogeyMotorFront.C0:lerp(any_toObjectSpace_result1, 0.1)
        arg1.BogeyMotorBack.C0 = arg1.BogeyMotorBack.C0:lerp(any_toObjectSpace_result1_2, 0.1)
    end;
    DestroyCar = function(arg1) -- Line 100, Named "DestroyCar"
        arg1.Model:Destroy()
        return true
    end;
}