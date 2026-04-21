local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police;
}
local Format_upvr = require(ReplicatedStorage.Module.Format)
function module.message(arg1) -- Line 7
    return string.format("Arrest a criminal with a %s+ bounty.", Format_upvr.Currency(arg1:GetGoal()));
end
function module.goal() -- Line 10
    return math.random(5, 6) * 500
end
module.rewardExp = 30
return module