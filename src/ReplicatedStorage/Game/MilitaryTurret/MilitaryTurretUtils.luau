local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    shortAngleDist = function(arg1, arg2) -- Line 7, Named "shortAngleDist"
        local var3 = (arg2 - arg1) % (-math.pi*2)
        return 2 * var3 % (-math.pi*2) - var3
    end;
}
local Players_upvr = game:GetService("Players")
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module.getNearestNonPolice(arg1, arg2) -- Line 12
    local var25
    for _, v in ipairs(Players_upvr:GetPlayers()) do
        local any_getTeam_result1_2 = PlayerUtils_upvr.getTeam(v)
        if any_getTeam_result1_2 then
            if any_getTeam_result1_2 ~= Settings_upvr.Team.Police then
                local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(v)
                if any_getRootPart_result1 then
                    if (any_getRootPart_result1.Position - arg1).Magnitude < (arg2 or math.huge) then
                    end
                end
            end
        end
    end
    return nil
end
return module