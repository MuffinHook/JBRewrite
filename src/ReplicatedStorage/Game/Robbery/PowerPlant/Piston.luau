local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local RunService_upvr = game:GetService("RunService")
local Players_upvr = game:GetService("Players")
function module_upvr_2.new(arg1) -- Line 10
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr.Maid = Maid_upvr.new()
    local Piston_upvr = arg1:FindFirstChild("Piston")
    if not arg1:FindFirstChild("PistonOrigin") then
        local Part_upvw = Instance.new("Part")
        Part_upvw.Name = "PistonOrigin"
        Part_upvw.Anchored = true
        Part_upvw.Transparency = 1
        Part_upvw.CanCollide = false
        Part_upvw.CFrame = Piston_upvr.CFrame
        Part_upvw.Parent = arg1
    end
    module_upvr.RemoteEvent = arg1:WaitForChild("RemoteEvent")
    local any_new_result1_upvr = Spring_upvr.new(0, 0, 1, 0)
    assert(true)
    local var12_upvw = true
    local tick_result1_3_upvw = tick()
    module_upvr.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 41
        local tick_result1_4 = tick()
        if 3 < tick_result1_4 - tick_result1_3_upvw then
            tick_result1_3_upvw = tick_result1_4
            any_new_result1_upvr.Damp = 0.7
            any_new_result1_upvr.Freq = 50
            any_new_result1_upvr:SetTarget(1)
            Audio_upvr.ObjectLocal(Piston_upvr, 5327245125, {
                MaxDistance = 96;
            })
            var12_upvw = false
            delay(1, function() -- Line 50
                any_new_result1_upvr.Damp = 0.9
                any_new_result1_upvr.Freq = 10
                any_new_result1_upvr:SetTarget(0)
                var12_upvw = true
            end)
        end
        Piston_upvr.CFrame = Part_upvw.CFrame * CFrame.new(0, (1 - any_new_result1_upvr:Update()) * 10, 0)
    end))
    local var19_upvw = 0
    module_upvr.Maid:GiveTask(Piston_upvr.Touched:Connect(function(arg1_2) -- Line 62
        local any_Update_result1 = any_new_result1_upvr:Update()
        local any_GetPlayerFromCharacter_result1_2 = Players_upvr:GetPlayerFromCharacter(arg1_2.Parent)
        if any_GetPlayerFromCharacter_result1_2 then
            local tick_result1_2 = tick()
            if 1.5 < tick_result1_2 - var19_upvw and 0.05 < any_Update_result1 and any_Update_result1 < 0.95 and var12_upvw == false then
                var19_upvw = tick_result1_2
                module_upvr:SlamPlayer(any_GetPlayerFromCharacter_result1_2)
            end
        end
    end))
    return module_upvr
end
function module_upvr_2.SlamPlayer(arg1, arg2) -- Line 81
    local Humanoid_upvr = arg2.Character.Humanoid
    Humanoid_upvr.BodyHeightScale.Value = 0.3
    Audio_upvr.ObjectLocal(Humanoid_upvr.RootPart, 5333889062)
    delay(4, function() -- Line 86
        Humanoid_upvr.BodyHeightScale.Value = 1
        Audio_upvr.ObjectLocal(Humanoid_upvr.RootPart, 5333889401)
    end)
    arg1.RemoteEvent:FireServer()
end
function module_upvr_2.Destroy(arg1) -- Line 92
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr_2