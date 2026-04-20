local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Players_upvr = game:GetService("Players")
local CameraConsts_upvr = require(script.Parent.CameraConsts)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_2_upvr.new(arg1, arg2) -- Line 12
    local module = {}
    setmetatable(module, module_2_upvr)
    module.obj = arg1
    module._maid = Maid_upvr.new()
    module._maid:GiveTask(arg2.spotRemote.OnClientEvent:Connect(function(arg1_2) -- Line 18
        if arg1_2.isViewer then
            local any_GetPlayerFromCharacter_result1_upvr = Players_upvr:GetPlayerFromCharacter(arg1_2.spottedCharacter)
            if any_GetPlayerFromCharacter_result1_upvr then
                any_GetPlayerFromCharacter_result1_upvr:SetAttribute("CCTVSpotted", true)
                task.delay(CameraConsts_upvr.SPOT_DURATION, function() -- Line 25
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