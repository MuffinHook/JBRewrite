local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local RunUtils_upvr = require(ReplicatedStorage.App.RunUtils)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module.canInteract(arg1) -- Line 7
    if RunUtils_upvr.isStudio() then
        return true
    end
    if PlayerUtils_upvr.getTeamId(arg1) ~= Settings_upvr.EnumTeam.Prisoner then
        return false
    end
    return true
end
return module