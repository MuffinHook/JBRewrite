return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return string.format("Rob the Cargo Plane %d times.", arg1:GetGoal());
    end;
    goal = 3;
    rewardExp = 55;
}