local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.OilRig.OilRigBinder):Start()
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Players_upvr = game:GetService("Players")
local RobberyConsts_upvr = require(ReplicatedStorage.Robbery.RobberyConsts)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder):GetClassAddedSignal():Connect(function(arg1) -- Line 10
    local any_new_result1_upvr = Maid_upvr.new()
    local function handleRobbery() -- Line 12
        any_new_result1_upvr:DoCleaning()
        if arg1:GetOwner() == Players_upvr.LocalPlayer and arg1:GetRobbery() == RobberyConsts_upvr.ENUM_ROBBERY.OIL_RIG then
            local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 1837697591, {
                Looped = true;
                Volume = 0.4;
                Group = game:GetService("SoundService").RobberyMusic;
            })
            any_new_result1_upvr:GiveTask(function() -- Line 21
                Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 0, 0.5):andThen(function() -- Line 22
                    any_ObjectLocal_result1_upvr:Destroy()
                end)
            end)
        end
    end
    handleRobbery()
    arg1._maid:GiveTask(arg1:GetRobberyChangedSignal():Connect(handleRobbery))
    arg1._maid:GiveTask(any_new_result1_upvr)
end)