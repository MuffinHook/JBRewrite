return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 7
        return "Rob the Train %d times.":format(arg1:GetGoal())
    end;
    goal = 6;
    rewardExp = 50;
}