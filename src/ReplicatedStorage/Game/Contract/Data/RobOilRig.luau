return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return string.format("Rob the Oil Rig %d times!", arg1:GetGoal());
    end;
    goal = 3;
    rewardExp = 60;
}