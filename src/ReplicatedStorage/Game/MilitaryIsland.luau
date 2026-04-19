-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:24
-- Luau version 6, Types version 3
-- Time taken: 0.003121 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    Maid = require(ReplicatedStorage.Std.Maid).new();
}
local CollectionService_upvr = game:GetService("CollectionService")
function module_upvr.Init() -- Line 12
    --[[ Upvalues[2]:
        [1]: CollectionService_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
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
    --[[ Upvalues[4]:
        [1]: module_upvr (readonly)
        [2]: RunService_upvr (readonly)
        [3]: CurrentCamera_upvr (readonly)
        [4]: Time_upvr (readonly)
    ]]
    assert(arg1)
    local cframe_upvr = CFrame.new(arg1.PrimaryPart.Position)
    local Position_upvr = cframe_upvr.Position
    module_upvr.Maid.ConnectionSpin = RunService_upvr.Heartbeat:Connect(function() -- Line 25
        --[[ Upvalues[5]:
            [1]: CurrentCamera_upvr (copied, readonly)
            [2]: Position_upvr (readonly)
            [3]: Time_upvr (copied, readonly)
            [4]: arg1 (readonly)
            [5]: cframe_upvr (readonly)
        ]]
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
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    module_upvr.Maid.ConnectionSpin = nil
end
return module_upvr