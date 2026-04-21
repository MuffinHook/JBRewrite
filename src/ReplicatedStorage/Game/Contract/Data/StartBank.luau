return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return string.format("Start a bank robbery %d times!", arg1:GetGoal());
    end;
    goal = 2;
    rewardExp = 35;
}