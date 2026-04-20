return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Rob the Museum %d times":format(arg1:GetGoal())
    end;
    goal = 4;
    rewardExp = 50;
}