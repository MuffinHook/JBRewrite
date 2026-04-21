return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return string.format("Drive or fly %d miles.", arg1:GetGoal());
    end;
    goal = 25;
    rewardExp = 30;
}