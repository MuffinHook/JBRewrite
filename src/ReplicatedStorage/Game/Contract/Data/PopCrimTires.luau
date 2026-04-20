return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Pop the tires of %d criminal vehicles!":format(arg1:GetGoal())
    end;
    goal = 4;
    rewardExp = 40;
}