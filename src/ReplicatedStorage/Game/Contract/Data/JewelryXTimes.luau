return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Rob the Jewelry Store %d times":format(arg1:GetGoal())
    end;
    goal = 5;
    rewardExp = 50;
}