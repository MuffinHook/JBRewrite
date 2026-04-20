local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local module_upvr = {}
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
local PrivateServerUtils_upvr = require(ReplicatedStorage_upvr.PrivateServer.PrivateServerUtils)
function module_upvr.promiseIsTeamSwitchingEnabled() -- Line 9
    if not RunUtils_upvr.isMainWorld() then
        return Promise_upvr.resolve(false)
    end
    return PrivateServerUtils_upvr.promiseGetIsBattleServer():andThen(function(arg1) -- Line 13
        return not arg1
    end)
end
function module_upvr.isTeamSwitchingEnabled() -- Line 18
    local any_await_result1, any_await_result2 = module_upvr.promiseIsTeamSwitchingEnabled():await()
    return any_await_result1 and any_await_result2
end
local Players_upvr = game:GetService("Players")
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
function module_upvr.isTeamFull(arg1) -- Line 25
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local players = Players_upvr:GetPlayers()
    local var20
    for i, v in players do
        local ChoosingTeam = v:FindFirstChild("ChoosingTeam")
        local var22
        if ChoosingTeam and (not ChoosingTeam or not ChoosingTeam.Value) then
            local Team = v.Team
            if Team then
            end
            if v.Team.Name == "Police" then
            else
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if v.Team.Name == "Prisoner" or v.Team.Name == "Criminal" then
                    var20 += 1
                end
            end
        end
    end
    if not RunUtils_upvr.isStudio() and not ReplicatedStorage_upvr:FindFirstChild("VipOwnerId") and (arg1 == Settings_upvr.EnumTeam.Prisoner or arg1 == Settings_upvr.EnumTeam.Criminal) then
        v = #players * 0.8
        i = math.ceil(v)
        v = 1
        if math.max(i, v) <= var20 then
            i = true
            return i
        end
    end
    return false
end
return module_upvr