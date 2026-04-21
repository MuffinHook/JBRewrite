return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return string.format("Taze %d criminals.", arg1:GetGoal());
    end;
    goal = 6;
    rewardExp = 30;
}