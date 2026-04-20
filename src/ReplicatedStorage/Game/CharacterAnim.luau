local module_upvr = {}
local Players_upvr = game:GetService("Players")
function module_upvr.init() -- Line 5
    module_upvr._handlePlayer(Players_upvr.LocalPlayer)
end
function module_upvr._handlePlayer(arg1) -- Line 8
    if arg1.Character then
        module_upvr._handleCharacter(arg1.Character)
    end
    arg1.CharacterAdded:Connect(module_upvr._handleCharacter)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module_upvr._handleCharacter(arg1) -- Line 14
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
    return module_upvr._idleTrack
end
function module_upvr.getSkydiveTrack() -- Line 39
    return module_upvr._skydiveTrack
end
function module_upvr.getRopeGrabTrack() -- Line 42
    return module_upvr._ropeGrabTrack
end
function module_upvr.getCarSitTrack() -- Line 45
    return module_upvr._carSitTrack
end
return module_upvr