local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    OnJump = nil;
    IsCrawling = false;
    IsCrawlingChanged = require(ReplicatedStorage.Std.Signal).new();
    WalkSpeedSpring = require(ReplicatedStorage.Std.Spring).new(1, 0, 0.8, 10);
    IsJuiced = false;
    setHumanoidEnabled = function(arg1, arg2) -- Line 12, Named "setHumanoidEnabled"
        for _, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
            if v ~= Enum.HumanoidStateType.Dead and v ~= Enum.HumanoidStateType.None and v ~= Enum.HumanoidStateType.Jumping and v ~= Enum.HumanoidStateType.FallingDown then
                arg1:SetStateEnabled(v, arg2)
            end
        end
    end;
    stopAnims = function(arg1) -- Line 24, Named "stopAnims"
        for _, v_2 in ipairs(arg1:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()) do
            v_2:Stop(0)
        end
    end;
}
local HumanoidUnloadConsts_upvr = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
function module_upvr.getPositionFromCharacter(arg1) -- Line 30
    local Humanoid = arg1:FindFirstChild("Humanoid")
    if not Humanoid then
        return nil
    end
    local SOME = Humanoid:FindFirstChild(HumanoidUnloadConsts_upvr.SERVER_POSITION_OBJ_NAME)
    if not SOME then
        return nil
    end
    return SOME.Value
end
local Players_upvr = game:GetService("Players")
function module_upvr.getAllCharacterPositions() -- Line 41
    for _, v_3 in Players_upvr:GetPlayers() do
        local Character = v_3.Character
        if Character then
            local any_getPositionFromCharacter_result1_2 = module_upvr.getPositionFromCharacter(Character)
            if any_getPositionFromCharacter_result1_2 then
                ({})[Character] = any_getPositionFromCharacter_result1_2
            end
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return {}
end
return module_upvr