return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return string.format("Use road spikes to pop %d tires.", arg1:GetGoal());
    end;
    goal = 3;
    rewardExp = 50;
}