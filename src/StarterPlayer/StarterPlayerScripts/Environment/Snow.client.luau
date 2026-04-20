local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local EnvironmentConsts_upvr = require(ReplicatedStorage_upvr.Environment.EnvironmentConsts)
local EnvironmentUtils_upvr = require(ReplicatedStorage_upvr.Environment.EnvironmentUtils)
if not EnvironmentConsts_upvr.SNOW then
else
    local DefaultSnow_upvr = ReplicatedStorage_upvr.Resource.DefaultSnow
    local any_new_result1_upvr = require(ReplicatedStorage_upvr.Std.Maid).new()
    for _, v in DefaultSnow_upvr:GetChildren() do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.CanTouch = false
            v.CanQuery = false
        end
    end
    local RunService_upvr = game:GetService("RunService")
    local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
    local Raycast_upvr = require(ReplicatedStorage_upvr.Std.Raycast)
    local function StartSnow_upvr() -- Line 27, Named "StartSnow"
        DefaultSnow_upvr.Parent = workspace
        any_new_result1_upvr:GiveTask(function() -- Line 29
            DefaultSnow_upvr.Parent = ReplicatedStorage_upvr.Resource
        end)
        local var16_upvw = 0
        local var17_upvw = Vector3.new(0, 0, 0)
        any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1) -- Line 34
            debug.profilebegin("snow Update")
            var16_upvw += arg1
            local var18
            if 0.2 < var18 then
                var18 = 0
                var16_upvw = var18
            end
            var18 = LocalPlayer_upvr
            var18 = var18.Character
            if var18 then
                var18 = LocalPlayer_upvr
                var18 = var18.Character
                var18 = var18.PrimaryPart
            end
            if var18 then
                var17_upvw = var18.Position + var18.Velocity * Vector3.new(1, 0, 1)
            end
            local var19
            if var16_upvw == 0 then
                local RaycastParams_new_result1 = RaycastParams.new()
                local tbl = {}
                var19 = workspace
                var19 = var19.Vehicles
                tbl[1] = var19
                tbl[2] = LocalPlayer_upvr.Character
                tbl[3] = DefaultSnow_upvr
                tbl[4] = workspace:FindFirstChild("Clouds")
                RaycastParams_new_result1.FilterDescendantsInstances = tbl
                var19 = var17_upvw
                if Raycast_upvr.collidable(var19, Vector3.new(0, 1, 0), 100, RaycastParams_new_result1) == nil then
                    var19 = false
                else
                    var19 = true
                end
                if DefaultSnow_upvr.RainFall.Rain.Enabled == true and var19 then
                    DefaultSnow_upvr.RainFall.Rain:Clear()
                end
                DefaultSnow_upvr.RainFall.Rain.Enabled = not var19
            end
            if DefaultSnow_upvr.RainFall.Rain.Enabled then
                var19 = var17_upvw
                DefaultSnow_upvr.RainFall.Position = var19 + Vector3.new(0, 37, 0)
            end
            debug.profileend()
        end))
    end
    local function _() -- Line 62, Named "UpdateSnowCheck"
        if EnvironmentUtils_upvr.getPrecipitation() == EnvironmentConsts_upvr.PRECIPITATION_ENUM.Rain then
            any_new_result1_upvr:Destroy()
            return false
        end
        StartSnow_upvr()
        return true
    end
    EnvironmentUtils_upvr.getPrecipitationChangedSignal():Connect(function() -- Line 70
        if EnvironmentUtils_upvr.getPrecipitation() == EnvironmentConsts_upvr.PRECIPITATION_ENUM.Rain then
            any_new_result1_upvr:Destroy()
        else
            StartSnow_upvr()
        end
    end)
    if EnvironmentUtils_upvr.getPrecipitation() == EnvironmentConsts_upvr.PRECIPITATION_ENUM.Rain then
        any_new_result1_upvr:Destroy()
        return
    end
    StartSnow_upvr()
end