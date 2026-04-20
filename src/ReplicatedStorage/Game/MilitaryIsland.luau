local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    Maid = require(ReplicatedStorage.Std.Maid).new();
}
local CollectionService_upvr = game:GetService("CollectionService")
function module_upvr.Init() -- Line 12
    for _, v in ipairs(CollectionService_upvr:GetTagged("MilitaryLasers")) do
        module_upvr.StartSpin(v)
    end
    CollectionService_upvr:GetInstanceAddedSignal("MilitaryLasers"):Connect(module_upvr.StartSpin)
    CollectionService_upvr:GetInstanceRemovedSignal("MilitaryLasers"):Connect(module_upvr.StopSpin)
end
local RunService_upvr = game:GetService("RunService")
local CurrentCamera_upvr = workspace.CurrentCamera
local Time_upvr = require(ReplicatedStorage.Module.Time)
function module_upvr.StartSpin(arg1) -- Line 19
    assert(arg1)
    local cframe_upvr = CFrame.new(arg1.PrimaryPart.Position)
    local Position_upvr = cframe_upvr.Position
    module_upvr.Maid.ConnectionSpin = RunService_upvr.Heartbeat:Connect(function() -- Line 25
        local Magnitude = (CurrentCamera_upvr.CFrame.Position - Position_upvr).Magnitude
        if 250000 < Magnitude * Magnitude then
        else
            debug.profilebegin("MilitaryIsland Laser Spin")
            local any_GetNowSync_result1 = Time_upvr.GetNowSync()
            arg1:SetPrimaryPartCFrame(cframe_upvr * CFrame.Angles(0, (any_GetNowSync_result1 + math.sin(2 * any_GetNowSync_result1) * 0.1) * 1 % (-math.pi*2), 0))
            debug.profileend()
        end
    end)
end
function module_upvr.StopSpin() -- Line 38
    module_upvr.Maid.ConnectionSpin = nil
end
return module_upvr