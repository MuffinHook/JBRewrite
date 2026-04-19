-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:11
-- Luau version 6, Types version 3
-- Time taken: 0.003064 seconds

local module_upvr = {}
local Players_upvr = game:GetService("Players")
function module_upvr.init() -- Line 5
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: Players_upvr (readonly)
    ]]
    module_upvr._handlePlayer(Players_upvr.LocalPlayer)
end
function module_upvr._handlePlayer(arg1) -- Line 8
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    if arg1.Character then
        module_upvr._handleCharacter(arg1.Character)
    end
    arg1.CharacterAdded:Connect(module_upvr._handleCharacter)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module_upvr._handleCharacter(arg1) -- Line 14
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
    ]]
    local Animator = arg1:WaitForChild("Humanoid"):WaitForChild("Animator")
    local any_LoadAnimation_result1_3 = Animator:LoadAnimation(arg1:WaitForChild("Animate"):WaitForChild("idle"):WaitForChild("Animation1"))
    any_LoadAnimation_result1_3.Priority = Enum.AnimationPriority.Action
    any_LoadAnimation_result1_3:AdjustSpeed(0)
    module_upvr._idleTrack = any_LoadAnimation_result1_3
    module_upvr._skydiveTrack = Animator:LoadAnimation(ReplicatedStorage_upvr.Resource.Skydive)
    local any_LoadAnimation_result1 = Animator:LoadAnimation(ReplicatedStorage_upvr.Resource.RopeGrabAnimation)
    any_LoadAnimation_result1.Priority = Enum.AnimationPriority.Action
    any_LoadAnimation_result1:AdjustSpeed(0)
    module_upvr._ropeGrabTrack = any_LoadAnimation_result1
    local any_LoadAnimation_result1_2 = Animator:LoadAnimation(ReplicatedStorage_upvr.Resource.CarSitAnimation)
    any_LoadAnimation_result1_2:AdjustSpeed(0)
    module_upvr._carSitTrack = any_LoadAnimation_result1_2
end
function module_upvr.getIdleTrack() -- Line 36
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr._idleTrack
end
function module_upvr.getSkydiveTrack() -- Line 39
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr._skydiveTrack
end
function module_upvr.getRopeGrabTrack() -- Line 42
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr._ropeGrabTrack
end
function module_upvr.getCarSitTrack() -- Line 45
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr._carSitTrack
end
return module_upvr