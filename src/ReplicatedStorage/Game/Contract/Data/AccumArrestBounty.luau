local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police;
}
local Format_upvr = require(ReplicatedStorage.Module.Format)
function module.message(arg1) -- Line 7
    return string.format("Arrest %s worth of criminal bounty.", Format_upvr.Currency(arg1:GetGoal()));
end
function module.goal() -- Line 10
    return 5000 + math.random(0, 4) * 250
end
module.rewardExp = 60
return module