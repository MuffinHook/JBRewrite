local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local CurrentCamera_upvr = workspace.CurrentCamera
function module.Init() -- Line 10
    Binder_upvr.new("LighthouseLight", function(arg1) -- Line 12
        local any_new_result1 = Maid_upvr.new()
        local var9
        if arg1.PrimaryPart.Name ~= "Center" then
            var9 = false
        else
            var9 = true
        end
        assert(var9, "LighthouseLight must have Center as PrimaryPart")
        any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 20
            local any_GetPivot_result1 = arg1:GetPivot()
            local Magnitude = (CurrentCamera_upvr.CFrame.Position - any_GetPivot_result1.Position).Magnitude
            if 1048576 < Magnitude * Magnitude then
            else
                debug.profilebegin("Lighthouse")
                arg1:PivotTo(any_GetPivot_result1 * CFrame.Angles(0, 0.5 * arg1_2, 0))
                debug.profileend()
            end
        end))
        return any_new_result1
    end):Start()
end
return module