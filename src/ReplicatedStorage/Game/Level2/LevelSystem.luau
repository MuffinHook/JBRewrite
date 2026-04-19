-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:13
-- Luau version 6, Types version 3
-- Time taken: 0.004245 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local module_upvr = {}
local Players_upvr = game:GetService("Players")
function module_upvr.init() -- Line 9
    --[[ Upvalues[2]:
        [1]: Players_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    for _, v in ipairs(Players_upvr:GetPlayers()) do
        module_upvr.connectPlayer(v)
    end
    Players_upvr.PlayerAdded:Connect(module_upvr.connectPlayer)
end
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
local LevelConsts_upvr = require(script.Parent.LevelConsts)
function module_upvr.connectPlayer(arg1) -- Line 15
    --[[ Upvalues[3]:
        [1]: waitForChild_upvr (readonly)
        [2]: LevelConsts_upvr (readonly)
        [3]: module_upvr (readonly)
    ]]
    waitForChild_upvr(arg1, LevelConsts_upvr.LEVEL_VALUE_NAME):andThen(function(arg1_2) -- Line 17
        --[[ Upvalues[2]:
            [1]: module_upvr (copied, readonly)
            [2]: arg1 (readonly)
        ]]
        if module_upvr._onLevelChangedSignal then
            module_upvr._onLevelChangedSignal:Fire(arg1, arg1_2.Value)
        end
        arg1_2:GetPropertyChangedSignal("Value"):Connect(function() -- Line 21
            --[[ Upvalues[3]:
                [1]: module_upvr (copied, readonly)
                [2]: arg1 (copied, readonly)
                [3]: arg1_2 (readonly)
            ]]
            if module_upvr._onLevelChangedSignal then
                module_upvr._onLevelChangedSignal:Fire(arg1, arg1_2.Value)
            end
        end)
    end):catch(warn)
    waitForChild_upvr(arg1, LevelConsts_upvr.EXP_VALUE_NAME):andThen(function(arg1_3) -- Line 30
        --[[ Upvalues[2]:
            [1]: module_upvr (copied, readonly)
            [2]: arg1 (readonly)
        ]]
        if module_upvr._onExpChangedSignal then
            module_upvr._onExpChangedSignal:Fire(arg1, arg1_3.Value)
        end
        arg1_3:GetPropertyChangedSignal("Value"):Connect(function() -- Line 34
            --[[ Upvalues[3]:
                [1]: module_upvr (copied, readonly)
                [2]: arg1 (copied, readonly)
                [3]: arg1_3 (readonly)
            ]]
            if module_upvr._onExpChangedSignal then
                module_upvr._onExpChangedSignal:Fire(arg1, arg1_3.Value)
            end
        end)
    end):catch(warn)
end
function module_upvr.getOnLevelChangedSignal() -- Line 42
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: Signal_upvr (readonly)
    ]]
    if module_upvr._onLevelChangedSignal then
        return module_upvr._onLevelChangedSignal
    end
    module_upvr._onLevelChangedSignal = Signal_upvr.new()
    return module_upvr._onLevelChangedSignal
end
function module_upvr.getOnExpChangedSignal() -- Line 49
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: Signal_upvr (readonly)
    ]]
    if module_upvr._onExpChangedSignal then
        return module_upvr._onExpChangedSignal
    end
    module_upvr._onExpChangedSignal = Signal_upvr.new()
    return module_upvr._onExpChangedSignal
end
return module_upvr