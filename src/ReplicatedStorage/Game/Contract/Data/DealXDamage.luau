local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal;
}
local Format_upvr = require(ReplicatedStorage.Module.Format)
function module.message(arg1) -- Line 7
    return "Deal %s damage":format(Format_upvr.Comma(arg1:GetGoal()))
end
function module.goal() -- Line 10
    return math.random(18, 22) * 100
end
module.rewardExp = 40
return module