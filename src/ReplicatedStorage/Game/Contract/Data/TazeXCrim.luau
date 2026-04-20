return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Taze %d criminals.":format(arg1:GetGoal())
    end;
    goal = 6;
    rewardExp = 30;
}