-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:54
-- Luau version 6, Types version 3
-- Time taken: 0.003602 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Players_upvr = game:GetService("Players")
local CameraConsts_upvr = require(script.Parent.CameraConsts)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_2_upvr.new(arg1, arg2) -- Line 12
    --[[ Upvalues[5]:
        [1]: module_2_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: Players_upvr (readonly)
        [4]: CameraConsts_upvr (readonly)
        [5]: Audio_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_2_upvr)
    module.obj = arg1
    module._maid = Maid_upvr.new()
    module._maid:GiveTask(arg2.spotRemote.OnClientEvent:Connect(function(arg1_2) -- Line 18
        --[[ Upvalues[3]:
            [1]: Players_upvr (copied, readonly)
            [2]: CameraConsts_upvr (copied, readonly)
            [3]: Audio_upvr (copied, readonly)
        ]]
        if arg1_2.isViewer then
            local any_GetPlayerFromCharacter_result1_upvr = Players_upvr:GetPlayerFromCharacter(arg1_2.spottedCharacter)
            if any_GetPlayerFromCharacter_result1_upvr then
                any_GetPlayerFromCharacter_result1_upvr:SetAttribute("CCTVSpotted", true)
                task.delay(CameraConsts_upvr.SPOT_DURATION, function() -- Line 25
                    --[[ Upvalues[1]:
                        [1]: any_GetPlayerFromCharacter_result1_upvr (readonly)
                    ]]
                    any_GetPlayerFromCharacter_result1_upvr:SetAttribute("CCTVSpotted", false)
                end)
            end
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 8274149535, {
                Volume = 0.5;
                RollOffMinDistance = 16;
                RollOffMaxDistance = 128;
            })
        end
    end))
    return module
end
function module_2_upvr.Damage(arg1) -- Line 39
    arg1.obj:FindFirstChild("DamageRemote"):FireServer()
end
function module_2_upvr.Spot(arg1, arg2) -- Line 43
    arg1.obj:FindFirstChild("SpotRemote"):FireServer(arg2)
end
function module_2_upvr.Destroy(arg1) -- Line 47
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return require(ReplicatedStorage.ManifestBinder).new("CCTVCamera", {
    spotRemote = "SpotRemote";
}, module_2_upvr)