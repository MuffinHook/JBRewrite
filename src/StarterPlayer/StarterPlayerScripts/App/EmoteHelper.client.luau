local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
CharacterUtils_upvr.observeLocalCharacterAdded(function(arg1, arg2) -- Line 8
    local Humanoid_upvr = arg1:FindFirstChild("Humanoid")
    task.wait(1)
    local var8_upvw
    local function _(arg1_2) -- Line 17, Named "StopAnimation"
        arg2.emoteBallConnection = nil
        local var9
        if var8_upvw then
            if arg1_2 then
                var9 = 0
            else
                var9 = nil
            end
            var8_upvw:Stop(var9)
            var8_upvw = nil
        end
    end
    arg1:WaitForChild("Animate"):WaitForChild("PlayEmote").OnInvoke = function(arg1_3) -- Line 25
        arg2.emoteBallConnection = nil
        if var8_upvw then
            var8_upvw:Stop(nil)
            var8_upvw = nil
        end
        if Humanoid_upvr:GetState() ~= Enum.HumanoidStateType.Running then return end
        var8_upvw = Humanoid_upvr:LoadAnimation(arg1_3)
        var8_upvw.Priority = Enum.AnimationPriority.Action
        var8_upvw:Play()
        local any_getRootPart_result1_upvr = CharacterUtils_upvr.getRootPart(arg1)
        if any_getRootPart_result1_upvr then
            local Part_upvr = Instance.new("Part")
            Part_upvr.Shape = Enum.PartType.Ball
            Part_upvr.Size = Vector3.new(4, 4, 4)
            Part_upvr.Name = "EmoteBall"
            Part_upvr.CanCollide = true
            Part_upvr.CollisionGroup = any_getRootPart_result1_upvr.CollisionGroup
            Part_upvr.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
            Part_upvr.CFrame = any_getRootPart_result1_upvr.CFrame * CFrame.new(0, 0, 1)
            Part_upvr.Transparency = 1
            Part_upvr.Parent = arg1
            Joint_upvr.CustomWeld(Part_upvr, any_getRootPart_result1_upvr, CFrame.new(0, 0, 0), CFrame.new(0, 0, 0))
            local any_new_result1 = Maid_upvr.new()
            any_new_result1:GiveTask(function() -- Line 51
                task.delay(0.25, function() -- Line 52
                    Part_upvr:Destroy()
                end)
            end)
            any_new_result1:GiveTask(var8_upvw.Stopped:Connect(function() -- Line 56
                arg2.emoteBallConnection = nil
                if var8_upvw then
                    var8_upvw:Stop(nil)
                    var8_upvw = nil
                end
            end))
            any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 59
                if 3 < (arg1.LowerTorso.Position - any_getRootPart_result1_upvr.Position).Magnitude then
                    arg2.emoteBallConnection = nil
                    if var8_upvw then
                        var8_upvw:Stop(0)
                        var8_upvw = nil
                    end
                end
            end))
            arg2.emoteBallConnection = any_new_result1
        end
        Part_upvr = true
        return Part_upvr
    end
    arg2:GiveTask(Humanoid_upvr.StateChanged:Connect(function(arg1_4, arg2_2) -- Line 72
        arg2.emoteBallConnection = nil
        if var8_upvw then
            var8_upvw:Stop(nil)
            var8_upvw = nil
        end
    end))
    arg2:GiveTask(Humanoid_upvr.Running:Connect(function(arg1_5) -- Line 75
        arg2.emoteBallConnection = nil
        if var8_upvw then
            var8_upvw:Stop(nil)
            var8_upvw = nil
        end
    end))
end)