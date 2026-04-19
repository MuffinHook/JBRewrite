-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:47
-- Luau version 6, Types version 3
-- Time taken: 0.002618 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.OilRig.OilRigBinder):Start()
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Players_upvr = game:GetService("Players")
local RobberyConsts_upvr = require(ReplicatedStorage.Robbery.RobberyConsts)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder):GetClassAddedSignal():Connect(function(arg1) -- Line 10
    --[[ Upvalues[4]:
        [1]: Maid_upvr (readonly)
        [2]: Players_upvr (readonly)
        [3]: RobberyConsts_upvr (readonly)
        [4]: Audio_upvr (readonly)
    ]]
    local any_new_result1_upvr = Maid_upvr.new()
    local function handleRobbery() -- Line 12
        --[[ Upvalues[5]:
            [1]: any_new_result1_upvr (readonly)
            [2]: arg1 (readonly)
            [3]: Players_upvr (copied, readonly)
            [4]: RobberyConsts_upvr (copied, readonly)
            [5]: Audio_upvr (copied, readonly)
        ]]
        any_new_result1_upvr:DoCleaning()
        if arg1:GetOwner() == Players_upvr.LocalPlayer and arg1:GetRobbery() == RobberyConsts_upvr.ENUM_ROBBERY.OIL_RIG then
            local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 1837697591, {
                Looped = true;
                Volume = 0.4;
                Group = game:GetService("SoundService").RobberyMusic;
            })
            any_new_result1_upvr:GiveTask(function() -- Line 21
                --[[ Upvalues[2]:
                    [1]: Audio_upvr (copied, readonly)
                    [2]: any_ObjectLocal_result1_upvr (readonly)
                ]]
                Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 0, 0.5):andThen(function() -- Line 22
                    --[[ Upvalues[1]:
                        [1]: any_ObjectLocal_result1_upvr (copied, readonly)
                    ]]
                    any_ObjectLocal_result1_upvr:Destroy()
                end)
            end)
        end
    end
    handleRobbery()
    arg1._maid:GiveTask(arg1:GetRobberyChangedSignal():Connect(handleRobbery))
    arg1._maid:GiveTask(any_new_result1_upvr)
end)