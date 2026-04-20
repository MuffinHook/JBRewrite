local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local module_upvr = {}
local var4_upvw
local var5_upvw = false
local CurrentCamera_upvr = workspace.CurrentCamera
local CamShaker_upvr = require(ReplicatedStorage_upvr.Game.CamShaker.CamShaker)
local RunService_upvr = game:GetService("RunService")
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
function module_upvr.onExplode(arg1, arg2, arg3, arg4, arg5) -- Line 16
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var10
    if not var5_upvw then
    else
        if not arg3 then
            local const_number = 24
        end
        if not var10 then
            var10 = 128
        end
        local Humanoid = LocalPlayer_upvr.Character:FindFirstChild("Humanoid")
        local RootPart = Humanoid.RootPart
        local var14 = RootPart.Position - arg1
        if var14.Magnitude < arg2 then
            if Humanoid.SeatPart then
                Humanoid.Jump = true
                task.wait(0.1)
            end
            task.spawn(var4_upvw.e1i6ygca)
            local CFrame_upvw = CurrentCamera_upvr.CFrame
            local any_new_result1_upvr = CamShaker_upvr.new(Enum.RenderPriority.Camera.Value + 2, function(arg1_2) -- Line 38
                CFrame_upvw = CurrentCamera_upvr.CFrame
                CurrentCamera_upvr.CFrame *= arg1_2
            end)
            any_new_result1_upvr:Start()
            any_new_result1_upvr:Shake(CamShaker_upvr.Presets.Explosion)
            local any_Connect_result1_upvr = RunService_upvr.Heartbeat:Connect(function() -- Line 42
                CurrentCamera_upvr.CFrame = CFrame_upvw
            end)
            Promise_upvr.delay(2):andThen(function() -- Line 48
                any_new_result1_upvr:Stop()
                any_Connect_result1_upvr:Disconnect()
            end)
            if not arg5 then
                RootPart:ApplyImpulse(RootPart.AssemblyMass * var14.Unit * ((var10 - const_number) * (1 - var14.Magnitude / arg2) + const_number))
            end
        end
    end
end
local C4Binder_upvr = require(script.Parent.C4Binder)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local C4Consts_upvr = require(script.Parent.C4Consts)
local C4Utils_upvr = require(script.Parent.C4Utils)
function module_upvr.init(arg1) -- Line 61
    var4_upvw = arg1.em
    var5_upvw = true
    C4Binder_upvr:Start()
    local function _(arg1_3) -- Line 66, Named "hide"
        arg1_3._obj.PrimaryPart.Anchored = true
        arg1_3._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
    end
    C4Binder_upvr:GetClassAddedSignal():Connect(function(arg1_4) -- Line 70
        RxInstanceUtils_upvr.yieldForProperty(arg1_4.obj, "PrimaryPart")
        if arg1_4:GetCreator() == LocalPlayer_upvr then
            arg1_4._obj.PrimaryPart.Anchored = true
            arg1_4._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
        end
        arg1_4._maid:GiveTask(arg1_4._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line 75
            if arg1_4:GetCreator() == LocalPlayer_upvr then
                local var27 = arg1_4
                var27._obj.PrimaryPart.Anchored = true
                var27._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
            end
        end))
    end)
    ReplicatedStorage_upvr:FindFirstChild(C4Consts_upvr.PLAY_EXPLOSION_REMOTE_NAME).OnClientEvent:Connect(function(arg1_5, arg2) -- Line 83
        C4Utils_upvr.explosionVisual(arg1_5)
    end)
    ReplicatedStorage_upvr:FindFirstChild("C4ExplodedRemote").OnClientEvent:Connect(module_upvr.onExplode)
end
return module_upvr