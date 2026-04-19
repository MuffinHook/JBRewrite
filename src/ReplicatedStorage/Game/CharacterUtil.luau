-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:12
-- Luau version 6, Types version 3
-- Time taken: 0.003268 seconds

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
    --[[ Upvalues[1]:
        [1]: HumanoidUnloadConsts_upvr (readonly)
    ]]
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
    --[[ Upvalues[2]:
        [1]: Players_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    for _, v_3 in Players_upvr:GetPlayers() do
        local Character = v_3.Character
        if Character then
            local any_getPositionFromCharacter_result1_2 = module_upvr.getPositionFromCharacter(Character)
            if any_getPositionFromCharacter_result1_2 then
                ({})[Character] = any_getPositionFromCharacter_result1_2
            end
        end
    end
    -- KONSTANTERROR: Expression was reused, decompilation is incorrect
    return {}
end
return module_upvr